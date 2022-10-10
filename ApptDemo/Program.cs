using ApptDemo.Data;
using ApptDemo.Services;
using GrpcDemo.Api;
using GrpcDemo.Api.Clients;
using GrpcDemo.Api.Constants;
using GrpcDemo.Api.Data;
using GrpcDemo.Api.Interfaces;
using GrpcDemo.Api.Topics;
using Hangfire;
using Hangfire.SqlServer;

namespace ApptDemo {
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
            builder.Services.AddScoped<IAppointmentRepo, AppointmentRepo>();

            builder.Services.AddScoped<IPubServer, PublisherService>();
            builder.Services.AddScoped<IPubClient, PubClient>();

            builder.Services.AddScoped<IGenerateDemoAppointments, GenerateDemoAppointments>();

            builder.Services.AddScoped<IBackgroundJobClient, BackgroundJobClient>();

            var app = builder.Build();

            app.MapGrpcService<PublisherService>();
            app.MapGet("/", () => "Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");

            //app.UseAuthorization(); // no auth for demo
            app.UseHangfireDashboard();

            // queue jobs for host and subscriptions
            var msgHost = new SubscriberHostMessage {
                Name = nameof(ApptDemo),
                Host = builder.Configuration.GetValue<string>("profiles:ApptDemo:applicationUrl")
            };
            BackgroundJob.Enqueue<IPubClient>(p => p.UpdateSubscriberHostAsync(msgHost, Hosts.PubSubServiceUri));

            var msgSub = new SubscriptionMessage {
                Name = nameof(ApptDemo),
                Topic = nameof(INewPatient),
                IsActive = true
            };
            BackgroundJob.Enqueue<IPubClient>(p => p.UpdateSubscriptionAsync(msgSub, Hosts.PubSubServiceUri));

            msgSub = new SubscriptionMessage {
                Name = nameof(ApptDemo),
                Topic = nameof(IPatientMerge),
                IsActive = true
            };
            BackgroundJob.Enqueue<IPubClient>(p => p.UpdateSubscriptionAsync(msgSub, Hosts.PubSubServiceUri));

            // queue recurring job to generate random appointments every minute
            RecurringJob.AddOrUpdate<IGenerateDemoAppointments>("GenerateRandomAppointments", g => g.GenerateAppointments(), "*/1 * * * *");

            app.Run();
        }
    }
}
