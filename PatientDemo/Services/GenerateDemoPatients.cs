using Dapper;
using GrpcDemo.Api.Constants;
using GrpcDemo.Api.Data;
using GrpcDemo.Api.Interfaces;
using GrpcDemo.Api.Models;
using GrpcDemo.Api.Topics;
using Hangfire;
using PatientDemo.Data;
using PatientDemo.Models;
using System.Text.Json;

namespace PatientDemo.Services {
    public interface IGenerateDemoData {
        Task<bool> GeneratePatients();
        Task<bool> GeneratePatientMerges();
    }

    public class GenerateDemoPatients : IGenerateDemoData {
        private readonly DapperContext _context;
        private readonly IBackgroundJobClient _client;
        private readonly IMessageQueueRepo _msgRepo;
        private readonly IPatientRepo _patientRepo;

        public GenerateDemoPatients(DapperContext context, IBackgroundJobClient client, IMessageQueueRepo msgRepo, IPatientRepo ptRepo) {
            _context = context;
            _client = client;
            _msgRepo = msgRepo;
            _patientRepo = ptRepo;
        }

        public Task<bool> GeneratePatientMerges() {
            throw new NotImplementedException();
        }

        public async Task<bool> GeneratePatients() {
            // create random patient
            using var db = _context.CreateConnection();
            var rand = new Random();
            var patient = new Patient {
                EpicId = Guid.NewGuid().ToString(),
                ClinicNumber = rand.Next(1000000, 99999999).ToString("D8"),
                FirstName = await db.ExecuteScalarAsync<string>("select top 1 FirstName from Names order by NEWID()"),
                LastName = await db.ExecuteScalarAsync<string>("select top 1 LastName from Names order by NEWID()")
            };

            var ptFullData = JsonSerializer.Serialize(patient);
            var newPtId = await _patientRepo.UpdatePatient(null, patient.ClinicNumber, ptFullData);

            // create message
            var msg = new MessageQueue {
                Topic = nameof(INewPatient),
                DTO = ptFullData,
                Source = nameof(PatientDemo)
            };
            var newMsgId = await _msgRepo.AddMessageQueueAsync(msg);

            _client.Enqueue<IPubClient>(p => p.PublishAsync(newMsgId, Hosts.PubSubServiceUri));

            return true;
        }
    }
}
