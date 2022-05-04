using System;
using System.ComponentModel.DataAnnotations;

namespace IdentityManagement.Entities
{
    public class Address
    {
        public int ID { get; set; }
        public int EpisodeID { get; set; }
        [Required(ErrorMessage = "Address Type is required.")]
        public int AddressTypeID { get; set; }
        public bool CaseEdit { get; set; }
        public string AddressTypeName { get; set; }
        public int? AddressLivingSituationID { get; set; }
        public string LivingSituationDesc { get; set; }
        public string FacilityName { get; set; }
        [Required(ErrorMessage = "Street Address is required.")]
        public string StreetAddress { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string ZIPCode { get; set; }
        public string PrimaryNumber { get; set; }
        public string SecondaryNumber { get; set; }
        public string FaxNumber { get; set; }
        [Required]
        public DateTime EffectiveDate { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public string AddressDetails { get; set; }
        public DateTime DateAction { get; set; }
        public string ActionByName { get; set; }
        public bool Inactive { get; set; }
        public bool LivingSituationShow { get; set; }
        public string ActionStatus { get; set; }
        public int Totals { get; set; }
    }

    public class AddressType
    {
        public int AddressTypeID { get; set; }
        public string AddressTypeDesc { get; set; }
    }

    public class AddressLivingSituation
    {
        public int AddressLivingSituationID { get; set; }
        public string LivingSituationDesc { get; set; }
    }

    public class StateEntity
    {
        public string State { get; set; }
    }
}
