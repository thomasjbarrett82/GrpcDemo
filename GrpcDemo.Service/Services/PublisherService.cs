using Grpc.Core;
using GrpcDemo.Api;
using GrpcDemo.Service.Data;
using GrpcDemo.Service.Models;
using Hangfire;

namespace GrpcDemo.Service.Services {
    public class PublisherService : Publisher.PublisherBase {
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
                var message = new MessageQueue { 
                    Id = 0,
                    Topic = request.Topic,
                    DTO = request.Dto,
                    Source = request.Source
                };
                var newId = await _messageRepo.AddMessageQueueAsync(message);

                _jobClient.Enqueue<IDistributionService>(m => m.DistributeMessage(newId, request.Topic));

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

        /// <summary>
        /// Receive request and queue job to update a subscriber's host URI
        /// </summary>
        /// <param name="request"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public override Task<PublishResponse> UpdateSubscriberHost(SubscriberHostMessage request, ServerCallContext context) {
            _logger.LogInformation($"Received subscriber {request.Name} host {request.Host}."); // TODO aspect logging

            try {
                _jobClient.Enqueue<ISubscriberService>(s => s.UpdateSubscriberHost(request.Name, request.Host));

                return Task.FromResult(new PublishResponse {
                    Received = true
                });
            }
            catch (Exception ex) {
                _logger.LogError($"{ex.Message}\n{ex.InnerException}");
                return Task.FromResult(new PublishResponse {
                    Received = false
                });
            }
        }

        /// <summary>
        /// Receive request and queue job to update a subscription
        /// </summary>
        /// <param name="request"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public override Task<PublishResponse> UpdateSubscription(SubscriptionMessage request, ServerCallContext context) {
            _logger.LogInformation($"Received subscriber {request.Name} topic {request.Topic} IsActive = {request.IsActive}."); // TODO aspect logging

            try {
                _jobClient.Enqueue<ISubscriberService>(s => s.UpdateSubscription(request.Name, request.Topic, request.IsActive));

                return Task.FromResult(new PublishResponse {
                    Received = true
                });
            }
            catch (Exception ex) {
                _logger.LogError($"{ex.Message}\n{ex.InnerException}");
                return Task.FromResult(new PublishResponse {
                    Received = false
                });
            }
        }
    }
}
