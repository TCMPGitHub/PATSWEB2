Update [dbo].[tlkpCaseNeeds] SET Name = 'FOOD' Where NeedId = 1
  Update [dbo].[tlkpCaseNeeds] SET Name = 'CLOTHING' Where NeedId = 2
  Update [dbo].[tlkpCaseNeeds] SET Name = 'SHELTER (HOUSING)' Where NeedId = 3
  Update [dbo].[tlkpCaseNeeds] SET Name = 'MEDICATION MANAGEMENT' Where NeedId = 4
  Update [dbo].[tlkpCaseNeeds] SET Name = 'HEALTH BENEFITS (MEDI-CAL, MEDI-CARE, VA, PRIVATE INSURANCE)' Where NeedId = 5
  Update [dbo].[tlkpCaseNeeds] SET Name = 'MEDICAL SERVICES' Where NeedId = 6
  Update [dbo].[tlkpCaseNeeds] SET Name = 'DENTAL SERVICES' Where NeedId = 7
  Update [dbo].[tlkpCaseNeeds] SET Name = 'MENTAL HEALTH SERVICES' Where NeedId = 8
  Update [dbo].[tlkpCaseNeeds] SET Name = 'SUBSTANCE USE' Where NeedId = 9
  Update [dbo].[tlkpCaseNeeds] SET Name = 'INCOME (GA/GR, SSI, EMPLOYMENT, CALWORKS, ETC.)' Where NeedId = 10
  Update [dbo].[tlkpCaseNeeds] SET Name = 'VIDEO/TELEPHONIC COMMUNICATION' Where NeedId = 11
  Update [dbo].[tlkpCaseNeeds] SET Name = 'TRANSPORTATION' Where NeedId = 12
  Update [dbo].[tlkpCaseNeeds] SET Name = 'IDENTIFICATION CARD (DL, State ID, Parole ID, Military ID, etc.)' Where NeedId = 13
  Update [dbo].[tlkpCaseNeeds] SET Name = 'FAMILY and/or ADDITIONAL SUPPORT SYSTEM' Where NeedId = 14
  Update [dbo].[tlkpCaseNeeds] SET Name = 'ACADEMIC/VOCATIONAL PROGRAMS' Where NeedId = 15

  INSERT INTO [dbo].[tlkpCaseNeeds] (Name, DateCreated) VALUES ('OTHER/ADDITIONAL NEED', GetDate())


USE [PATSWebV2Test]
GO

/****** Object:  Table [dbo].[CaseBHRIRP]    Script Date: 5/19/2022 9:24:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CaseBHRIRP](
	[IRPId] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
        [CurrentPhaseStatus] [int] NULL,
	[BHRIRPJson] [ntext] NULL,
	[AddtionalRemarks] [nvarchar](500) NULL,
	[ActionStatus] [int] NOT NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
	[BassUserID] [int] NULL,
 CONSTRAINT [PK_dbo.CaseBHRIRP] PRIMARY KEY CLUSTERED 
(
	[IRPId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[CaseBHRIRP]  WITH CHECK ADD  CONSTRAINT [FK_CaseBHRIRP_EpisodeID] FOREIGN KEY([IRPId])
REFERENCES [dbo].[CaseBHRIRP] ([IRPId])
GO

ALTER TABLE [dbo].[CaseBHRIRP] CHECK CONSTRAINT [FK_CaseBHRIRP_EpisodeID]
GO

USE [PATSWebV2Test]
GO

/****** Object:  Table [dbo].[tlkpCaseClosureReason]    Script Date: 5/20/2022 7:50:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tlkpIdentifiedBarriersToIntervention](
	[IBTIID] int identity(1, 1) NOT NULL,
	[IBTIIDValue] [varchar](100) NOT NULL,
	[DateAction] DateTime NOT NULL,
	[Disabled] [bit] NULL,
) ON [PRIMARY]

GO


INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('No identified barrier', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('Lack of available program', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('Waitlist for program', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('Delay in appointment for community resource', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('Condition of parole restriction', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('Client unwilling or unmotivated', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('Immigration issues', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('No Birth Certificate', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('No contact with client', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('Hospitalization', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('In custody', GetDate())
INSERT INTO dbo.tlkpIdentifiedBarriersToIntervention(IBTIIDValue, DateAction) VALUES ('Other (explain in notes)', GetDate())

ALTER TABLE [dbo].[EpisodeTrace]
ADD BHRIRPID INT NULL

CREATE TABLE [dbo].[tlkpBarriersFrequency](
	[BarrFreqID] int identity(1, 1) NOT NULL,
	[BarrFreqValue] [varchar](100) NOT NULL,
	[DateAction] DateTime NOT NULL,
	[Disabled] [bit] NULL,
) ON [PRIMARY]

GO

INSERT INTO dbo.tlkpBarriersFrequency([BarrFreqValue], DateAction) VALUES ('Chronic', GetDate())
INSERT INTO dbo.tlkpBarriersFrequency([BarrFreqValue], DateAction) VALUES ('Temporary', GetDate())
INSERT INTO dbo.tlkpBarriersFrequency([BarrFreqValue], DateAction) VALUES ('Sporadic ', GetDate())