using Grpc.Net.Client;
using GrpcDemo.Api.Exceptions;
using GrpcDemo.Api.Interfaces;

namespace GrpcDemo.Api.Clients {
    public class PubClient : IPubClient {
        private readonly IMessageQueueRepo _msgRepo;

        public PubClient(IMessageQueueRepo msg) {
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

        public async Task<bool> UpdateSubscriberHostAsync(SubscriberHostMessage msg, string host) {
            using var channel = GrpcChannel.ForAddress(host);
            var pubClient = new Publisher.PublisherClient(channel);
            var pubResponse = await pubClient.UpdateSubscriberHostAsync(msg);

            if (pubResponse == null || !pubResponse.Received) {
                throw new PublishException($"Invalid response from {host}.");
            }

            return pubResponse.Received;
        }

        public async Task<bool> UpdateSubscriptionAsync(SubscriptionMessage msg, string host) {
            using var channel = GrpcChannel.ForAddress(host);
            var pubClient = new Publisher.PublisherClient(channel);
            var pubResponse = await pubClient.UpdateSubscriptionAsync(msg);

            if (pubResponse == null || !pubResponse.Received) {
                throw new PublishException($"Invalid response from {host} for topic {msg.Topic}.");
            }

            return pubResponse.Received;
        }
    }
}
