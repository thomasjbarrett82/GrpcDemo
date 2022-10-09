namespace GrpcDemo.Api.Topics {
    public interface INewPatient {
        string ClinicNumber { get; set; }
        string EpicId { get; set; }
        string FirstName { get; set; }
        string LastName { get; set; }
    }
}