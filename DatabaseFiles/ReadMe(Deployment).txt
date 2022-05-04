Deploy PATSWebV2 read me

1  execute query: ALTER TABLE dbo.CaseNeedsAssessment ADD IRPID int null
2 Add the floowing new tables:
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
=====================================
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
=====================================
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
======================================
ALTER TABLE [dbo].[EpisodeTrace]
   ADD CONSTRAINT [FK_dbo.EpisodeTrace_dbo.Episode_EpisodeID] FOREIGN KEY (EpisodeID)
      REFERENCES dbo.Episode (EpisodeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
======================================
ALTER TABLE [dbo].[CaseNoteTrace]
   ADD CONSTRAINT [FK_dbo.CaseNoteTrace_dbo.CaseNote_ID] FOREIGN KEY (NoteID)
      REFERENCES dbo.CAseNote (ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
======================================
2  exec both PATSWebV2UserFunctions .sql and PATSWebV2StoredProcedures.sql  
2. execute PatsTraceDataQueries.sql