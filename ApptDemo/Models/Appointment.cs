using GrpcDemo.Api.Topics;

namespace ApptDemo.Models {
    public class Appointment : INewAppointment {
        public string ClinicNumber { get; set; }
        public DateTime StartTime { get; set; }
    }
}
