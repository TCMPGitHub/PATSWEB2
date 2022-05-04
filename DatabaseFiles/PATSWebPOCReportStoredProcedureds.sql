--============================================================================
--PATSWeb POC Report SP (Created at 08/19/2020)
--============================================================================
USE [PatsWebTest]
GO
--============================================================================
--spRptOPCS_Appointments
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_Appointments]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_Appointments]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_Appointments]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_Appointments] 
	-- Add the parameters for the stored procedure here
	@EpisodeID int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT t1.StartDate, t1.EndDate, (select [dbo].[fnGetApptTypeDesc](t1.TypeID))AppointmentType,
	   (SELECT [dbo].[fnGetlocationDesc](t1.LocationId))[LocationDesc], 
	   (select [dbo].[fnGetApptStatusDesc](t1.StatusID))ApptLongDesc, 
	   (select [dbo].[fnCaseWorkerTypeDesc](t3.StaffID))CaseWorkerTypeDesc,
	   (SELECT name FROM [dbo].[fn_GetUserName](t3.StaffID)) CaseWorker,
	   t2.EpisodeID
	
 FROM (SELECT AppointmentID,StartDate, EndDate, TypeID, StatusID, ActionStatus, LocationID,
	          ROW_NUMBER() OVER (PARTITION BY AppointmentTraceID ORDER BY AppointmentID DESC) AS nRowNum  
		 FROM Appointment) t1 
    INNER JOIN dbo.AppointmentWithClient t2 on t1.AppointmentID = t2.AppointmentID
	INNER JOIN dbo.AppointmentWithStaff t3 on t1.AppointmentID = t3.AppointmentID
	WHERE t1.nRowNum = 1 and t1.ActionStatus <> 10 AND t2.EpisodeID =@EpisodeID
Order BY t1.StartDate DESC
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_Appointments] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_Appointments] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spRptOPCS_CaseNotes
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_CaseNotes]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_CaseNotes]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_CaseNotes]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_CaseNotes] 
	-- Add the parameters for the stored procedure here
	@EpisodeID int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	  SELECT t.[Id],(SELECT [dbo].[fnGetCaseNoteTypeDesc](ISNULL(t.[CaseNoteTypeId], 0)))CaseNoteType
	  ,(SELECT [dbo].[fnGetCaseContactMethodDesc](ISNULL(t.[CaseContactMethodId], 0)))ContactMethod,t.[Note],t.[DateAction]
	  ,(t1.LastName + ', '+t1.FirstName) CaseWorker
  FROM  (SELECT [Id],[CaseNoteId],[EpisodeID],[CaseNoteTypeId],[CaseContactMethodId],[Note]
             ,ActionStatus,[DateAction], ActionBy
	         ,ROW_NUMBER() OVER (PARTITION BY EpisodeID, CaseNoteID ORDER BY ID DESC) AS nRowNum 
          FROM CaseNote Where ActionStatus <> 10 AND [EpisodeID] = @EpisodeID) t 
		  INNER JOIN [User] t1 ON t1.UserID=t.ActionBy
	 where t.nRowNum=1 
ORDER BY t.[DateAction]DESC
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_Appointments] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_Appointments] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spRptOPCS_DSM
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_DSM]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_DSM]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_DSM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_DSM] 
	-- Add the parameters for the stored procedure here
	@EpisodeID int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT t1.[Id]
      ,[DsmId]
      ,t1.[MasterDXId]
      ,[DsmTypeId]
      ,[DsmSpecifierId]
      ,[Note]
      ,t1.[ActionBy]
      ,t1.[ActionStatus]
      ,t1.[DateAction]
	  ,t3.[DSMDesc]
	  ,(SELECT Name FROM fn_GetUserName(t2.[ActionBy]))[CaseWorker]
  FROM [dbo].[DsmDiagnosis] t1 inner join [dbo].[Dsm] t2 on t1.DsmId=t2.Id inner join [dbo].[tlkpICD_DX_Codes] t3 on t1.MasterDXId=t3.MasterDXId
  where t2.EpisodeId=@EpisodeID
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_DSM] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_DSM] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spRptOPCS_EpisodeID
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_EpisodeID]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_EpisodeID]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_EpisodeID]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_EpisodeID]  
	-- Add the parameters for the stored procedure here
	@CDCRNum VARCHAR(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select EpisodeID From [dbo].[Episode] Where CDCRNum = @CDCRNum
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_EpisodeID] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_EpisodeID] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptOPCS_Evaluation
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_Evaluation]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_Evaluation]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_Evaluation]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_Evaluation] 
	-- Add the parameters for the stored procedure here
	@EpisodeID int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [ID],[EpisodeID],(SELECT [dbo].[fnGetEvaluationItemDesc](EvaluationItemId))EvaluationItemDescr,
       [EvaluationNote], [DateAction], (SELECT Name FROM fn_GetUserName([EvaluatedBy]))[CaseWorker]
  FROM dbo.EpisodeEvaluation WHERE [EpisodeID] =  @EpisodeID and DateAction 
     =(SELECT MAX(DateAction) FROM dbo.EpisodeEvaluation WHERE [EpisodeID] =  @EpisodeID)
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_Evaluation] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_Evaluation] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptOPCS_IDTTCase
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_IDTTCase]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_IDTTCase]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_IDTTCase]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_IDTTCase] 
	@EpisodeID int = 0
AS
BEGIN
	SET NOCOUNT ON;
SELECT [Id] ,[EpisodeID],[ProgramPhase] ,[ProgramTTStatus] ,[IDTTMeetingType]
      ,[MemeberAttendance] ,[NarrativeOfProgress] ,[RecommandationForPPS]
      ,[IDTTDate] ,[ActionBy] ,[ActionStatus] ,[DateAction]
      ,(SELECT Name FROM fn_GetUserName([ActionBy]))[CaseWorker]
  FROM [dbo].[CaseIDTT]
  where EpisodeID=@EpisodeID
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_IDTTCase] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_IDTTCase] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptOPCS_IDTTClinical
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_IDTTClinical]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_IDTTClinical]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_IDTTClinical]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_IDTTClinical]
	@EpisodeID int = 0
AS
BEGIN
	SET NOCOUNT ON;

    SELECT t1.[Id]
      ,[EpisodeId]
      ,[MemeberAttendance]
      ,[OtherMemeberAttendance]
      ,[RecommandationForStatus]
      ,[IDTTDecision]
      ,[IDTTDate]
      ,t1.[ActionBy]
      ,[ActionStatus]
      ,t1.[DateAction]
	  ,t2.FinalRecommendation
	  ,(SELECT Name FROM fn_GetUserName(t1.[ActionBy]))[CaseWorker]
  FROM [dbo].[ClinicalIDTT] t1 inner join [dbo].[tlkpFinalRecommendation] t2 on t1.IDTTDecision=t2.id
  where EpisodeID=@EpisodeID
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_IDTTClinical] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_IDTTClinical] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptOPCS_NextAppointment
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_NextAppointment]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_NextAppointment]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_NextAppointment]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_NextAppointment]  
	@EpisodeID int = 0
AS
BEGIN
	SET NOCOUNT ON;

    SELECT top 1 t1.StartDate, t1.EndDate, (select [dbo].[fnGetApptTypeDesc](t1.TypeID))AppointmentType,
	   (SELECT [dbo].[fnGetlocationDesc](t1.LocationId))[LocationDesc], 
	   (select [dbo].[fnGetApptStatusDesc](t1.StatusID))ApptLongDesc, 
	   (select [dbo].[fnCaseWorkerTypeDesc](t3.StaffID))CaseWorkerTypeDesc,
	   (SELECT name FROM [dbo].[fn_GetUserName](t3.StaffID)) CaseWorker,
	   t2.EpisodeID	
 FROM (SELECT AppointmentID,StartDate, EndDate, TypeID, StatusID, ActionStatus, LocationID,
	          ROW_NUMBER() OVER (PARTITION BY AppointmentTraceID ORDER BY AppointmentID DESC) AS nRowNum 
		 FROM Appointment) t1 
    INNER JOIN dbo.AppointmentWithClient t2 on t1.AppointmentID = t2.AppointmentID
	INNER JOIN dbo.AppointmentWithStaff t3 on t1.AppointmentID = t3.AppointmentID
	WHERE t1.nRowNum = 1 and t1.ActionStatus <> 10 AND t2.EpisodeID =@EpisodeID and t1.StartDate>=GetDate()
Order BY t1.StartDate
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_NextAppointment] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_NextAppointment] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptOPCS_ParoleInfo
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_ParoleInfo]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_ParoleInfo]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_ParoleInfo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_ParoleInfo] 
	@EpisodeID int = 0
AS
BEGIN
	SET NOCOUNT ON;

SELECT [EpisodeID],[ParoleUnit],[ParoleAgent]
  FROM [dbo].[Episode]
  where EpisodeID=@EpisodeID
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_ParoleInfo] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_ParoleInfo] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptOPCS_Rx
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_Rx]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_Rx]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_Rx]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_Rx] 
	@CDCRNum VARCHAR(20) = null
AS
BEGIN
	SET NOCOUNT ON;

    SELECT t2.PrescriptionDate,
		t5.CaseWorkerName,
		t4.GenericName,
		t4.BrandName,
		t3.DosageValue,
		t3.DosageUOM,
		t3.NumberOfUnits,
		t3.Directions,
		t3.NumberOfRefills
	FROM tcmp_poc.dbo.tblClientEpisode t1
	INNER JOIN tcmp_poc.dbo.tblEpisodePsychMedRx t2
	ON t1.ClientEpisodeGUID = t2.ClientEpisodeGUID
	INNER JOIN tcmp_poc.dbo.tblEpisodePsychMedRxDrug t3
	ON t2.EpisodePsychMedRxGUID = t3.EpisodePsychMedRxGUID
	INNER JOIN tcmp_poc.dbo.tlkpPsychiatricMedication t4
	ON t3.PsychiatricMedicationGUID = t4.PsychiatricMedicationGUID
	INNER JOIN tcmp_poc.dbo.tlkpCaseWorker t5
	ON t2.CaseWorkerGUID = t5.CaseWorkerGUID
	WHERE t1.CDCNo = @CDCRNum
	AND t2.PrescriptionDate IN (SELECT TOP 3 s2.PrescriptionDate
		FROM tcmp_poc.dbo.tblClientEpisode s1
		INNER JOIN tcmp_poc.dbo.tblEpisodePsychMedRx s2
		ON s1.ClientEpisodeGUID = s2.ClientEpisodeGUID
		WHERE s1.CDCNo = @CDCRNum
		ORDER BY s2.PrescriptionDate DESC)
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_Rx] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_Rx] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptOPCS_SuicidalIdeation
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_SuicidalIdeation]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_SuicidalIdeation]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_SuicidalIdeation]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_SuicidalIdeation]  
	-- Add the parameters for the stored procedure here
	@EpisodeID int = 0
AS
BEGIN
	SET NOCOUNT ON;

    SELECT Top 1 [Id]
      ,[PrevSuicideAttempts]     
      ,[SuicidalIdeation]
      ,[SuicidalPlan]
      ,[SuicidalIntent]
      ,[DateAction]
  FROM [dbo].[PsychiatryASMT]
  where EpisodeId=@EpisodeID
  Order by [Id] Desc
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_SuicidalIdeation] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_SuicidalIdeation] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptOPCS_SuicidealIdeation2
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_SuicidealIdeation2]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_SuicidealIdeation2]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_SuicidealIdeation2]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_SuicidealIdeation2] 
	-- Add the parameters for the stored procedure here
	@CDCRNum VARCHAR(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		SELECT  TOP 1 t2.CDCNo,
		t1.LName,
		t1.FName,
		t3.PastSuicidalIdeationDate,
		t3.SuicidalBehaviorHx
	FROM tcmp_poc.dbo.tblClient t1
	INNER JOIN tcmp_poc.dbo.tblClientEpisode t2
	ON t1.ClientGUID = t2.ClientGUID
	INNER JOIN tcmp_poc.dbo.tblEpisodeMentalHealthAssessment t3
	ON t2.ClientEpisodeGUID = t3.ClientEpisodeGUID
	WHERE t2.CDCNo = @CDCRNum
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_SuicidealIdeation2] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_SuicidealIdeation2] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptOPCS_Summary
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptOPCS_Summary]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptOPCS_Summary]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptOPCS_Summary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptOPCS_Summary]  
	@EpisodeID int = 0
AS
BEGIN
	SET NOCOUNT ON;

    SELECT t2.EpisodeID , t2.CDCRNum, (Select name from fn_GetClientName(t2.EpisodeID)) ClientName
	  ,t1.[IntakeDate],t1.ParoleDischargeDate, t4.Name CountyOfParole
	  ,(CASE WHEN t4.Region='N' THEN 'Northern' WHEN t4.Region='S' THEN 'Southern' ELSE '' END) ParoleRegion
	  ,t2.ReleaseDate EPRD, t3.DOB, t1.PlaceOfBirth ,t3.PC457 ,t3.PC290 ,t1.Alias
	  ,(SELECT [dbo].[fnGetEthnicityDesc](ISNULL(t1.EthnicityID, 0)))EthnicityDesc
	  ,t1.CaseClosureDate,t5.Name Gender,t1.CaseBankedDate,t3.USVet 
	  ,(SELECT [dbo].[fnGetMHStatusDesc](ISNULL(t1.ClientEpisodeID, 0), t2.EpisodeID))MI_Class	  
	  ,(SELECT [dbo].[fnGetCaseClosureReasonDesc](ISNULL(t1.CaseClosureReasonCode, '')))CaseClosureReasonDesc 
	  ,(SELECT [dbo].[fnGetSignificantOtherStatusDesc](ISNULL(t1.SignificantOtherStatusCode, '')))SignificantOtherStatusDesc, t1.IsConvictedOfStalking Stalker
  FROM (SELECT * FROM Episode WHERE EpisodeID = @EpisodeID) t2 INNER JOIN [Offender] t3 ON t2.OffenderID=t3.OffenderID  
  LEFT OUTER JOIN 
  (SELECT ClientEpisodeID, EpisodeID, ParoleMentalHealthLevelOfServiceID,CaseBankedDate, PlaceOfBirth, EthnicityID, CaseClosureDate,SignificantOtherStatusCode,IntakeDate, Alias, IsConvictedOfStalking, ParoleDischargeDate, CaseClosureReasonCode FROM 
      (SELECT ClientEpisodeID, EpisodeID,ParoleMentalHealthLevelOfServiceID,CaseBankedDate, PlaceOfBirth, EthnicityID, CaseClosureDate, SignificantOtherStatusCode,IntakeDate, Alias, IsConvictedOfStalking,
	  ParoleDischargeDate,CaseClosureReasonCode, ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY ClientEpisodeID DESC) AS nRowNum FROM ClientEpisode Where EpisodeID = @EpisodeID) sub WHERE sub.nRowNum = 1) t1 
   ON t1.EpisodeID  =  t2.EpisodeID
   LEFT OUTER JOIN dbo.tlkpCounty t4 on t4.CountyID = t2.ReleaseCountyID
   LEFT OUTER JOIN tlkpGender t5 ON t3.GenderID=t5.GenderID
  WHERE t2.EpisodeID=@EpisodeID
END
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_Summary] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptOPCS_Summary] to [ACCOUNTS\Svc_CDCRPATSUser]
GO