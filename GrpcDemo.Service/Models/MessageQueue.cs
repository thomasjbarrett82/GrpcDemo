namespace GrpcDemo.Service.Models {
    public class MessageQueue {
        public long Id { get; set; }
        public string Topic { get; set; }
        public string DTO { get; set; }
        public string Source { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
    }
}
