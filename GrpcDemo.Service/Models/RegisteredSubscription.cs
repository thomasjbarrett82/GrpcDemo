namespace GrpcDemo.Service.Models {
    public class RegisteredSubscription {
        public int TopicId { get; set; }
        public string TopicName { get; set; }
        public int SubscriberId { get; set; }
        public string SubscriberName { get; set; }
        public string Host { get; set; }
    }
}
