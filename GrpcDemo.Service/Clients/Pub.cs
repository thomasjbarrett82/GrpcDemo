using Grpc.Net.Client;
using GrpcDemo.Api;
using GrpcDemo.Service.Data;
using GrpcDemo.Service.Exceptions;

namespace GrpcDemo.Service.Clients {
    public class Pub : IPub {
        private readonly IMessageQueueRepo _msgRepo;

        public Pub(IMessageQueueRepo msg) {
            _msgRepo = msg;
        }

        public async Task<bool> PublishAsync(long messageId, string host) {
            var message = await _msgRepo.GetMessageQueueAsync(messageId);

            using var channel = GrpcChannel.ForAddress(host);
            var pubClient = new Publisher.PublisherClient(channel);
            var pubResponse = await pubClient.PublishAsync(new PublishMessage { 
                Topic = message.Topic,
                Dto = message.DTO,
                Source = message.Source
            });

            if (pubResponse == null || !pubResponse.Received) {
                throw new PublishException($"Invalid response from {host} for message {messageId}.");
            }

            return pubResponse.Received;
        }
    }
}
