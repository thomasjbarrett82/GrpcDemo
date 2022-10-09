using GrpcDemo.Service.Models;

namespace GrpcDemo.Service.Data {
    public interface ISubscriptionRepo {
        /// <summary>
        /// Get list of registered subscribers to a topic
        /// </summary>
        /// <param name="topic"></param>
        /// <returns></returns>
        Task<IList<RegisteredSubscription>> GetRegisteredSubscriptionsAsync(string topic);

        /// <summary>
        /// Update subscriber host URI
        /// </summary>
        /// <param name="name"></param>
        /// <param name="host"></param>
        /// <returns></returns>
        Task UpdateSubscriberHostAsync(string name, string host);

        /// <summary>
        /// Update a subscription 
        /// </summary>
        /// <param name="name"></param>
        /// <param name="topic"></param>
        /// <param name="isActive"></param>
        /// <returns></returns>
        Task UpdateSubscriptionAsync(string name, string topic, bool isActive);
    }
}
