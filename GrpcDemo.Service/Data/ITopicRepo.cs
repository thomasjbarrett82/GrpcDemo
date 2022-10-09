namespace GrpcDemo.Service.Data {
    public interface ITopicRepo {
        Task UpdateTopic(string name, bool isActive, string? description);
    }
}
