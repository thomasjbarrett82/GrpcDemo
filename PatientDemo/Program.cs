using GrpcDemo.Api;
using GrpcDemo.Api.Clients;
using GrpcDemo.Api.Constants;
using GrpcDemo.Api.Data;
using GrpcDemo.Api.Interfaces;
using GrpcDemo.Api.Topics;
using Hangfire;
using Hangfire.SqlServer;
using PatientDemo.Data;
using PatientDemo.Services;

namespace PatientDemo {
    public class Program {
        public static void Main(string[] args) {
            var builder = WebApplication.CreateBuilder(args);
            builder.Configuration.AddJsonFile(Path.Combine(Directory.GetCurrentDirectory(), "Properties", "launchSettings.json"));

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
            builder.Services.AddScoped<IPatientRepo, PatientRepo>();

            builder.Services.AddScoped<IPubServer, PublisherService>();
            builder.Services.AddScoped<IPubClient, PubClient>();

            builder.Services.AddScoped<IGenerateDemoData, GenerateDemoPatients>();

            builder.Services.AddScoped<IBackgroundJobClient, BackgroundJobClient>();

            var app = builder.Build();

            app.MapGrpcService<PublisherService>();
            app.MapGet("/", () => "Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");

            //app.UseAuthorization(); // no auth for demo
            app.UseHangfireDashboard();

            // queue jobs for host and subscriptions
            var msgHost = new SubscriberHostMessage { 
                Name = nameof(PatientDemo),
                Host = builder.Configuration.GetValue<string>("profiles:PatientDemo:applicationUrl")
            };
            BackgroundJob.Enqueue<IPubClient>(p => p.UpdateSubscriberHostAsync(msgHost, Hosts.PubSubServiceUri));

            var msgSub = new SubscriptionMessage {
                Name = nameof(PatientDemo),
                Topic = nameof(IPatientMerge),
                IsActive = true
            };
            BackgroundJob.Enqueue<IPubClient>(p => p.UpdateSubscriptionAsync(msgSub, Hosts.PubSubServiceUri));

            // queue recurring job to generate random patients every minute
            RecurringJob.AddOrUpdate<IGenerateDemoData>("GenerateRandomPatients", g => g.GeneratePatients(), "*/1 * * * *");

            // TODO queue recurring job to generate random patient merge every 5 minutes (save in DB first)
            // "*/5 * * * *"

            app.Run();
        }
    }
}
