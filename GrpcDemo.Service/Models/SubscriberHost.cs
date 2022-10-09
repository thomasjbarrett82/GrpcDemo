using GrpcDemo.Api.Topics;

namespace GrpcDemo.Service.Models {
    public class SubscriberHost : IUpdateSubscriberHost {
        public string Name { get; set; }
        public string Host { get; set; }
    }
}
