using System.Runtime.Serialization;

namespace GrpcDemo.Service.Exceptions {
    public class PublishException : InvalidOperationException {
        public PublishException() {
        }

        public PublishException(string message) : base(message) {
        }

        public PublishException(string message, Exception inner) : base(message, inner) {
        }

        public PublishException(SerializationInfo info, StreamingContext ctx) : base(info, ctx) {
        }
    }
}
