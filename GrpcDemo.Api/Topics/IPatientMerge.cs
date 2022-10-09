namespace GrpcDemo.Api.Topics {
    public interface IPatientMerge {
        string NewClinicNumber { get; set; }
        string OldClinicNumber { get; set; }
    }
}