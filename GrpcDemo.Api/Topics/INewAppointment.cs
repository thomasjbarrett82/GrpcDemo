namespace GrpcDemo.Api.Topics {
    public interface INewAppointment {
        string EpicId { get; set; }
        DateTime StartTime { get; set; }
    }
}