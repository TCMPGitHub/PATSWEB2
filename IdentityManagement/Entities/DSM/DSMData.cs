using System;
using System.ComponentModel.DataAnnotations;

namespace IdentityManagement.Entities
{
    public class DsmData
    {
        public int Id { get; set; }
        public int DsmId { get; set; }
        //[Range(1, int.MaxValue, ErrorMessage = "ICD Code is requested")]
        public int MasterDXId { get; set; }
        //[DataType(DataType.DateTime), Column(TypeName = "Date")]
        public DateTime? DateDsmDate { get; set; }
        //public string DsmDate { get; set; }
        public string IcdCode { get; set; }
        //public string Version { get; set; }
        //public string OnsetDate { get; set; }
        public string DsmDesc { get; set; }
        public string Comments { get; set; }
        public string DsmType { get; set; }
        public string DsmSpecifier { get; set; }
        public string ClinicalName { get; set; }
        public string ActionStatus { get; set; }
        public int? DsmTypeId { get; set; }       //question - type
        public int? DsmSpecifierId { get; set; }  //subquestion - specifier
    }
    public class DsmDates
    {
        public int DsmId { get; set; }
        public string DsmDate { get; set; }
    }

    public class ICDCodeList
    {
        public int MasterDXId { get; set; }
        public string Dsm { get; set; }
    }
    public class DsmQuestionList
    {
        public int DsmTypeId { get; set; }
        public string DsmType { get; set; }
    }
    public class DsmSubQuestionList
    {
        public int DsmSpecifierId { get; set; }
        public string DsmSpecifier { get; set; }
    }
}
