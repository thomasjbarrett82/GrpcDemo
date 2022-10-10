using GrpcDemo.Api.Topics;

namespace ApptDemo.Models {
    public class Patient : INewPatient {
        public string EpicId { get; set; }
        public string ClinicNumber { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}
