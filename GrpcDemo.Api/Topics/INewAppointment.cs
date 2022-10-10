namespace GrpcDemo.Api.Topics {
    public interface INewAppointment {
        string ClinicNumber { get; set; }
        DateTime StartTime { get; set; }
    }
}