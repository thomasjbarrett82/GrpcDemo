using GrpcDemo.Api.Topics;

namespace GrpcDemo.Service.Models {
    public class Subscription : IUpdateSubscription {
        public string Name { get; set; }
        public string Topic { get; set; }
        public bool IsActive { get; set; }
    }
}
