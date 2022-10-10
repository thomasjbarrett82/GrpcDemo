using ApptDemo.Data;
using ApptDemo.Models;
using Dapper;
using GrpcDemo.Api.Constants;
using GrpcDemo.Api.Data;
using GrpcDemo.Api.Interfaces;
using GrpcDemo.Api.Models;
using GrpcDemo.Api.Topics;
using Hangfire;
using System.Text.Json;

namespace ApptDemo.Services {
    public interface IGenerateDemoAppointments {
        Task<bool> GenerateAppointments();
    }

    public class GenerateDemoAppointments : IGenerateDemoAppointments {
        private readonly DapperContext _context;
        private readonly IBackgroundJobClient _client;
        private readonly IMessageQueueRepo _msgRepo;
        private readonly IAppointmentRepo _apptRepo;

        public GenerateDemoAppointments(DapperContext context, IBackgroundJobClient client, IMessageQueueRepo msgRepo, IAppointmentRepo apptRepo) {
            _context = context;
            _client = client;
            _msgRepo = msgRepo;
            _apptRepo = apptRepo;
        }

        public async Task<bool> GenerateAppointments() {
            using var db = _context.CreateConnection();
            var rand = new Random();

            // get patient
            var clinicNumber = await db.ExecuteScalarAsync<string>("select top 1 ClinicNumber from Patient order by NEWID()");
            if (string.IsNullOrWhiteSpace(clinicNumber))
                throw new NullReferenceException($"No clinic number found in Patient table.");

            // create random appointment
            var newAppt = new Appointment {
                ClinicNumber = clinicNumber,
                StartTime = DateTime.Today.AddDays(rand.Next(365))
            };

            // save to database
            var apptFullData = JsonSerializer.Serialize(newAppt);
            var newApptId = await _apptRepo.UpdateAppointment(null, clinicNumber, apptFullData);

            // publish message
            var apptMsg = new MessageQueue {
                Topic = nameof(INewAppointment),
                DTO = apptFullData,
                Source = nameof(ApptDemo)
            };
            var newMsgId = await _msgRepo.AddMessageQueueAsync(apptMsg);

            _client.Enqueue<IPubClient>(p => p.PublishAsync(newMsgId, Hosts.PubSubServiceUri));

            return true;
        }
    }
}
