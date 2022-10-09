﻿using Dapper;
using GrpcDemo.Service.Constants;
using GrpcDemo.Service.Models;
using System.Data;

namespace GrpcDemo.Service.Data {
    public class MessageQueueRepo : IMessageQueueRepo {
        private readonly DapperContext _context;

        public MessageQueueRepo(DapperContext context) {
            _context = context;
        }

        public async Task<long> AddMessageQueueAsync(MessageQueue mq) {
            using var db = _context.CreateConnection();
            var param = new DynamicParameters();
            param.Add("@Topic", mq.Topic);
            param.Add("@DTO", mq.DTO);
            param.Add("@Source", mq.Source);
            return await db.ExecuteScalarAsync<long>(QueryCommands.AddMessageToQueue, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<MessageQueue> GetMessageQueueAsync(long id) {
            using var db = _context.CreateConnection();
            var param = new DynamicParameters();
            param.Add("@Id", id);
            return await db.QueryFirstOrDefaultAsync<MessageQueue>(QueryCommands.GetMessageFromQueue, param, commandType: CommandType.StoredProcedure);
        }

        public Task<bool> RemoveMessageQueueAsync(long id) {
            // TODO use this for purging old messages - use date range instead?
            throw new NotImplementedException();
        }
    }
}
