--==================================================================
--PATS User Lookup Tables w/ data  (Created at 08/17/2020)
--==================================================================
USE [PatsWebTest]
GO
--==================================================================
--tlkpADAOrEC
--run this query to grib all data from exist prod database
  --SELECT 'INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
  --        VALUES (' + Convert(varchar, ID) + ',''' + ADAECDescription + ''',' + 
  --        CONVERT(varchar,DisplayOrder) + ',''' + Convert(Varchar, GetDate()) + ''')'  
  --  FROM dbo.tlkpADAOrEC

  --SELECT * FROM dbo.tlkpADAOrEC
--==================================================================
/****** Object:  Table [dbo].[tlkpADAOrEC]    Script Date: 8/17/2020 7:43:31 PM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpADAOrEC' AND Type = N'U')
  DROP TABLE dbo.tlkpADAOrEC
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpADAOrEC](
	[ID] [int] NOT NULL,
	[ADAECDescription] [nvarchar](100) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Disabled] [bit] NULL,
	[DateAction] [datetime] NOT NULL
CONSTRAINT [PK_dbo.tlkpADAOrEC] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--Insert 
--SET IDENTITY_INSERT dbo.[tlkpADAOrEC] ON

  INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (1,'Assistive Hearing Device (e.q. Amplifier)',1,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (2,'Assistive Visual Device (e.q. Magnifier)',2,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (3,'Assistive Visual Device (e.q. Own reading glasses)',3,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (4,'Foreign Language Interpeter-Telephonic',4,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (5,'Foreign Language Interpeter/Certified DAPO staff',5,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (6,'Foreign Language Interpeter/Contractor-In-Person',6,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (7,'Hearing Aids',7,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (8,'Mobility/Physical Assisstance',8,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (9,'No Accommodations Requested/Required',9,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (10,'Other - Specify:',10,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (11,'Read Lips',11,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (12,'Read/Spoke Loudly',12,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (13,'Read/Spoke Slowly',13,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (14,'Sign Language Interpreter (SLI)',14,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (15,'Sign Language Interpreter (VRI)',15,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (16,'TDD Services',16,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (17,'Use Simple English',17,'Aug 17 2020  8:41AM')
INSERT INTO dbo.tlkpADAOrEC (ID,ADAECDescription, DisPlayOrder, DateAction) 
          VALUES (18,'Written Notes',18,'Aug 17 2020  8:41AM')

--==================================================================
--tlkpAddressLivingSituation
--run this query to grib all data from exist prod database
 --SELECT 'INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (' + Convert(varchar, AddressLivingSituationID) + 
 -- ',''' + LivingSituationDesc + ''',' + (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',''' + 
 -- Convert(Varchar, GetDate()) + ''')'  
 -- FROM dbo.[tlkpAddressLivingSituation]
 --SELECT * FROM dbo.[tlkpAddressLivingSituation]
--==================================================================
/****** Object:  Table [dbo].[tlkpAddressLivingSituation]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpAddressLivingSituation' AND Type = N'U')
  DROP TABLE dbo.tlkpAddressLivingSituation
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpAddressLivingSituation](
	[AddressLivingSituationID] [int] IDENTITY(1,1) NOT NULL,
	[LivingSituationDesc] [nvarchar](50) NOT NULL,
	[Disabled] [bit] NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpAddressLivingSituation] PRIMARY KEY CLUSTERED 
(
	[AddressLivingSituationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpAddressLivingSituation] ON
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (1,'Sober Living Center',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (2,'Hospital Treatment Center',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (3,'Shelter',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (4,'Hotel/Motel',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (5,'Own/Rent House or Apt',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (6,'Parole Housing',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (7,'Staying with Friend/Relative',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (8,'County Drug/Alcohol Program',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (9,'Prison/Jail',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (10,'Homeless',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (11,'Board and Care',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (12,'Locked Facility',null,'Aug 17 2020  8:50AM')
INSERT INTO dbo.[tlkpAddressLivingSituation] (AddressLivingSituationID,LivingSituationDesc, Disabled, DateAction) VALUES (13,'Other',null,'Aug 17 2020  8:50AM')
SET IDENTITY_INSERT dbo.[tlkpAddressLivingSituation] OFF
--==================================================================
--tlkpAddressType
--run this query to grib all data from exist prod database
  --SELECT 'INSERT INTO dbo.[tlkpAddressType] (AddressTypeID,AddressTypeDesc, OrderBy, Disabled, DateAction) VALUES (' + Convert(varchar, AddressTypeID) + 
  --',''' + AddressTypeDesc + ''',' + Convert(varchar, AddressTypeID) + ',' + (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',''' + 
  --Convert(Varchar, GetDate()) + ''')'  
  --FROM dbo.[tlkpAddressType]
 --SELECT * FROM dbo.[tlkpAddressType]
--==================================================================
/****** Object:  Table [dbo].[tlkpAddressType]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpAddressType' AND Type = N'U')
  DROP TABLE dbo.tlkpAddressType
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tlkpAddressType](
	[AddressTypeID] [int] IDENTITY(1,1) NOT NULL,
	[AddressTypeDesc] [nvarchar](100) NOT NULL,
	[OrderBy] [int] NULL,
	[Disabled] [bit] NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpAddressType] PRIMARY KEY CLUSTERED 
(
	[AddressTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET IDENTITY_INSERT dbo.[tlkpAddressType] ON
INSERT INTO dbo.[tlkpAddressType] (AddressTypeID,AddressTypeDesc, OrderBy, Disabled, DateAction) VALUES (1,'Primary Residence',1,null,'Aug 17 2020  9:50AM')
INSERT INTO dbo.[tlkpAddressType] (AddressTypeID,AddressTypeDesc, OrderBy, Disabled, DateAction) VALUES (2,'Secondary Residence',2,null,'Aug 17 2020  9:50AM')
INSERT INTO dbo.[tlkpAddressType] (AddressTypeID,AddressTypeDesc, OrderBy, Disabled, DateAction) VALUES (3,'Emergency Contact',3,null,'Aug 17 2020  9:50AM')
INSERT INTO dbo.[tlkpAddressType] (AddressTypeID,AddressTypeDesc, OrderBy, Disabled, DateAction) VALUES (4,'Work',4,null,'Aug 17 2020  9:50AM')
SET IDENTITY_INSERT dbo.[tlkpAddressType] OFF

--==================================================================
--tlkpApplicationOutcome
--run this query to grib all data from exist prod database
  --SELECT 'INSERT INTO dbo.[tlkpApplicationOutcome] (ApplicationOutcomeID, Name, Position, IsMediCalOutcome, DateAction) VALUES (' + Convert(varchar, ApplicationOutcomeID) + 
  --',''' + Name + ''',' + Convert(varchar, Position) + ',' + 
  --(CASE WHEN [IsMediCalOutcome] IS NULL THEN 'null' ELSE CONVERT(varchar,[IsMediCalOutcome]) END) + ',' +
  --(CASE WHEN [IsSsiOutcome] IS NULL THEN 'null' ELSE CONVERT(varchar,[IsSsiOutcome]) END) + ',' +
  --(CASE WHEN [IsVaOutcome] IS NULL THEN 'null' ELSE CONVERT(varchar,[IsVaOutcome]) END) + ')'
  --FROM dbo.[tlkpApplicationOutcome]
 --SELECT * FROM dbo.[tlkpApplicationOutcome]
--==================================================================
/****** Object:  Table [dbo].[tlkpApplicationOutcome]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpApplicationOutcome' AND Type = N'U')
  DROP TABLE dbo.tlkpApplicationOutcome
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tlkpApplicationOutcome](
	[ApplicationOutcomeID] [int] IDENTITY(1,1) NOT NULL,
	[Position] [int] NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[IsMediCalOutcome] [bit] NOT NULL,
	[IsSsiOutcome] [bit] NOT NULL,
	[IsVaOutcome] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpApplicationOutcome] PRIMARY KEY CLUSTERED 
(
	[ApplicationOutcomeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET IDENTITY_INSERT dbo.[tlkpApplicationOutcome] ON
INSERT INTO dbo.[tlkpApplicationOutcome] (ApplicationOutcomeID, Name, Position, IsMediCalOutcome, IsSsiOutcome,IsVaOutcome) VALUES (1,'Approved',0,1,1,1)
INSERT INTO dbo.[tlkpApplicationOutcome] (ApplicationOutcomeID, Name, Position, IsMediCalOutcome, IsSsiOutcome,IsVaOutcome) VALUES (2,'Denied',1,1,1,1)
INSERT INTO dbo.[tlkpApplicationOutcome] (ApplicationOutcomeID, Name, Position, IsMediCalOutcome, IsSsiOutcome,IsVaOutcome) VALUES (4,'Incomplete',2,1,1,0)
INSERT INTO dbo.[tlkpApplicationOutcome] (ApplicationOutcomeID, Name, Position, IsMediCalOutcome, IsSsiOutcome,IsVaOutcome) VALUES (3,'Reinstated',3,1,1,0)
INSERT INTO dbo.[tlkpApplicationOutcome] (ApplicationOutcomeID, Name, Position, IsMediCalOutcome, IsSsiOutcome,IsVaOutcome) VALUES (5,'Pre-Approved',4,0,0,0)
INSERT INTO dbo.[tlkpApplicationOutcome] (ApplicationOutcomeID, Name, Position, IsMediCalOutcome, IsSsiOutcome,IsVaOutcome) VALUES (6,'Not Qualified',5,0,0,0)
SET IDENTITY_INSERT dbo.[tlkpApplicationOutcome] OFF

--==================================================================
--tlkpApplicationType
--run this query to grib all data from exist prod database
  --SELECT 'INSERT INTO dbo.[tlkpApplicationType] (ApplicationTypeID, Name, HasBIC, HasPhoneInterview, Disabled) VALUES (' + 
  --Convert(varchar, ApplicationTypeID) + ',''' + Name + ''',' + 
  --(CASE WHEN [HasBIC] IS NULL THEN 'null' ELSE CONVERT(varchar,[HasBIC]) END) + ',' +
  --(CASE WHEN [HasPhoneInterview] IS NULL THEN 'null' ELSE CONVERT(varchar,[HasPhoneInterview]) END) + ',' +
  --(CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ')'
  --FROM dbo.[tlkpApplicationType]
 --SELECT * FROM dbo.[tlkpApplicationType]
--==================================================================
/****** Object:  Table [dbo].[tlkpApplicationType]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpApplicationType' AND Type = N'U')
  DROP TABLE dbo.tlkpApplicationType
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tlkpApplicationType](
	[ApplicationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[HasBIC] [bit] NOT NULL,
	[HasPhoneInterview] [bit] NOT NULL,
	[Disabled] [bit] NULL,
 CONSTRAINT [PK_dbo.tlkpApplicationType] PRIMARY KEY CLUSTERED 
(
	[ApplicationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET IDENTITY_INSERT dbo.[tlkpApplicationType] ON
INSERT INTO dbo.[tlkpApplicationType] (ApplicationTypeID, Name, HasBIC, HasPhoneInterview, Disabled) VALUES (1,'SSI',0,1,null)
INSERT INTO dbo.[tlkpApplicationType] (ApplicationTypeID, Name, HasBIC, HasPhoneInterview, Disabled) VALUES (2,'VA',0,0,null)
INSERT INTO dbo.[tlkpApplicationType] (ApplicationTypeID, Name, HasBIC, HasPhoneInterview, Disabled) VALUES (3,'Medi-Cal',1,0,null)
INSERT INTO dbo.[tlkpApplicationType] (ApplicationTypeID, Name, HasBIC, HasPhoneInterview, Disabled) VALUES (4,'Private Insurance',0,0,null)
INSERT INTO dbo.[tlkpApplicationType] (ApplicationTypeID, Name, HasBIC, HasPhoneInterview, Disabled) VALUES (5,'Refused To State',0,0,null)
SET IDENTITY_INSERT dbo.[tlkpApplicationType] OFF

--==================================================================
--tlkpAppointmentStatus
--run this query to grib all data from exist prod database
 --SELECT 'INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (' + 
 -- Convert(varchar, ID) + ',''' + ApptLongDescr + ''',''' + ApptShortDescr + ''',' +
 -- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',''' +
 --   Convert(varchar,GetDate()) + ''')'
 -- FROM dbo.[tlkpAppointmentStatus]
 --SELECT * FROM dbo.[tlkpAppointmentStatus]
--==================================================================
/****** Object:  Table [dbo].[tlkpAppointmentStatus]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpAppointmentStatus' AND Type = N'U')
  DROP TABLE dbo.tlkpAppointmentStatus
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpAppointmentStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ApptLongDescr] [nvarchar](25) NOT NULL,
	[ApptShortDescr] [nvarchar](15) NOT NULL,
	[Disabled] [bit] NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpAppointmentStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT dbo.[tlkpAppointmentStatus] ON
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (1,'Absent','Absent',null,'Aug 17 2020 10:18AM')
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (2,'Pending','Pending',null,'Aug 17 2020 10:18AM')
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (3,'Canceled','Canceled',null,'Aug 17 2020 10:18AM')
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (4,'Present','Present',null,'Aug 17 2020 10:18AM')
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (5,'Excused','Excused',null,'Aug 17 2020 10:18AM')
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (6,'Case Management','Case MGMT',null,'Aug 17 2020 10:18AM')
SET IDENTITY_INSERT dbo.[tlkpAppointmentStatus] OFF

--==================================================================
--tlkpAppointmentStatus
--run this query to grib all data from exist prod database
 --SELECT 'INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (' + 
 -- Convert(varchar, ID) + ',''' + ApptLongDescr + ''',''' + ApptShortDescr + ''',' +
 -- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',''' +
 --   Convert(varchar,GetDate()) + ''')'
 -- FROM dbo.[tlkpAppointmentStatus]
 --SELECT * FROM dbo.[tlkpAppointmentStatus]
--==================================================================
/****** Object:  Table [dbo].[tlkpAppointmentStatus]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpAppointmentStatus' AND Type = N'U')
  DROP TABLE dbo.tlkpAppointmentStatus
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpAppointmentStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ApptLongDescr] [nvarchar](25) NOT NULL,
	[ApptShortDescr] [nvarchar](15) NOT NULL,
	[Disabled] [bit] NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpAppointmentStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT dbo.[tlkpAppointmentStatus] ON
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (1,'Absent','Absent',null,'Aug 17 2020 10:18AM')
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (2,'Pending','Pending',null,'Aug 17 2020 10:18AM')
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (3,'Canceled','Canceled',null,'Aug 17 2020 10:18AM')
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (4,'Present','Present',null,'Aug 17 2020 10:18AM')
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (5,'Excused','Excused',null,'Aug 17 2020 10:18AM')
INSERT INTO dbo.[tlkpAppointmentStatus] (ID, ApptLongDescr, ApptShortDescr, Disabled, DateAction) VALUES (6,'Case Management','Case MGMT',null,'Aug 17 2020 10:18AM')
SET IDENTITY_INSERT dbo.[tlkpAppointmentStatus] OFF

--==================================================================
--tlkpAppointmentType
--run this query to grib all data from exist prod database
 --SELECT 'INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
 -- EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) VALUES (' + 
 -- Convert(varchar, ID) + ',''' + EvtTCode + ''',''' + EvtTLongDescr + ''',''' + EvtTShortDescr + ''',' +
 -- (CASE WHEN EvtTSlots IS NULL THEN 'null' ELSE Convert(varchar, EvtTSlots) END) + ',' + 
 -- (CASE WHEN EvtTSlotLimit IS NULL THEN 'null' ELSE Convert(varchar,EvtTSlotLimit) END) + ',''' +
 -- EvtTTextColor + ''',''' + EvtTCellColor + ''',' + 
 -- (CASE WHEN ShowCDCRNum IS NULL THEN 'null' ELSE Convert(varchar, ShowCDCRNum) END) + ',' +
 -- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',''' +
 --   Convert(varchar,GetDate()) + ''')'
 -- FROM dbo.[tlkpAppointmentType]
 --SELECT * FROM dbo.[tlkpAppointmentType]
--==================================================================
/****** Object:  Table [dbo].[tlkpAppointmentType]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpAppointmentType' AND Type = N'U')
  DROP TABLE dbo.tlkpAppointmentType
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpAppointmentType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EvtTCode] [nvarchar](5) NOT NULL,
	[EvtTLongDescr] [nvarchar](50) NOT NULL,
	[EvtTShortDescr] [nvarchar](25) NOT NULL,
	[EvtTSlots] [smallint] NULL,
	[EvtTSlotLimit] [smallint] NULL,
	[EvtTTextColor] [nvarchar](10) NULL,
	[EvtTCellColor] [nvarchar](10) NULL,
	[ShowCDCRNum] [bit] NULL,
	[Disabled] [bit] NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpAppointmentType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpAppointmentType] ON
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (1,'I','Individual Session','Individual Session',2,6,'#CECECE','#d7bde2',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (2,'D','IDTT Meeting','IDTT Mt',2,8,'#CECECE','#0ef5e5',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (3,'SB','Schedule Blocked','Schedule Blocked',2,8,'#CECECE','#8e44ad',0,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (4,'SC','Screening','Screening',2,8,'#CECECE','#1abc9c',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (5,'W','Case Work','Case Work',2,8,'#CECECE','#b1d619',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (6,'C','Crisis Intervention','Crisis Intrvn',2,8,'#CECECE','#95a5a6',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (7,'M','Medication Monitoring','Med. Monitoring',2,6,'#CECECE','#f5b7b1',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (8,'E','Initial Evaluation','Init. Eval',2,6,'#CECECE','#f1c40f',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (9,'G','Group Session','Group',2,6,'#CECECE','#3e61ee',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (10,'T','Telemedicine','Telemed',2,6,'#CECECE','#ee0a53',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (11,'O','Other','Other',2,6,'#CECECE','#85c1e9',0,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (12,'SC3','Screening Follow up 3 days','Followup 3',2,6,'#CECECE','#F7F6AF',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (13,'SC7','Screening Follow up 7 days','Followup 7',2,6,'#CECECE','#F7F6AF',1,null,'Aug 17 2020 10:40AM')
INSERT INTO dbo.[tlkpAppointmentType] (ID, EvtTCode, EvtTLongDescr, EvtTShortDescr,EvtTSlots,
  EvtTSlotLimit,EvtTTextColor,EvtTCellColor,ShowCDCRNum, Disabled,DateAction) 
VALUES (14,'SC30','Screening Follow up 30 days','Followup 30',2,6,'#CECECE','#F7F6AF',1,null,'Aug 17 2020 10:40AM')
SET IDENTITY_INSERT dbo.[tlkpAppointmentType] OFF

--==================================================================
--tlkpCaseClosureReason
--run this query to grib all data from exist prod database
 --INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) 
 -- VALUES ('A','Parolee Not Amenable','Parolee Not Amenable',1')
 --SELECT * FROM dbo.[tlkpCaseClosureReason]
--==================================================================
/****** Object:  Table [dbo].[tlkpCaseClosureReason]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCaseClosureReason' AND Type = N'U')
  DROP TABLE dbo.tlkpCaseClosureReason
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpCaseClosureReason](
	[CaseClosureReasonCode] [varchar](1) NOT NULL,
	[CaseClosureReasonDescLong] [varchar](100) NOT NULL,
	[CaseClosureReasonDescShort] [varchar](20) NOT NULL,
	[Disabled] [bit] NULL,
 CONSTRAINT [PK_dbo.tlkpCaseClosureReason] PRIMARY KEY CLUSTERED 
(
	[CaseClosureReasonCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('A','Parolee Not Amenable','Parolee Not Amenable',1)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('C','NRP','NRP',1)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('D','Parole Discharge','Parole Discharge',null)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('E','Receiving Treatment Elsewhere','Rcving Tx Elsewhere',null)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('F','TCMP Forced Discharge','Forced Discharge',1)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('H','State Hospital','State Hospital',null)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('I','INS Hold','INS Hold',null)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('J','Local Jail Confinement','Jail Confinement',1)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('K','Did not Keep Appts.','Did not Keep Appts.',1)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('M','Maximum Benefit','Max Benefit',null)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('N','Not within 90 days','Not within 90 days',1)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('P','PAL','PAL',null)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('R','Re-incarcerated','Re-incarcerated',null)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('S','PRCS','PRCS',null)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('T','Transferred Out of State','Trans Out of State',null)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('V','Revoked','Revoked',1)
INSERT INTO dbo.[tlkpCaseClosureReason] (CaseClosureReasonCode, CaseClosureReasonDescLong, CaseClosureReasonDescShort, Disabled) VALUES ('X','Deceased','Deceased',null)

--==================================================================
--tlkpCaseContactMethod
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpCaseContactMethod] (CaseContactMethodID, ContactMethod, DateAction, Disabled) VALUES (' + 
-- Convert(varchar, CaseContactMethodID) + ',''' + ContactMethod + ''',''' + CONVERT(varchar,GetDate()) + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END)  + ')'
--  FROM dbo.[tlkpCaseContactMethod]
 --SELECT * FROM dbo.[tlkpCaseContactMethod]
--==================================================================
/****** Object:  Table [dbo].[tlkpCaseContactMethod]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCaseContactMethod' AND Type = N'U')
  DROP TABLE dbo.tlkpCaseContactMethod
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpCaseContactMethod](
	[CaseContactMethodID] [int] IDENTITY(1,1) NOT NULL,
	[ContactMethod] [nvarchar](30) NOT NULL,
	[DateAction] [datetime] NOT NULL,
	[Disabled] [bit] NULL,
 CONSTRAINT [PK_dbo.tlkpCaseContactMethod] PRIMARY KEY CLUSTERED 
(
	[CaseContactMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT dbo.[tlkpCaseContactMethod] ON
INSERT INTO dbo.[tlkpCaseContactMethod] (CaseContactMethodID, ContactMethod, DateAction, Disabled) VALUES (1,'Face to Face','Aug 17 2020 11:36AM',null)
INSERT INTO dbo.[tlkpCaseContactMethod] (CaseContactMethodID, ContactMethod, DateAction, Disabled) VALUES (2,'Telephonic','Aug 17 2020 11:36AM',null)
INSERT INTO dbo.[tlkpCaseContactMethod] (CaseContactMethodID, ContactMethod, DateAction, Disabled) VALUES (3,'Other','Aug 17 2020 11:36AM',null)
SET IDENTITY_INSERT dbo.[tlkpCaseContactMethod] OFF
GO
--==================================================================
--tlkpCaseNoteType
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpCaseNoteType] (CaseNoteTypeId, Name, Disabled) VALUES (' + 
-- Convert(varchar, CaseNoteTypeId) + ',''' + Name + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END)  + ')'
--  FROM dbo.[tlkpCaseNoteType]
 --SELECT * FROM dbo.[tlkpCaseNoteType]
--==================================================================
/****** Object:  Table [dbo].[tlkpCaseNoteType]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCaseNoteType' AND Type = N'U')
  DROP TABLE dbo.tlkpCaseNoteType
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpCaseNoteType](
	[CaseNoteTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NULL,
	[Disabled] [bit] NULL,
 CONSTRAINT [PK_dbo.tlkpCaseNoteType] PRIMARY KEY CLUSTERED 
(
	[CaseNoteTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT dbo.[tlkpCaseNoteType] ON
INSERT INTO dbo.[tlkpCaseNoteType] (CaseNoteTypeId, Name, Disabled) VALUES (1,'Intake',null)
INSERT INTO dbo.[tlkpCaseNoteType] (CaseNoteTypeId, Name, Disabled) VALUES (2,'Progress',null)
INSERT INTO dbo.[tlkpCaseNoteType] (CaseNoteTypeId, Name, Disabled) VALUES (3,'Case Management',null)
INSERT INTO dbo.[tlkpCaseNoteType] (CaseNoteTypeId, Name, Disabled) VALUES (4,'Major Event',null)
INSERT INTO dbo.[tlkpCaseNoteType] (CaseNoteTypeId, Name, Disabled) VALUES (5,'Discharge',null)
INSERT INTO dbo.[tlkpCaseNoteType] (CaseNoteTypeId, Name, Disabled) VALUES (6,'Follow-up',null)
INSERT INTO dbo.[tlkpCaseNoteType] (CaseNoteTypeId, Name, Disabled) VALUES (7,'Lab Report',null)
INSERT INTO dbo.[tlkpCaseNoteType] (CaseNoteTypeId, Name, Disabled) VALUES (8,'Other',null)
INSERT INTO dbo.[tlkpCaseNoteType] (CaseNoteTypeId, Name, Disabled) VALUES (9,'Telemed',null)
SET IDENTITY_INSERT dbo.[tlkpCaseNoteType] OFF
--==================================================================
--tlkpCaseNeeds
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (' + 
-- Convert(varchar, NeedId) + ',''' + Name + ''',''' + Convert(Varchar, DateCreated) + ''',' +
-- (CASE WHEN [DateDisabed] IS NULL THEN 'null' ELSE CONVERT(varchar,[DateDisabed]) END)  + ')'
--  FROM dbo.[tlkpCaseNeeds]
 --SELECT * FROM dbo.[tlkpCaseNeeds]
--==================================================================
/****** Object:  Table [dbo].[tlkpCaseNeeds]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCaseNeeds' AND Type = N'U')
  DROP TABLE dbo.tlkpCaseNeeds
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpCaseNeeds](
	[NeedId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](60) NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateDisabed] [datetime] NULL,
 CONSTRAINT [PK_dbo.tlkpCaseNeeds] PRIMARY KEY CLUSTERED 
(
	[NeedId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT dbo.[tlkpCaseNeeds] ON
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (1,'FOOD','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (2,'CLOTHING','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (3,'SHELTER','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (4,'MEDICATION MANAGEMENT','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (5,'HEALTH BENIFITS (ACA, MEDI-CAL,VA)','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (6,'MEDICAL/DENTAL SERVICES','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (7,'MENTAL HEALTH SERVICES','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (8,'SUBSTANCE ABUSE SERVICES','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (9,'INCOME (GA/GR, SSI, EMPLOYMENT, CAL WORKS)','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (10,'IDENTIFICATION CARD(STATE ID, DMV)','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (11,'LIFE SKILLS','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (12,'PRODUCTIVE ACTIVITES','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (13,'PRO-SOCIAL SUPPORT SYSTEMS','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (14,'ACADEMIC/VOCATIONAL PROGRAMS','May  5 2017 12:41PM',null)
INSERT INTO dbo.[tlkpCaseNeeds] (NeedId, Name, DateCreated, DateDisabed) VALUES (15,'COMMUNITY REINTEGRATION/DISCHARGE SUSTAINABILITY PLAN','May  5 2017 12:41PM',null)
SET IDENTITY_INSERT dbo.[tlkpCaseNeeds] OFF
GO
--==================================================================
--tlkpCaseReferralSource
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpCaseReferralSource] (CaseReferralSourceCode, Name, Disabled) VALUES (''' + 
-- CaseReferralSourceCode + ''',''' + CaseReferralSourceDesc + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END)  + ')'
--  FROM dbo.[tlkpCaseReferralSource]
 --SELECT * FROM dbo.[tlkpCaseReferralSource]
--==================================================================
/****** Object:  Table [dbo].[tlkpCaseReferralSource]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCaseReferralSource' AND Type = N'U')
  DROP TABLE dbo.tlkpCaseReferralSource
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpCaseReferralSource](
	[CaseReferralSourceCode] [varchar](1) NOT NULL,
	[CaseReferralSourceDesc] [varchar](15) NOT NULL,
	[Disabled] [bit] NULL,
 CONSTRAINT [PK_dbo.tlkpCaseReferralSource] PRIMARY KEY CLUSTERED 
(
	[CaseReferralSourceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT INTO dbo.[tlkpCaseReferralSource] (CaseReferralSourceCode, CaseReferralSourceDesc, Disabled) VALUES ('C','Crisis',null)
INSERT INTO dbo.[tlkpCaseReferralSource] (CaseReferralSourceCode, CaseReferralSourceDesc, Disabled) VALUES ('I','Institution',null)
INSERT INTO dbo.[tlkpCaseReferralSource] (CaseReferralSourceCode, CaseReferralSourceDesc, Disabled) VALUES ('J','County Jail',null)
INSERT INTO dbo.[tlkpCaseReferralSource] (CaseReferralSourceCode, CaseReferralSourceDesc, Disabled) VALUES ('M','Medical',null)
INSERT INTO dbo.[tlkpCaseReferralSource] (CaseReferralSourceCode, CaseReferralSourceDesc, Disabled) VALUES ('P','Parole Agent',null)
INSERT INTO dbo.[tlkpCaseReferralSource] (CaseReferralSourceCode, CaseReferralSourceDesc, Disabled) VALUES ('R','Prop47',null)
INSERT INTO dbo.[tlkpCaseReferralSource] (CaseReferralSourceCode, CaseReferralSourceDesc, Disabled) VALUES ('W','Court WalkOver',null)
GO
--==================================================================
--tlkpCaseWorkerType
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpCaseWorkerType] (CaseWorkerTypeId, CaseWorkerTypeDesc, Disabled, DateAction) VALUES (' + 
-- Convert(varchar, CaseWorkerTypeId) + ',''' + CaseWorkerTypeDesc + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',''' + 
-- Convert(varchar, DateAction) + ''')'
--  FROM dbo.[tlkpCaseWorkerType]
 --SELECT * FROM dbo.[tlkpCaseWorkerType]
--==================================================================
/****** Object:  Table [dbo].[tlkpCaseWorkerType]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCaseWorkerType' AND Type = N'U')
  DROP TABLE dbo.tlkpCaseWorkerType
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpCaseWorkerType](
	[CaseWorkerTypeId] [int] IDENTITY(1,1) NOT NULL,
	[CaseWorkerTypeDesc] [nvarchar](20) NOT NULL,
	[Disabled] [bit] NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpCaseWorkerType] PRIMARY KEY CLUSTERED 
(
	[CaseWorkerTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT dbo.[tlkpCaseWorkerType] ON
INSERT INTO dbo.[tlkpCaseWorkerType] (CaseWorkerTypeId, CaseWorkerTypeDesc, Disabled, DateAction) VALUES (1,'Admin',null,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpCaseWorkerType] (CaseWorkerTypeId, CaseWorkerTypeDesc, Disabled, DateAction) VALUES (2,'Case Manager',null,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpCaseWorkerType] (CaseWorkerTypeId, CaseWorkerTypeDesc, Disabled, DateAction) VALUES (3,'Psychiatrist',null,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpCaseWorkerType] (CaseWorkerTypeId, CaseWorkerTypeDesc, Disabled, DateAction) VALUES (4,'Psychologist',null,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpCaseWorkerType] (CaseWorkerTypeId, CaseWorkerTypeDesc, Disabled, DateAction) VALUES (5,'Social Worker',null,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpCaseWorkerType] (CaseWorkerTypeId, CaseWorkerTypeDesc, Disabled, DateAction) VALUES (6,'Parole Agent',null,'Jul  1 2019 10:00AM')
INSERT INTO dbo.[tlkpCaseWorkerType] (CaseWorkerTypeId, CaseWorkerTypeDesc, Disabled, DateAction) VALUES (7,'PSA',null,'Jul  1 2019 10:00AM')
SET IDENTITY_INSERT dbo.[tlkpCaseWorkerType] OFF
GO
--==================================================================
--tlkpEthnicity
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpEthnicity] (EthnicityID, EthnicityDesc, Disabled, ActionBy, DateAction) VALUES (' + 
-- Convert(varchar, EthnicityID) + ',''' + EthnicityDesc + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',' + 
-- (CASE WHEN [ActionBy] IS NULL THEN 'null' ELSE CONVERT(varchar,[ActionBy]) END) + ',''' + 
-- Convert(varchar, DateAction) + ''')'
--  FROM dbo.[tlkpEthnicity]
 --SELECT * FROM dbo.[tlkpEthnicity]
--==================================================================
/****** Object:  Table [dbo].[tlkpEthnicity]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpEthnicity' AND Type = N'U')
  DROP TABLE dbo.tlkpEthnicity
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tlkpEthnicity](
	[EthnicityID] [int] IDENTITY(1,1) NOT NULL,
	[EthnicityDesc] [varchar](30) NOT NULL,
	[Disabled] [bit] NULL,
	[ActionBy] [int] NULL,
	[DateAction] [datetime] NULL,
 CONSTRAINT [PK_dbo.tlkpEthnicity] PRIMARY KEY CLUSTERED 
(
	[EthnicityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT dbo.[tlkpEthnicity] ON
INSERT INTO dbo.[tlkpEthnicity] (EthnicityID, EthnicityDesc, Disabled, ActionBy, DateAction) VALUES (1,'Asian',null,0,'Aug 17 2020 12:30PM')
INSERT INTO dbo.[tlkpEthnicity] (EthnicityID, EthnicityDesc, Disabled, ActionBy, DateAction) VALUES (2,'Pacific Islander',null,0,'Aug 17 2020 12:30PM')
INSERT INTO dbo.[tlkpEthnicity] (EthnicityID, EthnicityDesc, Disabled, ActionBy, DateAction) VALUES (3,'African-American',null,0,'Aug 17 2020 12:30PM')
INSERT INTO dbo.[tlkpEthnicity] (EthnicityID, EthnicityDesc, Disabled, ActionBy, DateAction) VALUES (4,'Caucasian',null,0,'Aug 17 2020 12:30PM')
INSERT INTO dbo.[tlkpEthnicity] (EthnicityID, EthnicityDesc, Disabled, ActionBy, DateAction) VALUES (5,'Hispanic',null,0,'Aug 17 2020 12:30PM')
INSERT INTO dbo.[tlkpEthnicity] (EthnicityID, EthnicityDesc, Disabled, ActionBy, DateAction) VALUES (6,'American Indian',null,0,'Aug 17 2020 12:30PM')
INSERT INTO dbo.[tlkpEthnicity] (EthnicityID, EthnicityDesc, Disabled, ActionBy, DateAction) VALUES (7,'Other',null,0,'Aug 17 2020 12:30PM')
SET IDENTITY_INSERT dbo.[tlkpEthnicity] OFF
GO
--==================================================================
--tlkpEvaluationItem
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (' + 
-- Convert(varchar, EvaluationItemID) + ',''' + EvaluationItemDescr + ''',' + Convert(varchar, EvaluationSortOrder) + ',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',' + 
-- (CASE WHEN [ActionBy] IS NULL THEN 'null' ELSE CONVERT(varchar,[ActionBy]) END) + ',''' + 
-- Convert(varchar, GetDate()) + ''')'
--  FROM dbo.[tlkpEvaluationItem]
 --SELECT * FROM dbo.[tlkpEvaluationItem]
--==================================================================
/****** Object:  Table [dbo].[tlkpEvaluationItem]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpEvaluationItem' AND Type = N'U')
  DROP TABLE dbo.tlkpEvaluationItem
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpEvaluationItem](
	[EvaluationItemID] [int] IDENTITY(1,1) NOT NULL,
	[EvaluationItemDescr] [nvarchar](255) NOT NULL,
	[EvaluationSortOrder] [int] NOT NULL,
	[Disabled] [bit] NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpEvaluationItem] PRIMARY KEY CLUSTERED 
(
	[EvaluationItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET IDENTITY_INSERT dbo.[tlkpEvaluationItem] ON
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (1,'Identifying Information',1,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (2,'Reason for Referral',2,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (3,'Commitment Offense And Criminal History',3,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (4,'Substance Abuse History And Treatment',4,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (5,'Personal History',5,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (6,'Educational History',6,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (7,'Relationship History',7,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (8,'Employment History',8,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (9,'Psychiatric History',9,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (10,'Medical History',10,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (11,'Mental Status Examination',11,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (12,'Diagnostic Impression',12,null,5,'Aug 17 2020 12:45PM')
INSERT INTO dbo.[tlkpEvaluationItem] (EvaluationItemID, EvaluationItemDescr,EvaluationSortOrder, Disabled, ActionBy, DateAction) VALUES (13,'Treatment Plan',13,null,5,'Aug 17 2020 12:45PM')
SET IDENTITY_INSERT dbo.[tlkpEvaluationItem] OFF
GO
--==================================================================
--tlkpExitStatus
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (' + 
-- Convert(varchar, ExitStatusID) + ',''' + ExitStatusDesc + ''',''' + NewExitStatusDesc + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',' + 
-- (CASE WHEN [ActionBy] IS NULL THEN 'null' ELSE CONVERT(varchar,[ActionBy]) END) + ',''' + 
-- Convert(varchar, GetDate()) + ''')'
--  FROM dbo.[tlkpExitStatus]
 --SELECT * FROM dbo.[tlkpExitStatus]
--==================================================================
/****** Object:  Table [dbo].[tlkpExitStatus]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpExitStatus' AND Type = N'U')
  DROP TABLE dbo.tlkpExitStatus
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpExitStatus](
	[ExitStatusID] [int] IDENTITY(1,1) NOT NULL,
	[ExitStatusDesc] [nvarchar](50) NULL,
	[NewExitStatusDesc] [nvarchar](50) NOT NULL,
	[Disabled] [bit] NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpExitStatus] PRIMARY KEY CLUSTERED 
(
	[ExitStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpExitStatus] ON
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (1,'Completed BHR Program Successfully','Completed Program',null,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (2,'Transferred to alternate case management','Moved/Transferred',null,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (3,'Case closed due to non-compliance','Voluntary Refusal',null,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (4,'Returned to Prison','In Custody/Jail/Prison',null,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (5,'Transferred to Non-CDC Provider','',1,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (6,'Died','Deceased',null,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (7,'Client PAL','PAL/Absconded',null,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (8,'Went home to family','',1,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (9,'Hospice','Hospitalization',null,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (10,'Completed parole','Supervision Ended/Discharged',null,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (11,'Evaluation Only/No Need for Treatment','',1,0,'Aug 17 2020 12:52PM')
INSERT INTO dbo.[tlkpExitStatus] (ExitStatusID, ExitStatusDesc,NewExitStatusDesc, Disabled, ActionBy, DateAction) VALUES (12,'Other','',1,0,'Aug 17 2020 12:52PM')
SET IDENTITY_INSERT dbo.[tlkpExitStatus] OFF
GO
--==================================================================
--tlkpGender
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpGender] (GenderID, Code,Name, Disabled) VALUES (' + 
-- Convert(varchar, GenderID) + ',''' + Code + ''',''' + Name + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ')'
--  FROM dbo.[tlkpGender]
 --SELECT * FROM dbo.[tlkpGender]
--==================================================================
/****** Object:  Table [dbo].[tlkpGender]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpGender' AND Type = N'U')
  DROP TABLE dbo.tlkpGender
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpGender](
	[GenderID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](1) NOT NULL,
	[Name] [nvarchar](15) NOT NULL,
	[Disabled] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpGender] PRIMARY KEY CLUSTERED 
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT dbo.[tlkpGender] ON
INSERT INTO dbo.[tlkpGender] (GenderID, Code,Name, Disabled) VALUES (1,'F','Female',0)
INSERT INTO dbo.[tlkpGender] (GenderID, Code,Name, Disabled) VALUES (2,'M','Male',0)
INSERT INTO dbo.[tlkpGender] (GenderID, Code,Name, Disabled) VALUES (3,'T','Transgender',0)
INSERT INTO dbo.[tlkpGender] (GenderID, Code,Name, Disabled) VALUES (4,'P','Temp',1)
INSERT INTO dbo.[tlkpGender] (GenderID, Code,Name, Disabled) VALUES (99,'U','Unknown',1)
SET IDENTITY_INSERT dbo.[tlkpGender] OFF
GO
--==================================================================
--tlkpParoleMentalHealthLevelOfService
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpParoleMentalHealthLevelOfService] (ParoleMentalHealthLevelOfServiceID, ParoleMentalHealthLevelOfServiceDescLong,
--ParoleMentalHealthLevelOfServiceDescShort, Disabled) VALUES (' + 
-- Convert(varchar, ParoleMentalHealthLevelOfServiceID) + ',''' + 
-- ParoleMentalHealthLevelOfServiceDescLong + ''',''' + ParoleMentalHealthLevelOfServiceDescShort + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ')'
--  FROM dbo.[tlkpParoleMentalHealthLevelOfService]
 --SELECT * FROM dbo.[tlkpParoleMentalHealthLevelOfService]
--==================================================================
/****** Object:  Table [dbo].[tlkpParoleMentalHealthLevelOfService]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpParoleMentalHealthLevelOfService' AND Type = N'U')
  DROP TABLE dbo.tlkpParoleMentalHealthLevelOfService
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tlkpParoleMentalHealthLevelOfService](
	[ParoleMentalHealthLevelOfServiceID] [int] IDENTITY(1,1) NOT NULL,
	[ParoleMentalHealthLevelOfServiceDescLong] [varchar](100) NOT NULL,
	[ParoleMentalHealthLevelOfServiceDescShort] [varchar](20) NOT NULL,
	[Disabled] [bit] NULL,
 CONSTRAINT [PK_dbo.tlkpParoleMentalHealthLevelOfService] PRIMARY KEY CLUSTERED 
(
	[ParoleMentalHealthLevelOfServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT dbo.[tlkpParoleMentalHealthLevelOfService] ON
INSERT INTO dbo.[tlkpParoleMentalHealthLevelOfService] (ParoleMentalHealthLevelOfServiceID, ParoleMentalHealthLevelOfServiceDescLong,
ParoleMentalHealthLevelOfServiceDescShort, Disabled) VALUES (1,'Not Specified','Not Specified',1)
INSERT INTO dbo.[tlkpParoleMentalHealthLevelOfService] (ParoleMentalHealthLevelOfServiceID, ParoleMentalHealthLevelOfServiceDescLong,
ParoleMentalHealthLevelOfServiceDescShort, Disabled) VALUES (2,'Enhanced Outpatient Program','EOP',null)
INSERT INTO dbo.[tlkpParoleMentalHealthLevelOfService] (ParoleMentalHealthLevelOfServiceID, ParoleMentalHealthLevelOfServiceDescLong,
ParoleMentalHealthLevelOfServiceDescShort, Disabled) VALUES (3,'Correctional Clinical Case Management System','CCCMS',null)
INSERT INTO dbo.[tlkpParoleMentalHealthLevelOfService] (ParoleMentalHealthLevelOfServiceID, ParoleMentalHealthLevelOfServiceDescLong,
ParoleMentalHealthLevelOfServiceDescShort, Disabled) VALUES (4,'Medical Necessity','Medical Necessity',null)
INSERT INTO dbo.[tlkpParoleMentalHealthLevelOfService] (ParoleMentalHealthLevelOfServiceID, ParoleMentalHealthLevelOfServiceDescLong,
ParoleMentalHealthLevelOfServiceDescShort, Disabled) VALUES (5,'Removed','Removed',null)
INSERT INTO dbo.[tlkpParoleMentalHealthLevelOfService] (ParoleMentalHealthLevelOfServiceID, ParoleMentalHealthLevelOfServiceDescLong,
ParoleMentalHealthLevelOfServiceDescShort, Disabled) VALUES (6,'EOPToCCCMS','EOPToCCCMS',null)
INSERT INTO dbo.[tlkpParoleMentalHealthLevelOfService] (ParoleMentalHealthLevelOfServiceID, ParoleMentalHealthLevelOfServiceDescLong,
ParoleMentalHealthLevelOfServiceDescShort, Disabled) VALUES (7,'CCCMSToEOP','CCCMSToEOP',null)
SET IDENTITY_INSERT dbo.[tlkpParoleMentalHealthLevelOfService] OFF
GO
--==================================================================
--tlkpReleaseCaseType
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpReleaseCaseType] (ReleaseCaseTypeCode, ReleaseCaseTypeDescLong,
--ReleaseCaseTypeDescShort, Disabled, ActionBy, DateAction) VALUES (''' + 
-- ReleaseCaseTypeCode + ''',''' + ReleaseCaseTypeDescLong + ''',''' + ReleaseCaseTypeDescShort + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',' + 
-- (CASE WHEN [ActionBy] IS NULL THEN 'null' ELSE CONVERT(varchar,[ActionBy]) END) + ',''' + 
-- (CASE WHEN DateAction IS NULL THEN 'null' ELSE Convert(varchar, DateAction) END) + ''')'
--  FROM dbo.[tlkpReleaseCaseType]
 --SELECT * FROM dbo.[tlkpReleaseCaseType]
--==================================================================
/****** Object:  Table [dbo].[tlkpReleaseCaseType]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpReleaseCaseType' AND Type = N'U')
  DROP TABLE dbo.tlkpReleaseCaseType
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tlkpReleaseCaseType](
	[ReleaseCaseTypeCode] [varchar](1) NOT NULL,
	[ReleaseCaseTypeDescLong] [varchar](100) NOT NULL,
	[ReleaseCaseTypeDescShort] [varchar](20) NOT NULL,
	[Disabled] [bit] NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpReleaseCaseType] PRIMARY KEY CLUSTERED 
(
	[ReleaseCaseTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT INTO dbo.[tlkpReleaseCaseType] (ReleaseCaseTypeCode, ReleaseCaseTypeDescLong,
ReleaseCaseTypeDescShort, Disabled, ActionBy, DateAction) VALUES ('D','Controlling Discharge','CDD',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpReleaseCaseType] (ReleaseCaseTypeCode, ReleaseCaseTypeDescLong,
ReleaseCaseTypeDescShort, Disabled, ActionBy, DateAction) VALUES ('E','Earliest Possible Release','EPRD',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpReleaseCaseType] (ReleaseCaseTypeCode, ReleaseCaseTypeDescLong,
ReleaseCaseTypeDescShort, Disabled, ActionBy, DateAction) VALUES ('F','First Time Release','FTR',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpReleaseCaseType] (ReleaseCaseTypeCode, ReleaseCaseTypeDescLong,
ReleaseCaseTypeDescShort, Disabled, ActionBy, DateAction) VALUES ('L','Life','LIFE',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpReleaseCaseType] (ReleaseCaseTypeCode, ReleaseCaseTypeDescLong,
ReleaseCaseTypeDescShort, Disabled, ActionBy, DateAction) VALUES ('R','Revocation Release','RRD',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpReleaseCaseType] (ReleaseCaseTypeCode, ReleaseCaseTypeDescLong,
ReleaseCaseTypeDescShort, Disabled, ActionBy, DateAction) VALUES ('V','Parole Violator w/New Term','PVWNT',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpReleaseCaseType] (ReleaseCaseTypeCode, ReleaseCaseTypeDescLong,
ReleaseCaseTypeDescShort, Disabled, ActionBy, DateAction) VALUES ('W','Life Without Parole','LWOP',null,0,'May  5 2017 12:41PM')
GO
--==================================================================
--tlkpSignificantOtherStatus
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpSignificantOtherStatus] (SignificantOtherStatusCode, SignificantOtherStatusDesc,
--Disabled, ActionBy, DateAction) VALUES (''' + 
-- SignificantOtherStatusCode + ''',''' + SignificantOtherStatusDesc + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ',' + 
-- (CASE WHEN [ActionBy] IS NULL THEN 'null' ELSE CONVERT(varchar,[ActionBy]) END) + ',''' + 
--  Convert(varchar, DateAction) + ''')'
--  FROM dbo.[tlkpSignificantOtherStatus]
 --SELECT * FROM dbo.[tlkpSignificantOtherStatus]
--==================================================================
/****** Object:  Table [dbo].[tlkpSignificantOtherStatus]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpSignificantOtherStatus' AND Type = N'U')
  DROP TABLE dbo.tlkpSignificantOtherStatus
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpSignificantOtherStatus](
	[SignificantOtherStatusCode] [nvarchar](1) NOT NULL,
	[SignificantOtherStatusDesc] [nvarchar](30) NOT NULL,
	[Disabled] [bit] NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpSignificantOtherStatus] PRIMARY KEY CLUSTERED 
(
	[SignificantOtherStatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO dbo.[tlkpSignificantOtherStatus] (SignificantOtherStatusCode, SignificantOtherStatusDesc,
Disabled, ActionBy, DateAction) VALUES ('D','Divorced',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpSignificantOtherStatus] (SignificantOtherStatusCode, SignificantOtherStatusDesc,
Disabled, ActionBy, DateAction) VALUES ('M','Currently Married',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpSignificantOtherStatus] (SignificantOtherStatusCode, SignificantOtherStatusDesc,
Disabled, ActionBy, DateAction) VALUES ('N','Never Married',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpSignificantOtherStatus] (SignificantOtherStatusCode, SignificantOtherStatusDesc,
Disabled, ActionBy, DateAction) VALUES ('O','Living w/ Significant Other',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpSignificantOtherStatus] (SignificantOtherStatusCode, SignificantOtherStatusDesc,
Disabled, ActionBy, DateAction) VALUES ('P','Domestic Partner',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpSignificantOtherStatus] (SignificantOtherStatusCode, SignificantOtherStatusDesc,
Disabled, ActionBy, DateAction) VALUES ('S','Separated',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpSignificantOtherStatus] (SignificantOtherStatusCode, SignificantOtherStatusDesc,
Disabled, ActionBy, DateAction) VALUES ('W','Widowed',null,0,'May  5 2017 12:41PM')
GO
--==================================================================
--tlkpLocation
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
--[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
--[OLDLocationID],[OLDCountyID]) VALUES (' + Convert(Varchar,[LocationID]) + ',''' + LocationDesc + ''',''' +
-- LocationAbrv + ''',' + Convert(Varchar,ComplexID) + ',''' + ComplexDesc + ''',' +
-- (Case When ISNULL(StreetAddress, '')='' THEN 'null' ELSE '''' + StreetAddress + '''' END) + ',' +  
-- (Case When ISNULL(City, '') = '' THEN 'null' ELSE '''' + City + '''' END) + ',' + 
-- (Case When ISNULL([State], '') = '' THEN 'null' ELSE '''' + [State] + '''' END) + ',' +
-- (Case When ISNULL(ZipCode, '') = '' THEN 'null' ELSE '''' + ZipCode + '''' END) + ',' +  
-- (CASE WHEN CountyID IS NULL THEN 'null' ELSE Convert(varchar, CountyID)  END) + ',' +    
-- (Case When ISNULL(PhoneNumber1, '') = '' THEN 'null' ELSE '''' + PhoneNumber1 + '''' END) + ',' +  
-- (Case When ISNULL(PhoneNumber2, '') = '' THEN 'null' ELSE '''' + PhoneNumber2 + '''' END) + ',' +  
-- (CASE WHEN Disabled IS NULL THEN 'null' ELSE Convert(varchar, Disabled)  END) + ',' + 
-- (CASE WHEN OLDLocationID IS NULL THEN 'null' ELSE Convert(varchar, OLDLocationID)  END) + ',' + 
-- (CASE WHEN OLDCountyID IS NULL THEN 'null' ELSE Convert(varchar, OLDCountyID)  END) + ')' FROM dbo.[tlkpLocation]
 --SELECT * FROM dbo.[tlkpLocation]
--==================================================================
/****** Object:  Table [dbo].[tlkpLocation]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpLocation' AND Type = N'U')
  DROP TABLE dbo.tlkpLocation
GO
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCounty' AND Type = N'U')
  DROP TABLE dbo.tlkpCounty
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpLocation](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[LocationDesc] [varchar](50) NOT NULL,
	[LocationAbrv] [varchar](25) NOT NULL,
	[ComplexID] [int] NOT NULL,
	[ComplexDesc] [nvarchar](50) NOT NULL,
	[StreetAddress] [nvarchar](75) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](2) NULL,
	[ZipCode] [varchar](10) NULL,
	[CountyID] [int] NULL,
	[PhoneNumber1] [nvarchar](14) NULL,
	[PhoneNumber2] [nvarchar](14) NULL,
	[Disabled] [bit] NULL,
	[OLDLocationID] [int] NULL,
	[OLDCountyID] [int] NULL,
 CONSTRAINT [PK_dbo.tlkpLocation] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT dbo.[tlkpLocation] ON
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (0,'Unknown','UNKNOWN',0,'',null,null,'CA',null,59,null,null,1,0,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (1,'Ant Val 1','ANTVL1',1,'Antelope Valley','43645 Pioneer CT','Lancaster','CA','93534',19,'(661) 729-0530','(661) 274-4566',0,86,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (2,'Ant Val 4 ','ANTVL4',1,'Antelope Valley','43645 Pioneer CT','Lancaster','CA','93534',19,'(661) 729-0530',null,0,86,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (3,'Chula Vista 1','CHLVST1',2,'Chula Vista','765 Third Ave, Suite 300','Chula Vista','CA','91910',37,'(619) 476-3710','(619) 476-3706',0,100,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (4,'Chula Vista 2','CHLVST2',2,'Chula Vista','765 Third Ave, Suite 300','Chula Vista','CA','91910',37,'(619) 476-3710',null,0,100,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (5,'El Cajon 1','ELCJ1',2,'Chula Vista','765 Third Ave, Suite 300','Chula Vista','CA','91910',37,'(619) 476-3710',null,0,101,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (6,'San Diego 1','SD1',2,'Chula Vista','765 Third Ave, Suite 300','Chula Vista','CA','91910',37,'(619) 476-3710',null,0,113,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (7,'Compton 1','COMT1',3,'Compton','322 West Compton Blvd','Compton','CA','90220',19,'(310) 639-8601','(310) 639-2319',0,170,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (8,'Compton GPS','COMTGPS',3,'Compton','322 West Compton Blvd','Compton','CA','90220',19,'(310) 639-8601',null,0,260,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (9,'El Centro','ELCTRO',46,'El Centro','279 South Waterman Avenue','El Centro','CA','92243',37,'(760) 352-7524','(760) 352-8854',0,101,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (10,'El Monte 1','ELMTE1',5,'El Monte','9900 Baldwin Pl','El Monte','CA','91731',19,'(626) 527-3005','(626) 459-4453',0,87,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (11,'El Monte 2','ELMTE2',5,'El Monte','9900 Baldwin Pl','El Monte','CA','91731',19,null,null,0,101,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (12,'Long Beach 2','LGBH2',3,'Compton','322 Compton Blvd','Compton','CA','90220',19,'(626) 527-3005','(626) 459-4453',0,218,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (13,'SF Springs 2','SFSPR2',5,'El Monte','9900 Baldwin Pl','El Monte','CA','91731',19,'(562) 941-1947','(562) 941-0257',0,95,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (14,'Escondido','ESCDID',6,'Escondido','1301 Simpson Way','Escondido','CA','92029',37,'(760) 737-7925','(760) 737-8831',0,103,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (15,'Inland GPS','ILDGPS',6,'Escondido','1301 Simpson Way','Escondido','CA','92029',37,null,null,0,253,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (16,'Santa Ana 1','SANA1',7,'Irvine','18002 Sky Park Cir','Irvine','CA','92614',30,'(949) 863-1478','(714) 588-4742',0,114,30)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (17,'Santa Ana 3','SANA3',7,'Irvine','18002 Sky Park Cir','Irvine','CA','92614',30,'(949) 863-1478',null,0,213,30)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (18,'South Coast','SOUCT',7,'Irvine','18002 Sky Park Cir','Irvine','CA','92614',30,'(949) 863-1478',null,0,213,30)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (19,'Orange GPS','ORGGPS',7,'Irvine','18002 Sky Park Cir','Irvine','CA','92614',30,'(949) 863-1478',null,0,252,30)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (20,'Fullerton','FLT',8,'Anaheim','2911 Coronado Ave','Anaheim','CA','92806',30,null,null,0,99,30)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (21,'Orange','ORAG',8,'Anaheim','2911 Coronado Ave','Anaheim','CA','92806',30,'(714) 688-4855','(714) 688-4894',0,109,30)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (22,'Pomona','POMONA',9,'Pomona','971 Corporate Center Dr','Pomona','CA','91768',19,'(909) 802-1020','(909) 620-4495',0,91,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (23,'Ant Val GPS','ANTVLGPS',1,'Antelope Valley','43645 Pioneer CT','Lancaster','CA','93534',19,'(661) 729-0530',null,0,86,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (24,'San Gab Val','SANGVL',9,'Pomona','971 Corporate Center Dr','Pomona','CA','91768',19,'(626) 859-3201','(626) 859-3209',0,94,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (25,'San Gab Val GPS','SANGVLGPS',9,'Pomona','971 Corporate Center Dr','Pomona','CA','91768',19,null,null,0,218,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (26,'Riverside 1','RVSD1',10,'Riverside','1777 Atlanta Ave.  Suite G3','Riverside','CA','92507',33,'(951) 782-4479','(951) 782-4929',0,110,33)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (27,'Riverside 3','RVSD3',10,'Riverside','1777 Atlanta Ave.  Suite G3','Riverside','CA','92507',33,null,null,0,110,33)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (28,'Riverside GPS','RVSDGPS',10,'Riverside','1777 Atlanta Ave.  Suite G3','Riverside','CA','92507',33,'(951) 782-4479',null,0,258,33)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (29,'Moreno Valley 1','MONVL1',10,'Riverside','1777 Atlanta Ave.  Suite G3','Riverside','CA','92507',33,'(951) 571-4040','(951) 653-3201',0,106,33)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (30,'Moreno Valley 2','MONVL2',10,'Riverside','1777 Atlanta Ave.  Suite G3','Riverside','CA','92507',33,'(951) 571-4040','(951) 653-3201',0,106,33)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (31,'Palm Springs','PLMSPR',11,'Ind/Plm Spr','79-687 Country Club Dr','Bermuda Dunes','CA','92203',33,'(760) 772-3157','(760) 772-3165',0,105,33)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (32,'IPS GPS','IPSGPS',11,'Ind/Plm Spr','79-687 Country Club Dr','Bermuda Dunes','CA','92203',33,null,null,0,105,33)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (33,'San Bernardino 1','SBDO1',12,'San Bernardino','303 W. Fifth St.','San Bernardino','CA','92401',36,'(909) 806-3516','(909) 357-1159',0,104,36)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (34,'San Bernardino 2','SBDO2',12,'San Bernardino','303 W. Fifth St.','San Bernardino','CA','92401',36,null,null,0,112,36)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (35,'San Bernardino GPS','SBDOGPS',12,'San Bernardino','303 W. Fifth St.','San Bernardino','CA','92401',36,'(909) 806-3516',null,0,259,36)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (36,'Fontana','FNTN',12,'San Bernardino','303 W. Fifth St.','San Bernardino','CA','92401',36,'(909) 802-1020','(909) 984-1502',0,108,36)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (37,'Rialto','RALT',12,'San Bernardino','303 W. Fifth St.','San Bernardino','CA','92401',36,null,null,0,108,36)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (38,'LA Central 1','LAC1',13,'LA Central','2444 S Alameda St, 2nd Floor','Los Angeles','CA','90058',19,'(323) 238-1700','(323) 231-5976',0,117,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (39,'LA Central 3','LAC3',13,'LA Central','2444 S Alameda St, 2nd Floor','Los Angeles','CA','90058',19,'(323) 238-1700',null,0,206,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (40,'LA Central 4','LAC4',13,'LA Central','2444 S Alameda St, 2nd Floor','Los Angeles','CA','90058',19,'(323) 238-1700',null,0,21,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (41,'Long Beach 1','LGBH1',3,'Compton','322 Compton Blvd','Compton','CA','90220',19,'(562) 492-1022','(562) 427-7232',0,171,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (42,'Huntington Park GPS','HPGPS',13,'LA Central','2444 S Alameda St, 2nd Floor','Los Angeles','CA','90058',19,'(323) 586-5500','(213) 744-2305',0,88,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (43,'LA Central GPS','LACGPS',13,'LA Central','2444 S Alameda St, 2nd Floor','Los Angeles','CA','90058',19,'(323) 238-1700',null,0,117,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (44,'Long Beach 4','LGBH4',3,'Compton','322 Compton Blvd','Compton','CA','90220',19,'(562) 595-0057','(562) 989-2433',0,196,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (45,'MID-CITY 1','MDCT1',13,'LA Central','2444 S. Alameda St, 1st Flr','Los Angeles','CA','90058',19,'(323) 238-1600','(323) 231-5819',0,244,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (46,'MID-CITY 3','MDCT3',13,'LA Central','2444 S. Alameda St, 1st Flr','Los Angeles','CA','90058',19,'(323) 238-1600',null,0,245,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (47,'MID-CITY 4','MDCT4',13,'LA Central','2444 S. Alameda St, 1st Flr','Los Angeles','CA','90058',19,'(323) 238-1600',null,0,246,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (48,'Mid-City GPS','MDCTGPS',13,'LA Central','2444 S. Alameda St, 1st Flr','Los Angeles','CA','90058',19,'(323) 238-1600',null,0,205,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (49,'Van Nuys 2','VNNYS2',14,'Van Nuys','8100 Balboa Pl','Van Nuys','CA','91406',19,'(818) 442-0400','(818) 901-5125',0,93,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (50,'Van Nuys GPS','VNNYSGPS',14,'Van Nuys','8100 Balboa Pl','Van Nuys','CA','91406',19,null,null,0,93,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (51,'Pasadena 1','PSDN1',14,'Van Nuys','8100 Balboa Pl','Van Nuys','CA','91406',19,'(626) 450-6250','(626) 450-6262',0,174,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (52,'San Fern Val 1','SFVL1',14,'Van Nuys','8100 Balboa Pl','Van Nuys','CA','91406',19,'(818) 442-0420','(818) 901-5200',0,92,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (53,'San Fern Val 2','SFVL2',14,'Van Nuys','8100 Balboa Pl','Van Nuys','CA','91406',19,null,null,0,92,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (54,'Victorville 1','VCTRVL1',15,'Victorville','14040 Park Ave','Victorville','CA','92392',36,'(760) 241-3744','(760) 241-0443',0,115,36)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (55,'Victorville 2','VCTRVL2',15,'Victorville','14040 Park Ave','Victorville','CA','92392',36,'(760) 241-3744',null,0,115,36)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (56,'Victorville GPS','VCTRVLGPS',15,'Victorville','14040 Park Ave','Victorville','CA','92392',36,null,null,0,254,36)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (57,'Auburn','AUBN',16,'Auburn','1915 Grass Valley Hwy','Auburn','CA','95603',31,'(530) 823-4188','(530) 823-4197',0,39,31)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (58,'Bakersfield 1','BKSFLD1',17,'Bakersfield','3400 Sillect Ave','Bakersfield','CA','93308',59,'(661) 634-9620','(661) 395-3837',1,40,15)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (59,'Bakersfield 2','BKSFLD2',17,'Bakersfield','3400 Sillect Ave','Bakersfield','CA','93308',15,'(661) 634-9620','(661) 395-3837',0,40,15)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (60,'Bakersfield 3','BKSFLD3',17,'Bakersfield','3400 Sillect Ave','Bakersfield','CA','93308',15,'(661) 634-9620','(661) 395-3837',0,40,15)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (61,'Bakersfield 5','BKSFLD5',17,'Bakersfield','3416-B Sillect Ave','Bakersfield','CA','93308',15,'(661) 634-9620','(661) 395-3837',0,42,15)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (62,'Bakersfield 6','BKSFLD6',17,'Bakersfield','3416-A Sillect Ave','Bakersfield','CA','93308',15,'(661) 633-5100','(661) 633-5121',0,42,15)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (63,'Berkeley','BKLY',24,'Oakland','7717 Edgewater Drive, Suite 200','Oakland','CA','94621',1,'(510) 577-2407','(510) 883-6692',0,63,1)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (64,'Modesto 2','MODTO2',19,'Ceres','1051 Partee Ln','Ceres','CA','95307',50,'(209) 576-6400','(209) 576-6114',0,77,50)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (65,'Eureka','EUREKA',20,'Eureka','930 Third St','Eureka','CA','95501',12,'(707) 445-6520','(707)445-6620',0,65,12)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (66,'Fresno 2','FRESNO2',21,'Fresno','5060 E Clinton Way','Fresno','CA','93727',10,'(559) 253-4144','(559) 253-4166',0,46,10)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (67,'Fresno 5','FRESNO5',21,'Fresno','5060 E Clinton Way','Fresno','CA','93727',10,'(559) 253-4144','(559) 253-4166',0,46,10)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (68,'Fresno 7','FRESNO7',21,'Fresno','5060 E Clinton Way','Fresno','CA','93727',10,'(559) 253-4144','(559) 253-4166',0,46,10)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (69,'Central GPS','CTRGPS',21,'Fresno','5060 E Clinton Way','Fresno','CA','93727',10,'(559) 253-4144','(559) 253-4166',0,46,10)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (70,'Hanford','HADFD',22,'Hanford','344 W 5th St','Hanford','CA','93230',16,'(559) 582-1969','(559) 582-8790',0,49,16)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (71,'Merced','MERCED',23,'Merced','439 W 15th St','Merced','CA','95340',24,'(209) 726-6513','(209) 726-6519',0,52,24)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (72,'Eastbay GPS','ESTBAYGPS',24,'Oakland','7717 Edgewater Drive, Suite 200','Oakland','CA','94621',1,'(510) 577-2407',null,0,226,1)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (73,'Red Bluff','REDBLUF',25,'Red Bluff','10 Gilmore Rd','Red Bluff','CA','96080',52,'(530) 529-7700','(530) 529-7705',0,55,52)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (74,'Redwood City','REDWOOD',26,'Redwood City','540 Price Avenue','Redwood City','CA','94063',41,'(650) 367-1444','(650) 367-1520',0,70,41)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (75,'Concord 1','CNCRD1',27,'Concord','1957 Parkside Drive, Suite 100','Concord','CA','94510',1,'(925)602-0838','(925)602-0839',0,71,1)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (76,'SAC Metro 1','SACMETRO1',28,'Sac Elder Creek','8000 ELDER CREEK Rd','Sacramento','CA','95824',34,'(916)229-0105','(916) 445-8864',0,56,34)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (77,'SAC Metro 4','SACMETRO4',28,'Sac Elder Creek','8000 ELDER CREEK Rd','Sacramento','CA','95824',34,'(916)229-0105','(916) 574-2191',0,56,34)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (78,'SAC Metro 2','SACMETRO2',29,'Sac South','1608 T St','Sacramento','CA','95811',43,'(916)322-5504',null,0,207,43)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (79,'SAC Metro 3','SACMETRO3',29,'Sac South','1608 T St','Sacramento','CA','95811',43,'(916)322-5504',null,0,207,43)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (80,'Oakland 2','OAKLD2',24,'Oakland','7717 Edgewater Drive, Suite 200','Oakland','CA','94621',1,'(510) 577-2407',null,0,68,1)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (81,'Ceres','CERES',19,'Ceres','1051 Partee Ln','Ceres','CA','95307',50,'(209) 576-6400','(209) 576-6114',null,68,1)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (82,'San Jose 3, 5, 7','SAN JOSE',30,'San Jose','909 Coleman Ave','San Jose','CA','95110',43,'(408) 277-1821','(408) 277-1030',0,76,43)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (83,'San Luis Obispo','SLO',31,'San Luis Obispo','3232 S Higuera St','San Luis Obispo','CA','93401',40,'(805) 549-3251','(805) 549-3410',0,79,40)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (84,'Santa Rosa','SNTAROSA',32,'Santa Rosa','3222 Airway Dr','Santa Rosa','CA','95403',49,'(707) 576-2200','(707) 576-2305',0,82,49)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (85,'Stockton 1','STKTN 1',33,'Stockton','612 Carlton Ave','Stockton','CA','95203',39,'(209) 948-7652','(209) 948-3826',0,59,39)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (86,'Delta GPS','DELTGPS',19,'Ceres','612 Carlton Ave','Stockton','CA','95203',50,null,null,0,59,39)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (87,'Stockton 4','STKTN 4',33,'Stockton','612 Carlton Ave','Stockton','CA','95203',39,null,null,0,59,39)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (88,'CCTRP-SD','CCTRPSD',2,'Chula Vista','3050 ARMSTRONG St','San Diego','CA','92111',37,null,null,0,257,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (89,'Ukiah','UKIAH',34,'Ukiah','798 N State St','Ukiah','CA','95482',23,'(707) 463-5713','(707) 463-5704',0,83,23)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (90,'Vallejo','VALLEJO',35,'Vallejo','1840 Capitol St','Vallejo','CA','94590',48,'(707) 648-5372','(707) 648-5285',0,84,48)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (91,'Ventura 1','VENTURA1',36,'Ventura','1555 W 5th St','Oxnard','CA','93030',56,'(805) 382-8151',null,0,214,56)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (92,'Woodland','WOODLD',37,'Woodland','814 Court St','Woodland','CA','95695',57,'(530) 662-4977','(530) 662-6692',0,61,57)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (93,'Ventura 2','VENTURA2',36,'Ventura','1555 W 5th St','Oxnard','CA','93030',56,'(916) 229-0680',null,0,214,56)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (94,'Oakland 1','OAKLD1',24,'Oakland','7717 Edgewater Dr, Suite 200','Oakland','CA','94621',1,'(510) 577-2407','(510) 577-7555',null,68,1)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (95,'Concord 2','CNCRD2',27,'Concord','1957 Parkside Drive, Suite 100','Concord','CA','94510',1,'(925)602-0838','(925)602-0839',null,71,1)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (96,'SAC Natomas','SACNTMS',40,'Sac North/Natomas','4616 Roseville Rd','North Highlands','CA','95660',34,'(916)574-2414',null,null,180,34)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (97,'SAC North','SACNOR',40,'Sac North/Natomas','4616 Roseville Rd','North Highlands','CA','95660',34,'(916)574-2414',null,null,57,34)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (98,'Foothill GPS','FTHLGPS',12,'San Bernardino','303 W. Fifth St','San Bernardino','CA','92401',36,null,null,null,259,36)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (99,'El Monte GPS','ELMNTGPS',5,'El Monte','9900 W Baldwin PL','El Monte','CA','91731',19,null,null,null,87,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (100,'CCTRP-SF Springs','CCTRPSF',5,'El Monte','11121 Bloomfield AVE','Santa Fe Springs','CA','90670',19,null,null,null,95,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (101,'Atascadero Sub Unit','ATSCD',31,'San Luis Obispo','3232 S Higuera St','San Luis Obispo','CA','93401',40,'(805) 549-3251','(805) 549-3410',null,169,40)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (102,'Chico','CHICO',43,'Chico','1370 Ridgewood DR','Chico','CA','95973',4,null,null,null,45,4)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (103,'Sierra GPS','SIRAGPS',16,'Auburn','1915 Grass Valley Hwy','Auburn','CA','95603',31,null,null,null,39,31)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (104,'Redding GPS','SIRAGPS',41,'Redding GPS','391 Hemsted DR','Redding','CA','96002',45,null,null,null,54,45)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (105,'Escondido 2','ESCDID2',6,'Escondido','1301 Simpson Way','Escondido','CA','92029',37,null,null,null,103,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (106,'Seaport GPS','SPORTGPS',2,'Chula Vista','765 Third Avenue, Suite 300','Chula Vista','CA','91910',37,null,null,null,257,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (107,'Salinas 1 GPS','SALS1GPS',38,'Salinas','320 Airport Dr.','Salinas','CA','93905',27,null,null,null,72,27)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (108,'Salinas 2','SALS2',38,'Salinas','320 Airport Dr.','Salinas','CA','93905',27,null,null,null,72,27)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (109,'San Francisco 1','SFC1',39,'San Francisco','1727 Mission Street','San Francisco','CA','94103',38,null,null,null,73,38)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (110,'San Francisco 4','SFC4',39,'San Francisco','1727 Mission Street','San Francisco','CA','94103',38,null,null,null,73,38)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (111,'Visalia 1','VISL1',22,'Hanford','344 W 5th ST','Hanford','CA','93230',16,null,null,null,60,16)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (112,'Visalia 2','VISL2',22,'Hanford','344 W 5th ST','Hanford','CA','93230',16,null,null,null,60,16)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (113,'POC Region S HQ','PRSHQ',44,'POC Region Southern HQ','21015 Pathfinder Road, Suite 200','Diamond Bar','CA','91765',36,'(909) 468-2300','(909) 468-2398',null,22,36)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (114,'POC Region N HQ','PRNHQ',45,'POC Region Northern HQ','9825 Goethe Road, Suite 200','Sacramento','CA','95827',34,'(916) 255-2758','(916) 255-2754',null,19,34)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (131,'Long Beach (3rd Floor)','LGBH3RDFL',0,'','2165 East Spring Street, 3rd Floor','Long Beach','CA','90806',59,'(562) 595-5823','(562) 595-1364',1,89,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (132,'Inglewood (Suite 200)','INGLWDSUT200',0,'','101 North La Brea Avenue, Suite 200','Inglewood','CA','90301',59,'(310) 412-6392','(310) 677-5338',1,90,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (133,'Oroville','OROVILLE',0,'','1370 Ridgewood Drive, Suite 14','Chico','CA','95973',59,'(530) 895-4534','(530) 895-4538',1,53,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (134,'Inglewood (Suite 201)','INGLWDSUT201',0,'','101 North La Brea Avenue, Suite 201','Inglewood','CA','90301',59,'(310) 412-6134','(310) 330-5497',1,193,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (135,'Inglewood (7th Floor)','INGLWD7THFL',0,'','101 North La Brea Avenue, 7th Floor','Inglewood','CA','90301',59,'(310) 330-5482','(310) 330-5497',1,194,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (136,'Long Beach 2 (2nd Floor)','LGBH2NDFL',0,'','2165 East Spring Street, 2nd Floor','Long Beach','CA','90806',59,'(562) 492-1022','(562) 427-7232',1,195,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (137,'North Long Beach','NORLGBH',0,'','2165 East Spring Street, 2nd Floor','Long Beach','CA','90806',59,'(562) 492-1022','(562) 427-7232',1,204,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (138,'POC Region 2 HQ','PR2HQ',0,'','1515 Clay Street, 10th Floor','Oakland','CA','94612',59,'(510) 622-4781','(510) 622-4795',1,20,1)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (139,'Gold Country','GoldCountry',0,'','768 Pleasant Valley Road','Diamond Springs','CA','95619',59,'(530) 295-2147','(530) 823-4818',1,48,9)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (140,'Bakersfield 4','BKSFLD4',17,'Bakersfield','3416 Sillect Avenue, Suite B','Bakersfield','CA','93308',59,'(661) 634-9620','(661) 395-3837',1,42,15)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (141,'Susanville','Susanville',4,'Susanville','170 Russell Avenue, Suite G','Susanville','CA','96130',52,'(530) 257-2929','(530) 529-7705',null,116,52)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (142,'Harbor','NULL',0,'NULL','2165 E. Spring St, 3rd FL','Long Beach','CA','90806',59,'(562) 595-5823','(562) 595-1364',1,203,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (143,'South Bay','NULL',0,'NULL',null,null,'CA',null,59,null,null,1,203,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (144,'West Los Angeles','WESTLA',0,'','1835 South La Cienega Boulevard','Los Angeles','CA','90035',59,null,null,1,177,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (145,'West-Ferndale Board And Care','WFBACARE',0,'','1745 Northwestern Avenue','Los Angeles','CA','90027',59,null,null,1,178,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (146,'Panorama City','PANRMACITY',0,'','8737 Van Nuys Boulevard','Panorama City','CA','91402',59,null,null,1,247,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (147,'Long Beach GPS','LGBHGPS',0,'','2165 East Spring Street, 4th Floor','Long Beach','CA','90806',59,'(562) 595-0057',null,1,255,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (148,'Madera','MADREA',0,'','605 South Gateway Drive','Madera','CA','94612',59,'(559) 675-2120','(559) 675-5299',1,50,20)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (149,'Moreno Valley GPS','MONVLGPS',10,'Riverside','1777 Atlanta Ave.  Suite G3','Riverside','CA','92507',59,'(951) 571-4040','(559) 675-5299',1,251,33)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (150,'Sacramento-Florin','SACFLORN',0,'','8455 Jackson Road, Suite 150','Sacramento','CA','95826',59,'(951) 571-4040','(559) 675-5299',1,208,34)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (152,'Oceanside','OCEANSIDE',0,'','2952 Oceanside Boulevard','Oceanside','CA','92054',59,'(760) 754-6120','(760) 754-6144',1,107,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (153,'Daly City','DalyCity',0,'','540 Price Ave','Redwood City','CA','94063',59,'(650) 367-1444','(415) 469-6240',1,118,41)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (154,'Santa Barbara (Closed)','STBARBRA',0,'','411 East Canon Perdido Street','Santa Barbara','CA','93101',59,'(805) 564-7748','(805) 564-7754',1,80,42)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (155,'San Jose 1&2','SANJOSE12',0,'','165 Lewis Road','San Jose','CA','95111',59,'(408)629-5980 ',null,1,248,43)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (156,'Weed','WEED',18,'Weed','550 Park Street','Weed','CA','96094',52,'(530) 938-2107','(530) 226-3436',null,120,52)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (157,'Fairfield','Fairfield',0,'','2333 Courage Drive, Suite E','Fairfield','CA','94533',59,'(707) 428-2016','(707) 438-3274',1,66,48)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (158,'Marysville','MARYSVLE',0,'','201 D Street, Suite U','Marysville','CA','95901',59,'(530) 741-5315','(530) 741-5304',1,51,51)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (159,'MCRP Butte','MCRPBut',43,'Chico','1370 Ridgewood DR','Chico','CA','95973',4,null,null,null,null,4)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (160,'Stockton 2','STKTN 2',19,'Ceres','612 Carlton Ave','Stockton','CA','95203',50,null,null,0,null,39)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (161,'CCTRP Stockton','CCTRPSTKTN',33,'Stockton','612 Carlton Ave','Stockton','CA','95203',39,null,null,0,null,39)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (162,'CCTRP Bakersfield','CCTRPBKSFLD',17,'Bakersfield','3416-A Sillect Ave','Bakersfield','CA','93308',15,'(661) 633-5100','(661) 633-5121',0,null,15)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (163,'MCRP Kern','MCRPKern',17,'Bakersfield','3416-A Sillect Ave','Bakersfield','CA','93308',15,'(661) 633-5100','(661) 633-5121',0,null,15)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (164,'Fresno Central GPS','FRESNCGPS',21,'Fresno','5060 E Clinton Way','Fresno','CA','93727',10,'(559) 253-4144','(559) 253-4166',0,null,10)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (165,'CCU','CCU',21,'Fresno','5060 E Clinton Way','Fresno','CA','93727',10,'(559) 253-4144','(559) 253-4166',0,null,10)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (166,'CCTRP Sacramento','CCTRPSAC',28,'Sac Elder Creek','8000 ELDER CREEK Rd','Sacramento','CA','95824',34,'(916) 324-4141','(916) 445-8864',0,null,34)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (169,'South Bay GPS','SBAYGPS',30,'San Jose','909 Coleman Ave','San Jose','CA','95110',43,'(408) 277-1821','(408) 277-1030',0,null,43)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (170,'Santa Cruz Police Dept. Sub Unit ','SCPD',38,'Salinas','320 Airport Dr.','Salinas','CA','93905',27,null,null,null,null,27)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (171,'San Luis Obispo DRC','SLODRC',31,'San Luis Obispo','3232 S Higuera St','San Luis Obispo','CA','93401',40,'(805) 549-3251','(805) 549-3410',0,null,40)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (172,'Ventura GPS','VENTURAGPS',36,'Ventura','1555 W 5th St','Oxnard','CA','93030',56,'(805) 382-8151',null,0,null,56)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (173,'Ventura Training Center','VENTURATC',36,'Ventura','1555 W 5th St','Oxnard','CA','93030',56,'(805) 382-8151',null,0,null,56)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (174,'Los Angeles Central 2','LAC2',13,'LA Central','2444 S Alameda St, 2nd Floor','Los Angeles','CA','90058',19,'(323) 238-1700','(323) 231-5976',0,null,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (175,'Los Angeles Central GPS','LACGPS',13,'LA Central','2444 S Alameda St, 2nd Floor','Los Angeles','CA','90058',19,'(323) 238-1700','(323) 231-5976',0,null,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (176,'MCRP Los Angeles 1','MCRPLAC1',13,'LA Central','2444 S Alameda St, 2nd Floor','Los Angeles','CA','90058',19,'(323) 238-1700','(323) 231-5976',0,null,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (177,'MCRP Los Angeles 2','MCRPLAC2',13,'LA Central','2444 S Alameda St, 2nd Floor','Los Angeles','CA','90058',19,'(323) 238-1700','(323) 231-5976',0,null,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (178,'MCRP Los Angeles 3','MCRPLAC3',3,'Compton','322 Compton Blvd','Compton','CA','90220',19,'(562) 492-1022','(562) 427-7232',0,null,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (179,'Indio Palm Springs GPS','INDPLMSPRGPS',11,'Ind/Plm Spr','79-687 Country Club Dr','Bermuda Dunes','CA','92203',33,'(760) 772-3157','(760) 772-3165',0,null,33)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (180,'East San Diego GPS','ESDGPS',2,'Chula Vista','765 Third Avenue, Suite 300','Chula Vista','CA','91910',37,null,null,null,null,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (181,'MCRP San Diego','MCRPSD',2,'Chula Vista','765 Third Avenue, Suite 300','Chula Vista','CA','91910',37,null,null,null,null,37)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (182,'El Monte 3','ELMTE3',5,'El Monte','9900 Baldwin Pl','El Monte','CA','91731',19,'(626) 527-3005','(626) 459-4453',0,null,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (183,'El Monte 4','ELMTE4',5,'El Monte','9900 Baldwin Pl','El Monte','CA','91731',19,'(626) 527-3005','(626) 459-4453',0,null,19)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (184,'Fresno 1 GPS','FRESNO1GPS ',21,'Fresno','5060 E Clinton Way','Fresno','CA','93727',10,'(559) 253-4144','(559) 253-4166',0,46,10)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (185,'Fresno 6','FRESNO6 ',21,'Fresno','5060 E Clinton Way','Fresno','CA','93727',10,'(559) 253-4144','(559) 253-4166',0,46,10)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (186,'Delta South','DLTS',19,'Ceres','612 Carlton Ave','Stockton','CA','95203',50,'(209) 556-5010',null,null,null,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1],[PhoneNumber2],[Disabled],
[OLDLocationID],[OLDCountyID]) VALUES (187,'Delta GPS 2 ','DLTGPS2',19,'Ceres','612 Carlton Ave','Stockton','CA','95203',50,'(209) 948-7652',null,null,null,null)
INSERT INTO [dbo].[tlkpLocation]([LocationID],[LocationDesc],[LocationAbrv],[ComplexID],[ComplexDesc],
[StreetAddress],[City],[State],[ZipCode],[CountyID],[PhoneNumber1]) VALUES (188,'LA Central CCTRP','CCTRP',13,'LA Central','2756 James M Wood Blvd','Los Angeles','CA','90006',19,'(213) 523-3100')
SET IDENTITY_INSERT dbo.[tlkpLocation] OFF
GO
--==================================================================
--tlkpCounty
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (' + 
-- Convert(varchar, CountyID) + ',''' + Name + ''',''' + Region + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE CONVERT(varchar,[Disabled]) END) + ')'
--  FROM dbo.[tlkpCounty]
 --SELECT * FROM dbo.[tlkpCounty]
--==================================================================
/****** Object:  Table [dbo].[tlkpCounty]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCounty' AND Type = N'U')
  DROP TABLE dbo.tlkpCounty
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpCounty](
	[CountyID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[Region] [nvarchar](1) NULL,
	[Disabled] [bit] NULL,
 CONSTRAINT [PK_dbo.tlkpCounty] PRIMARY KEY CLUSTERED 
(
	[CountyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpCounty] ON
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (1,'Alameda','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (2,'Alpine','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (3,'Amador','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (4,'Butte','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (5,'Calaveras','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (6,'Colusa','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (7,'Contra Costa','N',0)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (8,'Del Norte','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (9,'El Dorado','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (10,'Fresno','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (11,'Glenn','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (12,'Humboldt','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (13,'Imperial','S',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (14,'Inyo','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (15,'Kern','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (16,'Kings','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (17,'Lake','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (18,'Lassen','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (19,'Los Angeles','S',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (20,'Madera','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (21,'Marin','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (22,'Mariposa','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (23,'Mendocino','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (24,'Merced','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (25,'Modoc','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (26,'Mono','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (27,'Monterey','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (28,'Napa','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (29,'Nevada','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (30,'Orange','S',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (31,'Placer','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (32,'Plumas','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (33,'Riverside','S',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (34,'Sacramento','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (35,'San Benito','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (36,'San Bernardino','S',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (37,'San Diego','S',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (38,'San Francisco','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (39,'San Joaquin','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (40,'San Luis Obispo','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (41,'San Mateo','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (42,'Santa Barbara','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (43,'Santa Clara','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (44,'Santa Cruz','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (45,'Shasta','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (46,'Sierra','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (47,'Siskiyou','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (48,'Solano','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (49,'Sonoma','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (50,'Stanislaus','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (51,'Sutter','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (52,'Tehama','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (53,'Trinity','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (54,'Tulare','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (55,'Tuolumne','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (56,'Ventura','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (57,'Yolo','N',null)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (58,'Yuba','N',1)
INSERT INTO dbo.[tlkpCounty] (CountyID, Name,Region,Disabled) VALUES (59,'Removed','S',1)
SET IDENTITY_INSERT dbo.[tlkpCounty] OFF
GO

ALTER TABLE [dbo].[tlkpLocation]
   ADD CONSTRAINT [FK_dbo.tlkpLocation_dbo.tlkpCounty_CountyID] FOREIGN KEY (CountyID)
      REFERENCES dbo.tlkpCounty (CountyID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
--==================================================================
--tlkpState
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES (''' + 
-- [State] + ''',''' + StateDesc + ''',''' + CountryCode + ''')' FROM dbo.[tlkpState]
 --SELECT * FROM dbo.[tlkpState]
--==================================================================
/****** Object:  Table [dbo].[tlkpState]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpState' AND Type = N'U')
  DROP TABLE dbo.tlkpState
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpState](
	[State] [nvarchar](2) NOT NULL,
	[StateDesc] [varchar](30) NOT NULL,
	[CountryCode] [varchar](3) NOT NULL,
 CONSTRAINT [PK_dbo.tlkpState] PRIMARY KEY CLUSTERED 
(
	[State] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('AB','Alberta','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('AK','Alaska','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('AL','Alabama','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('AR','Arkansas','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('AS','American Samoa','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('AZ','Arizona','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('BC','British Columbia','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('CA','California','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('CO','Colorado','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('CT','Connecticut','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('DC','District of Columbia','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('DE','Delaware','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('FL','Florida','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('GA','Georgia','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('GU','Guam','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('HI','Hawaii','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('IA','Iowa','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('ID','Idaho','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('IL','Illinois','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('IN','Indiana','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('KS','Kansas','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('KY','Kentucky','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('LA','Louisiana','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('LB','Labrador','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('MA','Massachusetts','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('MB','Manitoba','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('MD','Maryland','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('ME','Maine','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('MI','Michigan','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('MN','Minnesota','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('MO','Missouri','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('MS','Mississippi','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('MT','Montana','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('MX','Mexico','MEX')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NB','Brunswick','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NC','North Carolina','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('ND','North dakota','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NE','Nebraska','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NF','Newfoundland','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NH','New Hampshire','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NJ','New Jersey','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NM','New Mexico','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NS','Nova Scotia','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NT','Northwest Territories','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NV','Nevada','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('NY','New York','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('OH','Ohio','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('OK','Oklahoma','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('ON','Ontario','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('OR','Oregon','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('PA','Pennsylvania','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('PE','Prince Edward Island','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('PR','Puerto Rico','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('QC','Quebec','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('RI','Rhode Island','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('SC','South Carolina','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('SD','South Dakota','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('SK','Saskatchewan','CAN')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('TN','Tennessee','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('TX','Texas','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('UT','Utah','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('VA','Virginia','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('VI','Virgin Islands','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('VT','Vermont','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('WA','Washington','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('WI','Wisconsin','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('WV','West Virginia','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('WY','Wyoming','USA')
INSERT INTO dbo.[tlkpState] (State, StateDesc,CountryCode) VALUES ('YT','Yukon Territory','CAN')
GO
--==================================================================
--tlkpFacility
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
--Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (' + 
-- Convert(Varchar,FacilityID) + ',''' + OrgCommonID + ''',' + 
-- (CASE WHEN SomsLoc IS NULL THEN 'null' ELSE SomsLoc END) + ',''' + Name + ''',' +
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE Convert(Varchar, [Disabled]) END) + ',' +
-- (CASE WHEN [IsHospital] IS NULL THEN 'null' ELSE Convert(Varchar, [IsHospital]) END) + ',' +
-- (CASE WHEN [IsOutOfState] IS NULL THEN 'null' ELSE Convert(Varchar, [IsOutOfState]) END) + ',' +
-- (CASE WHEN [IsMCCF] IS NULL THEN 'null' ELSE Convert(Varchar, [IsMCCF]) END) + ')' FROM dbo.[tlkpFacility]
 --SELECT * FROM dbo.[tlkpFacility]
--==================================================================
/****** Object:  Table [dbo].[tlkpFacility]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpFacility' AND Type = N'U')
  DROP TABLE dbo.tlkpFacility
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpFacility](
	[FacilityID] [int] IDENTITY(1,1) NOT NULL,
	[OrgCommonID] [nvarchar](25) NOT NULL,
	[SomsLoc] [nvarchar](128) NULL,
	[Abbr] [nvarchar](25) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Disabled] [bit] NOT NULL,
	[IsHospital] [bit] NOT NULL,
	[IsOutOfState] [bit] NOT NULL,
	[IsMCCF] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpFacility] PRIMARY KEY CLUSTERED 
(
	[FacilityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpFacility] ON
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (1,'ASP',null,'ASP','Avenal State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (2,'CAC',null,'CAC','California City Correctional Facility',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (3,'CAL',null,'CAL','Calipatria State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (4,'CCC',null,'CCC','California Correctional Center',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (5,'CCI',null,'CCI','California Correctional Institution',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (6,'CCWF',null,'CCWF','Central California Women''s Facility',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (7,'CEN',null,'CEN','Centinela State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (8,'CHCF',null,'CHCF','California Health Care Facility - Stockton',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (9,'CIM',null,'CIM','California Institution for Men',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (10,'CIW',null,'CIW','California Institution for Women',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (11,'CMC',null,'CMC','California Men''s Colony',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (12,'CMF',null,'CMF','California Medical Facility',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (13,'COR',null,'COR','California State Prison, Corcoran',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (14,'CRC',null,'CRC','California Rehabilitation Center',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (15,'CTF',null,'CTF','Correctional Training Facility',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (16,'CVSP',null,'CVSP','Chuckawalla Valley State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (17,'DVI',null,'DVI','Deuel Vocational Institution',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (18,'FCRF',null,'FCRF','Female Community ReEntry Facility',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (19,'FOL',null,'FOL','Folsom State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (20,'FRCCC',null,'FRCCC','FR CCC Bakersfield',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (21,'FRMSC',null,'FRMSC','Female Residential Multi-Service Center',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (22,'HDSP',null,'HDSP','High Desert State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (23,'ISP',null,'ISP','Ironwood State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (24,'KVSP',null,'KVSP','Kern Valley State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (25,'LAC',null,'LAC','California State Prison, Los Angeles County',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (26,'MCSP',null,'MCSP','Mule Creek State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (27,'NKSP',null,'NKSP','North Kern State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (28,'PBSP',null,'PBSP','Pelican Bay State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (29,'PRCCF',null,'PRCCF','Private CCF Facilities',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (30,'PUCCF',null,'PUCCF','Public CCF Facilities',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (31,'PVSP',null,'PVSP','Pleasant Valley State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (32,'RJD',null,'RJD','RJ Donovan Correctional Facility',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (33,'SAC',null,'SAC','California State Prison, Sacramento',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (34,'SATF',null,'SATF','California Substance Abuse Treatment Facility',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (35,'SCC',null,'SCC','Sierra Conservation Center',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (36,'SHS',null,'SHS','State Hospitals',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (37,'SOL',null,'SOL','California State Prison, Solano',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (38,'SQ',null,'SQ','San Quentin State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (39,'SVSP',null,'SVSP','Salinas Valley State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (40,'VSP',null,'VSP','Valley State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (41,'WSP',null,'WSP','Wasco State Prison',0,0,0,0)
INSERT INTO dbo.[tlkpFacility] (FacilityID, OrgCommonID,SomsLoc, Abbr, 
Name, Disabled,IsHospital,IsOutOfState,IsMCCF) VALUES (42,'UNK',null,'UNK','Unknown',0,0,0,0)
SET IDENTITY_INSERT dbo.[tlkpFacility] OFF
GO
--==================================================================
--tlkpFinalRecommendation
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO dbo.[tlkpFinalRecommendation] (Id, FinalRecommendation,Disabled, ActionBy,DateAction) 
--VALUES (' +  Convert(Varchar,Id) + ',''' + FinalRecommendation + ''',' + 
-- (CASE WHEN [Disabled] IS NULL THEN 'null' ELSE Convert(Varchar, [Disabled]) END) + ',' +
-- Convert(Varchar, [ActionBy]) + ',''' +
-- (CASE WHEN [DateAction] IS NULL THEN 'null' ELSE Convert(Varchar, [DateAction]) END) + ''')' 
-- FROM dbo.[tlkpFinalRecommendation]
 --SELECT * FROM dbo.[tlkpFinalRecommendation]
--==================================================================
/****** Object:  Table [dbo].[tlkpFinalRecommendation]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpFinalRecommendation' AND Type = N'U')
  DROP TABLE dbo.tlkpFinalRecommendation
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpFinalRecommendation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FinalRecommendation] [nvarchar](75) NOT NULL,
	[Disabled] [bit] NULL,
	[ActionBy] [int] NOT NULL,
	[DateAction] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpFinalRecommendation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpFinalRecommendation] ON
INSERT INTO dbo.[tlkpFinalRecommendation] (Id, FinalRecommendation,Disabled, ActionBy,DateAction) 
VALUES (1,'Retain in BHR at EOP Level of Care',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpFinalRecommendation] (Id, FinalRecommendation,Disabled, ActionBy,DateAction) 
VALUES (2,'Change Level of Care to CCCMS',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpFinalRecommendation] (Id, FinalRecommendation,Disabled, ActionBy,DateAction) 
VALUES (3,'Transfer to Community Based Treatment',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpFinalRecommendation] (Id, FinalRecommendation,Disabled, ActionBy,DateAction) 
VALUES (4,'No Longer Meets Criteria for Inclusion in MHSDS',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpFinalRecommendation] (Id, FinalRecommendation,Disabled, ActionBy,DateAction) 
VALUES (5,'Place in BHR with Medical Necessity',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpFinalRecommendation] (Id, FinalRecommendation,Disabled, ActionBy,DateAction) 
VALUES (6,'Place in BHR with CCCMS LOC',null,0,'May  5 2017 12:41PM')
INSERT INTO dbo.[tlkpFinalRecommendation] (Id, FinalRecommendation,Disabled, ActionBy,DateAction) 
VALUES (7,'Place in BHR with EOP LOC',null,0,'May  5 2017 12:41PM')
SET IDENTITY_INSERT dbo.[tlkpFinalRecommendation] OFF
GO

--==================================================================
--tlkpDsmSubQuestion
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
--        VALUES (' + Convert(Varchar,Id) + ',' + Convert(varchar,QuestionId) + ',''' +
-- SubQuestion + ''',' + (CASE WHEN Disaled IS NULL THEN 'null' ELSE Convert(varchar, Disaled)  END) + ',''' + 
-- Convert(varchar, GetDate()) + ''')' FROM dbo.[tlkpDsmSubQuestion]
 --SELECT * FROM dbo.[tlkpDsmSubQuestion]
--==================================================================
/****** Object:  Table [dbo].[tlkpDsmSubQuestion]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpDsmSubQuestion' AND Type = N'U')
  DROP TABLE dbo.tlkpDsmSubQuestion
GO
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpDsmQuestion' AND Type = N'U')
  DROP TABLE dbo.tlkpDsmQuestion
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpDsmSubQuestion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[SubQuestion] [nvarchar](255) NULL,
	[Disaled] [bit] NULL,
	[DateEntered] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpDsmSubQuestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpDsmSubQuestion] ON
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (1,1,'Exclusive type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (2,1,'Nonexclusive type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (3,2,'Sexually attracted to males',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (4,2,'Sexually attracted to females',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (5,2,'Sexually attracted to both',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (6,6,'Requiring very substantial support',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (7,6,'Requiring substantial support',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (8,6,'Requiring support',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (9,7,'With accompanying intellectual impairment',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (10,7,'Without accompanying intellectual impairment',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (11,8,'With accompanying language impairment',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (12,8,'Without accompanying language impairment',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (13,10,'Mild',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (14,10,'Moderate',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (15,10,'Severe',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (16,12,'With self-injurious behavior',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (17,12,'Without self-injurious behavior',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (18,13,'With motor tics only',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (19,13,'With vocal tics only',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (20,14,'Erotomanic type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (21,14,'Grandiose type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (22,14,'Jealous type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (23,14,'Persecutory type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (24,14,'Somatic type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (25,14,'Mixed type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (26,14,'Unspecified type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (27,16,'First episode, currently in acute episode',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (28,16,'First episode, currently in partial remission',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (29,16,'First episode, currently in full remission',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (30,16,'Multiple episodes, currently in acute episode',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (31,16,'Multiple episodes, currently in partial remission',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (32,16,'Multiple episodes, currently in full remission',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (33,16,'Continuous',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (34,16,'Unspecified',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (35,17,'With good prognostic features',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (36,17,'Without good prognostic features',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (37,18,'With anxious distress, mild',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (38,18,'With anxious distress, moderate',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (39,18,'With anxious distress, moderate-severe',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (40,18,'With anxious distress, severe',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (41,38,'With good or fair insight',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (42,38,'With poor insight',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (43,38,'With absent insight/delusional beliefs',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (44,42,'With obsessive-compulsive disorder-like symptoms',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (45,42,'With appearance preoccupations, With hoarding symptoms',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (46,42,'With hair-pulling symptoms',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (47,42,'With skin-picking symptoms',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (48,47,'Care seeking type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (49,47,'Care avoidant type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (50,48,'Acute episode',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (51,48,'Persistent',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (52,49,'With psychological stressor',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (53,49,'Without psychological stressor',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (54,50,'Mild',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (55,50,'Moderate',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (56,50,'Severe',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (57,50,'Extreme',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (58,51,'Single episode',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (59,51,'Recurrent episodes',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (60,53,'Body part(s)',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (61,53,'Nonliving object(s)',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (62,53,'Other',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (63,54,'Nocturnal only',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (64,54,'Diurnal only',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (65,54,'Nocturnal and diurnal',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (66,55,'With constipation and overflow incontinence',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (67,55,'Without constipation and overflow incontinence',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (68,56,'Episodic',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (69,56,'Persistent',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (70,56,'Recurrent',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (71,60,'Acute',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (72,60,'Subacute',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (73,60,'Persistent',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (74,71,'Lifelong',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (75,71,'Acquired',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (76,72,'Generalized',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (77,72,'Situational',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (78,79,'Acute',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (79,79,'Persistent',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (80,80,'Hyperactive',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (81,80,'Hypoactive',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (82,80,'Mixed level of activity',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (83,81,'Without behavioral disturbance',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (84,81,'With behavioral disturbance',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (85,82,'Labile type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (86,82,'Disinhibited type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (87,82,'Aggressive type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (88,82,'Apathetic type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (89,82,'Paranoid type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (90,82,'Other type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (91,82,'Combined type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (92,82,'Unspecified type',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (93,83,'Sexually aroused by exposing genitals to prepubertal children',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (94,83,'Sexually aroused by exposing genitals to physically mature individuals',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (95,83,'Sexually aroused by exposing genitals to prepubertal children and to physically mature individuals',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (96,87,'With marked stressor(s)',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (97,87,'Without marked stressor(s)',null,'Aug 18 2020  9:11AM')
INSERT INTO [dbo].[tlkpDsmSubQuestion]([Id],[QuestionId],[SubQuestion],[Disaled],[DateEntered]) 
        VALUES (98,87,'With postpartum onset',null,'Aug 18 2020  9:11AM')
SET IDENTITY_INSERT dbo.[tlkpDsmSubQuestion] OFF
GO
--==================================================================
--tlkpDsmQuestion
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
--        VALUES (' + Convert(Varchar,Id) + ',' + (CASE WHEN HasSubQuestion IS NULL THEN 'null' ELSE Convert(varchar,HasSubQuestion) END) + ',''' +
-- Question + ''',' + (CASE WHEN Disaled IS NULL THEN 'null' ELSE Convert(varchar, Disaled)  END) + ',''' + 
-- Convert(varchar, GetDate()) + ''')' FROM dbo.[tlkpDsmQuestion]
 --SELECT * FROM dbo.[tlkpDsmQuestion]
--==================================================================
/****** Object:  Table [dbo].[tlkpDsmQuestion]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpDsmQuestion' AND Type = N'U')
  DROP TABLE dbo.tlkpDsmQuestion
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpDsmQuestion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HasSubQuestion] [bit] NULL,
	[Question] [nvarchar](255) NULL,
	[Disaled] [bit] NULL,
	[DateEntered] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpDsmQuestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpDsmQuestion] ON
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (1,1,'Exclusive type, Nonexclusive type',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (2,1,'Sexually attracted to males, Sexually attracted to females, Sexually attracted to both',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (3,null,'Limited to incest',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (4,null,'Associated with a known medical or genetic condition or environmental factor',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (5,null,'Associated with another neurodevelopmental, mental or behavioral factor',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (6,1,'Requiring support',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (7,1,'Accompanying intellectual impairment',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (8,1,'Accompanying language impairment',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (9,null,'With catatonia',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (10,1,'Level',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (11,null,'In partial remission',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (12,1,'Self-injurious behavior',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (13,1,'Tics Only',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (14,1,'Types',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (15,null,'With bizarre content',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (16,1,'Currently Status',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (17,1,'Good prognostic features',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (18,1,'Anxious distress',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (19,null,'With mixed features',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (20,null,'With rapid cycling',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (21,null,'With melancholic features',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (22,null,'With atypical features',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (23,null,'With mood-congruent psychotic features',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (24,null,'With mood-incongruent psychotic features',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (25,null,'With peripartum onset',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (26,null,'With seasonal pattern',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (27,null,'Current episode depressed',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (28,null,'Current episode hypomanic',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (29,null,'Most recent episode depressed',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (30,null,'In full remission',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (31,null,'Early onset',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (32,null,'Late onset',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (33,null,'With pure dysthymic syndrome',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (34,null,'With persistent major depressive episode',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (35,null,'With intermittent major depressive episodes with current episode',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (36,null,'With intermittent major depressive episodes without current episode',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (37,null,'Performance only',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (38,1,'Insight',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (39,null,'Tic-related',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (40,null,'With muscle dysmorphia',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (41,null,'With excessive acquisition',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (42,1,'Conditions',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (43,null,'With dissociative symptoms',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (44,null,'With delayed expression',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (45,null,'With predominant pain',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (46,null,'Persistent',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (47,1,'Care type',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (48,1,'Acute episode',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (49,1,'Psychological stressor',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (50,1,'Level1',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (51,1,'Episode Type',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (52,null,'In remission',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (53,1,'Body Part',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (54,1,'Nocturnal',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (55,1,'Constipation and overflow incontinence',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (56,1,'Acute episode 1',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (57,null,'With non-sleep disorder mental comorbidity',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (58,null,'With other medical comorbidity',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (59,null,'With other sleep disorder',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (60,null,'Situation',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (61,null,'With mental disorder',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (62,null,'With medical condition',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (63,null,'With another sleep disorder',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (64,null,'Familial',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (65,null,'With sleep-related eating',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (66,null,'With sleep-related sexual behavior (sexsomnia)',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (67,null,'During sleep onset',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (68,null,'With associated non-sleep disorder',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (69,null,'With associated other medical condition',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (70,null,'With associated other sleep disorder',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (71,1,'Lifelong_Acquired',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (72,1,'Generalized_Situational',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (73,null,'With a disorder of sex development',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (74,null,'Posttransition',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (75,null,'In early remission',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (76,null,'In sustained remission',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (77,null,'In a controlled environment',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (78,null,'On maintenance therapy',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (79,1,'Acute_Persistent',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (80,1,'Activity Level',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (81,1,'Behavioral disturbance',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (82,1,'Personnel Type',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (83,1,'Sexually history',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (84,null,'With asphyxiophilia',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (85,null,'With fetishism',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (86,null,'With autogynephilia',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (87,1,'stressor',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (88,null,'Associated with a known medical or genetic condition, neurodevelopmental disorder or environmental factor',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (89,null,'Never experienced an orgasm under any situation',null,'Aug 18 2020  8:44AM')
INSERT INTO [dbo].[tlkpDsmQuestion]([Id],[HasSubQuestion],[Question],[Disaled],[DateEntered]) 
        VALUES (90,null,'Overlapping with non-24-hour sleep-wake type',null,'Aug 18 2020  8:44AM')
SET IDENTITY_INSERT dbo.[tlkpDsmQuestion] OFF
GO
ALTER TABLE [dbo].[tlkpDsmSubQuestion]
   ADD CONSTRAINT [FK_dbo.DsmSubQuestion_dbo.DsmQuestion_QuestionId] FOREIGN KEY ([QuestionId])
      REFERENCES [dbo].[tlkpDsmQuestion] ([Id])
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
--==================================================================
--tlkpDsmQAMap
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
--        VALUES (' + Convert(Varchar,Id) + ',' + Convert(varchar,MasterDXId) + ',' + Convert(varchar, DsmQuestionId) + ',' +
-- (CASE WHEN Disabled IS NULL THEN 'null' ELSE Convert(varchar, Disabled)  END) + ',''' + 
-- Convert(varchar, GetDate()) + ''')' FROM dbo.[tlkpDsmQAMap]
 --SELECT * FROM dbo.[tlkpDsmQAMap]
--==================================================================
/****** Object:  Table [dbo].[tlkpDsmQAMap]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpDsmQAMap' AND Type = N'U')
  DROP TABLE dbo.tlkpDsmQAMap
GO
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpICD_DX_Codes' AND Type = N'U')
  DROP TABLE dbo.tlkpICD_DX_Codes
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpDsmQAMap](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MasterDXId] [int] NOT NULL,
	[DsmQuestionId] [int] NOT NULL,
	[Disabled] [bit] NULL,
	[DateEntered] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpDsmQAMap] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpDsmQAMap] ON
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (1,10002,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (2,10003,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (3,10004,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (4,10005,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (5,10006,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (6,10007,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (7,10008,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (8,10009,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (9,10010,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (10,10011,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (11,10012,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (12,10013,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (13,10014,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (14,10015,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (15,10016,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (16,10017,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (17,10018,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (18,10019,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (19,10020,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (20,10021,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (21,10022,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (22,10026,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (23,10026,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (24,10027,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (25,10027,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (26,10039,42,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (27,10041,82,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (28,10046,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (29,10046,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (30,10046,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (31,10048,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (32,10048,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (33,10059,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (34,10059,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (35,10059,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (36,10060,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (37,10060,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (38,10060,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (39,10063,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (40,10063,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (41,10081,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (42,10081,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (43,10094,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (44,10094,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (45,10094,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (46,10094,78,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (47,10096,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (48,10096,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (49,10107,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (50,10107,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (51,10107,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (52,10107,78,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (53,10108,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (54,10108,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (55,10108,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (56,10108,78,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (57,10111,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (58,10111,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (59,10125,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (60,10125,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (61,10137,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (62,10137,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (63,10137,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (64,10139,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (65,10139,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (66,10148,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (67,10148,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (68,10148,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (69,10149,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (70,10149,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (71,10149,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (72,10152,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (73,10152,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (74,10163,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (75,10163,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (76,10172,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (77,10172,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (78,10172,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (79,10174,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (80,10174,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (81,10185,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (82,10185,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (83,10185,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (84,10186,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (85,10186,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (86,10186,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (87,10189,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (88,10189,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (89,10208,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (90,10208,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (91,10225,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (92,10225,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (93,10225,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (94,10227,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (95,10227,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (96,10239,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (97,10239,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (98,10239,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (99,10240,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (100,10240,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (101,10240,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (102,10242,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (103,10242,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (104,10257,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (105,10257,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (106,10269,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (107,10269,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (108,10269,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (109,10270,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (110,10270,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (111,10270,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (112,10272,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (113,10272,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (114,10284,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (115,10284,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (116,10284,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (117,10285,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (118,10285,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (119,10285,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (120,10286,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (121,10286,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (122,10286,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (123,10287,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (124,10287,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (125,10287,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (126,10288,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (127,10288,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (128,10303,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (129,10303,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (130,10318,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (131,10318,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (132,10318,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (133,10319,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (134,10319,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (135,10319,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (136,10321,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (137,10321,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (138,10333,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (139,10333,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (140,10333,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (141,10334,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (142,10334,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (143,10334,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (144,10335,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (145,10335,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (146,10335,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (147,10336,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (148,10336,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (149,10336,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (150,10339,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (151,10339,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (152,10352,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (153,10352,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (154,10364,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (155,10364,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (156,10364,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (157,10364,78,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (158,10365,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (159,10365,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (160,10365,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (161,10365,78,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (162,10385,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (163,10385,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (164,10385,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (165,10387,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (166,10387,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (167,10397,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (168,10397,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (169,10397,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (170,10398,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (171,10398,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (172,10398,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (173,10401,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (174,10401,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (175,10413,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (176,10413,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (177,10423,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (178,10423,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (179,10423,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (180,10425,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (181,10425,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (182,10439,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (183,10439,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (184,10439,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (185,10440,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (186,10440,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (187,10440,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (188,10443,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (189,10443,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (190,10463,79,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (191,10463,80,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (192,10486,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (193,10486,17,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (194,10488,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (195,10488,16,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (196,10490,14,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (197,10490,15,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (198,10490,16,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (199,10491,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (200,10491,87,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (201,10493,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (202,10493,16,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (203,10494,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (204,10494,16,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (205,10508,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (206,10508,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (207,10508,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (208,10508,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (209,10508,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (210,10508,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (211,10508,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (212,10508,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (213,10508,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (214,10508,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (215,10510,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (216,10510,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (217,10510,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (218,10510,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (219,10510,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (220,10510,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (221,10510,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (222,10510,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (223,10510,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (224,10510,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (225,10511,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (226,10511,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (227,10511,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (228,10511,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (229,10511,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (230,10511,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (231,10511,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (232,10511,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (233,10511,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (234,10511,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (235,10512,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (236,10512,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (237,10512,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (238,10512,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (239,10512,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (240,10512,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (241,10512,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (242,10512,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (243,10512,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (244,10512,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (245,10513,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (246,10513,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (247,10513,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (248,10513,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (249,10513,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (250,10513,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (251,10513,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (252,10513,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (253,10513,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (254,10513,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (255,10515,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (256,10515,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (257,10515,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (258,10515,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (259,10515,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (260,10515,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (261,10515,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (262,10515,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (263,10515,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (264,10515,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (265,10516,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (266,10516,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (267,10516,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (268,10516,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (269,10516,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (270,10516,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (271,10516,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (272,10516,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (273,10516,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (274,10516,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (275,10517,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (276,10517,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (277,10517,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (278,10517,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (279,10517,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (280,10517,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (281,10517,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (282,10517,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (283,10517,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (284,10517,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (285,10518,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (286,10518,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (287,10518,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (288,10518,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (289,10518,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (290,10518,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (291,10518,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (292,10518,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (293,10518,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (294,10518,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (295,10527,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (296,10527,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (297,10527,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (298,10527,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (299,10527,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (300,10527,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (301,10527,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (302,10527,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (303,10527,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (304,10527,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (305,10528,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (306,10528,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (307,10528,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (308,10528,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (309,10528,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (310,10528,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (311,10528,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (312,10528,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (313,10528,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (314,10528,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (315,10529,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (316,10529,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (317,10529,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (318,10529,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (319,10529,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (320,10529,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (321,10529,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (322,10529,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (323,10529,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (324,10529,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (325,10530,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (326,10530,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (327,10530,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (328,10530,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (329,10530,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (330,10530,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (331,10530,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (332,10530,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (333,10530,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (334,10530,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (335,10531,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (336,10531,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (337,10531,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (338,10531,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (339,10531,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (340,10531,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (341,10531,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (342,10531,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (343,10531,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (344,10531,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (345,10532,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (346,10532,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (347,10532,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (348,10532,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (349,10532,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (350,10532,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (351,10532,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (352,10532,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (353,10532,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (354,10532,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (355,10535,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (356,10535,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (357,10535,11,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (358,10535,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (359,10535,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (360,10535,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (361,10535,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (362,10535,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (363,10535,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (364,10535,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (365,10535,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (366,10535,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (367,10535,27,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (368,10535,28,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (369,10535,29,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (370,10535,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (371,10537,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (372,10537,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (373,10537,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (374,10537,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (375,10537,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (376,10537,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (377,10537,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (378,10537,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (379,10537,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (380,10537,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (381,10538,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (382,10538,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (383,10538,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (384,10538,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (385,10538,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (386,10538,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (387,10538,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (388,10538,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (389,10538,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (390,10538,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (391,10539,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (392,10539,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (393,10539,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (394,10539,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (395,10539,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (396,10539,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (397,10539,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (398,10539,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (399,10539,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (400,10539,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (401,10540,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (402,10540,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (403,10540,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (404,10540,20,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (405,10540,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (406,10540,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (407,10540,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (408,10540,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (409,10540,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (410,10540,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (411,10542,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (412,10542,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (413,10542,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (414,10542,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (415,10542,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (416,10542,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (417,10542,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (418,10542,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (419,10542,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (420,10543,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (421,10543,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (422,10543,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (423,10543,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (424,10543,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (425,10543,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (426,10543,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (427,10543,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (428,10543,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (429,10544,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (430,10544,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (431,10544,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (432,10544,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (433,10544,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (434,10544,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (435,10544,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (436,10544,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (437,10544,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (438,10545,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (439,10545,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (440,10545,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (441,10545,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (442,10545,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (443,10545,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (444,10545,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (445,10545,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (446,10545,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (447,10546,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (448,10546,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (449,10546,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (450,10546,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (451,10546,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (452,10546,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (453,10546,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (454,10546,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (455,10546,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (456,10547,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (457,10547,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (458,10547,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (459,10547,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (460,10547,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (461,10547,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (462,10547,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (463,10547,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (464,10547,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (465,10549,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (466,10549,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (467,10549,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (468,10549,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (469,10549,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (470,10549,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (471,10549,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (472,10549,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (473,10549,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (474,10551,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (475,10551,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (476,10551,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (477,10551,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (478,10551,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (479,10551,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (480,10551,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (481,10551,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (482,10551,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (483,10552,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (484,10552,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (485,10552,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (486,10552,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (487,10552,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (488,10552,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (489,10552,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (490,10552,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (491,10552,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (492,10553,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (493,10553,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (494,10553,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (495,10553,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (496,10553,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (497,10553,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (498,10553,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (499,10553,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (500,10553,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (501,10554,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (502,10554,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (503,10554,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (504,10554,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (505,10554,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (506,10554,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (507,10554,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (508,10554,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (509,10554,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (510,10556,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (511,10556,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (512,10556,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (513,10556,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (514,10556,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (515,10556,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (516,10556,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (517,10556,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (518,10556,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (519,10557,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (520,10557,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (521,10557,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (522,10557,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (523,10557,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (524,10557,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (525,10557,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (526,10557,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (527,10557,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (528,10559,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (529,10559,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (530,10559,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (531,10559,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (532,10559,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (533,10559,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (534,10559,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (535,10559,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (536,10559,26,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (537,10560,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (538,10561,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (539,10561,11,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (540,10561,18,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (541,10561,19,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (542,10561,21,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (543,10561,22,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (544,10561,23,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (545,10561,24,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (546,10561,25,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (547,10561,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (548,10561,31,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (549,10561,32,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (550,10561,33,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (551,10561,34,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (552,10561,35,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (553,10561,36,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (554,10568,37,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (555,10593,38,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (556,10593,39,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (557,10594,38,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (558,10594,41,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (559,10598,43,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (560,10598,44,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (561,10613,48,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (562,10613,49,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (563,10614,48,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (564,10614,49,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (565,10615,48,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (566,10615,49,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (567,10616,48,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (568,10616,49,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (569,10617,48,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (570,10617,49,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (571,10618,48,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (572,10618,49,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (573,10619,48,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (574,10619,49,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (575,10620,48,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (576,10620,49,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (577,10625,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (578,10625,45,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (579,10625,46,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (580,10627,47,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (581,10628,38,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (582,10628,40,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (583,10639,11,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (584,10639,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (585,10639,50,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (586,10640,11,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (587,10640,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (588,10640,50,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (589,10641,11,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (590,10641,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (591,10641,50,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (592,10642,52,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (593,10643,52,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (594,10644,11,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (595,10644,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (596,10644,50,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (597,10657,65,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (598,10657,66,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (599,10659,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (600,10659,60,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (601,10659,67,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (602,10659,68,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (603,10659,69,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (604,10659,70,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (605,10662,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (606,10662,71,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (607,10662,72,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (608,10664,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (609,10664,71,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (610,10664,72,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (611,10665,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (612,10665,71,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (613,10665,72,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (614,10666,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (615,10666,71,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (616,10666,72,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (617,10666,89,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (618,10667,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (619,10667,71,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (620,10667,72,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (621,10668,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (622,10668,71,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (623,10668,72,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (624,10670,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (625,10670,71,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (626,10674,50,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (627,10693,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (628,10693,56,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (629,10700,73,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (630,10700,74,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (631,10703,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (632,10703,53,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (633,10703,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (634,10704,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (635,10704,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (636,10704,85,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (637,10704,86,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (638,10705,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (639,10705,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (640,10705,83,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (641,10706,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (642,10706,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (643,10707,1,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (644,10707,2,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (645,10707,3,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (646,10709,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (647,10709,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (648,10709,84,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (649,10710,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (650,10710,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (651,10711,30,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (652,10711,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (653,10715,51,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (654,10716,51,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (655,10742,4,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (656,10742,5,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (657,10742,6,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (658,10742,7,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (659,10742,8,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (660,10742,9,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (661,10751,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (662,10751,11,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (663,10752,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (664,10752,11,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (665,10753,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (666,10753,11,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (667,10758,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (668,10767,13,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (669,10771,54,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (670,10772,55,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (671,10773,52,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (672,10774,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (673,10774,12,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (674,10774,88,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (675,10791,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (676,10792,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (677,10793,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (678,10794,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (679,10795,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (680,10796,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (681,10797,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (682,10798,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (683,10799,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (684,10800,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (685,10801,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (686,10802,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (687,10802,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (688,10803,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (689,10803,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (690,10804,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (691,10804,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (692,10805,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (693,10805,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (694,10806,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (695,10806,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (696,10807,56,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (697,10807,57,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (698,10807,58,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (699,10807,59,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (700,10809,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (701,10809,60,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (702,10809,61,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (703,10809,62,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (704,10809,63,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (705,10812,56,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (706,10813,56,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (707,10813,64,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (708,10813,90,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (709,10814,56,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (710,10814,64,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (711,10815,56,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (712,10816,56,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (713,10817,56,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (714,10819,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (715,10824,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (716,10825,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (717,10826,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (718,10827,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (719,10828,10,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (720,10842,81,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (721,10939,75,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (722,10939,76,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (723,10939,77,null,'Aug 18 2020  9:25AM')
INSERT INTO [dbo].[tlkpDsmQAMap]([Id],[MasterDXId],[DsmQuestionId],[Disabled],[DateEntered]) 
        VALUES (724,10939,78,null,'Aug 18 2020  9:25AM')
SET IDENTITY_INSERT dbo.[tlkpDsmQAMap] OFF
GO
--==================================================================
--tlkpICD_DX_Codes
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
--[Disabled],[DateEntered]) VALUES (' + Convert(Varchar,MasterDXId) + ',''' + Version + ''',''' +
-- ICDCode + ''',''' + DSMDesc + ''',''' + ICDDesc + ''',' +
-- (CASE WHEN Disabled IS NULL THEN 'null' ELSE Convert(varchar, Disabled)  END) + ',''' + 
-- Convert(varchar, GetDate()) + ''')' FROM dbo.[tlkpICD_DX_Codes]
 --SELECT * FROM dbo.[tlkpICD_DX_Codes]
--==================================================================
/****** Object:  Table [dbo].[tlkpICD_DX_Codes]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpICD_DX_Codes' AND Type = N'U')
  DROP TABLE dbo.tlkpICD_DX_Codes
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpICD_DX_Codes](
	[MasterDXId] [int] IDENTITY(1,1) NOT NULL,
	[Version] [nvarchar](15) NULL,
	[ICDCode] [nvarchar](15) NULL,
	[DSMDesc] [nvarchar](400) NULL,
	[ICDDesc] [nvarchar](400) NULL,
	[Disabled] [bit] NULL,
	[DateEntered] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.tlkpICD_DX_Codes] PRIMARY KEY CLUSTERED 
(
	[MasterDXId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpICD_DX_Codes] ON
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10001,'ICD10-DSM5','E66.9','Overweight or obesity','Obesity, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10002,'ICD10-DSM5','F01.50','Probable major vascular neurocognitive disorder, without behavioral disturbance','Vascular dementia without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10003,'ICD10-DSM5','F01.51','Probable major vascular neurocognitive disorder, with behavioral disturbance','Vascular dementia with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10004,'ICD10-DSM5','F02.80','Probable major neurocognitive disorder due to Alzheimer''s disease, without behavioral disturbance','Dementia in other diseases classified elsewhere without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10005,'ICD10-DSM5','F02.80','Probable major neurocognitive disorder due to frontotemporal lobar degeneration, without behavioral disturbance','Dementia in other diseases classified elsewhere without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10006,'ICD10-DSM5','F02.80','Probable major neurocognitive disorder with Lewy bodies, without behavioral disturbance','Dementia in other diseases classified elsewhere without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10007,'ICD10-DSM5','F02.80','Major neurocognitive disorder due to another medical condition, without behavioral disturbance','Dementia in other diseases classified elsewhere without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10008,'ICD10-DSM5','F02.80','Major neurocognitive disorder due to traumatic brain injury, without behavioral disturbance','Dementia in other diseases classified elsewhere without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10009,'ICD10-DSM5','F02.80','Major neurocognitive disorder due to HIV infection, without behavioral disturbance','Dementia in other diseases classified elsewhere without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10010,'ICD10-DSM5','F02.80','Probable major neurocognitive disorder due to Prion disease, without behavioral disturbance','Dementia in other diseases classified elsewhere without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10011,'ICD10-DSM5','F02.80','Probable major neurocognitive disorder probably due to Parkinson''s disease, without behavioral disturbance','Dementia in other diseases classified elsewhere without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10012,'ICD10-DSM5','F02.80','Major neurocognitive disorder due to multiple etiologies, without behavioral disturbance','Dementia in other diseases classified elsewhere without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10013,'ICD10-DSM5','F02.80','Probable major neurocognitive disorder due to Huntington''s disease, without behavioral disturbance','Dementia in other diseases classified elsewhere without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10014,'ICD10-DSM5','F02.81','Probable major neurocognitive disorder due to frontotemporal lobar degeneration, with behavioral disturbance','Dementia in other diseases classified elsewhere with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10015,'ICD10-DSM5','F02.81','Probable major neurocognitive disorder due to Alzheimer''s disease, with behavioral disturbance','Dementia in other diseases classified elsewhere with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10016,'ICD10-DSM5','F02.81','Major neurocognitive disorder due to traumatic brain injury, with behavioral disturbance','Dementia in other diseases classified elsewhere with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10017,'ICD10-DSM5','F02.81','Major neurocognitive disorder due to HIV infection, with behavioral disturbance','Dementia in other diseases classified elsewhere with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10018,'ICD10-DSM5','F02.81','Major neurocognitive disorder due to Prion disease, with behavioral disturbance','Dementia in other diseases classified elsewhere with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10019,'ICD10-DSM5','F02.81','Major neurocognitive disorder probably due to Parkinson''s disease, with behavioral disturbance','Dementia in other diseases classified elsewhere with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10020,'ICD10-DSM5','F02.81','Major neurocognitive disorder due to Huntington''s disease, with behavioral disturbance','Dementia in other diseases classified elsewhere with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10021,'ICD10-DSM5','F02.81','Major neurocognitive disorder due to another medical condition, with behavioral disturbance','Dementia in other diseases classified elsewhere with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10022,'ICD10-DSM5','F02.81','Major neurocognitive disorder due to multiple etiologies, with behavioral disturbance','Dementia in other diseases classified elsewhere with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10023,'ICD10-DSM5','F03.90','Unspecified dementia without behavioral disturbance','Unspecified dementia without behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10024,'ICD10-DSM5','F03.91','Unspecified dementia with behavioral disturbance','Unspecified dementia with behavioral disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10025,'ICD10-DSM5','F04','Amnestic disorder due to known physiological condition','Amnestic disorder due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10026,'ICD10-DSM5','F05','Delirium due to another medical condition','Delirium due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10027,'ICD10-DSM5','F05','Delirium due to multiple etiologies','Delirium due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10028,'ICD10-DSM5','F06.0','Psychotic disorder due to another medical condition, with hallucinations','Psychotic disorder with hallucinations due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10029,'ICD10-DSM5','F06.1','Catatonia associated with another mental disorder (catatonia specifier)','Catatonic disorder due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10030,'ICD10-DSM5','F06.1','Catatonic disorder due to another medical condition','Catatonic disorder due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10031,'ICD10-DSM5','F06.1','Unspecified catatonia','Catatonic disorder due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10032,'ICD10-DSM5','F06.2','Psychotic disorder due to another medical condition, with delusions','Psychotic disorder with delusions due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10033,'ICD10-DSM5','F06.30','No corresponding DSM-5 description for this ICD-10 code','Mood disorder due to known physiological condition, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10034,'ICD10-DSM5','F06.31','Depressive disorder due to another medical condition, with depressive features','Mood disorder due to known physiological condition with depressive features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10035,'ICD10-DSM5','F06.32','Depressive disorder due to another medical condition, with major depressive-like episode','Mood disorder due to known physiological condition with major depressive-like episode',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10036,'ICD10-DSM5','F06.33','Bipolar and related disorder due to another medical condition, with manic or hypomanic-like episodes','Mood disorder due to known physiological condition with manic features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10037,'ICD10-DSM5','F06.34','Bipolar and related disorder due to another medical condition, with mixed features','Mood disorder due to known physiological condition with mixed features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10038,'ICD10-DSM5','F06.4','Anxiety disorder due to another medical condition','Anxiety disorder due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10039,'ICD10-DSM5','F06.8','Obsessive-compulsive and related disorder due to another medical condition','Other specified mental disorders due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10040,'ICD10-DSM5','F06.8','Other specified mental disorder due to another medical condition','Other specified mental disorders due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10041,'ICD10-DSM5','F07.0','Personality change due to another medical condition','Personality change due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10042,'ICD10-DSM5','F07.81','No corresponding DSM-5 description for this ICD-10 code','Postconcussional syndrome',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10043,'ICD10-DSM5','F07.89','No corresponding DSM-5 description for this ICD-10 code','Other personality and behavioral disorders due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10044,'ICD10-DSM5','F07.9','No corresponding DSM-5 description for this ICD-10 code','Unspecified personality and behavioral disorder due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10045,'ICD10-DSM5','F09','Unspecified mental disorder due to another medical condition','Unspecified mental disorder due to known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10046,'ICD10-DSM5','F10.10','Alcohol use disorder, mild','Alcohol abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10047,'ICD10-DSM5','F10.120','No corresponding DSM-5 description for this ICD-10 code','Alcohol abuse with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10048,'ICD10-DSM5','F10.121','Alcohol intoxication delirium, with mild use disorder','Alcohol abuse with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10049,'ICD10-DSM5','F10.129','Alcohol intoxication, with mild use disorder','Alcohol abuse with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10050,'ICD10-DSM5','F10.14','No corresponding DSM-5 description for this ICD-10 code','Alcohol abuse with alcohol-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10051,'ICD10-DSM5','F10.150','No corresponding DSM-5 description for this ICD-10 code','Alcohol abuse with alcohol-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10052,'ICD10-DSM5','F10.151','No corresponding DSM-5 description for this ICD-10 code','Alcohol abuse with alcohol-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10053,'ICD10-DSM5','F10.159','Alcohol-induced psychotic disorder, with mild use disorder','Alcohol abuse with alcohol-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10054,'ICD10-DSM5','F10.180','Alcohol-induced anxiety disorder, with mild use disorder','Alcohol abuse with alcohol-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10055,'ICD10-DSM5','F10.181','Alcohol-induced sexual dysfunction, with mild use disorder','Alcohol abuse with alcohol-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10056,'ICD10-DSM5','F10.182','Alcohol-induced sleep disorder, with mild use disorder','Alcohol abuse with alcohol-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10057,'ICD10-DSM5','F10.188','No corresponding DSM-5 description for this ICD-10 code','Alcohol abuse with other alcohol-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10058,'ICD10-DSM5','F10.19','No corresponding DSM-5 description for this ICD-10 code','Alcohol abuse with unspecified alcohol-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10059,'ICD10-DSM5','F10.20','Alcohol use disorder, moderate','Alcohol dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10060,'ICD10-DSM5','F10.20','Alcohol use disorder, severe','Alcohol dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10061,'ICD10-DSM5','F10.21','No corresponding DSM-5 description for this ICD-10 code','Alcohol dependence, in remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10062,'ICD10-DSM5','F10.220','No corresponding DSM-5 description for this ICD-10 code','Alcohol dependence with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10063,'ICD10-DSM5','F10.221','Alcohol intoxication delirium, with moderate or severe use disorder','Alcohol dependence with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10064,'ICD10-DSM5','F10.229','Alcohol intoxication, with moderate or severe use disorder','Alcohol dependence with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10065,'ICD10-DSM5','F10.230','No corresponding DSM-5 description for this ICD-10 code','Alcohol dependence with withdrawal, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10066,'ICD10-DSM5','F10.31','Alcohol withdrawal delirium','Alcohol dependence with withdrawal delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10067,'ICD10-DSM5','F10.232','Alcohol withdrawal, with perceptual disturbances','Alcohol dependence with withdrawal with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10068,'ICD10-DSM5','F10.239','Alcohol withdrawal, without perceptual disturbances','Alcohol dependence with withdrawal, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10069,'ICD10-DSM5','F10.24','No corresponding DSM-5 description for this ICD-10 code','Alcohol dependence with alcohol-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10070,'ICD10-DSM5','F10.250','No corresponding DSM-5 description for this ICD-10 code','Alcohol dependence with alcohol-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10071,'ICD10-DSM5','F10.251','No corresponding DSM-5 description for this ICD-10 code','Alcohol dependence with alcohol-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10072,'ICD10-DSM5','F10.259','Alcohol-induced psychotic disorder, with moderate to severe use disorder','Alcohol dependence with alcohol-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10073,'ICD10-DSM5','F10.26','Alcohol-induced major neurocognitive disorder, amnestic confabulatory type, with moderate or severe use disorder','Alcohol dependence with alcohol-induced persisting amnestic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10074,'ICD10-DSM5','F10.27','Alcohol-induced major neurocognitive disorder, nonamnestic confabulatory type, with moderate or severe use disorder','Alcohol dependence with alcohol-induced persisting dementia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10075,'ICD10-DSM5','F10.280','Alcohol-induced anxiety disorder, with moderate or severe use disorder','Alcohol dependence with alcohol-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10076,'ICD10-DSM5','F10.281','Alcohol-induced sexual dysfunction, with moderate or severe use disorder','Alcohol dependence with alcohol-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10077,'ICD10-DSM5','F10.282','Alcohol-induced sleep disorder, with moderate or severe use disorder','Alcohol dependence with alcohol-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10078,'ICD10-DSM5','F10.288','Alcohol-induced mild neurocognitive disorder, with moderate or severe use disorder','Alcohol dependence with other alcohol-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10079,'ICD10-DSM5','F10.29','No corresponding DSM-5 description for this ICD-10 code','Alcohol dependence with unspecified alcohol-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10080,'ICD10-DSM5','F10.920','No corresponding DSM-5 description for this ICD-10 code','Alcohol use, unspecified with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10081,'ICD10-DSM5','F10.921','Alcohol intoxication delirium, without use disorder','Alcohol use, unspecified with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10082,'ICD10-DSM5','F10.929','Alcohol intoxication, without use disorder','Alcohol use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10083,'ICD10-DSM5','F10.94','No corresponding DSM-5 description for this ICD-10 code','Alcohol use, unspecified with alcohol-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10084,'ICD10-DSM5','F10.950','No corresponding DSM-5 description for this ICD-10 code','Alcohol use, unspecified with alcohol-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10085,'ICD10-DSM5','F10.951','No corresponding DSM-5 description for this ICD-10 code','Alcohol use, unspecified with alcohol-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10086,'ICD10-DSM5','F10.959','Alcohol-induced psychotic disorder, without use disorder','Alcohol use, unspecified with alcohol-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10087,'ICD10-DSM5','F10.96','Alcohol-induced major neurocognitive disorder, amnestic confabulatory type, without use disorder','Alcohol use, unspecified with alcohol-induced persisting amnestic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10088,'ICD10-DSM5','F10.97','Alcohol-induced major neurocognitive disorder, nonamnestic confabulatory type, without use disorder','Alcohol use, unspecified with alcohol-induced persisting dementia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10089,'ICD10-DSM5','F10.980','Alcohol-induced anxiety disorder, without use disorder','Alcohol use, unspecified with alcohol-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10090,'ICD10-DSM5','F10.981','Alcohol-induced sexual dysfunction, without use disorder','Alcohol use, unspecified with alcohol-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10091,'ICD10-DSM5','F10.982','Alcohol-induced sleep disorder, without use disorder','Alcohol use, unspecified with alcohol-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10092,'ICD10-DSM5','F10.988','Alcohol-induced mild neurocognitive disorder, without use disorder','Alcohol use, unspecified with other alcohol-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10093,'ICD10-DSM5','F10.99','Unspecified alcohol-related disorder','Alcohol use, unspecified with unspecified alcohol-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10094,'ICD10-DSM5','F11.10','Opioid use disorder, mild','Opioid abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10095,'ICD10-DSM5','F11.120','No corresponding DSM-5 description for this ICD-10 code','Opioid abuse with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10096,'ICD10-DSM5','F11.121','Opioid intoxication delirium, with mild use disorder','Opioid abuse with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10097,'ICD10-DSM5','F11.122','Opioid intoxication, with perceptual disturbances, with mild use disorder','Opioid abuse with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10098,'ICD10-DSM5','F11.129','Opioid intoxication, without perceptual disturbances, with mild use disorder','Opioid abuse with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10099,'ICD10-DSM5','F11.14','Opioid-induced depressive disorder, with mild use disorder','Opioid abuse with opioid-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10100,'ICD10-DSM5','F11.150','No corresponding DSM-5 description for this ICD-10 code','Opioid abuse with opioid-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10101,'ICD10-DSM5','F11.151','No corresponding DSM-5 description for this ICD-10 code','Opioid abuse with opioid-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10102,'ICD10-DSM5','F11.159','No corresponding DSM-5 description for this ICD-10 code','Opioid abuse with opioid-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10103,'ICD10-DSM5','F11.181','Opioid-induced sexual dysfunction disorder, with mild use disorder','Opioid abuse with opioid-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10104,'ICD10-DSM5','F11.182','Opioid-induced sleep disorder, with mild use disorder','Opioid abuse with opioid-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10105,'ICD10-DSM5','F11.188','Opioid-induced anxiety disorder, with mild use disorder','Opioid abuse with other opioid-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10106,'ICD10-DSM5','F11.19','No corresponding DSM-5 description for this ICD-10 code','Opioid abuse with unspecified opioid-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10107,'ICD10-DSM5','F11.20','Opioid use disorder, moderate','Opioid dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10108,'ICD10-DSM5','F11.20','Opioid use disorder, severe','Opioid dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10109,'ICD10-DSM5','F11.21','No corresponding DSM-5 description for this ICD-10 code','Opioid dependence, in remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10110,'ICD10-DSM5','F11.220','No corresponding DSM-5 description for this ICD-10 code','Opioid dependence with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10111,'ICD10-DSM5','F11.221','Opioid intoxication delirium, with moderate or severe use disorder','Opioid dependence with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10112,'ICD10-DSM5','F11.222','Opioid intoxication, with perceptual disturbances, with moderate or severe use disorder','Opioid dependence with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10113,'ICD10-DSM5','F11.229','Opioid intoxication, without perceptual disturbances, with moderate or severe use disorder','Opioid dependence with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10114,'ICD10-DSM5','F11.23','Opioid withdrawal','Opioid dependence with withdrawal',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10115,'ICD10-DSM5','F11.24','Opioid-induced depressive disorder, with moderate or severe use disorder','Opioid dependence with opioid-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10116,'ICD10-DSM5','F11.250','No corresponding DSM-5 description for this ICD-10 code','Opioid dependence with opioid-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10117,'ICD10-DSM5','F11.251','No corresponding DSM-5 description for this ICD-10 code','Opioid dependence with opioid-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10118,'ICD10-DSM5','F11.259','No corresponding DSM-5 description for this ICD-10 code','Opioid dependence with opioid-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10119,'ICD10-DSM5','F11.281','Opioid-induced sexual dysfunction, with moderate or severe use disorder','Opioid dependence with opioid-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10120,'ICD10-DSM5','F11.282','Opioid-induced sleep disorder, with moderate or severe use disorder','Opioid dependence with opioid-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10121,'ICD10-DSM5','F11.288','Opioid-induced anxiety disorder, with moderate or severe use disorder','Opioid dependence with other opioid-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10122,'ICD10-DSM5','F11.29','No corresponding DSM-5 description for this ICD-10 code','Opioid dependence with unspecified opioid-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10123,'ICD10-DSM5','F11.90','No corresponding DSM-5 description for this ICD-10 code','Opioid use, unspecified, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10124,'ICD10-DSM5','F11.920','No corresponding DSM-5 description for this ICD-10 code','Opioid use, unspecified with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10125,'ICD10-DSM5','F11.921','Opioid intoxication delirium, without use disorder','Opioid use, unspecified with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10126,'ICD10-DSM5','F11.922','Opioid intoxication, with perceptual disturbances, without use disorder','Opioid use, unspecified with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10127,'ICD10-DSM5','F11.929','Opioid intoxication, without perceptual disturbances, without use disorder','Opioid use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10128,'ICD10-DSM5','F11.93','No corresponding DSM-5 description for this ICD-10 code','Opioid use, unspecified with withdrawal',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10129,'ICD10-DSM5','F11.94','Opioid-induced depressive disorder, without use disorder','Opioid use, unspecified with opioid-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10130,'ICD10-DSM5','F11.950','No corresponding DSM-5 description for this ICD-10 code','Opioid use, unspecified with opioid-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10131,'ICD10-DSM5','F11.951','No corresponding DSM-5 description for this ICD-10 code','Opioid use, unspecified with opioid-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10132,'ICD10-DSM5','F11.959','No corresponding DSM-5 description for this ICD-10 code','Opioid use, unspecified with opioid-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10133,'ICD10-DSM5','F11.981','Opioid-induced sexual dysfunction, without use disorder','Opioid use, unspecified with opioid-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10134,'ICD10-DSM5','F11.982','Opioid-induced sleep disorder, without use disorder','Opioid use, unspecified with opioid-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10135,'ICD10-DSM5','F11.988','Opioid-induced anxiety disorder, without use disorder','Opioid use, unspecified with other opioid-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10136,'ICD10-DSM5','F11.99','Unspecified opioid-related disorder','Opioid use, unspecified with unspecified opioid-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10137,'ICD10-DSM5','F12.10','Cannabis use disorder, mild','Cannabis abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10138,'ICD10-DSM5','F12.120','No corresponding DSM-5 description for this ICD-10 code','Cannabis abuse with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10139,'ICD10-DSM5','F12.121','Cannabis intoxication delirium, with mild use disorder','Cannabis abuse with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10140,'ICD10-DSM5','F12.122','Cannabis intoxication, with perceptual disturbances, with mild use disorder','Cannabis abuse with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10141,'ICD10-DSM5','F12.129','Cannabis intoxication, without perceptual disturbances, with mild use disorder','Cannabis abuse with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10142,'ICD10-DSM5','F12.150','No corresponding DSM-5 description for this ICD-10 code','Cannabis abuse with psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10143,'ICD10-DSM5','F12.151','No corresponding DSM-5 description for this ICD-10 code','Cannabis abuse with psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10144,'ICD10-DSM5','F12.159','Cannabis-induced psychotic disorder, with mild use disorder','Cannabis abuse with psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10145,'ICD10-DSM5','F12.180','Cannabis-induced anxiety disorder, with mild use disorder','Cannabis abuse with cannabis-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10146,'ICD10-DSM5','F12.188','Cannabis-induced sleep disorder, with mild use disorder','Cannabis abuse with other cannabis-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10147,'ICD10-DSM5','F12.19','No corresponding DSM-5 description for this ICD-10 code','Cannabis abuse with unspecified cannabis-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10148,'ICD10-DSM5','F12.20','Cannabis use disorder, moderate','Cannabis dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10149,'ICD10-DSM5','F12.20','Cannabis use disorder, severe','Cannabis dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10150,'ICD10-DSM5','F12.21','No corresponding DSM-5 description for this ICD-10 code','Cannabis dependence, in remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10151,'ICD10-DSM5','F12.220','No corresponding DSM-5 description for this ICD-10 code','Cannabis dependence with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10152,'ICD10-DSM5','F12.221','Cannabis intoxication delirium, with moderate or severe use disorder','Cannabis dependence with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10153,'ICD10-DSM5','F12.222','Cannabis intoxication, with perceptual disturbances, with moderate or severe use disorder','Cannabis dependence with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10154,'ICD10-DSM5','F12.229','Cannabis intoxication, without perceptual disturbances, with moderate or severe use disorder','Cannabis dependence with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10155,'ICD10-DSM5','F12.250','No corresponding DSM-5 description for this ICD-10 code','Cannabis dependence with psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10156,'ICD10-DSM5','F12.251','No corresponding DSM-5 description for this ICD-10 code','Cannabis dependence with psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10157,'ICD10-DSM5','F12.259','Cannabis-induced psychotic disorder, with moderate or severe use disorder','Cannabis dependence with psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10158,'ICD10-DSM5','F12.280','Cannabis-induced anxiety disorder, with moderate or severe use disorder','Cannabis dependence with cannabis-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10159,'ICD10-DSM5','F12.288','Cannabis withdrawal','Cannabis dependence with other cannabis-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10160,'ICD10-DSM5','F12.29','No corresponding DSM-5 description for this ICD-10 code','Cannabis dependence with unspecified cannabis-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10161,'ICD10-DSM5','F12.90','No corresponding DSM-5 description for this ICD-10 code','Cannabis use, unspecified, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10162,'ICD10-DSM5','F12.920','No corresponding DSM-5 description for this ICD-10 code','Cannabis use, unspecified with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10163,'ICD10-DSM5','F12.921','Cannabis intoxication delirium, without use disorder','Cannabis use, unspecified with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10164,'ICD10-DSM5','F12.922','Cannabis intoxication, with perceptual disturbances, without use disorder','Cannabis use, unspecified with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10165,'ICD10-DSM5','F12.929','Cannabis intoxication, without perceptual disturbances, without use disorder','Cannabis use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10166,'ICD10-DSM5','F12.950','No corresponding DSM-5 description for this ICD-10 code','Cannabis use, unspecified with psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10167,'ICD10-DSM5','F12.951','No corresponding DSM-5 description for this ICD-10 code','Cannabis use, unspecified with psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10168,'ICD10-DSM5','F12.959','Cannabis-induced psychotic disorder, without use disorder ','Cannabis use, unspecified with psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10169,'ICD10-DSM5','F12.980','Cannabis-induced anxiety disorder, without use disorder ','Cannabis use, unspecified with anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10170,'ICD10-DSM5','F12.988','Cannabis-induced sleep disorder, without use disorder ','Cannabis use, unspecified with other cannabis-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10171,'ICD10-DSM5','F12.99','Unspecified cannabis-related disorder','Cannabis use, unspecified with unspecified cannabis-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10172,'ICD10-DSM5','F13.10','Sedative, hypnotic or anxiolytic use disorder, mild','Sedative, hypnotic or anxiolytic abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10173,'ICD10-DSM5','F13.120','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic abuse with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10174,'ICD10-DSM5','F13.121','Sedative, hypnotic or anxiolytic intoxication delirium, with mild use disorder','Sedative, hypnotic or anxiolytic abuse with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10175,'ICD10-DSM5','F13.129','Sedative, hypnotic or anxiolytic intoxication, with mild use disorder','Sedative, hypnotic or anxiolytic abuse with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10176,'ICD10-DSM5','F13.14','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic abuse with sedative, hypnotic or anxiolytic-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10177,'ICD10-DSM5','F13.150','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic abuse with sedative, hypnotic or anxiolytic-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10178,'ICD10-DSM5','F13.151','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic abuse with sedative, hypnotic or anxiolytic-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10179,'ICD10-DSM5','F13.159','Sedative-, hypnotic-, or anxiolytic-induced psychotic disorder, with mild use disorder','Sedative, hypnotic or anxiolytic abuse with sedative, hypnotic or anxiolytic-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10180,'ICD10-DSM5','F13.180','Sedative-, hypnotic-, or anxiolytic-induced anxiety disorder, with mild use disorder','Sedative, hypnotic or anxiolytic abuse with sedative, hypnotic or anxiolytic-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10181,'ICD10-DSM5','F13.181','Sedative-, hypnotic-, or anxiolytic-induced sexual dysfunction, with mild use disorder','Sedative, hypnotic or anxiolytic abuse with sedative, hypnotic or anxiolytic-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10182,'ICD10-DSM5','F13.182','Sedative-, hypnotic-, or anxiolytic-induced sleep disorder, with mild use disorder','Sedative, hypnotic or anxiolytic abuse with sedative, hypnotic or anxiolytic-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10183,'ICD10-DSM5','F13.188','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic abuse with other sedative, hypnotic or anxiolytic-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10184,'ICD10-DSM5','F13.19','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic abuse with unspecified sedative, hypnotic or anxiolytic-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10185,'ICD10-DSM5','F13.20','Sedative, hypnotic or anxiolytic use disorder, moderate','Sedative, hypnotic or anxiolytic dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10186,'ICD10-DSM5','F13.20','Sedative, hypnotic or anxiolytic use disorder, severe','Sedative, hypnotic or anxiolytic dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10187,'ICD10-DSM5','F13.21','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic dependence, in remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10188,'ICD10-DSM5','F13.220','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic dependence with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10189,'ICD10-DSM5','F13.221','Sedative, hypnotic or anxiolytic intoxication delirium, with moderate or severe use disorder','Sedative, hypnotic or anxiolytic dependence with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10190,'ICD10-DSM5','F13.229','Sedative, hypnotic or anxiolytic intoxication, with moderate or severe use disorder','Sedative, hypnotic or anxiolytic dependence with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10191,'ICD10-DSM5','F13.230','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic dependence with withdrawal, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10192,'ICD10-DSM5','F13.231','Sedative, hypnotic or anxiolytic withdrawal delirium','Sedative, hypnotic or anxiolytic dependence with withdrawal delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10193,'ICD10-DSM5','F13.232','Sedative, hypnotic or anxiolytic withdrawal, with perceptual disturbances','Sedative, hypnotic or anxiolytic dependence with withdrawal with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10194,'ICD10-DSM5','F13.239','Sedative, hypnotic or anxiolytic withdrawal, without perceptual disturbances','Sedative, hypnotic or anxiolytic dependence with withdrawal, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10195,'ICD10-DSM5','F13.24','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic dependence with sedative, hypnotic or anxiolytic-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10196,'ICD10-DSM5','F13.250','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic dependence with sedative, hypnotic or anxiolytic-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10197,'ICD10-DSM5','F13.251','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic dependence with sedative, hypnotic or anxiolytic-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10198,'ICD10-DSM5','F13.259','Sedative-, hypnotic-, or anxiolytic-induced psychotic disorder, with moderate or severe use disorder','Sedative, hypnotic or anxiolytic dependence with sedative, hypnotic or anxiolytic-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10199,'ICD10-DSM5','F13.26','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic dependence with sedative, hypnotic or anxiolytic-induced persisting amnestic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10200,'ICD10-DSM5','F13.27','Sedative-, hypnotic-, or anxiolytic-induced major neurocognitive disorder, with moderate or severe use disorder','Sedative, hypnotic or anxiolytic dependence with sedative, hypnotic or anxiolytic-induced persisting dementia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10201,'ICD10-DSM5','F13.280','Sedative-, hypnotic-, or anxiolytic-induced anxiety disorder, with moderate or severe use disorder','Sedative, hypnotic or anxiolytic dependence with sedative, hypnotic or anxiolytic-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10202,'ICD10-DSM5','F13.281','Sedative-, hypnotic-, or anxiolytic-induced sexual dysfunction, with moderate or severe use disorder','Sedative, hypnotic or anxiolytic dependence with sedative, hypnotic or anxiolytic-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10203,'ICD10-DSM5','F13.282','Sedative-, hypnotic-, or anxiolytic-induced sleep disorder, with moderate or severe use disorder','Sedative, hypnotic or anxiolytic dependence with sedative, hypnotic or anxiolytic-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10204,'ICD10-DSM5','F13.288','Sedative-, hypnotic-, or anxiolytic-induced mild neurocognitive disorder, with moderate or severe use disorder','Sedative, hypnotic or anxiolytic dependence with other sedative, hypnotic or anxiolytic-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10205,'ICD10-DSM5','F13.29','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic dependence with unspecified sedative, hypnotic or anxiolytic-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10206,'ICD10-DSM5','F13.90','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic, or anxiolytic use, unspecified, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10207,'ICD10-DSM5','F13.920','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic use, unspecified with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10208,'ICD10-DSM5','F13.921','Sedative, hypnotic or anxiolytic intoxication delirium, without use disorder','Sedative, hypnotic or anxiolytic use, unspecified with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10209,'ICD10-DSM5','F13.929','Sedative, hypnotic or anxiolytic intoxication, without use disorder','Sedative, hypnotic or anxiolytic use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10210,'ICD10-DSM5','F13.930','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic use, unspecified with withdrawal, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10211,'ICD10-DSM5','F13.931','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic use, unspecified with withdrawal delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10212,'ICD10-DSM5','F13.932','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic use, unspecified with withdrawal with perceptual disturbances',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10213,'ICD10-DSM5','F13.939','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic use, unspecified with withdrawal, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10214,'ICD10-DSM5','F13.94','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic use, unspecified with sedative, hypnotic or anxiolytic-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10215,'ICD10-DSM5','F13.950','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic use, unspecified with sedative, hypnotic or anxiolytic-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10216,'ICD10-DSM5','F13.951','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic use, unspecified with sedative, hypnotic or anxiolytic-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10217,'ICD10-DSM5','F13.959','Sedative-, hypnotic-, or anxiolytic-induced psychotic disorder, without use disorder','Sedative, hypnotic or anxiolytic use, unspecified with sedative, hypnotic or anxiolytic-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10218,'ICD10-DSM5','F13.96','No corresponding DSM-5 description for this ICD-10 code','Sedative, hypnotic or anxiolytic use, unspecified with sedative, hypnotic or anxiolytic-induced persisting amnestic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10219,'ICD10-DSM5','F13.97','Sedative-, hypnotic-, or anxiolytic-induced major neurocognitive disorder, without use disorder','Sedative, hypnotic or anxiolytic use, unspecified with sedative, hypnotic or anxiolytic-induced persisting dementia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10220,'ICD10-DSM5','F13.980','Sedative-, hypnotic-, or anxiolytic-induced anxiety disorder, without use disorder','Sedative, hypnotic or anxiolytic use, unspecified with sedative, hypnotic or anxiolytic-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10221,'ICD10-DSM5','F13.981','Sedative-, hypnotic-, or anxiolytic-induced sexual dysfunction, without use disorder','Sedative, hypnotic or anxiolytic use, unspecified with sedative, hypnotic or anxiolytic-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10222,'ICD10-DSM5','F13.982','Sedative-, hypnotic-, or anxiolytic-induced sleep disorder, without use disorder','Sedative, hypnotic or anxiolytic use, unspecified with sedative, hypnotic or anxiolytic-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10223,'ICD10-DSM5','F13.988','Sedative-, hypnotic-, or anxiolytic-induced mild neurocognitive disorder, without use disorder','Sedative, hypnotic or anxiolytic use, unspecified with other sedative, hypnotic or anxiolytic-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10224,'ICD10-DSM5','F13.99','Unspecified sedative-, hypnotic-, or anxiolytic-related disorder','Sedative, hypnotic or anxiolytic use, unspecified with unspecified sedative, hypnotic or anxiolytic-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10225,'ICD10-DSM5','F14.10','Cocaine use disorder, mild','Cocaine abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10226,'ICD10-DSM5','F14.120','No corresponding DSM-5 description for this ICD-10 code','Cocaine abuse with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10227,'ICD10-DSM5','F14.121','Cocaine intoxication delirium, with mild use disorder','Cocaine abuse with intoxication with delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10228,'ICD10-DSM5','F14.122','Cocaine intoxication, with perceptual disturbances, with mild use disorder','Cocaine abuse with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10229,'ICD10-DSM5','F14.129','Cocaine intoxication, without perceptual disturbances, with mild use disorder','Cocaine abuse with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10230,'ICD10-DSM5','F14.14','No corresponding DSM-5 description for this ICD-10 code','Cocaine abuse with cocaine-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10231,'ICD10-DSM5','F14.150','No corresponding DSM-5 description for this ICD-10 code','Cocaine abuse with cocaine-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10232,'ICD10-DSM5','F14.151','No corresponding DSM-5 description for this ICD-10 code','Cocaine abuse with cocaine-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10233,'ICD10-DSM5','F14.159','Cocaine-induced psychotic disorder, with mild use disorder','Cocaine abuse with cocaine-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10234,'ICD10-DSM5','F14.180','Cocaine-induced anxiety disorder, with mild use disorder','Cocaine abuse with cocaine-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10235,'ICD10-DSM5','F14.181','Cocaine-induced sexual dysfunction, with mild use disorder','Cocaine abuse with cocaine-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10236,'ICD10-DSM5','F14.182','Cocaine-induced sleep disorder, with mild use disorder','Cocaine abuse with cocaine-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10237,'ICD10-DSM5','F14.188','Cocaine-induced obsessive-compulsive and related disorder, with mild use disorder','Cocaine abuse with other cocaine-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10238,'ICD10-DSM5','F14.19','No corresponding DSM-5 description for this ICD-10 code','Cocaine abuse with unspecified cocaine-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10239,'ICD10-DSM5','F14.20','Stimulant use disorder, moderate, cocaine','Cocaine dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10240,'ICD10-DSM5','F14.20','Stimulant use disorder, severe, cocaine','Cocaine dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10241,'ICD10-DSM5','F14.220','No corresponding DSM-5 description for this ICD-10 code','Cocaine dependence with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10242,'ICD10-DSM5','F14.221','Cocaine intoxication delirium, with moderate or severe use disorder','Cocaine dependence with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10243,'ICD10-DSM5','F14.222','Cocaine intoxication, with perceptual disturbances, with moderate or severe use disorder','Cocaine dependence with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10244,'ICD10-DSM5','F14.229','Cocaine intoxication, without perceptual disturbances, with moderate or severe use disorder','Cocaine dependence with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10245,'ICD10-DSM5','F14.23','Cocaine withdrawal','Cocaine dependence with withdrawal',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10246,'ICD10-DSM5','F14.24','No corresponding DSM-5 description for this ICD-10 code','Cocaine dependence with cocaine-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10247,'ICD10-DSM5','F14.250','No corresponding DSM-5 description for this ICD-10 code','Cocaine dependence with cocaine-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10248,'ICD10-DSM5','F14.251','No corresponding DSM-5 description for this ICD-10 code','Cocaine dependence with cocaine-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10249,'ICD10-DSM5','F14.259','Cocaine-induced psychotic disorder, with moderate or severe use disorder','Cocaine dependence with cocaine-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10250,'ICD10-DSM5','F14.280','Cocaine-induced anxiety disorder, with moderate or severe use disorder','Cocaine dependence with cocaine-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10251,'ICD10-DSM5','F14.281','Cocaine-induced sexual dysfunction, with moderate or severe use disorder','Cocaine dependence with cocaine-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10252,'ICD10-DSM5','F14.282','Cocaine-induced sleep disorder, with moderate or severe use disorder','Cocaine dependence with cocaine-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10253,'ICD10-DSM5','F14.288','Cocaine-induced obsessive-compulsive and related disorder, with moderate or severe use disorder','Cocaine dependence with other cocaine-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10254,'ICD10-DSM5','F14.29','No corresponding DSM-5 description for this ICD-10 code','Cocaine dependence with unspecified cocaine-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10255,'ICD10-DSM5','F14.90','No corresponding DSM-5 description for this ICD-10 code','Cocaine use, unspecified, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10256,'ICD10-DSM5','F14.920','No corresponding DSM-5 description for this ICD-10 code','Cocaine use, unspecified with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10257,'ICD10-DSM5','F14.921','Cocaine intoxication delirium, without use disorder','Cocaine use, unspecified with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10258,'ICD10-DSM5','F14.922','Cocaine intoxication, with perceptual disturbances, without use disorder','Cocaine use, unspecified with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10259,'ICD10-DSM5','F14.929','Cocaine intoxication, without perceptual disturbances, without use disorder','Cocaine use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10260,'ICD10-DSM5','F14.94','No corresponding DSM-5 description for this ICD-10 code','Cocaine use, unspecified with cocaine-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10261,'ICD10-DSM5','F14.950','No corresponding DSM-5 description for this ICD-10 code','Cocaine use, unspecified with cocaine-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10262,'ICD10-DSM5','F14.951','No corresponding DSM-5 description for this ICD-10 code','Cocaine use, unspecified with cocaine-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10263,'ICD10-DSM5','F14.959','Cocaine-induced psychotic disorder, without use disorder','Cocaine use, unspecified with cocaine-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10264,'ICD10-DSM5','F14.980','Cocaine-induced anxiety disorder, without use disorder','Cocaine use, unspecified with cocaine-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10265,'ICD10-DSM5','F14.981','Cocaine-induced sexual dysfunction, without use disorder','Cocaine use, unspecified with cocaine-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10266,'ICD10-DSM5','F14.982','Cocaine-induced sleep disorder, without use disorder','Cocaine use, unspecified with cocaine-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10267,'ICD10-DSM5','F14.988','Cocaine-induced obsessive-compulsive and related disorder, without use disorder','Cocaine use, unspecified with other cocaine-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10268,'ICD10-DSM5','F14.99','Unspecified cocaine-related disorder','Cocaine use, unspecified with unspecified cocaine-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10269,'ICD10-DSM5','F15.10','Stimulant use disorder, mild, amphetamine-type substance','Other stimulant abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10270,'ICD10-DSM5','F15.10','Stimulant use disorder, mild, other or unspecified stimulant','Other stimulant abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10271,'ICD10-DSM5','F15.120','No corresponding DSM-5 description for this ICD-10 code','Other stimulant abuse with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10272,'ICD10-DSM5','F15.121','Amphetamine (or other stimulant) intoxication delirium, with mild use disorder','Other stimulant abuse with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10273,'ICD10-DSM5','F15.122','Amphetamine or other stimulant intoxication, with perceptual disturbances, with mild use disorder','Other stimulant abuse with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10274,'ICD10-DSM5','F15.129','Amphetamine or other stimulant intoxication, without perceptual disturbances, with mild use disorder','Other stimulant abuse with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10275,'ICD10-DSM5','F15.14','No corresponding DSM-5 description for this ICD-10 code','Other stimulant abuse with stimulant-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10276,'ICD10-DSM5','F15.150','No corresponding DSM-5 description for this ICD-10 code','Other stimulant abuse with stimulant-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10277,'ICD10-DSM5','F15.151','No corresponding DSM-5 description for this ICD-10 code','Other stimulant abuse with stimulant-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10278,'ICD10-DSM5','F15.159','Amphetamine (or other stimulant)-induced psychotic disorder, with mild use disorder','Other stimulant abuse with stimulant-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10279,'ICD10-DSM5','F15.180','No corresponding DSM-5 description for this ICD-10 code','Other stimulant abuse with stimulant-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10280,'ICD10-DSM5','F15.181','Amphetamine (or other stimulant)-induced sexual dysfunction, with mild use disorder','Other stimulant abuse with stimulant-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10281,'ICD10-DSM5','F15.182','No corresponding DSM-5 description for this ICD-10 code','Other stimulant abuse with stimulant-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10282,'ICD10-DSM5','F15.188','Amphetamine (or other stimulant)-induced obsessive-compulsive and related disorder, with mild use disorder','Other stimulant abuse with other stimulant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10283,'ICD10-DSM5','F15.19','No corresponding DSM-5 description for this ICD-10 code','Other stimulant abuse with unspecified stimulant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10284,'ICD10-DSM5','F15.20','Stimulant use disorder, moderate, amphetamine-type substance','Other stimulant dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10285,'ICD10-DSM5','F15.20','Stimulant use disorder, moderate, other or unspecified stimulant','Other stimulant dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10286,'ICD10-DSM5','F15.20','Stimulant use disorder, severe, amphetamine-type substance','Other stimulant dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10287,'ICD10-DSM5','F15.20','Stimulant use disorder, severe, other or unspecified stimulant','Other stimulant dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10288,'ICD10-DSM5','F15.221','Amphetamine (or other stimulant) intoxication delirium, with moderate or severe use disorder','Other stimulant dependence with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10289,'ICD10-DSM5','F15.222','Amphetamine or other stimulant intoxication, with perceptual disturbances, with moderate or severe use disorder','Other stimulant dependence with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10290,'ICD10-DSM5','F15.229','Amphetamine or other stimulant intoxication, without perceptual disturbances, with moderate or severe use disorder','Other stimulant dependence with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10291,'ICD10-DSM5','F15.23','Amphetamine or other stimulant withdrawal','Other stimulant dependence with withdrawal',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10292,'ICD10-DSM5','F15.24','No corresponding DSM-5 description for this ICD-10 code','Other stimulant dependence with stimulant-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10293,'ICD10-DSM5','F15.250','No corresponding DSM-5 description for this ICD-10 code','Other stimulant dependence with stimulant-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10294,'ICD10-DSM5','F15.251','No corresponding DSM-5 description for this ICD-10 code','Other stimulant dependence with stimulant-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10295,'ICD10-DSM5','F15.259','Amphetamine (or other stimulant)-induced psychotic disorder, with moderate or severe use disorder','Other stimulant dependence with stimulant-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10296,'ICD10-DSM5','F15.280','No corresponding DSM-5 description for this ICD-10 code','Other stimulant dependence with stimulant-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10297,'ICD10-DSM5','F15.281','Amphetamine (or other stimulant)-induced sexual dysfunction, with moderate or severe use disorder','Other stimulant dependence with stimulant-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10298,'ICD10-DSM5','F15.282','No corresponding DSM-5 description for this ICD-10 code','Other stimulant dependence with stimulant-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10299,'ICD10-DSM5','F15.288','Amphetamine (or other stimulant)-induced obsessive-compulsive and related disorder, with moderate or severe use disorder','Other stimulant dependence with other stimulant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10300,'ICD10-DSM5','F15.29','No corresponding DSM-5 description for this ICD-10 code','Other stimulant dependence with unspecified stimulant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10301,'ICD10-DSM5','F15.90','No corresponding DSM-5 description for this ICD-10 code','Other stimulant use, unspecified, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10302,'ICD10-DSM5','F15.920','No corresponding DSM-5 description for this ICD-10 code','Other stimulant use, unspecified with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10303,'ICD10-DSM5','F15.921','Amphetamine (or other stimulant) intoxication delirium, without use disorder','Other stimulant use, unspecified with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10304,'ICD10-DSM5','F15.922','Amphetamine or other stimulant intoxication, with perceptual disturbances, without use disorder','Other stimulant use, unspecified with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10305,'ICD10-DSM5','F15.929','Caffeine intoxication','Other stimulant use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10306,'ICD10-DSM5','F15.929','Amphetamine or other stimulant, without perceptual disturbances, without use disorder','Other stimulant use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10307,'ICD10-DSM5','F15.93','Caffeine withdrawal','Other stimulant use, unspecified with withdrawal',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10308,'ICD10-DSM5','F15.94','No corresponding DSM-5 description for this ICD-10 code','Other stimulant use, unspecified with stimulant-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10309,'ICD10-DSM5','F15.950','No corresponding DSM-5 description for this ICD-10 code','Other stimulant use, unspecified with stimulant-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10310,'ICD10-DSM5','F15.951','No corresponding DSM-5 description for this ICD-10 code','Other stimulant use, unspecified with stimulant-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10311,'ICD10-DSM5','F15.959','Amphetamine (or other stimulant)-induced psychotic disorder, without use disorder','Other stimulant use, unspecified with stimulant-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10312,'ICD10-DSM5','F15.980','No corresponding DSM-5 description for this ICD-10 code','Other stimulant use, unspecified with stimulant-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10313,'ICD10-DSM5','F15.981','Amphetamine (or other stimulant)-induced sexual dysfunction, without use disorder','Other stimulant use, unspecified with stimulant-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10314,'ICD10-DSM5','F15.982','No corresponding DSM-5 description for this ICD-10 code','Other stimulant use, unspecified with stimulant-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10315,'ICD10-DSM5','F15.988','Amphetamine (or other stimulant)-induced obsessive-compulsive and related disorder, without use disorder','Other stimulant use, unspecified with other stimulant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10316,'ICD10-DSM5','F15.99','Unspecified caffeine-related disorder','Other stimulant use, unspecified with unspecified stimulant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10317,'ICD10-DSM5','F15.99','Unspecified amphetamine or other stimulant-related disorder','Other stimulant use, unspecified with unspecified stimulant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10318,'ICD10-DSM5','F16.10','Phencyclidine use disorder, mild','Hallucinogen abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10319,'ICD10-DSM5','F16.10','Other hallucinogen use disorder, mild','Hallucinogen abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10320,'ICD10-DSM5','F16.120','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen abuse with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10321,'ICD10-DSM5','F16.121','Hallucinogen intoxication delirium, with mild use disorder','Hallucinogen abuse with intoxication with delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10322,'ICD10-DSM5','F16.122','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen abuse with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10323,'ICD10-DSM5','F16.129','Phencyclidine intoxication, with use disorder, mild','Hallucinogen abuse with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10324,'ICD10-DSM5','F16.129','Other hallucinogen intoxication, with use disorder, mild','Hallucinogen abuse with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10325,'ICD10-DSM5','F16.14','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen abuse with hallucinogen-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10326,'ICD10-DSM5','F16.150','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen abuse with hallucinogen-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10327,'ICD10-DSM5','F16.151','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen abuse with hallucinogen-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10328,'ICD10-DSM5','F16.159','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen abuse with hallucinogen-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10329,'ICD10-DSM5','F16.180','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen abuse with hallucinogen-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10330,'ICD10-DSM5','F16.183','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen abuse with hallucinogen persisting perception disorder (flashbacks)',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10331,'ICD10-DSM5','F16.188','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen abuse with other hallucinogen-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10332,'ICD10-DSM5','F16.19','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen abuse with unspecified hallucinogen-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10333,'ICD10-DSM5','F16.20','Phencyclidine use disorder, moderate','Hallucinogen dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10334,'ICD10-DSM5','F16.20','Phencyclidine use disorder, severe','Hallucinogen dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10335,'ICD10-DSM5','F16.20','Other hallucinogen use disorder, moderate','Hallucinogen dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10336,'ICD10-DSM5','F16.20','Other hallucinogen use disorder, severe','Hallucinogen dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10337,'ICD10-DSM5','F16.21','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen dependence, in remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10338,'ICD10-DSM5','F16.220','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen dependence with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10339,'ICD10-DSM5','F16.221','Hallucinogen intoxication delirium, with moderate or severe use disorder','Hallucinogen dependence with intoxication with delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10340,'ICD10-DSM5','F16.229','Phencyclidine intoxication, with use disorder, moderate or severe','Hallucinogen dependence with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10341,'ICD10-DSM5','F16.229','Other hallucinogen intoxication, with use disorder, moderate or severe','Hallucinogen dependence with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10342,'ICD10-DSM5','F16.24','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen dependence with hallucinogen-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10343,'ICD10-DSM5','F16.250','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen dependence with hallucinogen-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10344,'ICD10-DSM5','F16.251','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen dependence with hallucinogen-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10345,'ICD10-DSM5','F16.259','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen dependence with hallucinogen-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10346,'ICD10-DSM5','F16.280','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen dependence with hallucinogen-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10347,'ICD10-DSM5','F16.283','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen dependence with hallucinogen persisting perception disorder (flashbacks)',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10348,'ICD10-DSM5','F16.288','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen dependence with other hallucinogen-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10349,'ICD10-DSM5','F16.29','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen dependence with unspecified hallucinogen-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10350,'ICD10-DSM5','F16.90','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen use, unspecified, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10351,'ICD10-DSM5','F16.920','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen use, unspecified with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10352,'ICD10-DSM5','F16.921','Hallucinogen intoxication delirium, without use disorder','Hallucinogen use, unspecified with intoxication with delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10353,'ICD10-DSM5','F16.929','Phencyclidine intoxication, without use disorder','Hallucinogen use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10354,'ICD10-DSM5','F16.929','Other hallucinogen intoxication, without use disorder','Hallucinogen use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10355,'ICD10-DSM5','F16.94','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen use, unspecified with hallucinogen-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10356,'ICD10-DSM5','F16.950','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen use, unspecified with hallucinogen-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10357,'ICD10-DSM5','F16.951','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen use, unspecified with hallucinogen-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10358,'ICD10-DSM5','F16.959','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen use, unspecified with hallucinogen-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10359,'ICD10-DSM5','F16.980','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen use, unspecified with hallucinogen-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10360,'ICD10-DSM5','F16.983','Hallucinogen persisting perception disorder','Hallucinogen use, unspecified with hallucinogen persisting perception disorder (flashbacks)',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10361,'ICD10-DSM5','F16.988','No corresponding DSM-5 description for this ICD-10 code','Hallucinogen use, unspecified with other hallucinogen-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10362,'ICD10-DSM5','F16.99','Unspecified phencyclidine-related disorder','Hallucinogen use, unspecified with unspecified hallucinogen-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10363,'ICD10-DSM5','F16.99','Unspecified hallucinogen-related disorder','Hallucinogen use, unspecified with unspecified hallucinogen-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10364,'ICD10-DSM5','F17.200','Tobacco use disorder, moderate','Nicotine dependence, unspecified, uncomplicated  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10365,'ICD10-DSM5','F17.200','Tobacco use disorder, severe','Nicotine dependence, unspecified, uncomplicated  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10366,'ICD10-DSM5','F17.201','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, unspecified, in remission ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10367,'ICD10-DSM5','F17.203','Tobacco withdrawal','Nicotine dependence unspecified, with withdrawal',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10368,'ICD10-DSM5','F17.208','Tobacco-induced sleep disorder, with moderate or severe use disorder','Nicotine dependence, unspecified, with other nicotine-induced disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10369,'ICD10-DSM5','F17.209','Unspecified tobacco-related disorder','Nicotine dependence, unspecified, with unspecified nicotine-induced disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10370,'ICD10-DSM5','F17.210','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, cigarettes, uncomplicated   ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10371,'ICD10-DSM5','F17.211','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, cigarettes, in remission    ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10372,'ICD10-DSM5','F17.213','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, cigarettes, with withdrawal',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10373,'ICD10-DSM5','F17.218','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, cigarettes, with other nicotine-induced disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10374,'ICD10-DSM5','F17.219','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, cigarettes, with unspecified nicotine-induced disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10375,'ICD10-DSM5','F17.220','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, chewing tobacco, uncomplicated   ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10376,'ICD10-DSM5','F17.221','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, chewing tobacco, in remission  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10377,'ICD10-DSM5','F17.223','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, chewing tobacco, with withdrawal',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10378,'ICD10-DSM5','F17.228','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, chewing tobacco, with other nicotine-induced disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10379,'ICD10-DSM5','F17.229','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, chewing tobacco, with unspecified nicotine-induced disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10380,'ICD10-DSM5','F17.290','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, other tobacco product, uncomplicated   ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10381,'ICD10-DSM5','F17.291','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, other tobacco product, in remission   ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10382,'ICD10-DSM5','F17.293','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, other tobacco product, with withdrawal',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10383,'ICD10-DSM5','F17.298','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, other tobacco product, with other nicotine-induced disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10384,'ICD10-DSM5','F17.299','No corresponding DSM-5 description for this ICD-10 code','Nicotine dependence, other tobacco product, with unspecified nicotine-induced disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10385,'ICD10-DSM5','F18.10','Inhalant use, mild','Inhalant abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10386,'ICD10-DSM5','F18.120','No corresponding DSM-5 description for this ICD-10 code','Inhalant abuse with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10387,'ICD10-DSM5','F18.121','Inhalant intoxication delirium, with mild use disorder','Inhalant abuse with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10388,'ICD10-DSM5','F18.129','Inhalant intoxication, with mild use disorder','Inhalant abuse with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10389,'ICD10-DSM5','F18.14','Inhalant-induced depressive disorder, with mild use disorder','Inhalant abuse with inhalant-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10390,'ICD10-DSM5','F18.150','No corresponding DSM-5 description for this ICD-10 code','Inhalant abuse with inhalant-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10391,'ICD10-DSM5','F18.151','No corresponding DSM-5 description for this ICD-10 code','Inhalant abuse with inhalant-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10392,'ICD10-DSM5','F18.159','Inhalant-induced psychotic disorder, with mild use disorder','Inhalant abuse with inhalant-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10393,'ICD10-DSM5','F18.17','Inhalant-induced major neurocognitive disorder, with mild use disorder','Inhalant abuse with inhalant-induced dementia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10394,'ICD10-DSM5','F18.180','Inhalant-induced anxiety disorder, with mild use disorder','Inhalant abuse with inhalant-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10395,'ICD10-DSM5','F18.188','Inhalant-induced mild neurocognitive disorder, with mild use disorder','Inhalant abuse with other inhalant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10396,'ICD10-DSM5','F18.19','No corresponding DSM-5 description for this ICD-10 code','Inhalant abuse with unspecified inhalant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10397,'ICD10-DSM5','F18.20','Inhalant use disorder, moderate','Inhalant dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10398,'ICD10-DSM5','F18.20','Inhalant use disorder, severe','Inhalant dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10399,'ICD10-DSM5','F18.21','No corresponding DSM-5 description for this ICD-10 code','Inhalant dependence, in remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10400,'ICD10-DSM5','F18.220','No corresponding DSM-5 description for this ICD-10 code','Inhalant dependence with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10401,'ICD10-DSM5','F18.221','Inhalant intoxication delirium, with moderate or severe use disorder','Inhalant dependence with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10402,'ICD10-DSM5','F18.229','Inhalant intoxication, with moderate or severe use disorder','Inhalant dependence with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10403,'ICD10-DSM5','F18.24','Inhalant-induced depressive disorder, with moderate or severe use disorder','Inhalant dependence with inhalant-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10404,'ICD10-DSM5','F18.250','No corresponding DSM-5 description for this ICD-10 code','Inhalant dependence with inhalant-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10405,'ICD10-DSM5','F18.251','No corresponding DSM-5 description for this ICD-10 code','Inhalant dependence with inhalant-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10406,'ICD10-DSM5','F18.259','Inhalant-induced psychotic disorder, with moderate or severe use disorder','Inhalant dependence with inhalant-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10407,'ICD10-DSM5','F18.27','Inhalant-induced major neurocognitive disorder, with moderate or severe use disorder','Inhalant dependence with inhalant-induced dementia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10408,'ICD10-DSM5','F18.280','Inhalant-induced anxiety disorder, with moderate or severe use disorder','Inhalant dependence with inhalant-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10409,'ICD10-DSM5','F18.288','Inhalant-induced mild neurocognitive disorder, with moderate or severe use disorder','Inhalant dependence with other inhalant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10410,'ICD10-DSM5','F18.29','No corresponding DSM-5 description for this ICD-10 code','Inhalant dependence with unspecified inhalant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10411,'ICD10-DSM5','F18.90','No corresponding DSM-5 description for this ICD-10 code','Inhalant use, unspecified, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10412,'ICD10-DSM5','F18.920','No corresponding DSM-5 description for this ICD-10 code','Inhalant use, unspecified with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10413,'ICD10-DSM5','F18.921','Inhalant intoxication delirium, without use disorder','Inhalant use, unspecified with intoxication with delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10414,'ICD10-DSM5','F18.929','Inhalant intoxication, without use disorder','Inhalant use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10415,'ICD10-DSM5','F18.94','Inhalant-induced depressive disorder, without use disorder','Inhalant use, unspecified with inhalant-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10416,'ICD10-DSM5','F18.950','No corresponding DSM-5 description for this ICD-10 code','Inhalant use, unspecified with inhalant-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10417,'ICD10-DSM5','F18.951','No corresponding DSM-5 description for this ICD-10 code','Inhalant use, unspecified with inhalant-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10418,'ICD10-DSM5','F18.959','Inhalant-induced psychotic disorder, without use disorder','Inhalant use, unspecified with inhalant-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10419,'ICD10-DSM5','F18.97','Inhalant-induced major neurocognitive disorder, without use disorder','Inhalant use, unspecified with inhalant-induced persisting dementia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10420,'ICD10-DSM5','F18.980','Inhalant-induced anxiety disorder, without use disorder','Inhalant use, unspecified with inhalant-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10421,'ICD10-DSM5','F18.988','Inhalant-induced mild neurocognitive disorder, without use disorder','Inhalant use, unspecified with other inhalant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10422,'ICD10-DSM5','F18.99','Unspecified inhalant-related disorder','Inhalant use, unspecified with unspecified inhalant-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10423,'ICD10-DSM5','F19.10','Other (or unknown) substance use disorder, mild','Other psychoactive substance abuse, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10424,'ICD10-DSM5','F19.120','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance abuse with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10425,'ICD10-DSM5','F19.121','Other (or unknown) substance intoxication delirium, with mild use disorder','Other psychoactive substance abuse with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10426,'ICD10-DSM5','F19.122','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance abuse with intoxication with perceptual disturbances',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10427,'ICD10-DSM5','F19.129','Other (or unknown) substance intoxication, with mild use disorder','Other psychoactive substance abuse with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10428,'ICD10-DSM5','F19.14','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance abuse with psychoactive substance-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10429,'ICD10-DSM5','F19.150','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance abuse with psychoactive substance-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10430,'ICD10-DSM5','F19.151','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance abuse with psychoactive substance-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10431,'ICD10-DSM5','F19.159','Other (or unknown) substance-induced psychotic disorder, with mild use disorder','Other psychoactive substance abuse with psychoactive substance-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10432,'ICD10-DSM5','F19.16','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance abuse with psychoactive substance-induced persisting amnestic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10433,'ICD10-DSM5','F19.17','Other (or unknown) substance-induced major neurocognitive disorder, with mild use disorder','Other psychoactive substance abuse with psychoactive substance-induced persisting dementia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10434,'ICD10-DSM5','F19.180','Other (or unknown) substance-induced anxiety disorder, with mild use disorder','Other psychoactive substance abuse with psychoactive substance-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10435,'ICD10-DSM5','F19.181','Other (or unknown) substance-induced sexual dysfunction, with mild use disorder','Other psychoactive substance abuse with psychoactive substance-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10436,'ICD10-DSM5','F19.182','Other (or unknown) substance-induced sleep disorder, with mild use disorder','Other psychoactive substance abuse with psychoactive substance-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10437,'ICD10-DSM5','F19.188','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance abuse with other psychoactive substance-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10438,'ICD10-DSM5','F19.19','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance abuse with unspecified psychoactive substance-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10439,'ICD10-DSM5','F19.20','Other (or unknown) substance use disorder, moderate','Other psychoactive substance dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10440,'ICD10-DSM5','F19.20','Other (or unknown) substance use disorder, severe','Other psychoactive substance dependence, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10441,'ICD10-DSM5','F19.21','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence, in remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10442,'ICD10-DSM5','F19.220','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10443,'ICD10-DSM5','F19.221','Other (or unknown) substance intoxication delirium, with moderate or severe use disorder','Other psychoactive substance dependence with intoxication delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10444,'ICD10-DSM5','F19.222','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10445,'ICD10-DSM5','F19.229','Other (or unknown) substance intoxication, with moderate or severe use disorder','Other psychoactive substance dependence with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10446,'ICD10-DSM5','F19.230','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence with withdrawal, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10447,'ICD10-DSM5','F19.231','Other (or unknown) substance withdrawal delirium','Other psychoactive substance dependence with withdrawal delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10448,'ICD10-DSM5','F19.232','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence with withdrawal with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10449,'ICD10-DSM5','F19.239','Other (or unknown) substance withdrawal','Other psychoactive substance dependence with withdrawal, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10450,'ICD10-DSM5','F19.24','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence with psychoactive substance-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10451,'ICD10-DSM5','F19.250','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence with psychoactive substance-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10452,'ICD10-DSM5','F19.251','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence with psychoactive substance-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10453,'ICD10-DSM5','F19.259','Other (or unknown) substance-induced psychotic disorder, with moderate or severe use disorder','Other psychoactive substance dependence with psychoactive substance-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10454,'ICD10-DSM5','F19.26','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence with psychoactive substance-induced persisting amnestic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10455,'ICD10-DSM5','F19.27','Other (or unknown) substance-induced major neurocognitive disorder, with moderate or severe use disorder','Other psychoactive substance dependence with psychoactive substance-induced persisting dementia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10456,'ICD10-DSM5','F19.280','Other (or unknown) substance-induced anxiety disorder, with moderate or severe use disorder','Other psychoactive substance dependence with psychoactive substance-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10457,'ICD10-DSM5','F19.281','Other (or unknown) substance-induced sexual dysfunction, with moderate or severe use disorder','Other psychoactive substance dependence with psychoactive substance-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10458,'ICD10-DSM5','F19.282','Other (or unknown) substance-induced sleep disorder, with moderate or severe use disorder','Other psychoactive substance dependence with psychoactive substance-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10459,'ICD10-DSM5','F19.288','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence with other psychoactive substance-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10460,'ICD10-DSM5','F19.29','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance dependence with unspecified psychoactive substance-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10461,'ICD10-DSM5','F19.90','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10462,'ICD10-DSM5','F19.920','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with intoxication, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10463,'ICD10-DSM5','F19.921','Other (or unknown) substance intoxication delirium, without use disorder','Other psychoactive substance use, unspecified with intoxication with delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10464,'ICD10-DSM5','F19.922','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with intoxication with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10465,'ICD10-DSM5','F19.929','Other (or unknown) substance intoxication, without use disorder','Other psychoactive substance use, unspecified with intoxication, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10466,'ICD10-DSM5','F19.930','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with withdrawal, uncomplicated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10467,'ICD10-DSM5','F19.931','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with withdrawal delirium',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10468,'ICD10-DSM5','F19.932','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with withdrawal with perceptual disturbance',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10469,'ICD10-DSM5','F19.939','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with withdrawal, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10470,'ICD10-DSM5','F19.94','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with psychoactive substance-induced mood disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10471,'ICD10-DSM5','F19.950','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with psychoactive substance-induced psychotic disorder with delusions',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10472,'ICD10-DSM5','F19.951','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with psychoactive substance-induced psychotic disorder with hallucinations',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10473,'ICD10-DSM5','F19.959','Other (or unknown) substance-induced psychotic disorder, without use disorder','Other psychoactive substance use, unspecified with psychoactive substance-induced psychotic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10474,'ICD10-DSM5','F19.96','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with psychoactive substance-induced persisting amnestic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10475,'ICD10-DSM5','F19.97','Other (or unknown) substance-induced major neurocognitive disorder, without use disorder','Other psychoactive substance use, unspecified with psychoactive substance-induced persisting dementia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10476,'ICD10-DSM5','F19.980','Other (or unknown) substance-induced anxiety disorder, without use disorder','Other psychoactive substance use, unspecified with psychoactive substance-induced anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10477,'ICD10-DSM5','F19.981','Other (or unknown) substance-induced sexual dysfunction, without use disorder','Other psychoactive substance use, unspecified with psychoactive substance-induced sexual dysfunction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10478,'ICD10-DSM5','F19.982','Other (or unknown) substance-induced sleep disorder, without use disorder','Other psychoactive substance use, unspecified with psychoactive substance-induced sleep disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10479,'ICD10-DSM5','F19.988','No corresponding DSM-5 description for this ICD-10 code','Other psychoactive substance use, unspecified with other psychoactive substance-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10480,'ICD10-DSM5','F19.99','Unspecified other (or unknown) substance-related disorder','Other psychoactive substance use, unspecified with unspecified psychoactive substance-induced disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10481,'ICD10-DSM5','F20.0','No corresponding DSM-5 description for this ICD-10 code','Paranoid schizophrenia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10482,'ICD10-DSM5','F20.1','No corresponding DSM-5 description for this ICD-10 code','Disorganized schizophrenia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10483,'ICD10-DSM5','F20.2','No corresponding DSM-5 description for this ICD-10 code','Catatonic schizophrenia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10484,'ICD10-DSM5','F20.3','No corresponding DSM-5 description for this ICD-10 code','Undifferentiated schizophrenia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10485,'ICD10-DSM5','F20.5','No corresponding DSM-5 description for this ICD-10 code','Residual schizophrenia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10486,'ICD10-DSM5','F20.81','Schizophreniform disorder','Schizophreniform disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10487,'ICD10-DSM5','F20.89','No corresponding DSM-5 description for this ICD-10 code','Other schizophrenia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10488,'ICD10-DSM5','F20.9','Schizophrenia','Schizophrenia, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10489,'ICD10-DSM5','F21','Schizotypal personality disorder','Schizotypal disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10490,'ICD10-DSM5','F22','Delusional disorders','Delusional disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10491,'ICD10-DSM5','F23','Brief psychotic disorder','Brief psychotic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10492,'ICD10-DSM5','F24','No corresponding DSM-5 description for this ICD-10 code','Shared psychotic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10493,'ICD10-DSM5','F25.0','Schizoaffective disorder, bipolar type','Schizoaffective disorder, bipolar type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10494,'ICD10-DSM5','F25.1','Schizoaffective disorder, depressive type','Schizoaffective disorder, depressive type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10495,'ICD10-DSM5','F25.8','No corresponding DSM-5 description for this ICD-10 code','Other schizoaffective disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10496,'ICD10-DSM5','F25.9','No corresponding DSM-5 description for this ICD-10 code','Schizoaffective disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10497,'ICD10-DSM5','F28','Other specified schizophrenia spectrum and other psychotic disorder','Other psychotic disorder not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10498,'ICD10-DSM5','F29','Unspecified schizophrenia spectrum and other psychotic disorder','Unspecified psychosis not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10499,'ICD10-DSM5','F30.10','No corresponding DSM-5 description for this ICD-10 code','Manic episode without psychotic symptoms, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10500,'ICD10-DSM5','F30.11','No corresponding DSM-5 description for this ICD-10 code','Manic episode without psychotic symptoms, mild',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10501,'ICD10-DSM5','F30.12','No corresponding DSM-5 description for this ICD-10 code','Manic episode without psychotic symptoms, moderate',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10502,'ICD10-DSM5','F30.13','No corresponding DSM-5 description for this ICD-10 code','Manic episode, severe, without psychotic symptoms',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10503,'ICD10-DSM5','F30.2','No corresponding DSM-5 description for this ICD-10 code','Manic episode, severe with psychotic symptoms',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10504,'ICD10-DSM5','F30.3','No corresponding DSM-5 description for this ICD-10 code','Manic episode in partial remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10505,'ICD10-DSM5','F30.4','No corresponding DSM-5 description for this ICD-10 code','Manic episode in full remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10506,'ICD10-DSM5','F30.8','No corresponding DSM-5 description for this ICD-10 code','Other manic episodes',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10507,'ICD10-DSM5','F30.9','No corresponding DSM-5 description for this ICD-10 code','Manic episode, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10508,'ICD10-DSM5','F31.0','Bipolar I disorder, current or most recent episode hypomanic','Bipolar disorder, current episode hypomanic',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10509,'ICD10-DSM5','F31.10','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, current episode manic without psychotic features, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10510,'ICD10-DSM5','F31.11','Bipolar I disorder, current or most recent episode manic, mild','Bipolar disorder, current episode manic without psychotic features, mild',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10511,'ICD10-DSM5','F31.12','Bipolar I disorder, current or most recent episode manic, moderate','Bipolar disorder, current episode manic without psychotic features, moderate',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10512,'ICD10-DSM5','F31.13','Bipolar I disorder, current or most recent episode manic, severe','Bipolar disorder, current episode manic without psychotic features, severe',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10513,'ICD10-DSM5','F31.2','Bipolar I disorder, current or most recent episode manic, with psychotic features','Bipolar disorder, current episode manic severe with psychotic features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10514,'ICD10-DSM5','F31.30','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, current episode depressed, mild or moderate severity, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10515,'ICD10-DSM5','F31.31','Bipolar I disorder, current or most recent episode depressed, mild','Bipolar disorder, current episode depressed, mild',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10516,'ICD10-DSM5','F31.32','Bipolar I disorder, current or most recent episode depressed, moderate','Bipolar disorder, current episode depressed, moderate',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10517,'ICD10-DSM5','F31.4','Bipolar I disorder, current or most recent episode depressed, severe','Bipolar disorder, current episode depressed, severe, without psychotic features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10518,'ICD10-DSM5','F31.5','Bipolar I disorder, current or most recent episode depressed, with psychotic features','Bipolar disorder, current episode depressed, severe, with psychotic features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10519,'ICD10-DSM5','F31.60','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, current episode mixed, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10520,'ICD10-DSM5','F31.61','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, current episode mixed, mild',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10521,'ICD10-DSM5','F31.62','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, current episode mixed, moderate',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10522,'ICD10-DSM5','F31.63','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, current episode mixed, severe, without psychotic features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10523,'ICD10-DSM5','F31.64','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, current episode mixed, severe, with psychotic features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10524,'ICD10-DSM5','F31.70','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, currently in remission, most recent episode unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10525,'ICD10-DSM5','F31.71','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, in partial remission, most recent episode hypomanic',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10526,'ICD10-DSM5','F31.72','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, in full remission, most recent episode hypomanic',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10527,'ICD10-DSM5','F31.73','Bipolar I disorder, current or most recent episode manic, in partial remission','Bipolar disorder, in partial remission, most recent episode manic',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10528,'ICD10-DSM5','F31.73','Bipolar I disorder, current or most recent episode hypomanic, in partial remission','Bipolar disorder, in partial remission, most recent episode manic',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10529,'ICD10-DSM5','F31.74','Bipolar I disorder, current or most recent episode manic, in full remission','Bipolar disorder, in full remission, most recent episode manic',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10530,'ICD10-DSM5','F31.74','Bipolar I disorder, current or most recent episode hypomanic, in full remission','Bipolar disorder, in full remission, most recent episode manic',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10531,'ICD10-DSM5','F31.75','Bipolar I disorder, current or most recent episode depressed, in partial remission','Bipolar disorder, in partial remission, most recent episode depressed',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10532,'ICD10-DSM5','F31.76','Bipolar I disorder, current or most recent episode depressed, in full remission','Bipolar disorder, in full remission, most recent episode depressed',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10533,'ICD10-DSM5','F31.77','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, in partial remission, most recent episode mixed',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10534,'ICD10-DSM5','F31.78','No corresponding DSM-5 description for this ICD-10 code','Bipolar disorder, in full remission, most recent episode mixed',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10535,'ICD10-DSM5','F31.81','Bipolar II disorder','Bipolar II disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10536,'ICD10-DSM5','F31.89','Other specified bipolar and related disorder','Other bipolar disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10537,'ICD10-DSM5','F31.9','Bipolar I disorder, current or most recent episode manic, unspecified','Bipolar disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10538,'ICD10-DSM5','F31.9','Bipolar I disorder, current or most recent episode hypomanic, unspecified','Bipolar disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10539,'ICD10-DSM5','F31.9','Bipolar I disorder, current or most recent episode depressed, unspecified','Bipolar disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10540,'ICD10-DSM5','F31.9','Bipolar I disorder, current or most recent episode unspecified','Bipolar disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10541,'ICD10-DSM5','F31.9','Unspecified bipolar and related disorder','Bipolar disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10542,'ICD10-DSM5','F32.0','Major depressive disorder, single episode, mild','Major depressive disorder, single episode, mild',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10543,'ICD10-DSM5','F32.1','Major depressive disorder, single episode, moderate','Major depressive disorder, single episode, moderate',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10544,'ICD10-DSM5','F32.2','Major depressive disorder, single episode, severe','Major depressive disorder, single episode, severe without psychotic features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10545,'ICD10-DSM5','F32.3','Major depressive disorder, single episode, with psychotic features','Major depressive disorder, single episode, severe with psychotic features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10546,'ICD10-DSM5','F32.4','Major depressive disorder, single episode, in partial remission','Major depressive disorder, single episode, in partial remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10547,'ICD10-DSM5','F32.5','Major depressive disorder, single episode, in full remission','Major depressive disorder, single episode, in full remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10548,'ICD10-DSM5','F32.8','Other specified depressive disorder','Other depressive episodes',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10549,'ICD10-DSM5','F32.9','Major depressive disorder, single episode, unspecified','Major depressive disorder, single episode, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10550,'ICD10-DSM5','F32.9','Unspecified depressive disorder','Major depressive disorder, single episode, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10551,'ICD10-DSM5','F33.0','Major depressive disorder, recurrent episode, mild','Major depressive disorder, recurrent, mild',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10552,'ICD10-DSM5','F33.1','Major depressive disorder, recurrent episode, moderate','Major depressive disorder, recurrent, moderate',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10553,'ICD10-DSM5','F33.2','Major depressive disorder, recurrent episode, severe','Major depressive disorder, recurrent severe without psychotic features',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10554,'ICD10-DSM5','F33.3','Major depressive disorder, recurrent episode, with psychotic features','Major depressive disorder, recurrent, severe with psychotic symptoms',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10555,'ICD10-DSM5','F33.40','No corresponding DSM-5 description for this ICD-10 code','Major depressive disorder, recurrent, in remission, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10556,'ICD10-DSM5','F33.41','Major depressive disorder, recurrent episode, in partial remission','Major depressive disorder, recurrent, in partial remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10557,'ICD10-DSM5','F33.42','Major depressive disorder, recurrent episode, in full remission','Major depressive disorder, recurrent, in full remission',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10558,'ICD10-DSM5','F33.8','No corresponding DSM-5 description for this ICD-10 code','Other recurrent depressive disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10559,'ICD10-DSM5','F33.9','Major depressive disorder, recurrent episode, unspecified','Major depressive disorder, recurrent, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10560,'ICD10-DSM5','F34.0','Cyclothymic disorder','Cyclothymic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10561,'ICD10-DSM5','F34.1','Persistent depressive disorder (dysthymia)','Dysthymic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10562,'ICD10-DSM5','F34.8','Disruptive mood dysregulation disorder','Other persistent mood [affective] disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10563,'ICD10-DSM5','F34.9','No corresponding DSM-5 description for this ICD-10 code','Persistent mood [affective] disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10564,'ICD10-DSM5','F39','No corresponding DSM-5 description for this ICD-10 code','Unspecified mood [affective] disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10565,'ICD10-DSM5','F40.00','Agoraphobia','Agoraphobia, unspecified  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10566,'ICD10-DSM5','F40.01','No corresponding DSM-5 description for this ICD-10 code','Agoraphobia with panic disorder   ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10567,'ICD10-DSM5','F40.02','No corresponding DSM-5 description for this ICD-10 code','Agoraphobia without panic disorder ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10568,'ICD10-DSM5','F40.10','Social anxiety disorder (social phobia)','Social phobia, unspecified ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10569,'ICD10-DSM5','F40.11','No corresponding DSM-5 description for this ICD-10 code','Social phobia, generalized ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10570,'ICD10-DSM5','F40.210','No corresponding DSM-5 description for this ICD-10 code','Arachnophobia ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10571,'ICD10-DSM5','F40.218','Specific phobia, animal','Other animal type phobia ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10572,'ICD10-DSM5','F40.220','No corresponding DSM-5 description for this ICD-10 code','Fear of thunderstorms  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10573,'ICD10-DSM5','F40.228','Specific phobia, natural environment','Other natural environment type phobia   ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10574,'ICD10-DSM5','F40.230','Specific phobia, fear of blood','Fear of blood    ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10575,'ICD10-DSM5','F40.231','Specific phobia, fear of injections and transfusions','Fear of injections and transfusions ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10576,'ICD10-DSM5','F40.232','Specific phobia, fear of other medical care','Fear of other medical care ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10577,'ICD10-DSM5','F40.233','Specific phobia, fear of injury','Fear of injury',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10578,'ICD10-DSM5','F40.240','No corresponding DSM-5 description for this ICD-10 code','Claustrophobia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10579,'ICD10-DSM5','F40.241','No corresponding DSM-5 description for this ICD-10 code','Acrophobia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10580,'ICD10-DSM5','F40.242','No corresponding DSM-5 description for this ICD-10 code','Fear of bridges  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10581,'ICD10-DSM5','F40.243','No corresponding DSM-5 description for this ICD-10 code','Fear of flying ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10582,'ICD10-DSM5','F40.248','Specific phobia, situational','Other situational type phobia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10583,'ICD10-DSM5','F40.290','No corresponding DSM-5 description for this ICD-10 code','Androphobia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10584,'ICD10-DSM5','F40.291','No corresponding DSM-5 description for this ICD-10 code','Gynephobia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10585,'ICD10-DSM5','F40.298','Specific phobia, other','Other specified phobia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10586,'ICD10-DSM5','F40.8','No corresponding DSM-5 description for this ICD-10 code','Other phobic anxiety disorders ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10587,'ICD10-DSM5','F40.9','No corresponding DSM-5 description for this ICD-10 code','Phobic anxiety disorder, unspecified  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10588,'ICD10-DSM5','F41.0','Panic disorder','Panic disorder [episodic paroxysmal anxiety] without agoraphobia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10589,'ICD10-DSM5','F41.1','Generalized anxiety disorder','Generalized anxiety disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10590,'ICD10-DSM5','F41.3','No corresponding DSM-5 description for this ICD-10 code','Other mixed anxiety disorders   ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10591,'ICD10-DSM5','F41.8','Other specified anxiety disorder','Other specified anxiety disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10592,'ICD10-DSM5','F41.9','Unspecified anxiety disorder','Anxiety disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10593,'ICD10-DSM5','F42','Obsessive-compulsive disorder','Obsessive-compulsive disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10594,'ICD10-DSM5','F42','Hoarding disorder','Obsessive-compulsive disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10595,'ICD10-DSM5','F42','Other specified obsessive-compulsive and related disorder','Obsessive-compulsive disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10596,'ICD10-DSM5','F42','Unspecified obsessive-compulsive and related disorder','Obsessive-compulsive disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10597,'ICD10-DSM5','F43.0','Acute stress reaction','Acute stress reaction',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10598,'ICD10-DSM5','F43.10','Posttraumatic stress disorder','Post-traumatic stress disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10599,'ICD10-DSM5','F43.11','No corresponding DSM-5 description for this ICD-10 code','Post-traumatic stress disorder, acute',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10600,'ICD10-DSM5','F43.12','No corresponding DSM-5 description for this ICD-10 code','Post-traumatic stress disorder, chronic',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10601,'ICD10-DSM5','F43.20','Adjustment disorders, unspecified','Adjustment disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10602,'ICD10-DSM5','F43.21','Adjustment disorders, with depressed mood','Adjustment disorder with depressed mood',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10603,'ICD10-DSM5','F43.22','Adjustment disorders, with anxiety','Adjustment disorder with anxiety',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10604,'ICD10-DSM5','F43.23','Adjustment disorders, with mixed anxiety and depressed mood','Adjustment disorder with mixed anxiety and depressed mood',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10605,'ICD10-DSM5','F43.24','Adjustment disorders, with disturbance of conduct','Adjustment disorder with disturbance of conduct',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10606,'ICD10-DSM5','F43.25','Adjustment disorders, with mixed disturbance of emotions and conduct','Adjustment disorder with mixed disturbance of emotions and conduct',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10607,'ICD10-DSM5','F43.29','No corresponding DSM-5 description for this ICD-10 code','Adjustment disorder with other symptoms',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10608,'ICD10-DSM5','F43.8','Other specified trauma- and stressor-related disorder','Other reactions to severe stress',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10609,'ICD10-DSM5','F43.9','Unspecified trauma- and stressor-related disorder','Reaction to severe stress, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10610,'ICD10-DSM5','F44.0','Dissociative amnesia','Dissociative amnesia  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10611,'ICD10-DSM5','F44.1','Dissociative amnesia, with dissociative fugue','Dissociative fugue',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10612,'ICD10-DSM5','F44.2','No corresponding DSM-5 description for this ICD-10 code','Dissociative stupor  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10613,'ICD10-DSM5','F44.4','Conversion disorder (functional neurological symptom disorder), with weakness or paralysis','Conversion disorder with motor symptom or deficit ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10614,'ICD10-DSM5','F44.4','Conversion disorder (functional neurological symptom disorder), with abnormal movement','Conversion disorder with motor symptom or deficit ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10615,'ICD10-DSM5','F44.4','Conversion disorder (functional neurological symptom disorder), with swallowing symptoms','Conversion disorder with motor symptom or deficit ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10616,'ICD10-DSM5','F44.4','Conversion disorder (functional neurological symptom disorder), with speech symptom','Conversion disorder with motor symptom or deficit ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10617,'ICD10-DSM5','F44.5','Conversion disorder (functional neurological symptom disorder), with attacks or seizures','Conversion disorder with seizures or convulsions ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10618,'ICD10-DSM5','F44.6','Conversion disorder (functional neurological symptom disorder), with anesthesia or sensory loss','Conversion disorder with sensory symptom or deficit  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10619,'ICD10-DSM5','F44.6','Conversion disorder (functional neurological symptom disorder), with special sensory symptom','Conversion disorder with sensory symptom or deficit  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10620,'ICD10-DSM5','F44.7','Conversion disorder (functional neurological symptom disorder), with mixed symptoms','Conversion disorder with mixed symptom presentation',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10621,'ICD10-DSM5','F44.81','Dissociative identity disorder','Dissociative identity disorder  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10622,'ICD10-DSM5','F44.89','Other specified dissociative disorder','Other dissociative and conversion disorders  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10623,'ICD10-DSM5','F44.9','Unspecified dissociative disorder','Dissociative and conversion disorder, unspecified ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10624,'ICD10-DSM5','F45.0','No corresponding DSM-5 description for this ICD-10 code','Somatization disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10625,'ICD10-DSM5','F45.1','Somatic symptom disorder','Undifferentiated somatoform disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10626,'ICD10-DSM5','F45.20','No corresponding DSM-5 description for this ICD-10 code','Hypochondriacal disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10627,'ICD10-DSM5','F45.21','Illness anxiety disorder','Hypochondriasis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10628,'ICD10-DSM5','F45.22','Body dysmorphic disorder','Body dysmorphic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10629,'ICD10-DSM5','F45.29','No corresponding DSM-5 description for this ICD-10 code','Other hypochondriacal disorders ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10630,'ICD10-DSM5','F45.41','No corresponding DSM-5 description for this ICD-10 code','Pain disorder exclusively related to psychological factors',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10631,'ICD10-DSM5','F45.42','No corresponding DSM-5 description for this ICD-10 code','Pain disorder with related psychological factors',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10632,'ICD10-DSM5','F45.8','Other specified somatic symptom and related disorders','Other somatoform disorders   ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10633,'ICD10-DSM5','F45.9','Unspecified somatic symptom and related disorder','Somatoform disorder, unspecified  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10634,'ICD10-DSM5','F48.1','Depersonalization/derealization disorder','Depersonalization-derealization syndrome',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10635,'ICD10-DSM5','F48.2','No corresponding DSM-5 description for this ICD-10 code','Pseudobulbar affect',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10636,'ICD10-DSM5','F48.8','No corresponding DSM-5 description for this ICD-10 code','Other specified nonpsychotic mental disorders ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10637,'ICD10-DSM5','F48.9','No corresponding DSM-5 description for this ICD-10 code','Nonpsychotic mental disorder, unspecified    ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10638,'ICD10-DSM5','F50.00','No corresponding DSM-5 description for this ICD-10 code','Anorexia nervosa, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10639,'ICD10-DSM5','F50.01','Anorexia nervosa, restricting type','Anorexia nervosa, restricting type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10640,'ICD10-DSM5','F50.02','Anorexia nervosa, binge-eating/purging type','Anorexia nervosa, binge eating/purging type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10641,'ICD10-DSM5','F50.2','Bulimia nervosa','Bulimia nervosa',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10642,'ICD10-DSM5','F50.8','Pica, in adults','Other eating disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10643,'ICD10-DSM5','F50.8','Avoidant/restrictive food intake disorder','Other eating disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10644,'ICD10-DSM5','F50.8','Binge-eating disorder','Other eating disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10645,'ICD10-DSM5','F50.8','Other specified feeding or eating disorder','Other eating disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10646,'ICD10-DSM5','F50.9','Unspecified feeding or eating disorder','Eating disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10647,'ICD10-DSM5','F51.01','No corresponding DSM-5 description for this ICD-10 code','Primary insomnia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10648,'ICD10-DSM5','F51.02','No corresponding DSM-5 description for this ICD-10 code','Adjustment insomnia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10649,'ICD10-DSM5','F51.03','No corresponding DSM-5 description for this ICD-10 code','Paradoxical insomnia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10650,'ICD10-DSM5','F51.04','No corresponding DSM-5 description for this ICD-10 code','Psychophysiologic insomnia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10651,'ICD10-DSM5','F51.05','No corresponding DSM-5 description for this ICD-10 code','Insomnia due to other mental disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10652,'ICD10-DSM5','F51.09','No corresponding DSM-5 description for this ICD-10 code','Other insomnia not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10653,'ICD10-DSM5','F51.11','No corresponding DSM-5 description for this ICD-10 code','Primary hypersomnia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10654,'ICD10-DSM5','F51.12','No corresponding DSM-5 description for this ICD-10 code','Insufficient sleep syndrome',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10655,'ICD10-DSM5','F51.13','No corresponding DSM-5 description for this ICD-10 code','Hypersomnia due to other mental disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10656,'ICD10-DSM5','F51.19','No corresponding DSM-5 description for this ICD-10 code','Other hypersomnia not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10657,'ICD10-DSM5','F51.3','Non-rapid eye movement sleep arousal disorders, sleepwalking type','Sleepwalking [somnambulism]',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10658,'ICD10-DSM5','F51.4','Non-rapid eye movement sleep arousal disorders, sleep terror type','Sleep terrors [night terrors]',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10659,'ICD10-DSM5','F51.5','Nightmare disorder','Nightmare disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10660,'ICD10-DSM5','F51.8','No corresponding DSM-5 description for this ICD-10 code','Other sleep disorders not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10661,'ICD10-DSM5','F51.9','No corresponding DSM-5 description for this ICD-10 code','Sleep disorder not due to a substance or known physiological condition, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10662,'ICD10-DSM5','F52.0','Male hypoactive sexual desire disorder','Hypoactive sexual desire disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10663,'ICD10-DSM5','F52.1','No corresponding DSM-5 description for this ICD-10 code','Sexual aversion disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10664,'ICD10-DSM5','F52.21','Erectile disorder','Male erectile disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10665,'ICD10-DSM5','F52.22','Female sexual interest/arousal disorder','Female sexual arousal disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10666,'ICD10-DSM5','F52.31','Female orgasmic disorder','Female orgasmic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10667,'ICD10-DSM5','F52.32','Delayed ejaculation','Male orgasmic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10668,'ICD10-DSM5','F52.4','Premature (early) ejaculation','Premature ejaculation',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10669,'ICD10-DSM5','F52.5','No corresponding DSM-5 description for this ICD-10 code','Vaginismus not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10670,'ICD10-DSM5','F52.6','Genito-pelvic pain/penetration disorder','Dyspareunia not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10671,'ICD10-DSM5','F52.8','Other specified sexual dysfunction','Other sexual dysfunction not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10672,'ICD10-DSM5','F52.9','Unspecified sexual dysfunction','Unspecified sexual dysfunction not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10673,'ICD10-DSM5','F53','No corresponding DSM-5 description for this ICD-10 code','Puerperal psychosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10674,'ICD10-DSM5','F54','Psychological factors affecting other medical conditions','Psychological and behavioral factors associated with disorders or diseases classified elsewhere',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10675,'ICD10-DSM5','F55.0','No corresponding DSM-5 description for this ICD-10 code','Abuse of antacids',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10676,'ICD10-DSM5','F55.1','No corresponding DSM-5 description for this ICD-10 code','Abuse of herbal or folk remedies',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10677,'ICD10-DSM5','F55.2','No corresponding DSM-5 description for this ICD-10 code','Abuse of laxatives',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10678,'ICD10-DSM5','F55.3','No corresponding DSM-5 description for this ICD-10 code','Abuse of steroids or hormones',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10679,'ICD10-DSM5','F55.4','No corresponding DSM-5 description for this ICD-10 code','Abuse of vitamins',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10680,'ICD10-DSM5','F55.8','No corresponding DSM-5 description for this ICD-10 code','Abuse of other non-psychoactive substances',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10681,'ICD10-DSM5','F59','No corresponding DSM-5 description for this ICD-10 code','Unspecified behavioral syndromes associated with physiological disturbances and physical factors',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10682,'ICD10-DSM5','F60.0','Paranoid personality disorder','Paranoid personality disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10683,'ICD10-DSM5','F60.1','Schizoid personality disorder','Schizoid personality disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10684,'ICD10-DSM5','F60.2','Antisocial personality disorder','Antisocial personality disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10685,'ICD10-DSM5','F60.3','Borderline personality disorder','Borderline personality disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10686,'ICD10-DSM5','F60.4','Histrionic personality disorder','Histrionic personality disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10687,'ICD10-DSM5','F60.5','Obsessive-compulsive personality disorder','Obsessive-compulsive personality disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10688,'ICD10-DSM5','F60.6','Avoidant personality disorder','Avoidant personality disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10689,'ICD10-DSM5','F60.7','Dependent personality disorder','Dependent personality disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10690,'ICD10-DSM5','F60.81','Narcissistic personality disorder','Narcissistic personality disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10691,'ICD10-DSM5','F60.89','Other specified personality disorder','Other specific personality disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10692,'ICD10-DSM5','F60.9','Unspecified personality disorder','Personality disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10693,'ICD10-DSM5','F63.0','Gambling disorder','Pathological gambling',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10694,'ICD10-DSM5','F63.1','Pyromania','Pyromania',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10695,'ICD10-DSM5','F63.2','Kleptomania','Kleptomania',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10696,'ICD10-DSM5','F63.3','Trichotillomania (hair-pulling disorder)','Trichotillomania',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10697,'ICD10-DSM5','F63.81','Intermittent explosive disorder','Intermittent explosive disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10698,'ICD10-DSM5','F63.89','No corresponding DSM-5 description for this ICD-10 code','Other impulse disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10699,'ICD10-DSM5','F63.9','No corresponding DSM-5 description for this ICD-10 code','Impulse disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10700,'ICD10-DSM5','F64.1','Gender dysphoria in adolescents and adults','Gender identity disorder in adolescence and adulthood',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10701,'ICD10-DSM5','F64.8','Other specified gender dysphoria','Other gender identity disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10702,'ICD10-DSM5','F64.9','Unspecified gender dysphoria','Gender identity disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10703,'ICD10-DSM5','F65.0','Fetishistic disorder','Fetishism',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10704,'ICD10-DSM5','F65.1','Transvestic disorder','Transvestic fetishism',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10705,'ICD10-DSM5','F65.2','Exhibitionistic disorder','Exhibitionism',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10706,'ICD10-DSM5','F65.3','Voyeuristic disorder','Voyeurism',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10707,'ICD10-DSM5','F65.4','Pedophilic disorder','Pedophilia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10708,'ICD10-DSM5','F65.50','No corresponding DSM-5 description for this ICD-10 code','Sadomasochism, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10709,'ICD10-DSM5','F65.51','Sexual masochism disorder','Sexual masochism',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10710,'ICD10-DSM5','F65.52','Sexual sadism disorder','Sexual sadism',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10711,'ICD10-DSM5','F65.81','Frotteuristic disorder','Frotteurism',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10712,'ICD10-DSM5','F65.89','Other specified paraphilic disorder','Other paraphilias',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10713,'ICD10-DSM5','F65.9','Unspecified paraphilic disorder','Paraphilia, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10714,'ICD10-DSM5','F66','No corresponding DSM-5 description for this ICD-10 code','Other sexual disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10715,'ICD10-DSM5','F68.10','Factitious disorder imposed on self','Factitious disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10716,'ICD10-DSM5','F68.10','Factitious disorder imposed on another','Factitious disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10717,'ICD10-DSM5','F68.11','No corresponding DSM-5 description for this ICD-10 code','Factitious disorder with predominantly psychological signs and symptoms ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10718,'ICD10-DSM5','F68.12','No corresponding DSM-5 description for this ICD-10 code','Factitious disorder with predominantly physical signs and symptoms',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10719,'ICD10-DSM5','F68.13','No corresponding DSM-5 description for this ICD-10 code','Factitious disorder with combined psychological and physical signs and symptoms    ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10720,'ICD10-DSM5','F68.8','No corresponding DSM-5 description for this ICD-10 code','Other specified disorders of adult personality and behavior  ',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10721,'ICD10-DSM5','F69','No corresponding DSM-5 description for this ICD-10 code','Unspecified disorder of adult personality and behavior',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10722,'ICD10-DSM5','F70','Intellectual disability (intellectual developmental disorder), mild','Mild intellectual disabilities',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10723,'ICD10-DSM5','F71','Intellectual disability (intellectual developmental disorder), moderate','Moderate intellectual disabilities',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10724,'ICD10-DSM5','F72','Intellectual disability (intellectual developmental disorder), severe','Severe intellectual disabilities',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10725,'ICD10-DSM5','F73','Intellectual disability (intellectual developmental disorder), profound','Profound intellectual disabilities',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10726,'ICD10-DSM5','F78','No corresponding DSM-5 description for this ICD-10 code','Other intellectual disabilities',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10727,'ICD10-DSM5','F79','Unspecified intellectual disability (intellectual developmental disorder)','Unspecified intellectual disabilities',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10728,'ICD10-DSM5','F80.0','Speech sound disorder','Phonological disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10729,'ICD10-DSM5','F80.1','No corresponding DSM-5 description for this ICD-10 code','Expressive language disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10730,'ICD10-DSM5','F80.2','No corresponding DSM-5 description for this ICD-10 code','Mixed receptive-expressive language disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10731,'ICD10-DSM5','F80.4','No corresponding DSM-5 description for this ICD-10 code','Speech and language development delay due to hearing loss',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10732,'ICD10-DSM5','F80.81','Childhood-onset fluency disorder (stuttering)','Childhood onset fluency disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10733,'ICD10-DSM5','F80.89','Social (pragmatic) communication disorder','Other developmental disorders of speech and language',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10734,'ICD10-DSM5','F80.9','Language Disorder','Developmental disorder of speech and language, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10735,'ICD10-DSM5','F80.9','Unspecified communication disorder','Developmental disorder of speech and language, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10736,'ICD10-DSM5','F81.0','Specific learning disorder, with impairment in reading','Specific reading disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10737,'ICD10-DSM5','F81.2','Specific learning disorder, with impairment in mathematics','Mathematics disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10738,'ICD10-DSM5','F81.81','Specific learning disorder, with impairment in written expression','Disorder of written expression',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10739,'ICD10-DSM5','F81.89','No corresponding DSM-5 description for this ICD-10 code','Other developmental disorders of scholastic skills',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10740,'ICD10-DSM5','F81.9','No corresponding DSM-5 description for this ICD-10 code','Developmental disorder of scholastic skills, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10741,'ICD10-DSM5','F82','Developmental coordination disorder','Specific developmental disorder of motor function',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10742,'ICD10-DSM5','F84.0','Autism spectrum disorder','Autistic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10743,'ICD10-DSM5','F84.2','No corresponding DSM-5 description for this ICD-10 code','Rett''s syndrome',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10744,'ICD10-DSM5','F84.3','No corresponding DSM-5 description for this ICD-10 code','Other childhood disintegrative disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10745,'ICD10-DSM5','F84.5','No corresponding DSM-5 description for this ICD-10 code','Asperger''s syndrome',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10746,'ICD10-DSM5','F84.8','No corresponding DSM-5 description for this ICD-10 code','Other pervasive developmental disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10747,'ICD10-DSM5','F84.9','No corresponding DSM-5 description for this ICD-10 code','Pervasive developmental disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10748,'ICD10-DSM5','F88','Global developmental delay','Other disorders of psychological development',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10749,'ICD10-DSM5','F88','Other specified neurodevelopmental disorder','Other disorders of psychological development',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10750,'ICD10-DSM5','F89','Unspecified neurodevelopmental disorder','Unspecified disorder of psychological development',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10751,'ICD10-DSM5','F90.0','Attention-deficit/hyperactivity disorder, predominantly inattentive presentation','Attention-deficit hyperactivity disorder, predominantly inattentive type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10752,'ICD10-DSM5','F90.1','Attention-deficit/hyperactivity disorder, predominantly hyperactive/impulsive presentation','Attention-deficit hyperactivity disorder, predominantly hyperactive type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10753,'ICD10-DSM5','F90.2','Attention-deficit/hyperactivity disorder, combined presentation','Attention-deficit hyperactivity disorder, combined type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10754,'ICD10-DSM5','F90.8','Other specified attention-deficit/hyperactivity disorder','Attention-deficit hyperactivity disorder, other type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10755,'ICD10-DSM5','F90.9','Unspecified attention-deficit/hyperactivity disorder','Attention-deficit hyperactivity disorder, unspecified type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10756,'ICD10-DSM5','F91.1','Conduct disorder, childhood-onset type','Conduct disorder, childhood-onset type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10757,'ICD10-DSM5','F91.2','Conduct disorder, adolescent-onset type','Conduct disorder, adolescent-onset type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10758,'ICD10-DSM5','F91.3','Oppositional defiant disorder','Oppositional defiant disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10759,'ICD10-DSM5','F91.8','Other specified disruptive, impulse-control, and conduct disorder','Other conduct disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10760,'ICD10-DSM5','F91.9','Conduct disorder, unspecified onset','Conduct disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10761,'ICD10-DSM5','F91.9','Unspecified disruptive, impulse-control, and conduct disorder','Conduct disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10762,'ICD10-DSM5','F93.0','Separation anxiety disorder','Separation anxiety disorder of childhood',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10763,'ICD10-DSM5','F94.0','Selective mutism','Selective mutism',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10764,'ICD10-DSM5','F94.1','Reactive attachment disorder','Reactive attachment disorder of childhood',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10765,'ICD10-DSM5','F94.2','Disinhibited social engagement disorder','Disinhibited attachment disorder of childhood',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10766,'ICD10-DSM5','F95.0','Provisional tic disorder','Transient tic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10767,'ICD10-DSM5','F95.1','Persistent (chronic) motor or vocal tic disorder','Chronic motor or vocal tic disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10768,'ICD10-DSM5','F95.2','Tourette''s disorder','Tourette''s disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10769,'ICD10-DSM5','F95.8','Other specified tic disorder','Other tic disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10770,'ICD10-DSM5','F95.9','Unspecified tic disorder','Tic disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10771,'ICD10-DSM5','F98.0','Enuresis','Enuresis not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10772,'ICD10-DSM5','F98.1','Encopresis','Encopresis not due to a substance or known physiological condition',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10773,'ICD10-DSM5','F98.21','Rumination disorder','Rumination disorder of infancy',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10774,'ICD10-DSM5','F98.4','Stereotypic movement disorder','Stereotyped movement disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10775,'ICD10-DSM5','F98.5','Adult-onset fluency disorder','Adult onset fluency disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10776,'ICD10-DSM5','F98.8','No corresponding DSM-5 description for this ICD-10 code','Other specified behavioral and emotional disorders with onset usually occurring in childhood and adolescence',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10777,'ICD10-DSM5','F98.9','No corresponding DSM-5 description for this ICD-10 code','Unspecified behavioral and emotional disorders with onset usually occurring in childhood and adolescence',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10778,'ICD10-DSM5','F99','Other specified mental disorder  ','Mental disorder, not otherwise specified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10779,'ICD10-DSM5','F99','Unspecified mental disorder  ','Mental disorder, not otherwise specified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10780,'ICD10-DSM5','G21.0','Neuroleptic malignant syndrome','Malignant neuroleptic syndrome',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10781,'ICD10-DSM5','G21.11','Neuroleptic-induced parkinsonism','Neuroleptic induced parkinsonism',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10782,'ICD10-DSM5','G21.19','Other medication-induced parkinsonism','Other drug induced secondary parkinsonism',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10783,'ICD10-DSM5','G24.01','Tardive dyskinesia','Drug induced subacute dyskinesia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10784,'ICD10-DSM5','G24.02','Medication-induced acute dystonia','Drug induced acute dystonia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10785,'ICD10-DSM5','G24.09','Tardive dystonia','Other drug induced dystonia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10786,'ICD10-DSM5','G25.1','Medication-induced postural tremor','Drug-induced tremor',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10787,'ICD10-DSM5','G25.71','Medication-induced acute akathisia','Drug induced akathisia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10788,'ICD10-DSM5','G25.71','Tardive akathisia','Drug induced akathisia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10789,'ICD10-DSM5','G25.79','Other medication-induced movement disorder','Other drug induced movement disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10790,'ICD10-DSM5','G25.81','Restless legs syndrome','Restless legs syndrome',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10791,'ICD10-DSM5','G31.84','Mild neurocognitive disorder due to Alzheimer''s disease','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10792,'ICD10-DSM5','G31.84','Mild neurocognitive disorder due to frontotemporal lobar degeneration','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10793,'ICD10-DSM5','G31.84','Mild neurocognitive disorder with Lewy bodies','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10794,'ICD10-DSM5','G31.84','Mild vascular neurocognitive disorder','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10795,'ICD10-DSM5','G31.84','Mild neurocognitive disorder due to traumatic brain injury ','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10796,'ICD10-DSM5','G31.84','Mild neurocognitive disorder due to HIV infection','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10797,'ICD10-DSM5','G31.84','Mild neurocognitive disorder due to Prion disease','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10798,'ICD10-DSM5','G31.84','Mild neurocognitive disorder due to Parkinson''s disease','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10799,'ICD10-DSM5','G31.84','Mild neurocognitive disorder due to Huntington''s disease','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10800,'ICD10-DSM5','G31.84','Mild neurocognitive disorder due to another medical condition','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10801,'ICD10-DSM5','G31.84','Mild neurocognitive disorder due to multiple etiologies','Mild cognitive impairment, so stated',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10802,'ICD10-DSM5','G31.9','Possible major neurocognitive disorder due to Alzheimer''s disease','Degenerative disease of nervous system, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10803,'ICD10-DSM5','G31.9','Possible major neurocognitive disorder due to frontotemporal lobar degeneration','Degenerative disease of nervous system, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10804,'ICD10-DSM5','G31.9','Possible major neurocognitive disorder with Lewy bodies','Degenerative disease of nervous system, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10805,'ICD10-DSM5','G31.9','Possible major vascular neurocognitive disorder','Degenerative disease of nervous system, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10806,'ICD10-DSM5','G31.9','Major neurocognitive disorder possibly due to Parkinson''s disease','Degenerative disease of nervous system, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10807,'ICD10-DSM5','G47.00','Insomnia disorder','Insomnia, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10808,'ICD10-DSM5','G47.09','Other specified insomnia disorder','Other insomnia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10809,'ICD10-DSM5','G47.10','Hypersomnolence disorder','Hypersomnia, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10810,'ICD10-DSM5','G47.10','Unspecified hypersomnolence disorder','Hypersomnia, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10811,'ICD10-DSM5','G47.19','Other specified hypersomnolence disorder','Other hypersomnia',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10812,'ICD10-DSM5','G47.20','Circadian rhythm sleep-wake disorders, unspecified type','Circadian rhythm sleep disorder, unspecified type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10813,'ICD10-DSM5','G47.21','Circadian rhythm sleep-wake disorders, delayed sleep phase type','Circadian rhythm sleep disorder, delayed sleep phase type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10814,'ICD10-DSM5','G47.22','Circadian rhythm sleep-wake disorders, advanced sleep phase type','Circadian rhythm sleep disorder, advanced sleep phase type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10815,'ICD10-DSM5','G47.23','Circadian rhythm sleep-wake disorders, irregular sleep-wake type','Circadian rhythm sleep disorder, irregular sleep wake type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10816,'ICD10-DSM5','G47.24','Circadian rhythm sleep-wake disorders, non-24-hour sleep-wake type','Circadian rhythm sleep disorder, free running type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10817,'ICD10-DSM5','G47.26','Circadian rhythm sleep-wake disorders, shift work type','Circadian rhythm sleep disorder, shift work type',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10818,'ICD10-DSM5','G47.31','Central sleep apnea, idiopathic central sleep apnea','Primary central sleep apnea',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10819,'ICD10-DSM5','G47.33','Obstructive sleep apnea hypopnea','Obstructive sleep apnea (adult) (pediatric)',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10820,'ICD10-DSM5','G47.34','Sleep-related hypoventilation, idiopathic hypoventilation','Idiopathic sleep related nonobstructive alveolar hypoventilation',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10821,'ICD10-DSM5','G47.35','Sleep-related hypoventilation, congenital central alveolar hypoventilation','Congenital central alveolar hypoventilation syndrome',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10822,'ICD10-DSM5','G47.36','Sleep-related hypoventilation, comorbid sleep-related hypoventilation','Sleep related hypoventilation in conditions classified elsewhere',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10823,'ICD10-DSM5','G47.37','Central sleep apnea comorbid with opioid use','Central sleep apnea in conditions classified elsewhere',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10824,'ICD10-DSM5','G47.411','Narcolepsy with cataplexy but without hypocretin deficiency','Narcolepsy with cataplexy',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10825,'ICD10-DSM5','G47.419','Narcolepsy without cataplexy but with hypocretin deficiency','Narcolepsy without cataplexy',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10826,'ICD10-DSM5','G47.419','Autosomal dominant cerebellar ataxia, deafness, and narcolepsy','Narcolepsy without cataplexy',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10827,'ICD10-DSM5','G47.419','Autosomal dominant narcolepsy, obesity, and type 2 diabetes','Narcolepsy without cataplexy',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10828,'ICD10-DSM5','G47.429','Narcolepsy secondary to another medical condition','Narcolepsy in conditions classified elsewhere without cataplexy',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10829,'ICD10-DSM5','G47.52','Rapid eye movement sleep behavior disorder','REM sleep behavior disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10830,'ICD10-DSM5','G47.8','Other specified sleep-wake disorder','Other sleep disorders',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10831,'ICD10-DSM5','G47.9','Unspecified sleep-wake disorder','Sleep disorder, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10832,'ICD10-DSM5','L98.1','Excoriation (skin-picking) disorder','Factitial dermatitis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10833,'ICD10-DSM5','N39.498','Other specified elimination disorder, with urinary symptoms','Other specified urinary incontinence',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10834,'ICD10-DSM5','N94.3','Premenstrual dysphoric disorder','Premenstrual tension syndrome',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10835,'ICD10-DSM5','R06.3','Central sleep apnea, Cheyne-Stokes breathing','Periodic breathing',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10836,'ICD10-DSM5','R15.9','Other specified elimination disorder, with fecal symptoms','Full incontinence of feces',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10837,'ICD10-DSM5','R15.9','Unspecified elimination disorder, with fecal symptoms','Full incontinence of feces',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10838,'ICD10-DSM5','R32','Unspecified elimination disorder, with urinary symptoms','Unspecified urinary incontinence',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10839,'ICD10-DSM5','R41.0','Other specified delirium','Disorientation, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10840,'ICD10-DSM5','R41.0','Unspecified delirium','Disorientation, unspecified',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10841,'ICD10-DSM5','R41.83','Borderline intellectual functioning','Borderline intellectual functioning',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10842,'ICD10-DSM5','R41.9','Unspecified neurocognitive disorder','Unspecified neurocognitive disorder',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10843,'ICD10-DSM5','T43.205A','Antidepressant discontinuation syndrome, initial encounter','Adverse effect of unspecified antidepressants, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10844,'ICD10-DSM5','T43.205D','Antidepressant discontinuation syndrome, subsequent encounter','Adverse effect of unspecified antidepressants, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10845,'ICD10-DSM5','T43.205S','Antidepressant discontinuation syndrome, sequelae','Adverse effect of unspecified antidepressants, sequela',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10846,'ICD10-DSM5','T50.905A','Other adverse effect of medication, initial encounter','Adverse effect of unspecified drugs, medicaments and biological substances, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10847,'ICD10-DSM5','T50.905D','Other adverse effect of medication, subsequent encounter','Adverse effect of unspecified drugs, medicaments and biological substances, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10848,'ICD10-DSM5','T50.905S','Other adverse effect of medication, sequelae','Adverse effect of unspecified drugs, medicaments and biological substances, sequela',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10849,'ICD10-DSM5','T76.01XD','Adult neglect, suspected, subsequent encounter','Adult neglect or abandonment, suspected, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10850,'ICD10-DSM5','T74.01XA','Spouse or partner neglect, confirmed, initial encounter','Adult neglect or abandonment, confirmed, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10851,'ICD10-DSM5','T74.01XD','Spouse or partner neglect, confirmed, subsequent encounter','Adult neglect or abandonment, confirmed, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10852,'ICD10-DSM5','T74.11XA','Spouse or partner violence, physical, confirmed, initial encounter','Adult physical abuse, confirmed, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10853,'ICD10-DSM5','T74.11XA','Adult physical abuse by nonspouse or nonpartner, confirmed, initial encounter','Adult physical abuse, confirmed, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10854,'ICD10-DSM5','T74.11XD','Spouse or partner violence, physical, confirmed, subsequent encounter','Adult physical abuse, confirmed, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10855,'ICD10-DSM5','T74.11XD','Adult physical abuse by nonspouse or nonpartner, confirmed, subsequent encounter','Adult physical abuse, confirmed, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10856,'ICD10-DSM5','T74.21XA','Spouse or partner violence, sexual, confirmed, initial encounter','Adult sexual abuse, confirmed, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10857,'ICD10-DSM5','T74.21XA','Adult sexual abuse by nonspouse or nonpartner, confirmed, initial encounter','Adult sexual abuse, confirmed, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10858,'ICD10-DSM5','T74.21XD','Spouse or partner violence, sexual, confirmed, subsequent encounter','Adult sexual abuse, confirmed, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10859,'ICD10-DSM5','T74.21XD','Adult sexual abuse by nonspouse or nonpartner, confirmed, subsequent encounter','Adult sexual abuse, confirmed, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10860,'ICD10-DSM5','T74.31XA','Spouse or partner abuse, psychological, confirmed, initial encounter','Adult psychological abuse, confirmed, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10861,'ICD10-DSM5','T74.31XA','Adult psychological abuse by nonspouse or nonpartner, confirmed, initial encounter','Adult psychological abuse, confirmed, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10862,'ICD10-DSM5','T74.31XD','Spouse or partner abuse, psychological, confirmed, subsequent encounter','Adult psychological abuse, confirmed, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10863,'ICD10-DSM5','T74.31XD','Adult psychological abuse by nonspouse or nonpartner, confirmed, subsequent encounter','Adult psychological abuse, confirmed, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10864,'ICD10-DSM5','T76.01XA','Spouse or partner neglect, suspected, initial encounter','Adult neglect or abandonment, suspected, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10865,'ICD10-DSM5','T76.01XA','Adult neglect, suspected, initial encounter','Adult neglect or abandonment, suspected, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10866,'ICD10-DSM5','T76.01XD','Spouse or partner neglect, suspected, subsequent encounter','Adult neglect or abandonment, suspected, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10867,'ICD10-DSM5','T76.01XD','Adult neglect, suspected, subsequent encounter','Adult neglect or abandonment, suspected, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10868,'ICD10-DSM5','T76.11XA','Spouse or partner violence, physical, suspected, initial encounter','Adult physical abuse, suspected, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10869,'ICD10-DSM5','T76.11XA','Adult physical abuse by nonspouse or nonpartner, suspected, initial encounter','Adult physical abuse, suspected, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10870,'ICD10-DSM5','T76.11XD','Spouse or partner violence, physical, suspected, subsequent encounter','Adult physical abuse, suspected, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10871,'ICD10-DSM5','T76.11XD','Adult physical abuse by nonspouse or nonpartner, suspected, subsequent encounter','Adult physical abuse, suspected, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10872,'ICD10-DSM5','T76.21XA','Spouse or partner violence, sexual, suspected, initial encounter','Adult sexual abuse, suspected, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10873,'ICD10-DSM5','T76.21XA','Adult sexual abuse by nonspouse or nonpartner, suspected, initial encounter','Adult sexual abuse, suspected, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10874,'ICD10-DSM5','T76.21XD','Spouse or partner violence, sexual, suspected, subsequent encounter','Adult sexual abuse, suspected, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10875,'ICD10-DSM5','T76.21XD','Adult sexual abuse by nonspouse or nonpartner, suspected, subsequent encounter','Adult sexual abuse, suspected, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10876,'ICD10-DSM5','T76.31XA','Spouse or partner abuse, psychological, suspected, initial encounter','Adult psychological abuse, suspected, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10877,'ICD10-DSM5','T76.31XA','Adult psychological abuse by nonspouse or nonpartner, suspected, initial encounter','Adult psychological abuse, suspected, initial encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10878,'ICD10-DSM5','T76.31XD','Spouse or partner abuse, psychological, suspected, subsequent encounter','Adult psychological abuse, suspected, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10879,'ICD10-DSM5','T76.31XD','Adult psychological abuse by nonspouse or nonpartner, suspected, subsequent encounter','Adult psychological abuse, suspected, subsequent encounter',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10880,'ICD10-DSM5','Z55.9','Academic or educational problem','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10881,'ICD10-DSM5','Z56.9','Other problem related to employment','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10882,'ICD10-DSM5','Z59.0','Homelessness','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10883,'ICD10-DSM5','Z59.1','Inadequate housing','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10884,'ICD10-DSM5','Z59.2','Discord with neighbor, lodger, or landlord','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10885,'ICD10-DSM5','Z59.3','Problem related to living in a residential institution','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10886,'ICD10-DSM5','Z59.4','Lack of adequate food or safe drinking water','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10887,'ICD10-DSM5','Z59.5','Extreme poverty','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10888,'ICD10-DSM5','Z59.6','Low income','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10889,'ICD10-DSM5','Z59.7','Insufficient social insurance or welfare support','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10890,'ICD10-DSM5','Z59.9','Unspecified housing or economic problem','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10891,'ICD10-DSM5','Z60.0','Phase of life problem','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10892,'ICD10-DSM5','Z60.2','Problem related to living alone','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10893,'ICD10-DSM5','Z60.3','Acculturation difficulty','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10894,'ICD10-DSM5','Z60.4','Social exclusion or rejection','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10895,'ICD10-DSM5','Z60.5','Target of (perceived) adverse discrimination or persecution','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10896,'ICD10-DSM5','Z60.9','Unspecified problem related to social environment','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10897,'ICD10-DSM5','Z62.810','Personal history (past history) of physical abuse in childhood','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10898,'ICD10-DSM5','Z62.810','Personal history (past history) of sexual abuse in childhood','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10899,'ICD10-DSM5','Z62.811','Personal history (past history) of psychological abuse in childhood','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10900,'ICD10-DSM5','Z62.812','Personal history (past history) of neglect in childhood','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10901,'ICD10-DSM5','Z62.820 ','Parent-child relational problem','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10902,'ICD10-DSM5','Z63.0','Relationship distress with spouse or intimate partner','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10903,'ICD10-DSM5','Z63.4','Uncomplicated bereavement','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10904,'ICD10-DSM5','Z63.5','Disruption of family by separation or divorce','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10905,'ICD10-DSM5','Z63.8','High expressed emotion level within family','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10906,'ICD10-DSM5','Z64.0','Problems related to unwanted pregnancy','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10907,'ICD10-DSM5','Z64.1','Problems related to multiparity','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10908,'ICD10-DSM5','Z64.4','Discord with social service provider, including probation officer, case manager, social services worker','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10909,'ICD10-DSM5','Z65.0','Conviction in civil or criminal proceedings without imprisonment','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10910,'ICD10-DSM5','Z65.1','Imprisonment or other incarceration','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10911,'ICD10-DSM5','Z65.2','Problems related to release from prison','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10912,'ICD10-DSM5','Z65.3','Problems related to other legal circumstances','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10913,'ICD10-DSM5','Z65.4','Victim of crime','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10914,'ICD10-DSM5','Z65.4','Victim of terrorism or torture','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10915,'ICD10-DSM5','Z65.5','Exposure to disaster, war, or other hostilities','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10916,'ICD10-DSM5','Z65.8','Religious or spiritual problem','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10917,'ICD10-DSM5','Z65.8','Other problem related to psychosocial circumstances','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10918,'ICD10-DSM5','Z65.9','Unspecified problem related to unspecified psychosocial circumstances','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10919,'ICD10-DSM5','Z69.011','Encounter for mental health services for perpetrator of parental child abuse','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10920,'ICD10-DSM5','Z69.011','Encounter for mental health services for perpetrator of parental child neglect','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10921,'ICD10-DSM5','Z69.011','Encounter for mental health services for perpetrator of parental child sexual abuse','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10922,'ICD10-DSM5','Z69.011','Encounter for mental health services for perpetrator of parental child psychological abuse','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10923,'ICD10-DSM5','Z69.021','Encounter for mental health services for perpetrator of nonparental child abuse','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10924,'ICD10-DSM5','Z69.021','Encounter for mental health services for perpetrator of nonparental child sexual abuse','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10925,'ICD10-DSM5','Z69.021','Encounter for mental health services for perpetrator of nonparental child neglect','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10926,'ICD10-DSM5','Z69.021','Encounter for mental health services for perpetrator of nonparental child psychological abuse','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10927,'ICD10-DSM5','Z69.11','Encounter for mental health services for victim of spouse or partner violence, physical','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10928,'ICD10-DSM5','Z69.11','Encounter for mental health services for victim of spouse or partner neglect','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10929,'ICD10-DSM5','Z69.11','Encounter for mental health services for victim of spouse or partner psychological abuse','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10930,'ICD10-DSM5','Z69.12','Encounter for mental health services for perpetrator of spouse or partner violence, physical','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10931,'ICD10-DSM5','Z69.12','Encounter for mental health services for perpetrator of spouse or partner violence, sexual','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10932,'ICD10-DSM5','Z69.12','Encounter for mental health services for perpetrator of spouse or partner neglect','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10933,'ICD10-DSM5','Z69.12','Encounter for mental health services for perpetrator of spouse or partner psychological abuse','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10934,'ICD10-DSM5','Z69.81','Encounter for mental health services for victim of spouse or partner violence, sexual ','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10935,'ICD10-DSM5','Z69.81','Encounter for mental health services for victim of nonspousal adult abuse ','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10936,'ICD10-DSM5','Z69.82','Encounter for mental health services for perpetrator of nonspousal adult abuse','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10937,'ICD10-DSM5','Z70.9','Sex counseling','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10938,'ICD10-DSM5','Z71.9','Other counseling or consultation','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10939,'ICD10-DSM5','Z72.0','Tobacco use disorder, mild','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10940,'ICD10-DSM5','Z72.811','Adult antisocial behavior','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10941,'ICD10-DSM5','Z72.9','Problem related to lifestyle','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10942,'ICD10-DSM5','Z75.3','Unavailability or inaccessibility of health care facilities','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10943,'ICD10-DSM5','Z75.4','Unavailability or inaccessibility of other helping agencies','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10944,'ICD10-DSM5','Z76.5','Malingering','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10945,'ICD10-DSM5','Z91.19','Nonadherence to medical treatment','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10946,'ICD10-DSM5','Z91.410','Personal history (past history) of spouse or partner violence, physical','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10947,'ICD10-DSM5','Z91.410','Personal history (past history) of spouse or partner violence, sexual','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10948,'ICD10-DSM5','Z91.411','Personal history (past history) of spouse or partner psychological abuse','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10949,'ICD10-DSM5','Z91.412','Personal history (past history) of spouse or partner neglect','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10950,'ICD10-DSM5','Z91.49','Other personal history of psychological trauma','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10951,'ICD10-DSM5','Z91.5','Personal history of self-harm','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10952,'ICD10-DSM5','Z91.82','Personal history of military deployment','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10953,'ICD10-DSM5','Z91.83','Wandering associated with a mental disorder','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
INSERT INTO [dbo].[tlkpICD_DX_Codes]([MasterDXId],[Version],[ICDCode],[DSMDesc],[ICDDesc],
[Disabled],[DateEntered]) VALUES (10954,'ICD10-DSM5','Z91.89','Other personal risk factors','No corresponding ICD-10 description for this DSM-5 diagnosis',null,'Aug 18 2020  7:58AM')
SET IDENTITY_INSERT dbo.[tlkpICD_DX_Codes] OFF
GO
ALTER TABLE [dbo].[tlkpDsmQAMap]
   ADD CONSTRAINT [FK_dbo.DsmQAMap_dbo.ICD_DX_Codes_lkup_MasterDXId] FOREIGN KEY ([MasterDXId])
      REFERENCES [dbo].[tlkpICD_DX_Codes] ([MasterDXId])
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
--==================================================================
--tlkpCaseMCASRAnwser
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[Explanation],[DateCreated],[DateDisabled]) 
--        VALUES (' + Convert(Varchar,Id) + ',' + Convert(varchar,QuestionId) + ',' + Convert(varchar, ScaleAnwserId) + ',''' + Anwser + ''',''' +
--		 Convert(varchar, DateCreated) + ''',' + 
-- (CASE WHEN DateDisabled IS NULL THEN 'null' ELSE '''' + Convert(varchar, DateDisabled) + '''' END) + ')' FROM dbo.[tlkpCaseMCASRAnwser]
 --SELECT * FROM dbo.[tlkpCaseMCASRAnwser]
--==================================================================
/****** Object:  Table [dbo].[tlkpCaseMCASRAnwser]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCaseMCASRAnwser' AND Type = N'U')
  DROP TABLE dbo.tlkpCaseMCASRAnwser
GO
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCaseMCASRQuestion' AND Type = N'U')
  DROP TABLE dbo.tlkpCaseMCASRQuestion
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpCaseMCASRAnwser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[ScaleAnwserId] [int] NOT NULL,
	[Anwser] [nvarchar](90) NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateDisabled] [datetime] NULL,
 CONSTRAINT [PK_dbo.tlkpCaseMCASRAnwser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpCaseMCASRAnwser] ON
GO
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (1,1,1,'Extreme health impairment','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (2,1,2,'Marked health impairment','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (3,1,3,'Moderate health impairment','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (4,1,4,'Slight health impairment','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (5,1,5,'No health impairment','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (6,2,1,'Extremely low intellectual functioning','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (7,2,2,'Moderately low intellectual functioning','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (8,2,3,'Low intellectual functioning','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (9,2,4,'Slightly low intellectual functioning','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (10,2,5,'Normal or above level of intellectual functioning','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (11,3,1,'Extremely low intellectual functioning','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (12,3,2,'Moderately low intellectual functioning','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (13,3,3,'Low intellectual functioning','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (14,3,4,'Slightly low intellectual functioning','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (15,3,5,'Normal or above level of intellectual functioning','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (16,4,1,'Extremely abnormal mood','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (17,4,2,'Markedly abnormal mood','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (18,4,3,'Moderately abnormal mood','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (19,4,4,'Slightly abnormal mood','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (20,4,5,'No impairment, normal mood','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (21,5,1,'Extremely impaired response','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (22,5,2,'Markedly impaired response','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (23,5,3,'Moderately impaired response','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (24,5,4,'Slightly impaired response','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (25,5,5,'Normal response','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (26,6,1,'Almost never manages money successfully','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (27,6,2,'Seldom manages money successfully','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (28,6,3,'Sometimes manages money successfully','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (29,6,4,'Manages money successfully a fair amount of the time ','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (30,6,5,'Almost always manages money successfully','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (31,7,1,'Almost never performs independently','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (32,7,2,'Often does not perform independently','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (33,7,3,'Sometimes performs independently','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (34,7,4,'Often performs independently','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (35,7,5,'Almost always performs independently','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (36,8,1,'Almost never accepts disability','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (37,8,2,'Seldom accepts disability','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (38,8,3,'Sometimes accepts disability','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (39,8,4,'Accepts disability a fair amount of the time','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (40,8,5,'Almost always accepts disability','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (41,9,1,'Very negative','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (42,9,2,'Fairly negative','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (43,9,3,'Mixed, mildly negative to mildly positive','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (44,9,4,'Fairly positive','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (45,9,5,'Very positive','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (46,10,1,'Very infrequently','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (47,10,2,'Fairly infrequently','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (48,10,3,'Occasionally','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (49,10,4,'Fairly frequently','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (50,10,5,'Very frequently','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (51,11,1,'Very ineffectively','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (52,11,2,'Ineffectively','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (53,11,3,'Mixed or dubious effectiveness','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (54,11,4,'Effective','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (55,11,5,'Very effective','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (56,12,1,'Very limited network','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (57,12,2,'Limited network','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (58,12,3,'Moderately extensive network','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (59,12,4,'Extensive network','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (60,12,5,'Very extensive network','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (61,13,1,'Almost never involved','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (62,13,2,'Seldom involved','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (63,13,3,'Sometimes involved','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (64,13,4,'Often involved','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (65,13,5,'Almost always involved','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (66,14,1,'Almost never complies','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (67,14,2,'Infrequently complies','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (68,14,3,'Sometimes complies','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (69,14,4,'Usually complies','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (70,14,5,'Almost always complies','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (71,15,1,'Almost never cooperates','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (72,15,2,'Infrequently cooperates','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (73,15,3,'Sometimes cooperates','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (74,15,4,'Usually cooperates','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (75,15,5,'Almost always cooperates','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (76,16,1,'Frequently abuses','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (77,16,2,'Often abuses','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (78,16,3,'Sometimes abuses','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (79,16,4,'Infrequently abuses','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (80,16,5,'Almost never','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (81,17,1,'Frequently acts out','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (82,17,2,'Acts out fairly often','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (83,17,3,'Sometimes acts out','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (84,17,4,'Infrequently acts out','Feb 26 2019  9:36AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRAnwser]([Id],[QuestionId],[ScaleAnwserId],[Anwser],[DateCreated],[DateDisabled]) 
        VALUES (85,17,5,'Almost never acts out','Feb 26 2019  9:36AM',null)
SET IDENTITY_INSERT dbo.[tlkpCaseMCASRAnwser] OFF
GO
--==================================================================
--tlkpCaseMCASRQuestion
--run this query to grib all data from exist prod database
--SELECT 'INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
--        VALUES (' + Convert(Varchar,QuestionId) + ',' + Convert(varchar,SectionId) + ',''' + Question + ''',''' + Explanation + ''',''' + 
--  Convert(varchar, DateCreated) + ''',' + 
-- (CASE WHEN DateDisabled IS NULL THEN 'null' ELSE '''' + Convert(varchar, DateDisabled) + '''' END) + ')' FROM dbo.[tlkpCaseMCASRQuestion]
 --SELECT * FROM dbo.[tlkpCaseMCASRQuestion]
--==================================================================
/****** Object:  Table [dbo].[tlkpCaseMCASRQuestion]    Script Date: 8/17/2020 9:11:29 AM ******/
IF EXISTS(SELECT 1 FROM sys.Tables WHERE  Name = N'tlkpCaseMCASRQuestion' AND Type = N'U')
  DROP TABLE dbo.tlkpCaseMCASRQuestion
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlkpCaseMCASRQuestion](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[SectionId] [int] NOT NULL,
	[Question] [nvarchar](50) NULL,
	[Explanation] [nvarchar](500) NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateDisabled] [datetime] NULL,
 CONSTRAINT [PK_dbo.tlkpCaseMCASRQuestion] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.[tlkpCaseMCASRQuestion] ON
GO
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (1,1,'Physical Health','How impaired is the client by his/her physical health status? &nbsp;<i>NOTE:</i>&nbsp;  Impairment may be from chronic health problems and/or frequency and severity of acute illnesses. 
 ','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (2,1,'Intellectual  Functioning','What is the client’s level of general intellectual function? &nbsp;<i>NOTE:</i>&nbsp; Low intellectual functioning may be due to a variety of reasons. It should be distinguished from impaired cognitive processes due to psychotic symptoms, which are covered in later questions.  Rate estimated IQ independent of psychotic symptoms. ','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (3,1,'Thought  Processes','How  impaired  is  the  client''s  thought  processes  as evidenced by such symptoms as hallucinations, delusions, tangentiality, loose associations, response latencies, ambivalence, incoherence, etc. 
','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (4,1,'Mood Abnormality','How abnormal is the client’s mood as evidenced by such symptoms as constricted mood, extreme mood swings, depression, rage, mania, etc.?  &nbsp;<i>NOTE:</i>&nbsp;  Abnormality in this area may include any of the following: range of moods, level of mood, and/or appropriateness of mood. 
','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (5,1,'Response to Stress and Anxiety','How impaired is the client by inappropriate and/or dysfunctional responses to stress and anxiety?  &nbsp;<i>NOTE:</i>&nbsp;  Impairment could due to inappropriate responses to stressful events (e.g. extreme responses or no response to events that should be of concern) and/or difficulty in handling anxiety as evidenced by agitations, perseveration, inability to problem solve, etc. ','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (6,2,'Adjustment to Living','How successfully does the client manage his/her money and control expenditures? ','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (7,2,'Independence in Daily Life','How well does the client perform independently in day-today living? &nbsp;<i>NOTE:</i>&nbsp; Performance includes personal hygiene, dressing appropriately, obtaining regular nutrition, and housekeeping.','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (8,2,'Acceptance of Illness','How well does the client accept (as opposed to deny) his/her psychiatric disability? ','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (9,3,'Social Acceptability','In general, what are other people''s reactions to the client?','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (10,3,'Social Interest','How frequently does the client initiate social contact or respond to others’ initiation of social contact?','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (11,3,'Social Effectiveness','How effectively does the client interact with others? &nbsp;<i>NOTE:</i>&nbsp; “Effectively” refers to how successfully and appropriately the client behaves in social settings, i.e.: how well he/she minimizes interpersonal friction, meets personal needs, achieves personal goals in a socially appropriate manner, etc. ','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (12,3,'Social  Network','How  extensive  is  the  client''s  social  support  network? &nbsp;<i>NOTE:</i>&nbsp;  a support network may consist of interested family, friends, acquaintances, professionals, coworkers, socialization programs, etc.  &nbsp;<i>NOTE:</i>&nbsp; Rate the size of the network, not the social acceptability. ','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (13,3,'Meaningful Activity','How frequently is the client involved in meaningful activities that are satisfying him/her? &nbsp;<i>NOTE:</i>&nbsp; Meaningful activities might include arts and crafts, reading, going to a movie, etc.','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (14,4,'Medication Compliance','How frequently does the client comply with his/her prescribed medication regimen?  &nbsp;<i>NOTE:</i>&nbsp; This question does not relate to how much those medications help the client. ','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (15,4,'Cooperation with Treatment Providers','How frequently does the client cooperate as demonstrated by, for example, keeping appointments, complying with treatment plans, and following through on reasonable requests? ','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (16,4,'Alcohol/Drug Abuse','How frequently does the client abuse drugs and/or alcohol?  &nbsp;<i>NOTE:</i>&nbsp; “abuse” means use to the extent that it interferes with functioning.','Feb 26 2019  9:35AM',null)
INSERT INTO [dbo].[tlkpCaseMCASRQuestion]([QuestionId],[SectionId],[Question],[Explanation],[DateCreated],[DateDisabled]) 
        VALUES (17,4,'Impulse Control','How frequently does the client exhibit episodes of extreme acting out?  &nbsp;<i>NOTE:</i>&nbsp; “Acting out” refers to such behavior as temper outbursts, spending sprees, aggressive actions, suicidal gestures, inappropriate sexual acts, etc. ','Feb 26 2019  9:35AM',null)
SET IDENTITY_INSERT dbo.[tlkpCaseMCASRQuestion] OFF
GO
ALTER TABLE [dbo].[tlkpCaseMCASRAnwser]
   ADD CONSTRAINT [FK_dbo.CaseMCASRAnwser_dbo.CaseMCASRQuestion_QuestionId] FOREIGN KEY ([QuestionId])
      REFERENCES [dbo].[tlkpCaseMCASRQuestion] ([QuestionId])
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO