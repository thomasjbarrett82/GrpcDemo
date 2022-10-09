using Grpc.Core;

namespace GrpcDemo.Api.Interfaces {
    public interface IPubServer {
        /// <summary>
        /// Receive and acknowledge published message
        /// </summary>
        /// <param name="request"></param>
        /// <param name="context"></param>
        /// <returns></returns>
        Task<PublishResponse> Publish(PublishMessage request, ServerCallContext context);
    }
}
