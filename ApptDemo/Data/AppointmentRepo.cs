using ApptDemo.Constants;
using ApptDemo.Models;
using Dapper;
using GrpcDemo.Api.Data;
using System.Data;

namespace ApptDemo.Data {
    public interface IAppointmentRepo {
        Task<IEnumerable<AppointmentDto>> GetAppointmentsByPatient(string clinicNumber);

        Task<long> UpdateAppointment(long? id, string clinicNumber, string fullData);
    }

    public class AppointmentRepo : IAppointmentRepo {
        private readonly DapperContext _context;

        public AppointmentRepo(DapperContext context) {
            _context = context;
        }

        public async Task<IEnumerable<AppointmentDto>> GetAppointmentsByPatient(string clinicNumber) {
            using var db = _context.CreateConnection();
            var param = new DynamicParameters();
            param.Add("@ClinicNumber", clinicNumber);
            return await db.QueryAsync<AppointmentDto>(QueryCommands.GetAppointmentsByPatient, param, commandType: CommandType.StoredProcedure);
        }

        public async Task<long> UpdateAppointment(long? id, string clinicNumber, string fullData) {
            using var db = _context.CreateConnection();
            var param = new DynamicParameters();
            param.Add("@Id", id);
            param.Add("@ClinicNumber", clinicNumber);
            param.Add("@FullData", fullData);
            return await db.ExecuteScalarAsync<long>(QueryCommands.UpdateAppointment, param, commandType: CommandType.StoredProcedure);
        }
    }
}
