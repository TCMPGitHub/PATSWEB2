namespace IdentityManagement.Entities
{
    public class ClientNote
    {
        public int ClientNoteID { get; set; }
        public int EpisodeID { get; set; }
        public int NoteType { get; set; }
        public string NoteField { get; set; }
        public string EntryDate { get; set; }
        public int EntryID { get; set; }
        public string NoteOrComments { get; set; }                
        public int ActionStatus { get; set; }
        public string ActionByName { get; set; }
        public string ADAE { get; set; }  // from Appointment
    }
   
}
