using GrpcDemo.Service.Models;
using Microsoft.Extensions.Hosting;

namespace GrpcDemo.Service.Services {
    public interface ITopicService {
        /// <summary>
        /// Update list of topics
        /// </summary>
        /// <param name="topics"></param>
        /// <returns></returns>
        Task<bool> UpdateTopics(IList<Topic>? topics);
    }
}
