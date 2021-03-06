--======================================================================
/* All Table-valued Functions -- 08/14/2020 */
--======================================================================
USE [PATSWebV2Test]
GO
--======================================================================
--fnGetRptApptFollowup
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetRptApptFollowup]    Script Date: 6/14/2022 12:10:49 PM ******/
IF EXISTS (SELECT * FROM sys.objects  WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetRptApptFollowup]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[fnGetRptApptFollowup]
GO
CREATE FUNCTION [dbo].[fnGetRptApptFollowup] 
(
    @AppointmentID int,
	@StartDate DateTime, 
	@EpisodeID int,
	@StaffID int = 0
)
RETURNS nvarchar(4000)
AS
BEGIN
	DECLARE @followupString nvarchar(100)
	SET  @followupString = (SELECT Top 1 (CASE WHEN StartDate IS NULL THEN '' ELSE FORMAT(StartDate, 'MM-dd-yyyy hh:mm tt') END)
  FROM Appointment a1
	   INNER JOIN AppointmentTrace a2 on a1.AppointmentID = a2.AppointmentID 
	   INNER JOIN AppointmentWithStaff a3 on a1.AppointmentID = a3.AppointmentID 
	   INNER JOIN AppointmentWithClient a4 on a1.AppointmentID = a4.AppointmentID 
  Where DateDiff(HOUR,a1.StartDate, @StartDate)< 0 AND StaffID = @StaffID AND EpisodeID = @EpisodeID 
        AND a1.ActionStatus <> 10
  Order By StartDate ASC)
	
   If @followupString IS NULL SET @followupString = ''
	RETURN @followupString
END
GO
--======================================================================
--fn_GetAppointmentByDate
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fn_GetAppointmentByDate]    Script Date: 8/14/2020 12:10:49 PM ******/
IF EXISTS (SELECT * FROM sys.objects  WHERE  object_id = OBJECT_ID(N'[dbo].[fn_GetAppointmentByDate]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[fn_GetAppointmentByDate]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetAppointmentByDate](@StartDate DateTime,@EndDate DateTime )
RETURNS @AppointmentTable TABLE
(
       [AppointmentID] int
      ,[AppointmentTraceID] int
      ,[TypeID] int
      ,[StatusID] int
      ,[LocationId] int
      ,[IsAllDay] bit
      ,[IsCompleted] bit
      ,[StartDate] DateTime
      ,[EndDate] DateTime
      ,[ADAECIDs] nvarchar(100)
      ,[Note] nvarchar(1000)
      ,[ActionStatus] int
      ,[ActionBy] int
      ,[DateAction] DateTime
) 
AS
BEGIN 
  declare @start DateTime = Convert(DateTime, CONVERT(VARCHAR(10), @StartDate, 111) + ' 00:00')
  declare @end DateTime
  IF @EndDate IS NULL OR @StartDate = @EndDate OR Convert(Date, @StartDate) = Convert(Date, @EndDate) 
	 SET @end = Convert(DateTime, CONVERT(VARCHAR(10), @StartDate, 111) + ' 23:00')
  ELSE 
     SET @end = Convert(DateTime, CONVERT(VARCHAR(10), @EndDate, 111) + ' 23:00')
  --ELSE
	 --SET @end = dateAdd(hour, 24, Convert(DateTime, CONVERT(VARCHAR(10), @EndDate, 111) + ' 24:00'))
   
     INSERT INTO @AppointmentTable
        SELECT [AppointmentID], [AppointmentTraceID], [TypeID], [StatusID],[LocationId],[IsAllDay] ,[IsCompleted] ,[StartDate],
               [EndDate],[ADAECIDs] ,[Note] ,[ActionStatus] ,[ActionBy] ,[DateAction]
         FROM 
		 (SELECT [AppointmentID], [AppointmentTraceID], [TypeID], [StatusID],[LocationId],[IsAllDay] ,[IsCompleted] ,[StartDate],
               [EndDate],[ADAECIDs] ,[Note] ,[ActionStatus] ,[ActionBy],[DateAction], 
			   ROW_NUMBER() OVER (PARTITION BY AppointmentTraceID ORDER BY AppointmentID DESC) AS RowNum 
		    FROM [dbo].[Appointment] WHERE [StartDate] >= @start and [EndDate] <= @end) T WHERE T.RowNum =1
	
	RETURN
END
GO
--======================================================================
--fn_GetAsstUserName
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fn_GetAsstUserName]    Script Date: 8/14/2020 12:21:04 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fn_GetAsstUserName]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fn_GetAsstUserName]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_GetAsstUserName](@UserId int)
RETURNS @UserTable TABLE
(
  UserID int,
  Name Varchar(40)
) 
AS
BEGIN 

    IF (@UserID = 0)
	BEGIN
	  
    INSERT INTO @UserTable
    SELECT 0, ''
	
	END
	ELSE
	BEGIN
     INSERT INTO @UserTable
       SELECT @UserID,  Concat(LastName, ', ', SUBSTRING(FirstName, 1, 1), '.')
          FROM dbo.[User]
         WHERE UserID = @UserID		
	END
	RETURN
END
GO
--======================================================================
--fn_GetClientName
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fn_GetClientName]    Script Date: 8/14/2020 12:24:38 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fn_GetClientName]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fn_GetClientName]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetClientName](@EpisodeID int)
RETURNS @OffenderTable TABLE
(
  EpisodeID int,
  Name Varchar(120)
) 
AS
BEGIN 

    IF (@EpisodeID = 0)
	BEGIN
	  
    INSERT INTO @OffenderTable
    SELECT 0, ''
	
	END
	ELSE
	BEGIN
     INSERT INTO @OffenderTable
        SELECT @EpisodeID ,  RTRIM(LTRIM(B.LastName + ', ' +  B.FirstName  + ' ' + ISNULL(B.MiddleName, '')))
          FROM dbo.[Episode] A INNER JOIN dbo.[Offender] B ON A.OffenderID = B.OffenderID
         WHERE EpisodeID = @EpisodeID

		
	END
	RETURN
END
GO
--======================================================================
--fn_GetLatestClientEpisode
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fn_GetLatestClientEpisode]    Script Date: 8/14/2020 12:26:02 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fn_GetLatestClientEpisode]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fn_GetLatestClientEpisode]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetLatestClientEpisode](@EpisodeID int)
RETURNS @ClientEpisodeTable TABLE
(
    [ClientEpisodeID] [int] NOT NULL,
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
	[ActionStatus] [int] NOT NULL
) 
AS
BEGIN 
   --DECLARE @EpisodeID  int  = 771999
   DECLARE @ID int = (SELECT ClientEpisodeID FROM (
                       SELECT ClientEpisodeID, ROW_NUMBER() OVER (PARTITION BY [EpisodeID] 
			                  ORDER BY [ClientEpisodeID] DESC) AS RowNum 
			             FROM [dbo].[ClientEpisode]
			            WHERE EpisodeID =  @EpisodeID)T WHERE T.RowNum = 1)

   --SELECT MAX(ClientEpisodeID) from ClientEpisode Where EpisodeID =@EpisodeID
   --select @ID
     INSERT INTO @ClientEpisodeTable
     SELECT  [ClientEpisodeID],[EpisodeID],[Alias],[IntakeDate],[CaseBankedDate],                 [CaseReferralSourceCode],[SignificantOtherStatusCode],
	         [IsConvictedOfStalking],[ParoleMentalHealthLevelOfServiceID],
	         [ReleaseCaseTypeCode],[ParoleDischargeDate],
	         [ControllingDischargeDate],[DischargeReviewDate],
	         [CaseClosureDate],[CSRAScore],[CompasCriminogenicNeeds],
	         [AdditionalInformation],[CaseClosureReasonCode],[EthnicityID],
	         [PlaceOfBirth],[DateAction],[ActionBy],[ISMIPReferredDate],
	         [ISMIPEnrolledDate],[ISMIPClosedDate],[CMProgramStartDate],
	         [CMProgramClosedDate],[MATProgramStartDate],[MATProgramClosedDate],
	         [CMRPEStartDate],[CMRPEClosedDate],[ASAMDate],
	         [InclusionCriteriaMet],[ASAMComments],[ActionStatus]
		FROM [dbo].[ClientEpisode] WHERE ClientEpisodeID =@ID
	RETURN
END
GO
--======================================================================
--fn_GetLatestEpisodeByOffenderID
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fn_GetLatestEpisodeByOffenderID]    Script Date: 8/27/2020 10:25:17 AM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fn_GetLatestEpisodeByOffenderID]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fn_GetLatestEpisodeByOffenderID]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetLatestEpisodeByOffenderID](@OffenderID int )
RETURNS @EpisodeTable TABLE
(
	[EpisodeID] [int] NOT NULL,
	[OffenderID] [int] NOT NULL,
	[SuggestionDate] [datetime] NOT NULL,
	[ParoleLocationID] [int] NULL,
	[CDCRNum] [nchar](6) NOT NULL,
	[ReleaseDate] [date] NULL,
	[CustodyFacilityID] [int] NULL,
	[ReleaseCountyID] [int] NULL,
	[Lifer] [bit] NOT NULL,
	[ParoleUnit] [nvarchar](50) NULL,
	[ParoleAgent] [nvarchar](70) NULL
) 
AS
BEGIN 


 INSERT INTO @EpisodeTable
 SELECT [EpisodeID],[OffenderID],[SuggestionDate],[ParoleLocationID],[CDCRNum], [ReleaseDate],[CustodyFacilityID],[ReleaseCountyID],[Lifer],[ParoleUnit],[ParoleAgent]
  FROM ( SELECT [EpisodeID],[OffenderID],[SuggestionDate],[ParoleLocationID],[CDCRNum], [ReleaseDate],[CustodyFacilityID],[ReleaseCountyID],[Lifer],[ParoleUnit],[ParoleAgent]
				, ROW_NUMBER() OVER (PARTITION BY OffenderID ORDER BY [EpisodeID] DESC) AS RowNum 
		  FROM [dbo].[Episode] 
		 WHERE OffenderID  = @OffenderID) T 
 WHERE T.RowNum = 1 
	
	RETURN
END
GO
--======================================================================
--fn_GetUserName
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserName]    Script Date: 8/14/2020 12:28:25 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fn_GetUserName]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fn_GetUserName]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetUserName](@UserID int)
RETURNS @AssignTable TABLE
(
  UserID int,
  Name Varchar(70)
) 
AS
BEGIN 

    IF (@UserID = 0)
	BEGIN
	  
    INSERT INTO @AssignTable
    SELECT 0, ''
	
	END
	ELSE
	BEGIN
     INSERT INTO @AssignTable
        SELECT @UserID ,  LastName + ', ' +  FirstName  + ' ' + ISNULL(MiddleName, '')
          FROM dbo.[User]
         WHERE UserID = @UserID

		
	END
	RETURN
END
GO
--======================================================================
--fnSplitString
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnSplitString]    Script Date: 8/14/2020 12:30:07 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnSplitString]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnSplitString]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnSplitString] 
( 
    @string NVARCHAR(MAX), 
    @delimiter CHAR(1) 
) 
RETURNS @output TABLE(splitdata NVARCHAR(MAX) 
) 
BEGIN 
    DECLARE @start INT, @end INT 
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string) 
    WHILE @start < LEN(@string) + 1 BEGIN 
        IF @end = 0  
            SET @end = LEN(@string) + 1
       
        INSERT INTO @output (splitdata)  
        VALUES(SUBSTRING(@string, @start, @end - @start)) 
        SET @start = @end + 1 
        SET @end = CHARINDEX(@delimiter, @string, @start)
        
    END 
    RETURN 
END
GO
--======================================================================
--fnCaseWorkerTypeDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnCaseWorkerTypeDesc]    Script Date: 8/14/2020 12:43:50 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnCaseWorkerTypeDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnCaseWorkerTypeDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnCaseWorkerTypeDesc] 
(
	-- Add the parameters for the function here
	@Userid int
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	-- Add the T-SQL statements to compute the return value here
	IF @Userid > 0 SET @desc =(SELECT c.CaseWorkerTypeDesc FROM [dbo].[User] u INNER JOIN tlkpCaseWorkerType c on u.CaseWorkerTypeId = c.CaseWorkerTypeId WHERE UserID = @Userid)

	-- Return the result of the function
	RETURN @desc

END
GO
--======================================================================
--fnGetApptStaffNames
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetApptStaffNames]    Script Date: 8/14/2020 1:14:52 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetApptStaffNames]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetApptStaffNames]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetApptStaffNames] 
(
	-- Add the parameters for the function here
	@ApptId int
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @retdesc nvarchar(200) =''
	-- Add the T-SQL statements to compute the return value here
	IF @ApptId > 0 SET @retdesc =(SELECT(stuff(
 (
 SELECT ';' + ts.StaffName  
  FROM (SELECT (SELECT Name FROM [dbo].[fn_GetAsstUserName](a.StaffId))StaffName
             FROM (SELECT AppointmentId, StaffId 
				         FROM AppointmentWithStaff 
						WHERE AppointmentID  = @ApptId) a 
						   ) ts  
	    FOR XML PATH('') ),1,1,''))) 

	-- Return the result of the function
	RETURN @retdesc
END
GO
--======================================================================
--fnGetApptStatusDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetApptStatusDesc]    Script Date: 8/14/2020 1:18:53 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetApptStatusDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetApptStatusDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetApptStatusDesc] 
(
	@id int
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	IF @id > 0 SET @desc =(SELECT [ApptLongDescr]  FROM [dbo].[tlkpAppointmentStatus] WHERE ID = @id)

	RETURN @desc
END
GO
--======================================================================
--fnGetApptTypeDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetApptTypeDesc]    Script Date: 8/14/2020 1:21:12 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetApptTypeDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetApptTypeDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetApptTypeDesc] 
(
	@id int
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	IF @id > 0 SET @desc =(SELECT [EvtTLongDescr] FROM [dbo].[tlkpAppointmentType] WHERE ID = @id)

	RETURN @desc

END
GO
--======================================================================
--fnGetCaseClosureReasonDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetCaseClosureReasonDesc]    Script Date: 8/14/2020 1:22:55 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetCaseClosureReasonDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetCaseClosureReasonDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGetCaseClosureReasonDesc] 
(
	 @CaseClosureReasonCod varchar(1) = ''
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	IF @CaseClosureReasonCod <> ''
	     SET @desc =(SELECT CaseClosureReasonDescShort 
	              FROM [dbo].[tlkpCaseClosureReason] 
				 WHERE CaseClosureReasonCode = @CaseClosureReasonCod)

	RETURN @desc
END
GO
--======================================================================
--fnGetCaseContactMethodDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetCaseContactMethodDesc]    Script Date: 8/14/2020 1:25:08 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetCaseContactMethodDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetCaseContactMethodDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGetCaseContactMethodDesc] 
(
	@id int
)
RETURNS nvarchar(30)
AS
BEGIN
	DECLARE @desc nvarchar(30) =''
	IF @id > 0 SET @desc =(SELECT ContactMethod FROM [dbo].[tlkpCaseContactMethod] WHERE CaseContactMethodID = @id)

	RETURN @desc
END
GO
--======================================================================
--fnGetCaseNoteTypeDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetCaseNoteTypeDesc]    Script Date: 8/14/2020 1:27:37 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetCaseNoteTypeDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetCaseNoteTypeDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetCaseNoteTypeDesc] 
(
	@id int
)
RETURNS nvarchar(30)
AS
BEGIN
	DECLARE @desc nvarchar(30) =''
	IF @id > 0 SET @desc =(SELECT Name FROM [dbo].[tlkpCaseNoteType] WHERE CaseNoteTypeId = @id)

	RETURN @desc
END
GO
--======================================================================
--fnGetClientContactPhone
--======================================================================
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetClientContactPhone]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetClientContactPhone]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetClientContactPhone] 
(
	@EpisodeID int
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @phone nvarchar(25) =''
	-- Add the T-SQL statements to compute the return value here
	IF @EpisodeID > 0 AND EXISTS(SELECT 1 FROM ADDRESS WHERE EpisodeID = @EpisodeID)
      SET @phone = (SELECT ISNULl(PrimaryNumber,'') FROM
        (Select PrimaryNumber, ROW_NUMBER() OVER (PARTITION BY EpisodeID, AddressTypeID ORDER BY ID DESC) AS rownum
		   From Address WHERE EpisodeID  = @EpisodeID AND AddressTypeID = 1 )d 
	   WHERE d.rownum = 1 ) 
	RETURN @phone
END
GO
--======================================================================
--fnGetClientPreApptDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetClientPreApptDesc]    Script Date: 8/14/2020 1:29:52 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetClientPreApptDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetClientPreApptDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGetClientPreApptDesc] 
(
	@AppointmentId int = 0,
	@EpisodeId int = 0
)
RETURNS nvarchar(1000)
AS
BEGIN
	DECLARE @desc nvarchar(500) =''
	IF @AppointmentId > 0 AND @EpisodeID > 0
	BEGIN
	--DECLARE @otherAppt nvarchar(500)
	--SET @EpisodeID  = 583682
	--SET @AppointmentID  =496615
	DECLARE @start DateTime = (Select StartDate from Appointment Where AppointmentID = @AppointmentID)
	DECLARE @Staffs TABLE
	(
	   StaffID int
	) 
	INSERT INTO @Staffs
    Select StaffID from AppointmentWithStaff Where AppointmentID = @AppointmentID
	
	declare @preAppt table(
	   StartDate DateTime,
	   AppData nvarchar(100)
	)

	Insert Into  @preAppt(StartDate, AppData)
	SELECT top 3 t1.StartDate, 
	     (lower(CASE WHEN t3.ClientEventStatus = 1 THEN 'Absent'
					 WHEN t3.ClientEventStatus = 2 THEN 'Pending'
					 WHEN t3.ClientEventStatus = 3 THEN 'Present'
					 WHEN t3.ClientEventStatus = 4 THEN 'Excused' END) + ' on ' + Format(t1.StartDate, 'MM/dd/yyyy hh:mm tt')) data
		  FROM (SELECT AppointmentID, StartDate, Enddate, StatusId, TypeID, ActionStatus 
		          FROM dbo.fn_GetAppointmentByDate( DateAdd(year, -2, @start), @start)
		         WHERE ActionStatus <> 10 And StartDate < @start) t1 
		  INNER JOIN AppointmentWithStaff t2 on t1.AppointmentID = t2.AppointmentID 
		  INNER JOIN (SELECT AppointmentID, ClientEventStatus FROM AppointmentWithClient WHERE EpisodeID  = @EpisodeID) t3 on t1.AppointmentID = t3.AppointmentID 
		 Where t2.StaffID in (Select StaffID From @Staffs) 
		 order by t1.StartDate DESC

	IF (SELECT COUNT(*) FROM @preAppt) > 0
	BEGIN
		SET @desc =  'You were ' + (select
		LTRIM(stuff(
		(
			 SELECT ', ' +  AppData 
			  FROM @preAppt Order by StartDate
			   for XML Path('')
		 ),1,1,''
		)))

		if (SELECT COUNT(*) FROM @preAppt) > 1
		    Set @desc = left(@desc, len(@desc) - charindex(',', reverse(@desc) + ','))
				   + ' and ' + right(@desc, charindex(',', reverse(@desc) + ',') - 1)
	END
	END
	RETURN @desc
END
GO
--======================================================================
--fnGetClientsJsonString
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetClientsJsonString]    Script Date: 8/14/2020 1:32:53 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetClientsJsonString]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetClientsJsonString]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetClientsJsonString] 
(
	@AppointmentID int = 0,
	@StartDate DateTime,
	@StaffID int,
	@OneDay bit = 0
)
RETURNS nvarchar(4000)
AS
BEGIN
   
  DECLARE @clientsJsonString varchar(5000)=
   (select'['+ stuff((
       select ',{ "EpisodeID": "' + Convert(varchar, cl1.EpisodeID) + '", "CDCRNumber": "' + cl2.CDCRNum
		  + '","ClientName": "' + (SELECT Name FROM [dbo].[fn_GetClientName](cl1.EpisodeID))  
		  + '","AppointmentId": "'+ convert(varchar, @AppointmentID)
		  + '", "Agent": "' + ISNULl(cl2.ParoleAgent,'')
		  + '", "Unit": "' +  (CASE WHEN ISNULL(cl2.ParoleUnit, '') <> '' THEN cl2.ParoleUnit ELSE
                                   (CASE WHEN ISNULL(cl2.ParoleLocationID, 0) = 0 THEN '' ELSE (SELECT dbo.fnGetComplexDescByLocation(cl2.ParoleLocationID)) END) END)
		  + '", "FollowupAppt": ' +  (CASE WHEN (@StaffID = -1 OR @OneDay = 0) THEN '""' ELSE (SELECT dbo.fnGetApptFollowup(@AppointmentID, @StartDate, cl1.EpisodeID, @StaffID)) END)
		  + ', "ReleaseLoc": "' + convert(varchar, ISNULl(cl2.ParoleLocationID,''))
		  + '", "ClientStatus": "' + convert(varchar, (CASE cl1.StatusID WHEN 3 THEN 5 WHEN 5 THEN 4 ELSE cl1.[ClientEventStatus] END) ) 
		  + '", "ContactPh": "' + ISNULL((SELECT dbo.fnGetClientContactPhone(cl1.EpisodeID)), '') +'"}' 
		 FROM (SELECT t1.AppointmentID, t1.EpisodeID, t1.[ClientEventStatus], t2.StatusID 
		         FROM AppointmentWithClient t1 INNER JOIN Appointment t2 on t1.AppointmentID  = t2.AppointmentID 
				WHERE t1.AppointmentID  = @AppointmentID) cl1 INNER JOIN Episode cl2 ON cl1.EpisodeID  = cl2.EpisodeID
	     for XML Path('') ),1,1,'') +']')
	
	RETURN @clientsJsonString
END
GO
--======================================================================
--fnGetApptFollowup
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetApptFollowup]    Script Date: 8/14/2020 1:32:53 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetApptFollowup]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetApptFollowup]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetApptFollowup] 
(
    @AppointmentID int,
	@StartDate DateTime, 
	@EpisodeID int,
	@StaffID int = 0
)
RETURNS nvarchar(4000)
AS
BEGIN
	DECLARE @followupString nvarchar(4000)
	DECLARE @table TABLE(
	  StaffID int
	)
	IF @StaffID <> 0 
	  INSERT INTO @table(StaffID) VALUES(@StaffID)
	ELSE 
	  INSERT INTO @table(StaffID) 
	  select StaffID from AppointmentWithStaff Where AppointmentID =@AppointmentID

	SET @followupString =(select + stuff((
    select ';"' +  concat(LTRIM(convert(varchar(25), MIN(t.StartDate), 110)), ' ', LTRIM(convert(varchar(25), MIN(t.StartDate), 114))) + '"'  
   FROM 
	(SELECT a3.StaffID, a1.StartDate, ROW_NUMBER() OVER(PARTITION BY a3.StaffID ORDER BY a1.StartDate) AS rk FROM
	(SELECT AppointmentID, StartDate, ActionStatus FROM Appointment WHERE  ActionStatus <> 10 ) a1 
	INNER JOIN AppointmentTrace a2 on a1.AppointmentID = a2.AppointmentID 
	INNER JOIN (SELECT AppointmentID, StaffID FROM AppointmentWithStaff  
	             Where StaffID in (SELECT StaffID FROM @table)) a3 
				 on a1.AppointmentID = a3.AppointmentID 
	INNER JOIN (SELECT AppointmentID, EpisodeID, ClientEventStatus FROM AppointmentWithClient 
				 WHERE EpisodeID = @EpisodeID AND ClientEventStatus <> 4 ) a4 on a1.AppointmentID = a4.AppointmentID
	Where DateDiff(HOUR,a1.StartDate, @StartDate)< 0)t WHERE t.rk=1 GROUP BY StaffID, StartDate
	for XML Path('')),1,1,'')) 
	if @followupString IS NULL SET @followupString = '""'
   RETURN @followupString
END
GO
--======================================================================
--fnGetComplexDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetComplexDesc]    Script Date: 8/14/2020 1:34:35 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetComplexDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetComplexDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetComplexDesc] 
(
	@ComplexId int
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	IF @ComplexId > 0 
	    SET @desc =(SELECT top 1 ComplexDesc FROM [dbo].[tlkpLocation] WHERE ComplexId = @ComplexId)
	
	RETURN @desc
END
GO
--======================================================================
--fnGetComplexDescByLocation
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetComplexDescByLocation]    Script Date: 8/14/2020 1:36:36 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetComplexDescByLocation]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetComplexDescByLocation]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetComplexDescByLocation] 
(
	@Locationid int
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	IF @Locationid > 0 
	    SET @desc =(SELECT top 1 ComplexDesc FROM [dbo].[tlkpLocation] WHERE LocationID = @Locationid)
	
	RETURN @desc
END
GO
--======================================================================
--fnGetCountyName
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetCountyName]    Script Date: 8/14/2020 1:38:38 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetCountyName]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetCountyName]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetCountyName] 
(
	@id int
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	IF @id > 0 SET @desc =(SELECT Name FROM [dbo].[tlkpCounty] WHERE CountyID = @id)

	RETURN @desc
END
GO
--======================================================================
--fnGetCWNextApptDate
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetCWNextApptDate]    Script Date: 8/14/2020 1:40:46 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetCWNextApptDate]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetCWNextApptDate]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetCWNextApptDate] 
(
	@StaffID int =0,
	@EpisodeID int =0,
	@StartDate datetime = null
)
RETURNS datetime
AS
BEGIN
	-- Declare the return variable here
	DECLARE @retStartdate datetime

	set @retStartdate =(SELECT top 1 t2.StartDate 
	                      FROM AppointmentWithStaff t1 inner join Appointment t2  
						    on t1.AppointmentID = t2.AppointmentID 
							inner join AppointmentWithClient t3 on t1.AppointmentID = t3.AppointmentID
                         WHERE  t1.StaffID = @StaffID and t3.EpisodeID = @EpisodeID and t2.StartDate > @StartDate
						        and t2.ActionStatus <> 10 
						 order by t2.StartDate)
	RETURN @retStartdate
END
GO
--======================================================================
--fnGetEthnicityDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetEthnicityDesc]    Script Date: 8/14/2020 1:42:44 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetEthnicityDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetEthnicityDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGetEthnicityDesc] 
(
	@id int
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	IF @id > 0 SET @desc =(SELECT EthnicityDesc FROM [dbo].[tlkpEthnicity] WHERE EthnicityID = @id)

	RETURN @desc
END
GO
--======================================================================
--fnGetEvaluationItemDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetEvaluationItemDesc]    Script Date: 8/14/2020 1:44:40 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetEvaluationItemDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetEvaluationItemDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnGetEvaluationItemDesc] 
(
	@id int
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	IF @id > 0 SET @desc =(SELECT EvaluationItemDescr FROM [dbo].[tlkpEvaluationItem] WHERE EvaluationItemID = @id)

	RETURN @desc
END
GO
--======================================================================
--fnGetFollowupAppt
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetFollowupAppt]    Script Date: 8/14/2020 1:46:29 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetFollowupAppt]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetFollowupAppt]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetFollowupAppt] 
(
    @AppointmentId int = 0,
	@EpisodeID int =0,
	@StartDate datetime = null,
	@StaffID int = 0
)
RETURNS nvarchar(500)
AS
BEGIN
   DECLARE @sid int
   DECLARE @desc nvarchar(500) = ''
	IF @AppointmentId > 0 AND @EpisodeID > 0
	BEGIN
		--SET @EpisodeID  = 583682
		--SET @AppointmentID  =496615
		DECLARE @allStaff int = 1
		IF @StaffID > 0 SET @allStaff = 0
		DECLARE @Staffs TABLE
		(
		   StaffID int
		) 
		INSERT INTO @Staffs
		Select StaffID from AppointmentWithStaff Where (@allStaff =1 AND AppointmentID = @AppointmentID) OR (@allStaff =0 AND AppointmentID = @AppointmentID AND StaffID = @StaffID)

	   IF EXISTS(SELECT * FROM @Staffs)
	   BEGIN
		   DECLARE apptcursor CURSOR FOR SELECT StaffID from @Staffs
		   OPEN apptcursor
		   FETCH NEXT FROM apptcursor INTO @sid
		   WHILE @@FETCH_STATUS = 0
			 BEGIN
			  IF len(@desc) > 0 SET @desc = @desc + ';'
	          SET @desc = @desc + 
			    (SELECT TOP 1 concat (LTRIM(convert(varchar(25), MIN(t1.StartDate), 110)), ' ', 
                                      LTRIM(convert(varchar(25), MIN(t1.StartDate), 114))) 
				FROM (SELECT AppointmentID, StartDate, ActionStatus 
						FROM
						(SELECT AppointmentID, StartDate, ActionStatus, 
						ROW_NUMBER() OVER (PARTITION BY AppointmentTraceID ORDER BY AppointmentID DESC) AS RowNum 
							FROM Appointment WHERE StartDate > DateAdd(year, -1, @StartDate) AND 
							StartDate < DateAdd(year, 3, @StartDate))a
						WHERE a.RowNum = 1 and a.ActionStatus <> 10 and a.StartDate > @StartDate) t1 
						INNER JOIN 
					(SELECT AppointmentID, StaffID 
						FROM AppointmentWithStaff 
						WHERE StaffID =@sid) t2 on t1.AppointmentID = t2.AppointmentID 
						INNER JOIN 
					(SELECT AppointmentID, EpisodeID, ClientEventStatus 
						FROM AppointmentWithClient 
						WHERE EpisodeID = @EpisodeID AND ClientEventStatus <> 4) t3 on t1.AppointmentID = t3.AppointmentID)
				FETCH NEXT FROM apptcursor INTO @sid
			END
			CLOSE apptcursor
			DEALLOCATE apptcursor
	   END
	END
	RETURN @desc
END
GO
--======================================================================
--fnGetlocationDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetlocationDesc]    Script Date: 8/14/2020 1:48:48 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetlocationDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetlocationDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetlocationDesc] 
(
	@Locationid int
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	IF @Locationid > 0 
	    SET @desc =(SELECT LocationDesc FROM [dbo].[tlkpLocation] WHERE LocationID = @Locationid)
	eLSE
	    SET @desc = 'ZZ'

	RETURN @desc
END
GO
--======================================================================
--fnGetMHStatusDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetMHStatusDesc]    Script Date: 8/14/2020 1:50:37 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetMHStatusDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetMHStatusDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetMHStatusDesc] 
(
	 @ClientEpisodeID int = 0,
	 @EpisodeID int =0
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	DECLARE @MHStatusID int  = (SELECT ISNULL(ParoleMentalHealthLevelOfServiceID, 0) FROM  ClientEpisode
	                             Where ClientEpisodeID = @ClientEpisodeID)
	IF @MHStatusID = 0 
	   SET @MHStatusID = (SELECT ISNULL(@MHStatusID, 0) FROM Offender o INNER JOIN  Episode e on o.OffenderID = e.OffenderID WHERE e.EpisodeID = @EpisodeID)
	
	 IF   @MHStatusID > 0 
	     SET @desc =(SELECT ParoleMentalHealthLevelOfServiceDescShort 
	              FROM [dbo].[tlkpParoleMentalHealthLevelOfService] 
				 WHERE ParoleMentalHealthLevelOfServiceID = @MHStatusID)

	RETURN @desc
END
GO
--======================================================================
--fnGetNextApptInfo
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetNextApptInfo]    Script Date: 8/14/2020 1:52:46 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetNextApptInfo]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetNextApptInfo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetNextApptInfo] 
(
	@EpisodeID int,
	@StartDate DateTime = null
)
RETURNS nvarchar(2500)
AS
BEGIN
	DECLARE @desc nvarchar(2500) =''
	SET @desc =  (SELECT (Select [dbo].[fnGetApptTypeDesc](W.TypeID)) + char(13)+char(10) + 
			  (Convert(nvarchar(10),W.StartDate, 101) + ' ' + 
	          LTRIM(substring(Convert(nvarchar(30),W.StartDate, 109),12, 5))) + 
              substring(Convert(nvarchar(30),W.StartDate, 109),24, 4) + '-' + 
              LTRIM(substring(Convert(nvarchar(30),W.EndDate, 109),12, 5)) +
              substring(Convert(nvarchar(30),W.EndDate, 109),24, 4) + char(13)+char(10) + 
	          (SELECT [dbo].[fnGetComplexDesc](W.ComplexID)) FROM
			  (SELECT TOP 1 AppointmentID, AppointmentTraceID, EpisodeID,TypeID, StatusID, ComplexID,  StartDate, EndDate FROM
			 (Select t1.AppointmentID, t2.AppointmentTraceID, t1.EpisodeID,t2.TypeID, t2.StatusID, t2.ComplexID,  t2.StartDate, t2.EndDate, 
			         RANK() OVER (PARTITION BY t1.EpisodeID ORDER BY t2.StartDate)rd1 
			  From AppointmentWithClient t1 INNER JOIN Appointment t2 on t1.AppointmentID  = t2.AppointmentID 
			  Where EpisodeID  = @EpisodeID And StartDate >  @StartDate AND DateDiff(day, @StartDate, StartDate) > 30) T WHERE T.rd1 = 1)W)

	RETURN @desc
END
GO
--======================================================================
--fnGetSignificantOtherStatusDesc
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetSignificantOtherStatusDesc]    Script Date: 8/14/2020 2:12:54 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetSignificantOtherStatusDesc]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetSignificantOtherStatusDesc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetSignificantOtherStatusDesc] 
(
	 @SignificantOtherStatusCode varchar(1) = ''
)
RETURNS nvarchar(25)
AS
BEGIN
	DECLARE @desc nvarchar(25) =''
	
	IF @SignificantOtherStatusCode <> ''
	     SET @desc =(SELECT SignificantOtherStatusDesc 
	              FROM [dbo].[tlkpSignificantOtherStatus] 
				 WHERE SignificantOtherStatusCode = @SignificantOtherStatusCode)

	RETURN @desc
END
GO
--======================================================================
--fnGetStaffsJasnString
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnGetStaffsJasnString]    Script Date: 8/14/2020 2:14:17 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnGetStaffsJasnString]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnGetStaffsJasnString]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetStaffsJasnString] 
(
	@AppointmentID int,
	@StaffID int
)
RETURNS nvarchar(4000)
AS
BEGIN
  DECLARE @staffJsonString nvarchar(4000) = ''
  IF EXISTS(SELECT StaffID FROM dbo.AppointmentWithStaff WHERE AppointmentID = @AppointmentID AND StaffID <> @StaffID)
  BEGIN
	--DECLARE @staffJsonString nvarchar(4000)

	SET @staffJsonString =(select'['+
stuff(
 (
 select ',{ "StaffId": "' + Convert(varchar, t.StaffId) 
  + '","StaffName": "' + t.StaffName  
  + '","StaffTypeId": "'+ convert(varchar, t.StaffTypeId)
  + '", "StaffType": "' + t.StaffType 
  + '", "LocationId": "' + convert(varchar, t.LocationId) 
  + '", "IsCurrentUser": false}'
  from (SELECT t2.StaffId, (SELECT Name FROM dbo.fn_GetAsstUserName(t2.StaffId))StaffName,
      u.CaseWorkerTypeId as StaffTypeId, (CASE WHEN ISNULL(u.CaseWorkerTypeId, 0)>0 THEN 
	  (SELECT dbo.fnCaseWorkerTypeDesc(u.CaseWorkerTypeId)) ELSE '' END)StaffType, ISNULL(u.PrimaryLocationId, 0)LocationId 
	     FROM (SELECT StaffID FROM dbo.AppointmentWithStaff 
	    WHERE AppointmentID = @AppointmentID AND StaffID <> @StaffID) t2 inner join dbo.[User] u on t2.StaffID = u.UserID 
      ) t  for XML Path('')
 ),1,1,''
) +']') 
END
	RETURN @staffJsonString
END
GO
--======================================================================
--fnIsCaseAssignedToWho
--======================================================================
/****** Object:  UserDefinedFunction [dbo].[fnIsCaseAssignedToWho]    Script Date: 8/14/2020 2:16:06 PM ******/
IF EXISTS (SELECT * FROM sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[fnIsCaseAssignedToWho]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT'))
  DROP FUNCTION [dbo].[fnIsCaseAssignedToWho]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnIsCaseAssignedToWho] 
(
	@EpisodeID int,
	@StaffID int
)
RETURNS bit
AS
BEGIN
DECLARE @IsAssigned bit = 0
	IF EXISTS(Select 1 FROM
		 (SELECT [EpisodeID],[SocialWorkerUserId], [CaseManagerUserId], [PsychiatristUserId],[PsychologistUserId],[ActionStatus],[DateAction]
		  FROM
	       (SELECT [EpisodeID],[SocialWorkerUserId], [CaseManagerUserId], [PsychiatristUserId],[PsychologistUserId],[ActionStatus],[DateAction],
	          ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY [ID] DESC) AS nRowNum FROM [dbo].[StaffAssignment] Where EpisodeID  = @EpisodeID ) sub where Sub.nRowNum = 1) T Where T.PsychiatristUserId = @StaffID OR T.PsychologistUserId = @StaffID or T.CaseManagerUserId = @StaffID OR T.SocialWorkerUserId = @StaffID)
		SET @IsAssigned  = 1
			
 return @IsAssigned
END
GO