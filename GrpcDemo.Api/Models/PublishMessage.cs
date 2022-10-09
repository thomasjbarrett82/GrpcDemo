using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GrpcDemo.Api.Models {
    public class MessageQueue {
        public long Id { get; set; }
        public string Topic { get; set; }
        public string DTO { get; set; }
        public string Source { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
    }
}
