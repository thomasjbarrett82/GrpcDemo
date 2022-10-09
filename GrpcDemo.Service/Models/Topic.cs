namespace GrpcDemo.Service.Models {
    public class Topic {
        public string Name { get; set; }
        public string? Description { get; set; }
        public bool IsActive { get; set; }
        // TODO include a Version property to handle changes over time
    }
}
