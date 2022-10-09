using Grpc.Core;
using GrpcDemo.Api;
using GrpcDemo.Api.Interfaces;
using GrpcDemo.Api.Models;
using Hangfire;

namespace PatientDemo.Services {
    public class PublisherService : Publisher.PublisherBase, IPubServer {
        private readonly ILogger<PublisherService> _logger;
        private readonly IMessageQueueRepo _messageRepo;
        private readonly IBackgroundJobClient _jobClient;

        public PublisherService(ILogger<PublisherService> logger, IMessageQueueRepo messageRepo, IBackgroundJobClient jobClient) {
            _logger = logger;
            _messageRepo = messageRepo;
            _jobClient = jobClient;
        }

        /// <summary>
        /// Receive published message and distribute to subscribers
        /// </summary>
        /// <param name="request"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        public async override Task<PublishResponse> Publish(PublishMessage request, ServerCallContext context) {
            _logger.LogInformation($"Received topic {request.Topic} and message {request.Dto}."); // TODO aspect logging

            try {
                // TODO deal with incoming messages

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
