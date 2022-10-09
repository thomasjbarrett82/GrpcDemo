namespace GrpcDemo.Service.Services {
    public interface ISubscriberService {
        /// <summary>
        /// Update a subscriber's host URI
        /// </summary>
        /// <param name="name"></param>
        /// <param name="host"></param>
        /// <returns></returns>
        Task<bool> UpdateSubscriberHost(string name, string host);

        /// <summary>
        /// Update a subscription
        /// </summary>
        /// <param name="name"></param>
        /// <param name="topic"></param>
        /// <param name="isActive"></param>
        /// <returns></returns>
        Task<bool> UpdateSubscription(string name, string topic, bool isActive);
    }
}
