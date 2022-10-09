using GrpcDemo.Service.Models;

namespace GrpcDemo.Service.Data {
    public interface IMessageQueueRepo {
        /// <summary>
        /// Async get message from the queue
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        Task<MessageQueue> GetMessageQueueAsync(long id);

        /// <summary>
        /// Async add message to the queue
        /// </summary>
        /// <param name="mq"></param>
        /// <returns></returns>
        Task<long> AddMessageQueueAsync(MessageQueue mq);

        /// <summary>
        /// Async remove message from the queue
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        Task<bool> RemoveMessageQueueAsync(long id);
    }
}
