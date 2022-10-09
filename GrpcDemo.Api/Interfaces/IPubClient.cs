namespace GrpcDemo.Api.Interfaces {
    public interface IPubClient {
        /// <summary>
        /// Async publish message to a subscriber
        /// </summary>
        /// <param name="messageId"></param>
        /// <param name="host"></param>
        /// <returns></returns>
        Task<bool> PublishAsync(long messageId, string host);

        /// <summary>
        /// Async publish update to subscriber host URI
        /// </summary>
        /// <param name="msg"></param>
        /// <returns></returns>
        Task<bool> UpdateSubscriberHostAsync(SubscriberHostMessage msg, string host);

        /// <summary>
        /// Async publish update for subscription
        /// </summary>
        /// <param name="msg"></param>
        /// <returns></returns>
        Task<bool> UpdateSubscriptionAsync(SubscriptionMessage msg, string host);
    }
}
