--==================================================================
--PATS User Tables (Created at 08/17/2020)
--==================================================================
USE [PatsWebTest]
GO
--==================================================================
--EpisodeEvaluation
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'EpisodeEvaluation' AND Type = N'U')
  DROP TABLE dbo.EpisodeEvaluation
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EpisodeEvaluation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[EpisodeEvaluationGUID] [uniqueidentifier] null,
	[EvaluationItemId] [int] NOT NULL,
	[EvaluationNote] [varchar](5000) NULL,
	[EvaluatedBy] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.EpisodeEvaluation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
--==================================================================
--Address
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'Address' AND Type = N'U')
  DROP TABLE dbo.Address
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[AddressTypeID] [int] NOT NULL,
	[FacilityName] [nvarchar](150) NULL,
	[StreetAddress] [nvarchar](150) NOT NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](2) NULL,
	[ZIPCode] [nvarchar](10) NULL,
	[LivingSituationID] [int] NULL,
	[Inactive] [bit] NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NULL,
	[AddressDetails] [nvarchar](255) NULL,
	[PrimaryNumber] [nvarchar](25) NULL,
	[SecondaryNumber] [nvarchar](25) NULL,
	[FaxNumber] [nvarchar](25) NULL,
	[OrderBy] [smallint] NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
	[ActionModel] [nvarchar](10) NULL,
 CONSTRAINT [PK_dbo.Address] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--AppointmentWithClient
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'AppointmentWithClient' AND Type = N'U')
  DROP TABLE dbo.AppointmentWithClient
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentWithClient](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentID] [int] NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[ClientEventStatus] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.AppointmentWithClient] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--AppointmentWithStaff
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'AppointmentWithStaff' AND Type = N'U')
  DROP TABLE dbo.AppointmentWithStaff
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentWithStaff](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentID] [int] NOT NULL,
	[StaffID] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.AppointmentWithStaff] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--AppointmentTrace
--==================================================================
/****** Object:  Table [dbo].[AppointmentTrace]    Script Date: 9/4/2020 8:35:16 PM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'AppointmentTrace' AND Type = N'U')
  DROP TABLE dbo.AppointmentTrace
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentTrace](
	[AppointmentTraceId] [int] NOT NULL,
	[AppointmentID] [int] NOT NULL,
 CONSTRAINT [PK_dbo.AppointmentTrace] PRIMARY KEY CLUSTERED 
(
	[AppointmentTraceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--Appointment
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'Appointment' AND Type = N'U')
  DROP TABLE dbo.Appointment
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[AppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentTraceID] [int] NOT NULL,
	[AppointmentGUID] [uniqueidentifier] NULL,
	[TypeID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[LocationId] [int] NULL,
	[IsAllDay] [bit] NULL,
	[IsCompleted] [bit] NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Note] [nvarchar](1000) NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
	[ActionModel] [nvarchar](10) NULL,
	[ADAECIDs] [nvarchar](100) NULL,
	[ComplexId] [int] NULL,
 CONSTRAINT [PK_dbo.Appointment] PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--CaseIRP
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'CaseIRP' AND Type = N'U')
  DROP TABLE dbo.CaseIRP
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaseIRP](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[NeedId] [int] NOT NULL,
	[NeedStatus] [int] NULL,
	[DescriptionCurrentNeed] [nvarchar](500) NULL,
	[Note] [nvarchar](500) NULL,
	[ShortTermGoal] [nvarchar](100) NULL,
	[LongTermGoal] [nvarchar](100) NULL,
	[LongTermStatus] [bit] NULL,
	[LongTermStatusDate] [datetime] NULL,
	[PlanedIntervention] [nvarchar](255) NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.CaseIRP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--CaseMCASR
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'CaseMCASR' AND Type = N'U')
  DROP TABLE dbo.CaseMCASR
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaseMCASR](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[Section1Score] [int] NULL,
	[Section2Score] [int] NULL,
	[Section3Score] [int] NULL,
	[Section4Score] [int] NULL,
	[Question1Anwser] [int] NULL,
	[Question2Anwser] [int] NULL,
	[Question3Anwser] [int] NULL,
	[Question4Anwser] [int] NULL,
	[Question5Anwser] [int] NULL,
	[Question6Anwser] [int] NULL,
	[Question7Anwser] [int] NULL,
	[Question8Anwser] [int] NULL,
	[Question9Anwser] [int] NULL,
	[Question10Anwser] [int] NULL,
	[Question11Anwser] [int] NULL,
	[Question12Anwser] [int] NULL,
	[Question13Anwser] [int] NULL,
	[Question14Anwser] [int] NULL,
	[Question15Anwser] [int] NULL,
	[Question16Anwser] [int] NULL,
	[Question17Anwser] [int] NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.CaseMCASR] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--CaseNeedsAssessment
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'CaseNeedsAssessment' AND Type = N'U')
  DROP TABLE dbo.CaseNeedsAssessment
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaseNeedsAssessment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[AdditionalInformation] [nvarchar](500) NULL,
	[InterpreterNeeded] [bit] NULL,
	[AssessmentLauguage] [nvarchar](10) NULL,
	[ServiceNeeds] [int] NULL,
	[MCASRScore] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
	[IRPDate] [datetime] NULL,
	[IRPID] [int] NULL,
 CONSTRAINT [PK_dbo.CaseNeedsAssessment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--CaseNoteTrace
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'CaseNoteTrace' AND Type = N'U')
  DROP TABLE dbo.CaseNoteTrace
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaseNoteTrace](
	[CaseNoteId] [int] NOT NULL,
	[NoteID] [int] NOT NULL,
 CONSTRAINT [PK_dbo.CaseNoteTrace] PRIMARY KEY CLUSTERED 
(
	[CaseNoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--CaseNote
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'CaseNote' AND Type = N'U')
  DROP TABLE dbo.CaseNote
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaseNote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CaseNoteId] [int] NOT NULL,
	[EpisodeId] [int] NOT NULL,
	[Note] [varchar](5000) NULL,
	[ActionBy] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionModel] [nvarchar](10) NULL,
	[DateAction] [datetime] NOT NULL,
	[CaseNoteTypeId] [int] NOT NULL,
	[CaseContactMethodID] [int] NOT NULL,
 CONSTRAINT [PK_dbo.CaseNote] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--CaseReEntryIMHS
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'CaseReEntryIMHS' AND Type = N'U')
  DROP TABLE dbo.CaseReEntryIMHS
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaseReEntryIMHS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[Observasion] [nvarchar](500) NULL,
	[CommunicationBarrier] [bit] NULL,
	[CommunicationBarrierNote] [nvarchar](500) NULL,
	[BadNewsWorriesStress] [bit] NULL,
	[BadNewsWorriesStressNote] [nvarchar](500) NULL,
	[HearingVoice] [bit] NULL,
	[HearingVoice_Note] [nvarchar](500) NULL,
	[SeeingThingsNotThere] [bit] NULL,
	[SeeingThingsNotThereNote] [nvarchar](500) NULL,
	[TakingPsychotropicMed] [bit] NULL,
	[TakingPsychotropicMedNote] [nvarchar](500) NULL,
	[DoSupplyMed] [bit] NULL,
	[MedicationNumber] [int] NULL,
	[LastTimeMedTakenDate] [datetime] NULL,
	[BridgeMedsRequested] [bit] NULL,
	[ThoughtsHurtingOrCommittimgSuicide] [bit] NULL,
	[ThoughtsHurtingOrCommittimgSuicide_Note] [nvarchar](500) NULL,
	[ThoughtsHurtingSomeElse] [bit] NULL,
	[ThoughtsHurtingSomeElse_Note] [nvarchar](500) NULL,
	[ThoughtsHurtingWho] [nvarchar](70) NULL,
	[TakeMedicationForMedicalIssues] [bit] NULL,
	[TakeMedicationForMedicalIssues_Note] [nvarchar](500) NULL,
	[FollowupAppointment] [bit] NULL,
	[FollowupAppointmentNote] [nvarchar](500) NULL,
	[AllergiesToMedication] [bit] NULL,
	[AllergiesToMedicationNote] [nvarchar](500) NULL,
	[DrugOrAlcoholProblem] [bit] NULL,
	[DrugOrAlcoholProblemNote] [nvarchar](500) NULL,
	[AcuteRemandedTo] [nvarchar](70) NULL,
	[UrgentNextAppointmentNote] [nvarchar](70) NULL,
	[IntermediateNextAppointmentNote] [nvarchar](70) NULL,
	[RoutineNextAppointmentNote] [nvarchar](70) NULL,
	[MHChronoCompleted] [bit] NULL,
	[NewLevelCare] [int] NULL,
	[CurrentDESCCare] [int] NULL,
	[ScreeningNote] [nvarchar](500) NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
	[UrgentCurrentlyPreScribedMed] [bit] NULL,
	[UrgentHasMed] [bit] NULL,
	[UrgentBridgeMedRequested] [bit] NULL,
	[InterMediateCurrentlyPreScribedMed] [bit] NULL,
	[InterMediateHasMed] [bit] NULL,
	[InterMediateBridgeMedRequested] [bit] NULL,
	[RoutineCurrentlyPreScribedMed] [bit] NULL,
	[RoutineHasMed] [bit] NULL,
	[RoutineBridgeMedRequested] [bit] NULL,
	[HistoryMHTreatment] [bit] NULL,
	[MHStatue] [int] NULL,
	[UnApptNecessary] [bit] NULL,
 CONSTRAINT [PK_dbo.CaseReEntryIMHS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--ClientEpisode
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'ClientEpisode' AND Type = N'U')
  DROP TABLE dbo.ClientEpisode
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientEpisode](
	[ClientEpisodeID] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[Alias] [nvarchar](50) NULL,
	[IntakeDate] [datetime] NULL,
	[CaseBankedDate] [datetime] NULL,
	[CaseReferralSourceCode] [varchar](1) NULL,
	[SignificantOtherStatusCode] [nvarchar](1) NULL,
	[IsConvictedOfStalking] [bit] NULL,
	[ParoleMentalHealthLevelOfServiceID] [int] NULL,
	[ReleaseCaseTypeCode] [varchar](1) NULL,
	[ParoleDischargeDate] [datetime] NULL,
	[ControllingDischargeDate] [datetime] NULL,
	[DischargeReviewDate] [datetime] NULL,
	[CaseClosureDate] [datetime] NULL,
	[CSRAScore] [int] NULL,
	[CompasCriminogenicNeeds] [nvarchar](100) NULL,
	[AdditionalInformation] [nvarchar](255) NULL,
	[CaseClosureReasonCode] [varchar](1) NULL,
	[EthnicityID] [int] NULL,
	[PlaceOfBirth] [nvarchar](50) NULL,
	[DateAction] [datetime] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[ISMIPReferredDate] [datetime] NULL,
	[ISMIPEnrolledDate] [datetime] NULL,
	[ISMIPClosedDate] [datetime] NULL,
	[CMProgramStartDate] [datetime] NULL,
	[CMProgramClosedDate] [datetime] NULL,
	[MATProgramStartDate] [datetime] NULL,
	[MATProgramClosedDate] [datetime] NULL,
	[CMRPEStartDate] [datetime] NULL,
	[CMRPEClosedDate] [datetime] NULL,
	[ASAMDate] [datetime] NULL,
	[InclusionCriteriaMet] [bit] NULL,
	[ASAMComments] [nvarchar](255) NULL,
	[ActionStatus] [int] NOT NULL,
 CONSTRAINT [PK_dbo.ClientEpisode] PRIMARY KEY CLUSTERED 
(
	[ClientEpisodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
--==================================================================
--ClientHealthCareBenefit
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'ClientHealthCareBenefit' AND Type = N'U')
  DROP TABLE dbo.ClientHealthCareBenefit
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientHealthCareBenefit](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BenefitTypeID] [int] NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[AppliedOrRefusedOnDate] [datetime] NULL,
	[PhoneInterviewDate] [datetime] NULL,
	[OutcomeID] [int] NULL,
	[OutcomeDate] [date] NULL,
	[BICNum] [nvarchar](20) NULL,
	[IssuedOnDate] [datetime] NULL,
	[ArchivedOnDate] [datetime] NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
	[NoteOrComment] [nvarchar](255) NULL,
	[AppliedOrRefused] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.ClientHealthCareBenefit] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--ClientNote
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'ClientNote' AND Type = N'U')
  DROP TABLE dbo.ClientNote
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientNote](
	[ClientNoteID] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[NoteType] [int] NOT NULL,
	[NoteField] [varchar](50) NULL,
	[NoteOrComments] [varchar](1000) NULL,
	[EntryDate] [datetimeoffset](7) NOT NULL,
	[EntryID] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
 CONSTRAINT [PK_dbo.ClientNote] PRIMARY KEY CLUSTERED 
(
	[ClientNoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
--==================================================================
--ClientUploadFile
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'ClientUploadFile' AND Type = N'U')
  DROP TABLE dbo.ClientUploadFile
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientUploadFile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeId] [int] NOT NULL,
	[FileTypeId] [int] NOT NULL,
	[FileOrigName] [nvarchar](1000) NULL,
	[FileName] [nvarchar](1000) NULL,
	[FileData] [varbinary](max) NULL,
	[FileSize] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.ClientUploadFile] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
--==================================================================
--ClinicalIDTT
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'ClinicalIDTT' AND Type = N'U')
  DROP TABLE dbo.ClinicalIDTT
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClinicalIDTT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeId] [int] NOT NULL,
	[MemeberAttendance] [nvarchar](255) NULL,
	[OtherMemeberAttendance] [nvarchar](255) NULL,
	[RecommandationForStatus] [nvarchar](max) NULL,
	[IDTTDecision] [int] NULL,
	[IDTTDate] [datetime] NULL,
	[ActionBy] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.ClinicalIDTT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
--==================================================================
--ClinicalPMHS
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'ClinicalPMHS' AND Type = N'U')
  DROP TABLE dbo.ClinicalPMHS
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClinicalPMHS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[InclusionInPMHS] [int] NULL,
	[MentalDisorder] [bit] NULL,
	[RefForWelfare] [bit] NULL,
	[RefToContratedService] [bit] NULL,
	[TeamLeaderName] [nvarchar](70) NULL,
	[SupervisorName] [nvarchar](70) NULL,
	[TeamLeaderSigDate] [datetime] NULL,
	[SupervisorSigDate] [datetime] NULL,
	[RefToContratedServiceNote] [nvarchar](255) NULL,
	[RefForResourcePlan] [bit] NULL,
	[RefForResourcePlanNote] [nvarchar](255) NULL,
	[RefForDischarge] [bit] NULL,
	[Other] [bit] NULL,
	[OtherNote] [nvarchar](255) NULL,
	[LGAFScore] [int] NULL,
	[PsychottropicPrescribed] [bit] NULL,
	[PMHSDischargeType] [int] NULL,
	[BehavioralAlerts] [nvarchar](255) NULL,
	[LTDFNLE] [nvarchar](255) NULL,
	[PMHSChangeNote] [nvarchar](255) NULL,
	[PMHSChangeDate] [datetime] NULL,
	[PMHSDischargeNote] [nvarchar](255) NULL,
	[PMHSDischargeDate] [datetime] NULL,
	[ActionBy] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
	[ClinicianName] [nvarchar](70) NULL,
 CONSTRAINT [PK_dbo.ClinicalPMHS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--LegalDocument
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'DsmDiagnosis' AND Type = N'U')
  DROP TABLE dbo.DsmDiagnosis
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DsmDiagnosis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DsmId] [int] NOT NULL,
	[MasterDXId] [int] NOT NULL,
	[DsmTypeId] [int] NULL,
	[DsmSpecifierId] [int] NULL,
	[Note] [nvarchar](255) NULL,
	[ActionBy] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.DsmDiagnosis] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--Dsm
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'Dsm' AND Type = N'U')
  DROP TABLE dbo.Dsm
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dsm](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeId] [int] NOT NULL,
	[DsmDate] [date] NULL,
	[ActionBy] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Dsm] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--LegalDocument
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'LegalDocument' AND Type = N'U')
  DROP TABLE dbo.LegalDocument
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LegalDocument](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeId] [int] NOT NULL,
	[ReleaseInformationsNote] [nvarchar](500) NULL,
	[ReleaseTo] [nvarchar](255) NULL,
	[ReleaseFrom] [nvarchar](255) NULL,
	[OtherDdesc] [nvarchar](255) NULL,
	[DateReleaseInfoExpiration] [datetime] NULL,
	[DateNoticePrivacyPractice] [datetime] NULL,
	[DateInformedConcentForTreatment] [datetime] NULL,
	[DateOther] [datetime] NULL,
	[ActionBy] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.LegalDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--==================================================================
--PageLoad
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'PageLoad' AND Type = N'U')
  DROP TABLE dbo.PageLoad
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageLoad](
	[PageLoadID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Controller] [nvarchar](32) NOT NULL,
	[Action] [nvarchar](32) NOT NULL,
	[Method] [nvarchar](6) NOT NULL,
	[DateTimeOffset] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_dbo.PageLoad] PRIMARY KEY CLUSTERED 
(
	[PageLoadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--==================================================================
--PsychiatryASMT
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'PsychiatryASMT' AND Type = N'U')
  DROP TABLE dbo.PsychiatryASMT
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PsychiatryASMT](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeId] [int] NOT NULL,
	[ASMTDate] [date] NULL,
	[PsychiatristId] [int] NOT NULL,
	[Weight] [int] NULL,
	[ChiefComplaint] [nvarchar](2000) NULL,
	[DiscontinuedMedications] [nvarchar](2000) NULL,
	[MedicationChanges] [nvarchar](2000) NULL,
	[MedicationSideEffects] [nvarchar](2000) NULL,
	[PrevPsyAdmission] [int] NULL,
	[PrevSuicideAttempts] [int] NULL,
	[YearOutpatientPsyCare] [int] NULL,
	[PrevDrugDependence] [nvarchar](2000) NULL,
	[CurrDrugDependence] [nvarchar](2000) NULL,
	[YearDrugUse] [int] NULL,
	[LastDrugUseDate] [date] NULL,
	[MedicationAllergies] [nvarchar](2000) NULL,
	[Hospitalizations] [nvarchar](2000) NULL,
	[Surgeries] [nvarchar](2000) NULL,
	[HeadTraumaHistory] [bit] NULL,
	[HeadTraumaHistoryNote] [nvarchar](100) NULL,
	[StrokeHistory] [bit] NULL,
	[StrokeHistoryNote] [nvarchar](100) NULL,
	[LossConsciousnessHistory] [bit] NULL,
	[LossConsciousnessHistoryNote] [nvarchar](100) NULL,
	[SpinalCordInjuries] [bit] NULL,
	[SpinalCordInjuriesNote] [nvarchar](100) NULL,
	[SkeletalFracturesOrBrakes] [bit] NULL,
	[SkeletalFracturesOrBrakesNote] [nvarchar](100) NULL,
	[MVA] [bit] NULL,
	[MVANote] [nvarchar](100) NULL,
	[GunshotWounds] [bit] NULL,
	[GunshotWoundsNote] [nvarchar](100) NULL,
	[SeizuresHistory] [bit] NULL,
	[SeizuresHistoryNote] [nvarchar](100) NULL,
	[MigraineHAHistory] [bit] NULL,
	[MigraineHAHistoryNote] [nvarchar](100) NULL,
	[HeartDisease] [bit] NULL,
	[HeartDiseaseNote] [nvarchar](100) NULL,
	[Asthma] [bit] NULL,
	[AsthmaNote] [nvarchar](100) NULL,
	[COPD] [bit] NULL,
	[COPDNote] [nvarchar](100) NULL,
	[Diabetes] [bit] NULL,
	[DiabetesNote] [nvarchar](100) NULL,
	[Hyperlipidemia] [bit] NULL,
	[HyperlipidemiaNote] [nvarchar](100) NULL,
	[Hypertension] [bit] NULL,
	[HypertensionNote] [nvarchar](100) NULL,
	[Hepatitis] [bit] NULL,
	[HepatitisNote] [nvarchar](100) NULL,
	[VDOrHIV] [bit] NULL,
	[VDOrHIVNote] [nvarchar](100) NULL,
	[Anemia] [bit] NULL,
	[AnemiaNote] [nvarchar](100) NULL,
	[ThyroidAbnormalities] [bit] NULL,
	[ThyroidAbnormalitiesNote] [nvarchar](100) NULL,
	[Glaucoma] [bit] NULL,
	[GlaucomaNote] [nvarchar](100) NULL,
	[AbnormalLabResults] [bit] NULL,
	[AbnormalLabResultsNote] [nvarchar](100) NULL,
	[AbnormalEKG] [bit] NULL,
	[AbnormalEKGNote] [nvarchar](100) NULL,
	[CurrPregnancy] [bit] NULL,
	[CurrPregnancyNote] [nvarchar](100) NULL,
	[PriapismHistory] [bit] NULL,
	[PriapismHistoryNote] [nvarchar](100) NULL,
	[OtherChronicMediIll] [bit] NULL,
	[OtherChronicMediIllNote] [nvarchar](100) NULL,
	[PregnanciesNum] [int] NULL,
	[DeliveryNum] [int] NULL,
	[CurrHousing] [nvarchar](100) NULL,
	[SupportiveRelationships] [nvarchar](100) NULL,
	[CurrEmployment] [nvarchar](100) NULL,
	[LastEmployed] [nvarchar](100) NULL,
	[HighestGradeCompleted] [nvarchar](100) NULL,
	[IdentifyLearnDisablity] [bit] NULL,
	[IdentifyLearnDisablityNote] [nvarchar](100) NULL,
	[IntellectualImpairment] [bit] NULL,
	[IntellectualImpairmentNote] [nvarchar](100) NULL,
	[IncarcerationHistory] [nvarchar](100) NULL,
	[Appearance] [int] NULL,
	[PsychomotorActivity] [int] NULL,
	[AbnormalInvoluntaryMovement] [int] NULL,
	[Distractibility] [nvarchar](100) NULL,
	[Impulsivity] [nvarchar](100) NULL,
	[Concentration] [nvarchar](100) NULL,
	[MemoRegistration] [nvarchar](100) NULL,
	[AnxietyLevel] [nvarchar](100) NULL,
	[ChildhoodMemo] [int] NULL,
	[AdultMemPrevTraumatic] [int] NULL,
	[RptIntentPsyReactTrauMemo] [int] NULL,
	[RptAvoidSAWTrauMemo] [int] NULL,
	[RptFlashTrauMemo] [int] NULL,
	[RptRecurrDistressNMTrau] [int] NULL,
	[ObsessionsCompulsions] [bit] NULL,
	[AppearsRespInternStimulus] [bit] NULL,
	[Anhedonia] [int] NULL,
	[SLArticulation] [bit] NULL,
	[SLRate] [bit] NULL,
	[SLRhythm] [bit] NULL,
	[Mood] [nvarchar](100) NULL,
	[Euphoria] [nvarchar](100) NULL,
	[Demeanor] [nvarchar](100) NULL,
	[Sleep] [int] NULL,
	[PridTimeEnergizedSleep] [nvarchar](100) NULL,
	[Appetite] [nvarchar](100) NULL,
	[EnergyLevel] [nvarchar](100) NULL,
	[Libido] [nvarchar](100) NULL,
	[Irritability] [int] NULL,
	[RangeAffect] [int] NULL,
	[AppropriateContentSpeech] [bit] NULL,
	[MoodCongruent] [bit] NULL,
	[HomicidalIdeationPlanOrUntent] [int] NULL,
	[SuicidalIdeation] [int] NULL,
	[SuicidalPlan] [int] NULL,
	[SuicidalIntent] [int] NULL,
	[VisualHallucinations] [int] NULL,
	[AuditoryHallucinations] [int] NULL,
	[Insight] [int] NULL,
	[InternalStimulus] [bit] NULL,
	[ThoughtProcesses] [int] NULL,
	[RacingThoughts] [int] NULL,
	[Delusions] [nvarchar](2000) NULL,
	[GuardSuspicious] [bit] NULL,
	[HyperVigilant] [bit] NULL,
	[Preoccupation] [bit] NULL,
	[Judgement] [nvarchar](2000) NULL,
	[ExaggPsySymptoms] [bit] NULL,
	[MedTargetSymptoms] [nvarchar](100) NULL,
	[FuncImpairment] [nvarchar](70) NULL,
	[Recommendations] [nvarchar](10) NULL,
	[LabsRequested] [nvarchar](10) NULL,
	[LabsRequestedOtherNote] [nvarchar](100) NULL,
	[RTC] [int] NULL,
	[RTCWeeks] [int] NULL,
	[Discussed] [nvarchar](10) NULL,
	[ActionBy] [int] NOT NULL,
	[ActionStatus] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
	[SexPreferenceGender] [int] NULL,
	[SexPreferenceNote] [nvarchar](100) NULL,
	[CurrentMedications] [nvarchar](2000) NULL,
	[PreviousPsychiatricMedications] [nvarchar](2000) NULL,
 CONSTRAINT [PK_dbo.PsychiatryASMT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--StaffAssignment
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'StaffAssignment' AND Type = N'U')
  DROP TABLE dbo.StaffAssignment
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffAssignment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[SocialWorkerUserId] [int] NULL,
	[CaseManagerUserId] [int] NULL,
	[PsychiatristUserId] [int] NULL,
	[PsychologistUserId] [int] NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.StaffAssignment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--EpisodeTrace
--==================================================================
/****** Object:  Table [dbo].[EpisodeTrace]    Script Date: 9/4/2020 8:39:59 PM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'EpisodeTrace' AND Type = N'U')
  DROP TABLE dbo.EpisodeTrace
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EpisodeTrace](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[ClientEpisodeID] [int] NULL,
	[ClientNoteID] [int] NULL,
	[AddressID] [int] NULL,
	[StaffAssignmentID] [int] NULL,
	[HealthBenefitID] [int] NULL,
	[IDTTID] [int] NULL,
	[IRPID] [int] NULL,
	[MCASRID] [int] NULL,
	[NeedsAssessmentID] [int] NULL,
	[ReEntryIMHSID] [int] NULL,
	[PMHSID] [int] NULL,
	[DSMID] [int] NULL,
	[LegalDocID] [int] NULL,
	[ASMTID] [int] NULL,
	[DateAction] [datetime] NOT NULL,
	[EvaluationID] [int] NULL,
 CONSTRAINT [PK_dbo.EpisodeTrace] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--==================================================================
--Episode
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'Episode' AND Type = N'U')
  DROP TABLE dbo.Episode
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Episode](
	[EpisodeID] [int] IDENTITY(1,1) NOT NULL,
	[OffenderID] [int] NOT NULL,
	[SuggestionDate] [datetime] NOT NULL,
	[AuditGuid] [uniqueidentifier] NULL,
	[ParoleLocationID] [int] NULL,
	[InitialDate] [datetime] NOT NULL,
	[SomsUploadId] [int] NULL,
	[CDCRNum] [nchar](6) NOT NULL,
	[ReleaseDate] [date] NULL,
	[CustodyFacilityID] [int] NULL,
	[ReleaseCountyID] [int] NULL,
	[Lifer] [bit] NOT NULL,
	[ParoleUnit] [nvarchar](50) NULL,
	[ParoleAgent] [nvarchar](70) NULL,
	[EpisodeTrace_ID] [int] NULL,
 CONSTRAINT [PK_dbo.Episode] PRIMARY KEY CLUSTERED 
(
	[EpisodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
--==================================================================
--Offender
--==================================================================
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'Offender' AND Type = N'U')
  DROP TABLE dbo.Offender
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Offender](
	[OffenderID] [int] IDENTITY(1,1) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[PC290] [bit] NOT NULL,
	[PC457] [bit] NOT NULL,
	[USVet] [bit] NOT NULL,
	[AuditGuid] [uniqueidentifier] NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](75) NOT NULL,
	[SSN] [nchar](11) NULL,
	[DOB] [date] NULL,
	[GenderID] [int] NOT NULL,
	[MHStatus] [int] NULL,
	[PhysDisabled] [bit] NOT NULL,
	[DevDisabled] [bit] NOT NULL,
	[DDP] [nvarchar](3) NULL,
	[DPPHearing] [nvarchar](3) NULL,
	[DPPMobility] [nvarchar](3) NULL,
	[DPPSpeech] [nvarchar](3) NULL,
	[DPPVision] [nvarchar](3) NULL,
	[PID] [int] NULL,
	[InitialDate] [datetime] NOT NULL,
	[SomsUploadId] [int] NULL,
 CONSTRAINT [PK_dbo.Offender] PRIMARY KEY CLUSTERED 
(
	[OffenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--====================================================
--Create relationship of tables
--====================================================
ALTER TABLE [dbo].[EpisodeEvaluation]
   ADD CONSTRAINT [FK_dbo.EpisodeEvaluation_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[EpisodeTrace]
   ADD CONSTRAINT [FK_dbo.EpisodeTrace_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Address]
   ADD CONSTRAINT [FK_dbo.Address_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[AppointmentWithClient]
   ADD CONSTRAINT [FK_dbo.AppointmentWithClient_dbo.Appointment_AppointmentID] FOREIGN KEY (AppointmentID)
      REFERENCES dbo.Appointment (AppointmentID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[AppointmentWithStaff]
   ADD CONSTRAINT [FK_dbo.AppointmentWithStaff_dbo.Appointment_AppointmentID] FOREIGN KEY (AppointmentID)
      REFERENCES dbo.Appointment (AppointmentID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CaseIRP]
   ADD CONSTRAINT [FK_dbo.CaseIRP_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[CaseMCASR]
   ADD CONSTRAINT [FK_dbo.CaseMCASR_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[CaseNeedsAssessment]
   ADD CONSTRAINT [FK_dbo.CaseNeedsAssessment_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CaseNoteTrace]
   ADD CONSTRAINT [FK_dbo.CaseNoteTrace_dbo.CaseNote_ID] FOREIGN KEY (NoteID)
      REFERENCES dbo.CAseNote (ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CaseNote]
   ADD CONSTRAINT [FK_dbo.CaseNote_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CaseReEntryIMHS]
   ADD CONSTRAINT [FK_dbo.CaseReEntryIMHS_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ClientEpisode]
   ADD CONSTRAINT [FK_dbo.ClientEpisode_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ClientNote]
   ADD CONSTRAINT [FK_dbo.ClientNote_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ClientHealthCareBenefit]
   ADD CONSTRAINT [FK_dbo.ClientHealthCareBenefit_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ClientUploadFile]
   ADD CONSTRAINT [FK_dbo.ClientUploadFile_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ClinicalIDTT]
   ADD CONSTRAINT [FK_dbo.ClinicalIDTT_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ClinicalPMHS]
   ADD CONSTRAINT [FK_dbo.ClinicalPMHS_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Dsm]
   ADD CONSTRAINT [FK_dbo.Dsm_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[DsmDiagnosis]
   ADD CONSTRAINT [FK_dbo.DsmDiagnosis_dbo.Dsm_EpisodeID] FOREIGN KEY (DsmId)
      REFERENCES dbo.Dsm (Id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LegalDocument]
   ADD CONSTRAINT [FK_dbo.LegalDocument_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PsychiatryASMT]
   ADD CONSTRAINT [FK_dbo.PsychiatryASMT_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[StaffAssignment]
   ADD CONSTRAINT [FK_dbo.StaffAssignment_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Episode]
   ADD CONSTRAINT [FK_dbo.Episode_dbo.Offender_OffenderID] FOREIGN KEY (OffenderID)
      REFERENCES dbo.Offender (OffenderID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

CREATE NONCLUSTERED INDEX [IX_EpisodeID] ON [dbo].[EpisodeTrace]
(
	[EpisodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO