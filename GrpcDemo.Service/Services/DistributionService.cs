using GrpcDemo.Api.Interfaces;
using GrpcDemo.Service.Data;
using Hangfire;

namespace GrpcDemo.Service.Services {
    public interface IDistributionService {
        /// <summary>
        /// Distribute a message to all active topic subscribers.
        /// </summary>
        /// <param name="messageId"></param>
        /// <returns></returns>
        Task<bool> DistributeMessage(long messageId, string topic);
    }

    public class DistributionService : IDistributionService {
        private readonly ILogger<DistributionService> _logger;
        private readonly ISubscriptionRepo _subsRepo;
        private readonly IBackgroundJobClient _jobClient;

        public DistributionService(ILogger<DistributionService> log, ISubscriptionRepo subs, IBackgroundJobClient job) {
            _logger = log;
            _subsRepo = subs;
            _jobClient = job;
        }

        public async Task<bool> DistributeMessage(long messageId, string topic) {
           var subscriptions = await _subsRepo.GetRegisteredSubscriptionsAsync(topic);

            if (subscriptions.Count ==0) {
                _logger.LogWarning($"No subscribers for topic {topic}."); // TODO aspect logging
                return false;
            }

            foreach (var subscription in subscriptions) {
                _jobClient.Enqueue<IPubClient>(p => p.PublishAsync(messageId, subscription.Host));
            }

            return true;
        }
    }
}
