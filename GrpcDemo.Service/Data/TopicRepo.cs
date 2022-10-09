using Dapper;
using GrpcDemo.Api.Data;
using GrpcDemo.Service.Constants;
using System.Data;

namespace GrpcDemo.Service.Data {
    public interface ITopicRepo {
        Task UpdateTopic(string name, bool isActive, string? description);
    }

    public class TopicRepo : ITopicRepo {
        private readonly DapperContext _context;

        public TopicRepo(DapperContext context) {
            _context = context;
        }

        public async Task UpdateTopic(string name, bool isActive, string? description) {
            using var db = _context.CreateConnection();
            var param = new DynamicParameters();
            param.Add("@Name", name);
            param.Add("@IsActive", isActive);
            param.Add("@Description", description);
            await db.ExecuteAsync(QueryCommands.UpdateTopic, param, commandType: CommandType.StoredProcedure);
        }
    }
}
