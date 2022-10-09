using GrpcDemo.Api.Topics;
using GrpcDemo.Service.Data;
using GrpcDemo.Service.Models;
using GrpcDemo.Service.Services;
using Hangfire;
using Hangfire.SqlServer;
using System.Reflection;

namespace GrpcDemo.Service {
    public class Program {
        public static void Main(string[] args) {
            var builder = WebApplication.CreateBuilder(args);

            builder.Services.AddHangfire(config => config
                .SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
                .UseColouredConsoleLogProvider()
                .UseSimpleAssemblyNameTypeSerializer()
                .UseRecommendedSerializerSettings()
                .UseSqlServerStorage(builder.Configuration.GetConnectionString("SqlConnection"), 
                    new SqlServerStorageOptions {
                        CommandBatchMaxTimeout = TimeSpan.FromMinutes(5),
                        SlidingInvisibilityTimeout = TimeSpan.FromMinutes(5),
                        QueuePollInterval = TimeSpan.Zero,
                        UseRecommendedIsolationLevel = true,
                        DisableGlobalLocks = true
                    })
                );
            builder.Services.AddHangfireServer();

            builder.Services.AddGrpc();

            builder.Services.AddSingleton<DapperContext>();
            builder.Services.AddScoped<IMessageQueueRepo, MessageQueueRepo>();
            builder.Services.AddScoped<ISubscriptionRepo, SubscriptionRepo>();
            builder.Services.AddScoped<ITopicRepo, TopicRepo>();

            builder.Services.AddScoped<IDistributionService, DistributionService>();
            builder.Services.AddScoped<ISubscriberService, SubscriberService>();
            builder.Services.AddScoped<ITopicService, TopicService>();

            builder.Services.AddScoped<IBackgroundJobClient, BackgroundJobClient>();

            var app = builder.Build();

            app.MapGrpcService<PublisherService>();
            app.MapGet("/", () => "Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");

            //app.UseAuthorization(); // no auth for demo
            app.UseHangfireDashboard();

            // initialize Topics based on GrpcDemo.Api.Topics classes
            var apiAssembly = Assembly.GetAssembly(typeof(IUpdateSubscription));
            if (apiAssembly == null)
                throw new InvalidOperationException();

            var topics = apiAssembly
                .GetTypes()
                .Where(t => t.Namespace == "GrpcDemo.Api.Topics" && t.IsInterface) // TODO magic string
                .Select(t => new Topic {
                    Name = t.Name,
                    Description = string.Empty, // TODO pull value from an attribute?
                    IsActive = true
                })
                .ToList();
            BackgroundJob.Enqueue<ITopicService>(t => t.UpdateTopics(topics));

            app.Run();
        }
    }
}