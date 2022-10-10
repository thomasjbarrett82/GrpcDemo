using ApptDemo.Data;
using ApptDemo.Models;
using Grpc.Core;
using GrpcDemo.Api;
using GrpcDemo.Api.Interfaces;
using GrpcDemo.Api.Topics;
using Hangfire;
using System.Text.Json;

namespace ApptDemo.Services {
    public class PublisherService : Publisher.PublisherBase, IPubServer {
        private readonly ILogger<PublisherService> _logger;
        private readonly IMessageQueueRepo _messageRepo;
        private readonly IBackgroundJobClient _jobClient;
        private readonly IPatientRepo _patientRepo;

        public PublisherService(ILogger<PublisherService> logger, IMessageQueueRepo messageRepo, IBackgroundJobClient jobClient, IPatientRepo ptRepo) {
            _logger = logger;
            _messageRepo = messageRepo;
            _jobClient = jobClient;
            _patientRepo = ptRepo;
        }

        /// <summary>
        /// Receive published message and do something with it
        /// </summary>
        /// <param name="request"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        public async override Task<PublishResponse> Publish(PublishMessage request, ServerCallContext context) {
            _logger.LogInformation($"Received topic {request.Topic} and message {request.Dto}."); // TODO aspect logging

            try {
                // TODO use a factory or strategy pattern to dynamically deal with different topics
                if (request.Topic.Equals(nameof(INewPatient))) {
                    var patient = JsonSerializer.Deserialize<Patient>(request.Dto);
                    if (patient == null)
                        throw new NullReferenceException($"Invalid patient DTO.");
                    await _patientRepo.UpdatePatient(null, patient.ClinicNumber, request.Dto);
                }

                return new PublishResponse {
                    Received = true
                };
            }
            catch (Exception ex) {
                _logger.LogError($"{ex.Message}\n{ex.InnerException}");
                return new PublishResponse {
                    Received = false
                };
            }
        }
    }
}
