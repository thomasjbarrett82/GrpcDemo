namespace GrpcDemo.Service.Clients {
    public interface IPub {
        /// <summary>
        /// Async publish message to a subscriber
        /// </summary>
        /// <param name="messageId"></param>
        /// <param name="host"></param>
        /// <returns></returns>
        Task<bool> PublishAsync(long messageId, string host);
    }
}
