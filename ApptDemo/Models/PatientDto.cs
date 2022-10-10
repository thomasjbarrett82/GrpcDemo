namespace ApptDemo.Models {
    public class PatientDto {
        public int Id { get; set; }
        public string ClinicNumber { get; set; }
        public string FullData { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public string EditedBy { get; set; }
        public DateTime EditedOn { get; set; }
    }
}
