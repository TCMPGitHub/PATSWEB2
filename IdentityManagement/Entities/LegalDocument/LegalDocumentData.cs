using System;

namespace IdentityManagement.Entities
{
    public class LegalDocumentData
    {
        public int Id { get; set; }
        public int EpisodeId { get; set; }
        public string OtherDdesc { get; set; }
        public DateTime? DateNoticePrivacyPractice { get; set; }
        public DateTime? DateInformedConcentForTreatment { get; set; }
        public DateTime? DateOther { get; set; }
        public DateTime? DateReleaseInfoExpiration { get; set; }
        public string ReleaseTo { get; set; }
        public string ReleaseFrom { get; set; }
        public string ReleaseInformationsNote { get; set; }
        public string ActionByName { get; set; }
        public bool IsLastOne { get; set; }
        public bool Failed { get; set; }
    }
}
