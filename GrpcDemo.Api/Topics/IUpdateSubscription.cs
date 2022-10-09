namespace GrpcDemo.Api.Topics {
    public interface IUpdateSubscription {
        string Name { get; set; }
        string Topic { get; set; }
        bool IsActive { get; set; }
    }
}
