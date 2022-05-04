using Dapper;
using IdentityManagement.Entities;
using IdentityManagement.Entities.SocialWork;
using IdentityManagement.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Data
{
    //public enum DataRetriveTypeEnum
    //{
    //    First = 1,
    //    List
    //}
    //public class MapItem
    //{
    //    public Type Type { get; private set; }
    //    public DataRetriveTypeEnum DataRetriveType { get; private set; }
    //    public string PropertyName { get; private set; }

    //    public MapItem(Type type, DataRetriveTypeEnum dataRetriveType, string propertyName)
    //    {
    //        Type = type;
    //        DataRetriveType = dataRetriveType;
    //        PropertyName = propertyName;
    //    }
    //}

    public static class SqlHelper
    {
        public static T GetRecord<T>(string spName, List<ParameterInfo> parameters)
        {
            T objRecord = default(T);

            using (SqlConnection objConnection = new SqlConnection(Utils.ConnectionString()))
            {
                try
                {
                    objConnection.Open();
                    DynamicParameters p = new DynamicParameters();
                    foreach (var param in parameters)
                    {
                         p.Add("@" + param.ParameterName, param.ParameterValue);
                    }                
                    objRecord = SqlMapper.Query<T>(objConnection, spName, p, commandType: CommandType.StoredProcedure).FirstOrDefault();
                }
                catch (SqlException sqlEx)
                {
                    throw sqlEx;
                }
                catch (Exception err)
                {
                    throw err;
                }
                finally
                {
                    objConnection.Close();
                }
                return objRecord;
            }
        }
        
        public static List<T> GetRecords<T>(string spName, List<ParameterInfo> parameters)
        {
            List<T> recordList = new List<T>();
            using (SqlConnection objConnection = new SqlConnection(Utils.ConnectionString()))
            {
               try
                {
                    objConnection.Open();
                    DynamicParameters p = new DynamicParameters();
                    foreach (var param in parameters)
                    {
                        p.Add("@" + param.ParameterName, param.ParameterValue);
                    }               
                    recordList = SqlMapper.Query<T>(objConnection, spName, p, commandTimeout: 90, commandType: CommandType.StoredProcedure).AsList();
                }
                catch (SqlException sqlEx)
                {
                    throw sqlEx;
                }
                catch (Exception err)
                {
                    throw err;
                }
                finally
                {
                    objConnection.Close();
                }
            }
            return recordList;
        }
        public static string ExecuteOutputParam(string spName, DynamicParameters parameters)
        {
            //T recordList = new T();
            string record = string.Empty;
            using (SqlConnection objConnection = new SqlConnection(Utils.ConnectionString()))
            {
                try
                {
                    objConnection.Open();                              
                    record = SqlMapper.Query<string>(objConnection, spName, parameters, commandTimeout: 90, commandType: CommandType.StoredProcedure).SingleOrDefault();
                }
                catch (SqlException sqlEx)
                {
                    throw sqlEx;
                }
                catch (Exception err)
                {
                    throw err;
                }
                finally
                {
                    objConnection.Close();
                }
            }
            return record;
        }
        public static List<object> GetMultiRecordsets<T>(string spName, List<ParameterInfo> parameters, List<string> ObjectSets)
        {
            List<object> recordList = new List<object>();
            using (SqlConnection objConnection = new SqlConnection(Utils.ConnectionString()))
            {
                objConnection.Open();
                DynamicParameters p = new DynamicParameters();
                foreach (var param in parameters)
                {
                    p.Add("@" + param.ParameterName, param.ParameterValue);
                }

                try
                {
                    using (var multipleResults = SqlMapper.QueryMultiple(objConnection, spName, p, commandType: CommandType.StoredProcedure))
                    {
                        for (int i = 0; i < ObjectSets.Count; i++)
                        {
                            switch (ObjectSets[i])
                            {
                                case "ClientProfile":
                                    {
                                        var set = multipleResults.Read<ClientProfile>();
                                        recordList.Add(set.FirstOrDefault());
                                        break;
                                    }
                                case "NeedsAssessment":
                                    {
                                        var set = multipleResults.Read<NeedsAssessmentData>();
                                        recordList.Add(set.FirstOrDefault());
                                        break;
                                    }
                                case "IRP":
                                    {
                                        var set = multipleResults.Read<IRPSet>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "Complex":
                                    {
                                        var set = multipleResults.Read<Complex>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "Ethnicity":
                                    {
                                        var set = multipleResults.Read<Ethnicity>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "Gender":
                                    {
                                        var set = multipleResults.Read<Gender>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "SignificantOtherStatus":
                                    {
                                        var set = multipleResults.Read<SignificantOtherStatus>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "CaseClosureReason":
                                    {
                                        var set = multipleResults.Read<CaseClosureReason>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "CaseReferralSource":
                                    {
                                        var set = multipleResults.Read<CaseReferralSource>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "ParoleMentalHealthLevelOfService":
                                    {
                                        var set = multipleResults.Read<ParoleMentalHealthLevelOfService>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "PPSummary":
                                    {
                                        var set = multipleResults.Read<PPSummary>();
                                        recordList.Add(set.FirstOrDefault());
                                        break;
                                    }
                                case "CaseAssignSmy":
                                    {
                                        var set = multipleResults.Read<CaseAssignSmy>();
                                        if (set.Count() == 0)
                                            recordList.Add(null);
                                        else
                                            recordList.Add(set.ToList());
                                        break;
                                    }
                                case "SummaryCollection":
                                    {
                                        var set = multipleResults.Read<SummaryCollection>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "AppointmentSummary":
                                    {
                                        var set = multipleResults.Read<AppointmentSummary>();
                                        if (set.Count() == 0)
                                            recordList.Add(null);
                                        else
                                            recordList.Add(set.ToList());
                                        break;
                                    }
                                case "MCASRData":
                                    {
                                        var set = multipleResults.Read<MCASRData>();
                                        recordList.Add(set.FirstOrDefault());
                                        break;
                                    }
                                case "ScaleQuestion":
                                    {
                                        var set = multipleResults.Read<ScaleQuestion>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "ClinicalIDTTData":
                                    {
                                        var set = multipleResults.Read<ClinicalIDTTData>();
                                        recordList.Add(set.FirstOrDefault());
                                        break;
                                    }
                                case "FinalRecommendations":
                                    {
                                        var set = multipleResults.Read<FinalRecommendations>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "PMHProfileData":
                                    {
                                        var set = multipleResults.Read<PMHProfileData>();
                                        recordList.Add(set.FirstOrDefault());
                                        break;
                                    }
                                case "Facilities":
                                    {
                                        var set = multipleResults.Read<Facilities>();
                                        recordList.Add(set.ToList());
                                        break;
                                    }
                                case "ParoleLocationID":
                                    {
                                        var set = multipleResults.Read<int>();
                                        recordList.Add(set.FirstOrDefault());
                                        break;
                                    }
                            }
                        }
                    }
                }
                catch (SqlException sqlEx)
                {
                    throw sqlEx;
                }
                catch (Exception err)
                {
                    throw err;
                }
                finally { 
                   objConnection.Close();
                }
            }
            return recordList;
        }

        public static int GetIntRecord<T>(string spName, List<ParameterInfo> parameters)
        {
            int intRecord = 0;
            using (SqlConnection objConnection = new SqlConnection(Utils.ConnectionString()))
            {
                try
                {
                    objConnection.Open();
                    DynamicParameters p = new DynamicParameters();
                    foreach (var param in parameters)
                    {
                        p.Add("@" + param.ParameterName, param.ParameterValue);
                    }

                    using (var reader = SqlMapper.ExecuteReader(objConnection, spName, p, commandType: CommandType.StoredProcedure))
                    {
                        if (reader != null && reader.Read())
                        {
                            intRecord = Convert.ToInt32(reader[0].ToString());
                        }
                    }
                }
                catch (SqlException sqlEx)
                {
                    throw sqlEx;
                }
                catch (Exception err)
                {
                    throw err;
                }
                finally
                {
                    objConnection.Close();
                }
            }
            return intRecord;
        }
        public static int ExecuteQuery(string spName, List<ParameterInfo> parameters)
        {
            int success = 0;
            using (SqlConnection objConnection = new SqlConnection(Utils.ConnectionString()))
            {
                try
                {
                    objConnection.Open();
                    DynamicParameters p = new DynamicParameters();
                    foreach (var param in parameters)
                    {
                        p.Add("@" + param.ParameterName, param.ParameterValue);
                    }
                    success = SqlMapper.Execute(objConnection, spName, p, commandType: CommandType.StoredProcedure);
                }
                catch (SqlException sqlEx)
                {
                    throw sqlEx;
                }
                catch (Exception err)
                {
                    throw err;
                }
                finally
                {
                    objConnection.Close();
                }
            }
            return success;
        }
        public static int ExecuteQueryWithIntOutputParam(string spName, List<ParameterInfo> parameters)
        {
            int success = 0;
            using (SqlConnection objConnection = new SqlConnection(Utils.ConnectionString()))
            {
                try { 
                    objConnection.Open();
                    DynamicParameters p = new DynamicParameters();
                    foreach (var param in parameters)
                    {
                       p.Add("@" + param.ParameterName, param.ParameterValue);
                    }              
                   success = SqlMapper.Execute(objConnection, spName, p, commandType: CommandType.StoredProcedure);
                }
                catch (SqlException sqlEx)
                {
                    throw sqlEx;
                }
                catch (Exception err)
                {
                    throw err;
                }
                finally {
                    objConnection.Close();
                }
            }
            return success;
        }
        public static int ExecuteQueryWithReturnValue(string SqlQery)
        {
            int newId = 0;
            using (SqlConnection objConnection = new SqlConnection(Utils.ConnectionString()))
            {
                try
                {
                    objConnection.Open();
                    newId = objConnection.QuerySingle<int>(SqlQery);
                }
                catch (SqlException sqlEx)
                {
                    throw sqlEx;
                }
                catch (Exception err)
                {
                    throw err;
                }
                finally
                {
                    objConnection.Close();
                }
            }
            return newId;
        }
        public static int ExecuteCommand(string query)
        {
            int success = 0;
            using (SqlConnection objConnection = new SqlConnection(Utils.ConnectionString()))
            {                
                try
                {                 
                    objConnection.Open();
                    SqlTransaction trans = objConnection.BeginTransaction();
                    SqlCommand comm = new SqlCommand(query, objConnection, trans);
                    success = comm.ExecuteNonQuery();
                    //success = SqlMapper.Execute(objConnection, query, commandType: CommandType.Text, trans);
                    trans.Commit();
                }
                catch (SqlException sqlEx)
                {
                    throw sqlEx;
                }
                catch (Exception err)
                {
                    throw err;
                }
                finally
                {
                    objConnection.Close();
                }
            }
            return success;
        }
        public static List<T> ExecuteCommands<T>(string query)
        {
            List<T> recordList = new List<T>();
            using (SqlConnection objConnection = new SqlConnection(Utils.ConnectionString()))
            {
                try
                {
                    objConnection.Open();
                    recordList = SqlMapper.Query<T>(objConnection, query, commandType: CommandType.Text).AsList();
                }
                catch (SqlException sqlEx)
                {
                    throw sqlEx;
                }
                catch (Exception err)
                {
                    throw err;
                }
                finally
                {
                    objConnection.Close();
                }
            }
            return recordList;
        }
    }
}

