using Dapper;
using GrpcDemo.Api.Data;
using PatientDemo.Constants;
using PatientDemo.Models;

namespace PatientDemo.Data {
    public interface IPatientRepo {
        Task<PatientDto> GetPatient(string clinicNumber);

        Task<int> UpdatePatient(int? id, string clinicNumber, string fullData);
    }

    public class PatientRepo : IPatientRepo {
        private readonly DapperContext _context;

        public PatientRepo(DapperContext context) {
            _context = context;
        }

        public async Task<PatientDto> GetPatient(string clinicNumber) {
            using var db = _context.CreateConnection();
            var param = new DynamicParameters();
            param.Add("@ClinicNumber", clinicNumber);
            return await db.QueryFirstOrDefaultAsync<PatientDto>(QueryCommands.GetPatient, param, commandType: System.Data.CommandType.StoredProcedure);
        }

        public async Task<int> UpdatePatient(int? id, string clinicNumber, string fullData) {
            using var db = _context.CreateConnection();
            var param = new DynamicParameters();
            param.Add("@Id", id);
            param.Add("@ClinicNumber", clinicNumber);
            param.Add("@FullData", fullData);
            return await db.ExecuteScalarAsync<int>(QueryCommands.UpdatePatient, param, commandType: System.Data.CommandType.StoredProcedure);
        }
    }
}
