using IdentityManagement.Entities;

namespace PATSWebV2.ViewModels.LegalDocument
{
    public class LegalDocumentViewModel
    {
        public int EpisodeId { get; set; }
        public string ActiveTabIn { get; set; }
        public bool CanEdit { get; set; }
        public LegalDocumentData legDoc { get; set; }
        public LegalDocumentViewModel() { }
    }
}