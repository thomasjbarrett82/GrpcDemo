namespace GrpcDemo.Service.Services {
    public interface IDistributionService {
        /// <summary>
        /// Distribute a message to all active topic subscribers.
        /// </summary>
        /// <param name="messageId"></param>
        /// <returns></returns>
        Task<bool> DistributeMessage(long messageId, string topic);
    }
}
