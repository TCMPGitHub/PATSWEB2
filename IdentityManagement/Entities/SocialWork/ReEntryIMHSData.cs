using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IdentityManagement.Entities
{
    public class ReEntryIMHSData
    {
        public int CaseReEntryID { get; set; }
        public string Observasion { get; set; }
        public bool CommunicationBarrierYes { get; set; }
        public bool CommunicationBarrierNo { get; set; }
        public string CommunicationBarrierNote { get; set; }
        public bool BadNewsWorriesStressYes { get; set; }
        public bool BadNewsWorriesStressNo { get; set; }
        public string BadNewsWorriesStressNote { get; set; }
        public bool HearingVoiceYes { get; set; }
        public bool HearingVoiceNo { get; set; }
        public string HearingVoice_Note { get; set; }
        public bool SeeingThingsNotThereYes { get; set; }
        public bool SeeingThingsNotThereNo { get; set; }
        public string SeeingThingsNotThereNote { get; set; }
        public bool TakingPsychotropicMedYes { get; set; }
        public bool TakingPsychotropicMedNo { get; set; }
        public string TakingPsychotropicMedNote { get; set; }
        public bool DoSupplyMedYes { get; set; }
        public bool DoSupplyMedNo { get; set; }
        public int? MedicationNumber { get; set; }
        public DateTime? LastTimeMedTakenDate { get; set; }
        public bool BridgeMedsRequestedYes { get; set; }
        public bool BridgeMedsRequestedNo { get; set; }
        public bool ThoughtsHurtingOrCommittimgSuicideYes { get; set; }
        public bool ThoughtsHurtingOrCommittimgSuicideNo { get; set; }
        public string ThoughtsHurtingOrCommittimgSuicide_Note { get; set; }
        public bool ThoughtsHurtingSomeElseYes { get; set; }
        public bool ThoughtsHurtingSomeElseNo { get; set; }
        public string ThoughtsHurtingSomeElse_Note { get; set; }
        public string ThoughtsHurtingWho { get; set; }
        public bool TakeMedicationForMedicalIssuesYes { get; set; }
        public bool TakeMedicationForMedicalIssuesNo { get; set; }
        public string TakeMedicationForMedicalIssues_Note { get; set; }
        public bool FollowupAppointmentYes { get; set; }
        public bool FollowupAppointmentNo { get; set; }
        public string FollowupAppointmentNote { get; set; }
        public bool AllergiesToMedicationYes { get; set; }
        public bool AllergiesToMedicationNo { get; set; }
        public string AllergiesToMedicationNote { get; set; }
        public bool DrugOrAlcoholProblemYes { get; set; }
        public bool DrugOrAlcoholProblemNo { get; set; }
        public string DrugOrAlcoholProblemNote { get; set; }
        public string AcuteRemandedTo { get; set; }
        public string UrgentNextAppointmentNote { get; set; }
        public string IntermediateNextAppointmentNote { get; set; }
        public string RoutineNextAppointmentNote { get; set; }
        public bool MHChronoCompletedYes { get; set; }
        public bool MHChronoCompletedNo { get; set; }
        public bool NewLevelCareEOP { get; set; }
        public bool NewLevelCareCCCMS { get; set; }
        public bool NewLevelCareMedNecessity { get; set; }
        public string ScreeningNote { get; set; }
        public bool UrgentCurrentlyPreScribedMedYes { get; set; }
        public bool UrgentCurrentlyPreScribedMedNo { get; set; }
        public bool UrgentHasMedYes { get; set; }
        public bool UrgentHasMedNo { get; set; }
        public bool UrgentBridgeMedRequestedYes { get; set; }
        public bool UrgentBridgeMedRequestedNo { get; set; }
        public bool InterMediateCurrentlyPreScribedMedYes { get; set; }
        public bool InterMediateCurrentlyPreScribedMedNo { get; set; }
        public bool InterMediateHasMedYes { get; set; }
        public bool InterMediateHasMedNo { get; set; }
        public bool InterMediateBridgeMedRequestedYes { get; set; }
        public bool InterMediateBridgeMedRequestedNo { get; set; }
        public bool RoutineHasMedYes { get; set; }
        public bool RoutineHasMedNo { get; set; }
        public bool RoutineCurrentlyPreScribedMedYes { get; set; }
        public bool RoutineCurrentlyPreScribedMedNo { get; set; }
        public bool RoutineBridgeMedRequestedYes { get; set; }
        public bool RoutineBridgeMedRequestedNo { get; set; }
        public bool UnApptNecessary { get; set; }
        public bool MHStatusWNL { get; set; }
        public bool MHStatusABWNL { get; set; }
        public bool HisMHTreatmentYes { get; set; }
        public bool HisMHTreatmentNo { get; set; }
        public bool CurrentDESCEOP { get; set; }
        public bool CurrentDESCCCCMS { get; set; }
        public bool CurrentDESCNone { get; set; }
        public string ActionName { get; set; }
        public DateTime? CaseReEntryDate { get; set; }
        public string CMAssigneTo { get; set; }
        public bool IsLastReentrySet { get; set; }
        public string PrintUrl { get; set; }
    }

    public class CaseReEntryDates
    {
        public int CaseRIMHSID { get; set; }
        public string CaseReEntryDate { get; set; }
    }
}
