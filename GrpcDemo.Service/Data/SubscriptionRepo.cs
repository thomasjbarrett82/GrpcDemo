using Dapper;
using GrpcDemo.Api.Data;
using GrpcDemo.Service.Constants;
using GrpcDemo.Service.Models;
using System.Data;

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

    public class SubscriptionRepo : ISubscriptionRepo {
        private readonly DapperContext _context;

        public SubscriptionRepo(DapperContext context) {
            _context = context;
        }

        public async Task<IList<RegisteredSubscription>> GetRegisteredSubscriptionsAsync(string topic) {
            using var db = _context.CreateConnection();
            var param = new DynamicParameters();
            param.Add("@IsActive", true);
            param.Add("@Topic", topic);
            var results = await db.QueryAsync<RegisteredSubscription>(QueryCommands.GetSubscriptionRegistry, param, commandType: CommandType.StoredProcedure);
            return results.ToList();
        }

        public async Task UpdateSubscriberHostAsync(string name, string host) {
            using var db = _context.CreateConnection();
            var param = new DynamicParameters();
            param.Add("@Name", name);
            param.Add("@Host", host);
            await db.ExecuteAsync(QueryCommands.UpdateSubscriberHost, param, commandType: CommandType.StoredProcedure);
        }

        public async Task UpdateSubscriptionAsync(string name, string topic, bool isActive) {
            using var db = _context.CreateConnection();
            var param = new DynamicParameters();
            param.Add("@Name", name);
            param.Add("@Topic", topic);
            param.Add("@IsActive", isActive);
            await db.ExecuteAsync(QueryCommands.UpdateSubscription, param, commandType: CommandType.StoredProcedure);
        }
    }
}
