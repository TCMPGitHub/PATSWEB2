--============================================================================
--PATSWeb Version II  (PATSWebV2 -- Created at 08/19/2020)
--============================================================================
USE [PatsWebV2Test]
GO
--============================================================================
--spCheckOccupied
--============================================================================
/****** Object:  StoredProcedure [dbo].[spCheckOccupied]    Script Date: 8/19/2020 9:58:13 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spCheckOccupied]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spCheckOccupied]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCheckOccupied]
    @StartDate DateTime,
	@EndDate DateTime,
	@Staffs nvarchar(1000) = '',
	@Clients nvarchar(1000) = '',
	@TypeID int = 0,
	@AppointmentTraceID int = 0,
	@retMessage nvarchar(4000) out
AS	
BEGIN
   DECLARE @IsUpdate bit 
	SET @IsUpdate = 0
	SET @retMessage = ''
	DECLARE @tblStaff TABLE(
	  StaffID int
	)	
	
	DECLARE @tblClient TABLE(
	  EpisodeID int
	)	
	DECLARE @apptID  int = 0
	--check to see if client selected
	DECLARE @ShowCDCR bit = (SELECT ShowCDCRNum FROM dbo.tlkpAppointmentType WHERE ID= @TypeID)
	IF @ShowCDCR = 1 AND (len(@Clients) = 0 OR ISNULL(@Clients, '') = '')
		SET @retMessage = 'Must select one client.'

    IF @AppointmentTraceID > 0
	BEGIN
	   --get latest appointment id
	   DEclare @sdate datetime, @edate DateTime 	  
	   --get selected start date 
	  SELECT @apptID = AppointmentID, @sdate = StartDate, @edate = EndDate 
	    FROM Appointment WHERE AppointmentID  = (Select AppointmentID From AppointmentTrace  Where AppointmentTraceID = @AppointmentTraceID)
	   
	   IF NOT ( @StartDate >= @sdate AND @EndDate <= @edate)
	    BEGIN
	       INSERT INTO @tblStaff SELECT * FROM dbo.fnSplitString(@Staffs, ',')
	       INSERT INTO @tblClient SELECT * FROM dbo.fnSplitString(@Clients, ',')
	       SET @IsUpdate = 1
	   END
	   ELSE IF LEN(@Staffs) > 0 OR LEN(@Clients) > 0 
	   BEGIN
	       IF EXISTS(SELECT StaffID FROM
					(SELECT splitdata as StaffID FROM dbo.fnSplitString(@Staffs, ',')
					  EXCEPT   
					SELECT StaffID from AppointmentWithStaff where AppointmentID = @apptID) m)		
			BEGIN
					INSERT INTO @tblStaff 
					SELECT StaffID FROM
					 (SELECT splitdata as StaffID FROM dbo.fnSplitString(@Staffs, ',')
					  EXCEPT   
					  SELECT StaffID from AppointmentWithStaff where AppointmentID = @apptID) m				   
                    SET @IsUpdate = 1
			END		
	   
	       IF EXISTS(SELECT EpisodeID FROM
		            (SELECT splitdata AS EpisodeID FROM dbo.fnSplitString(@Clients, ',')
					  EXCEPT   
					SELECT EpisodeID from AppointmentWithClient where AppointmentID = @apptID) m) 
		   	BEGIN
				   INSERT INTO @tblClient 
				   SELECT EpisodeID FROM
		            (SELECT splitdata AS EpisodeID FROM dbo.fnSplitString(@Clients, ',')
					  EXCEPT   
					SELECT EpisodeID from AppointmentWithClient where AppointmentID = @apptID) m
				  SET @IsUpdate = 1
			END
	   END
	END
		
	 IF @AppointmentTraceID = 0
	 BEGIN
	   INSERT INTO @tblStaff SELECT * FROM dbo.fnSplitString(@Staffs, ',')
	   INSERT INTO @tblClient SELECT * FROM dbo.fnSplitString(@Clients, ',')
	   SET @IsUpdate = 1 
	 END 

	IF @IsUpdate = 1
	BEGIN
	--declare @Staffs nvarchar(1000) = '840',  @Clients nvarchar(1000) = '2605,22537'
	--Declare @StartDate DateTime = '2018-02-17 10:15',@EndDate DateTime = '2018-02-17 10:35'
	Declare @ST DateTime = CONVERT(DateTime, Concat(convert(varchar, @StartDate, 101),' ', '07:00'))
	Declare @ED DateTime = CONVERT(DateTime, Concat(convert(varchar, @StartDate, 101),' ', '18:00'))
	--DECLARE @retMessage nvarchar(4000)
	DECLARE @staffArray nvarchar(1000)
	DECLARE @clientArray nvarchar(1000)
	

	DECLARE @ExistApptTable TABLE(
	  StartDate DateTime,
	  EndDate DateTime,
	  EpisodeID int,
	  StaffID int,
	  StaffName varchar(35),
	  ClientName varchar(45)
	)
	--Make sure is clients exists
	INSERT INTO @ExistApptTable
	SELECT A.StartDate, A.EndDate,C.EpisodeID, B.StaffID,
			(SELECT Name FROM dbo.fn_GetUserName(B.StaffID) ) AS StaffName, 
			(SELECT Name FROM dbo.fn_GetClientName(ISNULL(C.EpisodeID, 0))) as ClientName		 
	   FROM (SELECT AppointmentID,  StartDate, EndDate, StatusID, ActionStatus 
	           FROM dbo.fn_GetAppointmentByDate(@ST, null) 
			  WHERE ActionStatus<> 10 AND StatusID NOT IN (3, 5) and AppointmentID <> @apptID AND 
			        ((StartDate >= @StartDate AND EndDate >= @EndDate AND StartDate < @EndDate) OR
					 (StartDate >= @StartDate AND EndDate <= @EndDate ) OR
					 (StartDate >= @ST AND StartDate <= @StartDate AND EndDate <= @EndDate 
					                   AND EndDate > @StartDate) OR
					 (EndDate <= @ED AND StartDate >= @StartDate AND EndDate >= @EndDate 
					                 AND EndDate < @StartDate) OR
					 (StartDate <= @StartDate and EndDate >= @EndDate))) A 
	        LEFT OUTER JOIN (SELECT AppointmentID, StaffID FROM AppointmentWithStaff
			             WHERE StaffID in (SELECT StaffID FROM @tblStaff)) B 
						    ON A.AppointmentID = B.AppointmentID
			LEFT OUTER JOIN (SELECT AppointmentID, EpisodeID, ClientEventStatus FROM AppointmentWithClient
			                  WHERE ISNULL(ClientEventStatus, 0) <> 4) C on A.AppointmentID = C.AppointmentID	  
	
	  IF EXISTS(SELECT * FROM @ExistApptTable WHERE ISNULL(StaffName, '') <> '')
	  BEGIN
	  SELECT @staffArray =  substring(list, 1, len(list) - 1)
	  FROM   (SELECT list = 
			  (SELECT DISTINCT StaffName + ','
			   FROM  @ExistApptTable
			   ORDER BY StaffName + ','
			 FOR XML PATH(''), TYPE).value('.', 'nvarchar(MAX)')) AS T
			IF @retMessage = ''
			    SET @retMessage = Concat('Staff: ',  @staffArray)
			ELSE
			    SET @retMessage = Concat(@retMessage, '||', 'Staff: ',  @staffArray)
	  END 

	   IF EXISTS(SELECT * FROM @ExistApptTable WHERE ISNULL(ClientName, '') <> '' 
	                AND EpisodeID IS NOT NULL
	                AND EpisodeID IN (SELECT EpisodeID FROM @tblClient))
	   BEGIN     
		SELECT @clientArray=  substring(list, 1, len(list) - 1)
		FROM   (SELECT list = 
				  (SELECT DISTINCT ClientName + ','
				   FROM  @ExistApptTable WHERE EpisodeID IN (SELECT EpisodeID FROM @tblClient)
				   ORDER BY ClientName + ','
				 FOR XML PATH(''), TYPE).value('.', 'nvarchar(MAX)')) AS T
			IF @retMessage = ''
			    SET @retMessage = Concat('Client: ',  @clientArray)
			ELSE
			    SET @retMessage = Concat(@retMessage, '||', 'Client: ',  @clientArray)
		END
      select @retMessage
 END
END
GO
GRANT EXECUTE ON [dbo].[spCheckOccupied] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spCheckOccupied] to [ACCOUNTS\Svc_CDCRPATSUser]
GO  
--============================================================================
--spGetAppointmentList
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetAppointmentList]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetAppointmentList]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetAppointmentList]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2018-01-09
-- Description:	Retrive appointment
-- =============================================
CREATE PROCEDURE [dbo].[spGetAppointmentList] 
	@StartDate DateTime,
	@EpisodeID int = 0,
	@StaffID int = 0,
	@LocationID int = 0,
	@AppointmentTraceId int = 0,
	@EndDate DateTime = null		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @start DateTime = Convert(DateTime, CONVERT(VARCHAR(10), @StartDate, 111) + ' 00:00')
    DECLARE @end DateTime
	DECLARE @OneDay bit =0
    IF @EndDate IS NULL OR @StartDate = @EndDate OR Convert(Date, @StartDate) = Convert(Date, @EndDate) 
	   OR DateDiff(hour,@StartDate, @EndDate) <= 48
	   BEGIN
	      SET @end = Convert(DateTime, CONVERT(VARCHAR(10), @StartDate, 111) + ' 23:00')
		  SET @OneDay = 1
	   END
    ELSE 
       SET @end = Convert(DateTime, CONVERT(VARCHAR(10), @EndDate, 111) + ' 23:00')
	
	IF @StaffID > 0
	BEGIN	  
	DECLARE @SelectedApptStaff nvarchar(4000) =  (SELECT '{ "StaffId": "' + Convert(varchar(10), UserID) 
  + '","StaffName": "' + (Select Name From dbo.fn_GetAsstUserName(UserID)) 
  + '","StaffTypeId": "'+ convert(varchar(3), ISNULl(CaseWorkerTypeId,0))
  + '", "StaffType": "' + (SELECT dbo.fnCaseWorkerTypeDesc(UserID))
  + '", "LocationId": "' + convert(varchar(5), ISNULL(PrimaryLocationID, 0)) 
  + '", "ComplexId": "' + convert(varchar(5), (CASE WHEN ISNULL(PrimaryLocationID, 0) =0 THEN 0 ELSE  (SELECT DISTINCT ISNULl(ComplexID, 0)ComplexID 
                                                 FROM tlkpLocation 
												WHERE LocationID  = ISNULL(PrimaryLocationID, 0)) END)) 
  + '", "IsCurrentUser": false}'
  FROM dbo.[User] WHERE UserID =@StaffID)

     SELECT a1.AppointmentID, a1.AppointmentTraceID, a1.StartDate, a1.EndDate, ISNULL(a1.TypeID, 5)TypeID, 
        ISNULL(a1.StatusId, 1)StatusId, a1.ADAECIDs, a1.IsCompleted, 
	 (CASE WHEN a1.IsCompleted = 1 THEN 'Completed' ELSE 
	    (CASE WHEN DateDiff(day,a1.StartDate, GetDate()) < 0 THEN
	        (CASE WHEN a1.StatusId = 3 THEN 'Canceled' WHEN StatusId = 5 THEN 'Excused' ELSE 'Pending' END) ELSE
	        (CASE WHEN a1.StatusId = 1 THEN 'Absent'  WHEN a1.StatusId = 3 THEN 'Canceled' WHEN a1.StatusId = 4 THEN 'Present' 
	              WHEN  a1.StatusId = 5 THEN 'Excused' WHEN  a1.StatusId = 6 THEN 'Case MGMT' ELSE 'Due' END) END) END)ProcessStatus,
	    ISNULL(a1.IsAllDay, 0) IsAllDay,ISNULL(a1.ComplexId, 0)LocationId, D.EvtTCellColor, D.EvtTShortDescr,
	  (SELECT dbo.fnGetApptStatusDesc(ISNULL(a1.StatusID, 1)))ApptShortDescr,a1.Note, a1.ActionStatus, a1.ComplexId,
	  (CASE WHEN ISNULl(a1.ComplexId, 0) = 0 THEN 'Unknown' ELSE (SELECT dbo.fnGetComplexDesc(a1.ComplexId)) END)LocationDesc,
	  (CASE WHEN a4.AppointmentID IS NULL THEN ''
	        WHEN @OneDay =1 THEN (SELECT [dbo].[fnGetClientsJsonString](a1.AppointmentID, a1.StartDate, @StaffID,@OneDay)) ELSE
	   (select'['+ stuff((
       select ',{ "EpisodeID": "' + Convert(varchar, cl1.EpisodeID) + '", "CDCRNumber": "' + cl2.CDCRNum
		  + '","ClientName": "' + (SELECT Name FROM [dbo].[fn_GetClientName](cl1.EpisodeID))  
		  + '","AppointmentId": "'+ convert(varchar, a1.AppointmentID)
		  + '", "Agent": "' + ISNULl(cl2.ParoleAgent,'')
		  + '", "Unit": "' +  (CASE WHEN ISNULL(cl2.ParoleUnit, '') <> '' THEN cl2.ParoleUnit ELSE
                                   (CASE WHEN ISNULL(cl2.ParoleLocationID, 0) = 0 THEN '' ELSE (SELECT dbo.fnGetComplexDescByLocation(cl2.ParoleLocationID)) END) END)
		  + '", "FollowupAppt": "", "ReleaseLoc": "' + convert(varchar, ISNULl(cl2.ParoleLocationID,''))
		  + '", "ClientStatus": "' + convert(varchar, cl1.[ClientEventStatus]) 
		  + '", "ContactPh": "' +  ''  +   ISNULL((SELECT dbo.fnGetClientContactPhone(cl1.EpisodeID)), '') +'"}' 
		 FROM (SELECT AppointmentID, EpisodeID, [ClientEventStatus] FROM AppointmentWithClient WHERE AppointmentID  = a1.AppointmentID) cl1 
		 LEFT OUTER JOIN Episode cl2 ON cl1.EpisodeID  = cl2.EpisodeID for XML Path('') ),1,1,'') +']') END )ApptClient,
	   -- WHERE cl1.AppointmentID  =a1.AppointmentID 

	  (CASE WHEN (SELECT COUNT(StaffID) FROM AppointmentWithStaff WHERE AppointmentID=a3.AppointmentID) > 1 THEN 
	     (SELECT [dbo].[fnGetStaffsJasnString](a1.AppointmentID, 0)) ELSE '[' + @SelectedApptStaff + ']' END)ApptStaff,	  
	  --(SELECT [dbo].[fnGetStaffsJasnString](a1.AppointmentID,, @StaffID))ApptStaff,
	   (CASE WHEN a1.ADAECIDs IS NOT NULL AND a1.ADAECIDs<>'' THEN ('[' + stuff((
  SELECT ',{ "Value": "' + Convert(varchar, ID) + '","Text": "' + ADAECDescription +'"}' 
  FROM tlkpADAOrEC WHERE ID in (SELECT * FROM [dbo].[fnSplitString](a1.ADAECIDs, ',')) FOR XML PATH('') ),1,1,'') +']') ELSE '' END)  AS ADAECs,
  0 AS ClientLocationID
	  FROM 
	  (SELECT AppointmentID,AppointmentTraceID,StartDate,EndDate,TypeID,StatusId,ADAECIDs,IsCompleted,Note,ActionStatus,ComplexId, 
	          IsAllDay FROM Appointment Where ActionStatus <> 10 AND StartDate >= @start AND StartDate < @end) a1 
	     INNER JOIN AppointmentTrace a2 on a1.AppointmentID =  a2.AppointmentID			
	     INNER JOIN (SELECT DISTINCT AppointmentID FROM AppointmentWithStaff WHERE StaffID  = @StaffID) a3 on a1.AppointmentID = a3.AppointmentID 
		 INNER JOIN dbo.tlkpAppointmentType D on a1.TypeID = D.ID
		 LEFT OUTER JOIN (Select DISTINCT AppointmentID FROM AppointmentWithClient) a4 on a1.AppointmentID =  a4.AppointmentID ORDER BY Startdate    
				--Where a1.ActionStatus <> 10 AND StartDate >= @start AND StartDate < @end
	END
    ELSE IF @LocationID > 0
	BEGIN
	   SELECT DISTINCT a1.AppointmentID, a1.AppointmentTraceID, a1.StartDate, a1.EndDate, 
	         ISNULL(a1.StatusID, 1)StatusID, ISNULL(a1.TypeID, 5) TypeID, 
		     ISNULL(a1.IsCompleted, 0)IsCompleted, 
		    (CASE WHEN a1.IsCompleted = 1 THEN 'Completed' ELSE 
		    (CASE WHEN DateDiff(day,a1.StartDate, GetDate()) > 0 THEN 'Due' ELSE 'Pending' END) END )ProcessStatus,
		     ISNULL(a1.IsAllDay, 0)IsAllDay, ISNULL(a1.ComplexId, 0) LocationId, a1.Note,D.EvtTCellColor,D.EvtTShortDescr,  
	        (SELECT dbo.fnGetApptStatusDesc(ISNULL(a1.StatusID, 1)))ApptShortDescr, 
	        (SELECT dbo.fnGetComplexDesc(a1.ComplexId))LocationDesc,
			(SELECT [dbo].[fnGetClientsJsonString](a1.AppointmentID, a1.StartDate, -1, @OneDay))ApptClient,
	        (SELECT [dbo].[fnGetStaffsJasnString](a1.AppointmentID, -1))ApptStaff,
		      (CASE WHEN a1.ADAECIDs IS NOT NULL AND a1.ADAECIDs<>'' THEN ('[' + stuff((
  SELECT ',{ "Value": "' + Convert(varchar, ID) + '","Text": "' + ADAECDescription +'"}' 
  FROM tlkpADAOrEC WHERE ID in (SELECT * FROM [dbo].[fnSplitString](a1.ADAECIDs, ',')) FOR XML PATH('') ),1,1,'') +']') ELSE '' END)  AS ADAECs, 
  0 AS ClientLocationID
	    FROM 
		(SELECT AppointmentID, AppointmentTraceID, StartDate, EndDate, LocationID, ComplexId,
             TypeID, StatusId, ADAECIDs, IsCompleted, IsAllDay, Note,ActionStatus  
		   FROM  Appointment WHERE StartDate >= @start AND ComplexId  = @LocationId AND StartDate < @end AND ActionStatus <> 10) a1 
		     INNER JOIN AppointmentTrace a2 on a1.AppointmentID = a2.AppointmentID 	 
		     INNER JOIN (SELECT AppointmentID FROM AppointmentWithStaff) a3 ON a1.AppointmentID = a3.AppointmentID
			 INNER JOIN tlkpAppointmentType D on a1.TypeID = D.ID
			 LEFT OUTER JOIN (Select DISTINCT AppointmentID FROM AppointmentWithClient) a4 on  a1.AppointmentID =  a4.AppointmentID
			order by startDate	
    END
	ELSE IF @EpisodeID > 0
	BEGIN
	  DECLARE @clientLocationID int = (Select ISNULL(ParoleLocationID, 0) From episode Where EpisodeID = @EpisodeID)
	  DECLARE @CDCRNum varchar(6)
	  DECLARE @ClientName nvarchar(70)
	  Declare @IsHistory bit = 1
	  IF DateDiff(hour,@start, @end) <= 48
	    Set @IsHistory= 0
	  ELSE
		 SET @StaffID = -1

	  IF @IsHistory = 1
	  BEGIN	   
	  SELECT @CDCRNum = CDCRNum,  @ClientName = RTRIM(LTRIM(B.LastName + ', ' +  B.FirstName  + ' ' + ISNULL(B.MiddleName, '')))
		FROM dbo.[Episode] A INNER JOIN dbo.[Offender] B ON A.OffenderID = B.OffenderID
		WHERE EpisodeID = @EpisodeID
	  END

	   SELECT a1.AppointmentId, a1.AppointmentTraceID, a1.StartDate, a1.EndDate,
           ISNULl(a1.StatusID, 1)StatusID, ISNULL(a1.TypeID, 5)TypeID, a1.IsCompleted, 
		   (CASE WHEN a1.IsCompleted = 1 THEN 'Completed' 
			      WHEN a1.ActionStatus = 10 THEN 'Deleted' ELSE 
	    (CASE WHEN DateDiff(day,a1.StartDate, GetDate()) < 0 THEN
	        (CASE WHEN a1.StatusId = 3 THEN 'Canceled' WHEN StatusId = 5 THEN 'Excused' ELSE 'Pending' END) ELSE
	        (CASE WHEN a1.StatusId = 1 THEN 'Absent'  WHEN a1.StatusId = 3 THEN 'Canceled' WHEN a1.StatusId = 4 THEN 'Present' 
	              WHEN  a1.StatusId = 5 THEN 'Excused' WHEN  a1.StatusId = 6 THEN 'Case MGMT' ELSE 'Due' END) END) END)ProcessStatus,
		   a1.IsAllDay, ISNULL(a1.ComplexId, 0) LocationId,D.EvtTCellColor, D.EvtTShortDescr, 
		   (SELECT dbo.fnGetApptStatusDesc(ISNULL(a1.StatusID, 1)))ApptShortDescr, a1.Note,
		   (SELECT dbo.fnGetComplexDesc(ISNULL(a1.ComplexId, 0)))LocationDesc,
		   (CASE WHEN @IsHistory=0 THEN (SELECT [dbo].[fnGetClientsJsonString](a1.AppointmentID, a1.StartDate, 0,@OneDay))  
		         ELSE
				 ('[{ "EpisodeID" :"' + Convert(varchar, @EpisodeID) + '", "CDCRNumber": "' + @CDCRNum + '", "ClientName": "' + @ClientName +
				      '", "AppointmentId": "' + convert(varchar, a1.AppointmentID) + '", "Agent" : "", "Unit": "","FollowupAppt": "", "ReleaseLoc": "' + 
					  '", "ClientStatus": "' + convert(varchar, (CASE a1.StatusId WHEN 3 THEN 5 WHEN 5 THEN 4 ELSE t4.[ClientEventStatus] END) ) + '", "ContactPh": "" }]') END)ApptClient,
	       (SELECT [dbo].[fnGetStaffsJasnString](a1.AppointmentID, -1))ApptStaff,	  
	        (CASE WHEN a1.ADAECIDs IS NOT NULL AND a1.ADAECIDs<>'' THEN ('[' + stuff((
  SELECT ',{ "Value": "' + Convert(varchar, ID) + '","Text": "' + ADAECDescription +'"}' 
  FROM tlkpADAOrEC WHERE ID in (SELECT * FROM [dbo].[fnSplitString](a1.ADAECIDs, ',')) FOR XML PATH('') ),1,1,'') +']') ELSE '' END)  AS ADAECs,
	  @clientLocationID AS ClientLocationId
		FROM (Select AppointmentID,AppointmentTraceID,StartDate,EndDate,TypeID,StatusId,ADAECIDs,IsCompleted,Note,ActionStatus,ComplexId, 
	          IsAllDay FROM Appointment WHERE (@IsHistory = 1 AND 1=1 ) OR (@IsHistory = 0 AND ActionStatus <> 10 AND StartDate >= @start AND StartDate < @end )) a1 
	     INNER JOIN AppointmentTrace a2 on a1.AppointmentID =  a2.AppointmentID			
	     INNER JOIN (SELECT DISTINCT AppointmentID FROM AppointmentWithStaff) a3 on a1.AppointmentID = a3.AppointmentID 
		 INNER JOIN dbo.tlkpAppointmentType D on a1.TypeID = D.ID
		 INNER JOIN (Select AppointmentID, ClientEventStatus FROM AppointmentWithClient Where EpisodeID  = @EpisodeID) t4 on a1.AppointmentID =  t4.AppointmentID	
					order by startDate
    END
	ELSE IF @AppointmentTraceId > 0
	BEGIN
	  SELECT DISTINCT t1.AppointmentId, t1.AppointmentTraceID,  t1.StartDate AS Start, t1.StartDate AS StartTime, 
	    t1.EndDate AS EndTime, (SELECT Name From dbo.fn_GetAsstUserName(t1.ActionBy))ActionBy, t1.DateAction,  
		D.EvtTShortDescr, (SELECT dbo.fnGetApptStatusDesc(ISNULL(t1.StatusID, 1)))ApptShortDescr, 
	   (SELECT dbo.fnGetComplexDesc(ISNULl(t1.ComplexId, 0)))LocationDesc,
	   (SELECT stuff(( SELECT ',' + ts.CDCRNum FROM (Select CDCRNum 
          FROM AppointmentWithClient a1 INNER JOIN Episode a2 on a1.EpisodeID = a2.EpisodeID  
		 WHERE AppointmentID  = t1.AppointmentID) ts  FOR XML PATH('')),1,1,''))ApptClient,
       (SELECT stuff(( SELECT ',' + ts.Name
          FROM (SELECT (SELECT Name From dbo.[fn_GetAsstUserName](staffID))name
                          FROM AppointmentWithStaff 
						 WHERE AppointmentID = t1.AppointmentID) ts  FOR XML PATH('')),1,1,''))ApptStaff,
						 (CASE WHEN ADAECIDs IS NOT NULL AND ADAECIDs<>'' THEN ('[' + stuff((
  SELECT ',{ "Value": "' + Convert(varchar, ID) + '","Text": "' + ADAECDescription +'"}' 
  FROM tlkpADAOrEC WHERE ID in (1,5) FOR XML PATH('') ),1,1,'') +']') ELSE '' END)  AS ADAECs, 
	  0 AS ClientLocationId
	    FROM 
		(SELECT a1.AppointmentID, a1.AppointmentTraceID, StartDate, EndDate, LocationID, ComplexId,ADAECIDs,
             TypeID, StatusId, IsCompleted, IsAllDay, ActionStatus, ActionBy, DateAction  
		   FROM Appointment a1 WHERE AppointmentTraceID  = @AppointmentTraceId )t1 
		        LEFT OUTER JOIN 
		(SELECT DISTINCT AppointmentID FROM AppointmentWithClient) t2 on  t1.AppointmentID =  t2.AppointmentID
				INNER JOIN 
		(SELECT DISTINCT AppointmentID FROM AppointmentWithStaff) t3 on t1.AppointmentiD  =  t3.AppointmentID
		        INNER JOIN tlkpAppointmentType D on t1.TypeID = D.ID
		ORDER BY StartDate
	END
END
GO
GRANT EXECUTE ON [dbo].[spGetAppointmentList] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetAppointmentList] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetApptClientList
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetApptClientList]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetApptClientList]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetApptClientList]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Create date: 2018-01-13
-- Description:	grab all Clients
-- =============================================
CREATE PROCEDURE [dbo].[spGetApptClientList] 
	@SearchStr VARCHAR(20) = null,
	@EpisodeIDs VARCHAR(200) = null,
	@AppointmentID int = 0	
AS
BEGIN
	SET NOCOUNT ON;

IF @AppointmentID = 0
BEGIN
		--DECLARE @SearchStr nvarchar(100)='BA'
SELECT TOP 10 e.EpisodeID, e.CDCRNum AS CDCRNumber,
CONCAT(e.CDCRNum, '-', o.LastName,', ',o.FirstName, ' ' , ISNULl(o.MiddleName, ''))ClientName,
ISNULL(e.ParoleAgent, '') as Agent, ISNULL(e.ParoleUnit, '') as Unit,
ISNULL(e.ParoleLocationID, 0) as ReleaseLoc, 0 as AppointmentId, '' as FollowupAppt, 2 as ClientStatus
FROM
(SELECT EpisodeID, OffenderID, CDCRNum, ParoleAgent, ParoleUnit, ParoleLocationID 
   FROM (SELECT EpisodeID, OffenderID, CDCRNum, ParoleAgent, ParoleUnit, ParoleLocationID, ROW_NUMBER() OVER (PARTITION BY OffenderID ORDER BY EpisodeID DESC) AS t1RowNum 
           FROM Episode WHERE ReleaseDate>= DateAdd(year, -10, Getdate()) ) e0 Where e0.t1RowNum = 1) e 
	    INNER JOIN EpisodeTrace e1 ON e.EpisodeID = e1.EpisodeID 
	    INNER JOIN Offender o on e.OffenderID = o.OffenderID 
	    LEFT OUTER JOIN dbo.Clientepisode e2 on e2.EpisodeID  = e.EpisodeID AND e2.ClientEpisodeID  = e1.ClientEpisodeID	   
   WHERE e2.CaseClosureDate IS NULL AND (e2.ParoleDischargeDate IS NULL OR e2.ParoleDischargeDate >= DateAdd(year, -2, Getdate())) 
      AND ((1=(case when len(@SearchStr) > 0 then 1 else 0 end) 
	  AND CONCAT(e.CDCRNum, '-', o.LastName,', ',o.FirstName, ' ' , ISNULl(o.MiddleName, '')) like '%' +  @SearchStr + '%')
           OR (1=(case when len(@SearchStr) = 0 then 1 else 0 end))) Order by e.CDCRNUm
END
ELSE 
BEGIN
 SELECT e.EpisodeID, e.CDCRNum AS CDCRNumber, 
      CONCAT(e.CDCRNum, '-', o.LastName,', ',o.FirstName, ' ' , ISNULl(o.MiddleName, '')) as ClientName,
      ISNULL(e.ParoleAgent, '') as Agent,ISNULL(e.ParoleUnit, '') as Unit,
	  ISNULL(e.ParoleLocationID, 0) as ReleaseLoc, @AppointmentID as AppointmentId,'' as FollowupAppt, t2.ClientEventStatus as ClientStatus
FROM Episode e Inner join EpisodeTrace e1 on e.EpisodeID  = e1.EpisodeID INNER JOIN Offender o on e.OffenderID = o.OffenderID 
  left outer join ClientEpisode d on e.EpisodeID = d.EpisodeID AND e1.ClientEpisodeID = d.ClientEpisodeID
  INNER JOIN AppointmentWithClient t2 on 
	 e.EpisodeID = t2.EpisodeID where AppointmentId=@AppointmentID
END
END
GO
GRANT EXECUTE ON [dbo].[spGetApptClientList] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetApptClientList] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetApptNotice
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetApptNotice]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetApptNotice]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetApptNotice]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
CREATE PROCEDURE [dbo].[spGetApptNotice] 
	@AppointmentID int = 0	
AS
BEGIN
	SET NOCOUNT ON;

IF @AppointmentID > 0
BEGIN
    DECLARE @apptNote nvarchar(500) = (Select ADAECIDs From Appointment Where AppointmentID = @AppointmentID)
	
	if(@apptNote is NOT NULL AND @apptNote <> '' )
	 SET @apptNote=  ( select
LTRIM(stuff(
(
	 SELECT ', ' + ADAECDescription 
	  FROM tlkpADAOrEC Where ID in (Select splitdata From [dbo].[fnSplitString](@apptNote, ','))  for XML Path('')
 ),1,1,''
)))
	ELSE
	BEGIN
	  SET @apptNote= (Select (SELECT dbo.fnGetApptTypeDesc(TypeID)) From Appointment Where AppointmentID = @AppointmentID)
	END	
				   
	DECLARE @apptloc nvarchar(2000) = (SELECT TOP 1 (ComplexDesc + ' - Behavioral Health Reintegration')  + char(13) + char(10) + 
             ISNULl(StreetAddress, '') + char(13) + char(10) + ISNULL(City, '') + ' ' + ISNULL(State, '') + ' ' +  
			 ISNULL(ZipCOde, '') + char(13) + char(10) + ISNULl(PhoneNumber1, '') FROM tlkpLocation WHERE ComplexID = (SELECT ComplexID FROM Appointment WHERE AppointmentID  = @AppointmentID))

    SELECT FORMAT(A.StartDate, 'dddd, MMMM d, yyyy')ApptDate, 
	  FORMAT(A.StartDate, 'hh:mm tt')ApptTime,
	  (ISNULl(@apptNote, '') + char(13)+char(10) + ISNULL(A.Note, '') )ApptPurpose, B.StaffType, B.StaffName, 
	  (CASE WHEN ISNULL(A.ComplexId,0) = 0 THEN '' ELSE @apptloc END)ApptLocation,C.ParoleName, C.CDCRNum,
	  ('California Department of Corrections and Rehabilitation' + char(13)+char(10) + 
	   'Parole and Community Services Division' + char(13)+char(10) + 
	   (CASE WHEN ISNULL(A.ComplexId, 0) = 0 THEN '' ELSE @apptloc END))Location,
	    (FORMAT(GetDate(), 'dddd, MMMM d, yyyy') + char(13)+char(10) + 'Attn: ' + (CASE WHEN ISNULL(C.FacilityName,'') = '' THEN  C.ParoleName ELSE C.FacilityName END) + 
	    char(13)+char(10) + ISNULL(C.StreetAddress, '') +  char(13)+char(10) + ISNULl(C.City, '') + ' ' + 
		ISNULL(C.State, '') + ' ' + ISNULl(C.ZIPCode, ''))ParoleInfo, C.ParoleAgent, '' as OtherAppts
	  FROM 
	  (SELECT AppointmentID, StartDate,Note, ComplexId FROM Appointment WHERE AppointmentID = @AppointmentID) A
	  INNER JOIN 
	 (SELECT Top 1 b1.AppointmentID, 
		   (CASE WHEN b2.IsPOCPsychiatrist = 1 OR b2.IsPOCPsychologist =1 
		         THEN 'Clinician:  Dr. '  ELSE 'Social Worker:' END)StaffType,(SELECT Name FROM dbo.fn_GetAsstUserName(b1.StaffID))StaffName  
		FROM AppointmentWithStaff b1 INNER JOIN [user] b2 on b1.StaffID  = b2.UserID 
	   WHERE AppointmentId =@AppointmentID Order by StaffType) B ON A.AppointmentID = B.AppointmentID 
		INNER JOIN 
	 (SELECT c1.AppointmentID, c1.EpisodeID, e.CDCRNum, e.ParoleAgent,(SELECT Name FROM dbo.fn_GetClientName(c1.EpisodeID))ParoleName,
	         d.FacilityName,d.StreetAddress, d.City, d.State, d.ZIPCode  
	    FROM AppointmentWithClient c1 INNER JOIN Episode e ON c1.EpisodeID  = e.EpisodeID INNER JOIN EpisodeTrace c2 on e.EpisodeID  = c2.EpisodeID
	         LEFT OUTER JOIN dbo.Address d ON c1.EpisodeID = d.EpisodeID AND d.ID = c2.AddressID)C ON A.AppointmentID  = C.AppointmentID	
END
END
GO
GRANT EXECUTE ON [dbo].[spGetApptNotice] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetApptNotice] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetApptStaffList
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetApptStaffList]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetApptStaffList]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetApptStaffList]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
CREATE PROCEDURE [dbo].[spGetApptStaffList] 
	@CurrentUserID int = 0,
	@StartDate DateTime = null,
	@EndDate DateTime = null,
	@LocationID int = null,
	@StaffID int = -1
AS
BEGIN

	SET NOCOUNT ON;
	--DECLARE @CurrentUserID int =10
	--DECLARE @StartDate DateTime = '2018-10-25'
	--DECLARE @EndDate DateTime = '2018-10-26'
	--DECLARE @LocationID int = 12	
    IF @StaffID = -1 
	BEGIN
		 SELECT DISTINCT U.UserID AS StaffId, (SELECT Name FROM fn_GetAsstUserName(U.UserID)) as StaffName,  C.CaseWorkerTypeDesc as StaffType,  U.CaseWorkerTypeId AS StaffTypeId, ISNULL(PrimaryLocationID, -1) as LocationId, ISNULl(l.ComplexID, 0) AS ComplexId,	 
			   (CASE WHEN U.UserID = @CurrentUserID THEN Convert(Bit, 1) ELSE Convert(Bit, 0) END)IsCurrentUser
			   FROM [User] U INNER JOIN tlkpCaseWorkerType C ON U.CaseWorkerTypeId =  C.CaseWorkerTypeId
			        LEFT OUTER JOIN tlkpLocation l on ISNULL(U.PrimaryLocationId, 0) = l.LocationID
			   WHERE IsActive = 1 AND ISNULL(LastName, '') <> '' AND (IsPOCAdmin = 1 OR IsPOCCaseManager = 1 OR IsPOCPsychologist = 1 OR IsPOCPsychiatrist = 1 OR IsPOCSocialWorker = 1)
	END
	ELSE 
	BEGIN
	SELECT DISTINCT  G.StaffId, G.StaffName, G.StaffType,  G.StaffTypeId, G.LocationID, G.ComplexId, IsCurrentUser  FROM
	(SELECT distinct t2.StaffID, C.CaseWorkerTypeDesc AS StaffType, (SELECT Name FROM fn_GetAsstUserName(U.UserID)) as StaffName, U.CaseWorkerTypeId as StaffTypeId, ISNULl(t1.ComplexId, 0)ComplexId,
	ISNULl(U.PrimaryLocationId, 0) as LocationId, (CASE WHEN t2.StaffID = @CurrentUserID THEN Convert(bit, 1) ELSE Convert(bit, 0) END) as IsCurrentUser FROM 
	(SELECT AppointmentID, ComplexId FROM
	(SELECT AppointmentID, ComplexId, StartDate,EndDate, ActionStatus,  ROW_NUMBER() OVER (PARTITION BY AppointmentTraceID ORDER BY AppointmentID DESC) AS RowNum FROM Appointment WHERE StartDate >= DateAdd(day, -10, @StartDate)
	AND EndDate <= DateAdd(Day, 10, @EndDate) AND ActionStatus <> 10 AND ComplexID = @LocationID)a Where a.RowNum = 1 and  StartDate >= @StartDate AND EndDate <= @EndDate) t1 
	INNER JOIN AppointmentWithStaff t2 ON t1.AppointmentID = t2.AppointmentID  
	INNER JOIN [User] U ON U.UserID = t2.StaffID 
	LEFT OUTER JOIN tlkpCaseWorkerType C ON U.CaseWorkerTypeId = C.CaseWorkerTypeId
	where U.IsActive =1 AND (U.IsPOCAdmin = 1 OR U.IsPOCCaseManager = 1 OR U.IsPOCPsychologist = 1 OR U.IsPOCPsychiatrist = 1 OR U.IsPOCSocialWorker = 1)) G

    END
END
GO
GRANT EXECUTE ON [dbo].[spGetApptStaffList] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetApptStaffList] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetAvailabilityList
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetAvailabilityList]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetAvailabilityList]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetAvailabilityList]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
CREATE PROCEDURE [dbo].[spGetAvailabilityList]
    @StartDate DateTime,
	@EndDate DateTime,
	@Staffs nvarchar(1000) = '',
	@Clients nvarchar(1000) = ''
AS	
BEGIN
	--declare @staffs nvarchar(1000) = '840'
	--declare @clients nvarchar(1000) = '2605,22537'
	--Declare @startdate DateTime = '2017-02-17 10:15'
	Declare @start DateTime = CONVERT(DateTime, (convert(varchar, @StartDate, 101) + ' 07:00'))
	Declare @end DateTime = CONVERT(DateTime, Concat(convert(varchar, @StartDate, 101),' ', '18:00'))
	--Declare @endDate DateTime = '2017-02-17 10:35'

	--Get DateTime Interval
	Declare @datediff int = DateDiff(MINUTE, @StartDate, @EndDate)
	if @datediff > 0 and @datediff < 15 set @datediff = 15
	else if @datediff > 15 and @datediff < 30 set @datediff = 30
	else if @datediff > 30 and @datediff < 45 set @datediff = 45
	else if @datediff > 45 and @datediff < 60 set @datediff = 60

	 --Collect all date ranges with the selected date 
	 DECLARE @Availability TABLE(
	  StartDate DateTime,
	  EndDate DateTime
	)
	;WITH x(n) AS 
	(
	  SELECT TOP (DATEDIFF(MINUTE, @start, @end) / @datediff + 1 ) 
	  rn = ROW_NUMBER() OVER (ORDER BY [object_id]) 
	  FROM sys.all_columns ORDER BY [object_id]
	)
	INSERT INTO @Availability
	SELECT t = DATEADD(MINUTE, (n-1) * @datediff, @start), m=DATEADD(MINUTE, ((n-1) * @datediff) + @datediff, @start) FROM x 
	ORDER BY t;

	DECLARE @tblStaff TABLE(
	  StaffID int
	)
	INSERT INTO @tblStaff 
	SELECT Convert(int, splitdata) as StaffID FROM [dbo].[fnSplitString](@Staffs, ',')
		
	
	DECLARE @tblClient TABLE(
	  EpisodeID int
	)	
	INSERT INTO @tblClient 
	SELECT Convert(int, splitdata) as EpisodeID FROM dbo.fnSplitString(@clients, ',')
	--collect all free date range for selected clients and staffs
	DECLARE @CurrentDate TABLE(

	  StartDate DateTime,
	  EndDate DateTime
	)
	INSERT INTO @CurrentDate
	select * from
	 (SELECT MAX(N.EndDate) OVER (ORDER BY N.StartDate) start_gap,
	  ISNULL(LEAD(N.StartDate) OVER (ORDER BY N.StartDate),MIN(N.StartDate) OVER (ORDER BY N.StartDate))  end_gap
	  from 
	  (SELECT A.EndDate, A.StartDate
	     FROM (SELECT AppointmentID, EndDate, StartDate, ActionStatus, StatusID FROM dbo.fn_GetAppointmentByDate(@start, @end)
		        WHERE ActionStatus <> 10 AND StatusID NOT in (3, 5) )A 
		      LEFT OUTER JOIN AppointmentWithClient B ON A.AppointmentID = B.AppointmentID
	          INNER JOIN AppointmentWithStaff C ON A.AppointmentID = C.AppointmentID
			  LEFT OUTER JOIN @tblClient D on B.EpisodeID = D.EpisodeID
	    WHERE C.StaffID in (SELECT * FROM @tblStaff) AND ISNULL(B.ClientEventStatus, 0) <> 4 )N ) M 

	IF NOT EXISTS(SELECT * FROM @CurrentDate)
	  select FORMAT(StartDate, 'h:mm tt') as StartDate, FORMAT(EndDate, 'h:mm tt') as EndDate FROM 
	  (SELECT StartDate, EndDate FROM @Availability where StartDate >= @start and EndDate <= @end ) M order by M.StartDate DESC
	ELSE
	BEGIN
	   --get the min startdate, min end date, max start date and max end date
	   DECLARE @CurrentMinStart DateTime
	   DECLARE @CurrentMaxEnd DateTime
	   SELECT @CurrentMinStart= min(d.StartDate), @CurrentMaxEnd = Max(d.EndDate) FROM 
		  (SELECT A.StartDate, A.EndDate			        
			 FROM (SELECT AppointmentID, EndDate, StartDate, ActionStatus, StatusID FROM dbo.fn_GetAppointmentByDate(@start, @end)
			        WHERE ActionStatus <> 10 AND StatusID NOT in (3, 5) ) A
				 LEFT OUTER JOIN AppointmentWithClient B ON A.AppointmentID = B.AppointmentID
				 INNER JOIN AppointmentWithStaff C ON A.AppointmentID = C.AppointmentID
				 LEFT OUTER JOIN @tblClient D on B.EpisodeID =  D.EpisodeID
			 WHERE ISNULL(B.ClientEventStatus, 0) <> 4  AND 
			       (C.StaffID in (SELECT * FROM @tblStaff)))d
	--return 
	select FORMAT(StartDate, 'h:mm tt') as StartDate, FORMAT(EndDate, 'h:mm tt') as EndDate FROM
	(select * from @Availability Where (StartDate >= @start and EndDate <=@CurrentMinStart) or 
		 (StartDate >= @CurrentMaxEnd and EndDate < @end)
	union
	(select * From @CurrentDate WHERE StartDate <> EndDate and StartDate < EndDate)) M Order by M.StartDate Desc
	END
END
GO
GRANT EXECUTE ON [dbo].[spGetAvailabilityList] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetAvailabilityList] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetClientSummaryList
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetClientSummaryList]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetClientSummaryList]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetClientSummaryList]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
-- =============================================
-- Create date: 2018-01-13
-- Update date: 2020-03-04
-- Description:	Retrive appointment
-- =============================================
CREATE PROCEDURE [dbo].[spGetClientSummaryList] 
	@EpisodeID int = 0	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--DECLARE @EpisodeId int = 583682
DECLARE @ClientEpisodeID int
DECLARE @ClientNoteID int
DECLARE @AddressID int
DECLARE @StaffAssignmentID int
DECLARE @HealthBenefitID int
DECLARE @IDTTID int
DECLARE @MCASRID int
DECLARE @NeedsAssessmentID int
DECLARE @ReEntryIMHSID int
DECLARE @PMHSID int
DECLARE @DSMID int
DECLARE @LegalDocID int
DECLARE @ASMTID int
DECLARE @EvaluationID int
DECLARE @DateAction int
DECLARE @IRPID int
DECLARE @DSM5ID int


SELECT @ClientEpisodeID =[ClientEpisodeID],@ClientNoteID=[ClientNoteID],@AddressID=[AddressID],@StaffAssignmentID=[StaffAssignmentID]
      ,@HealthBenefitID=[HealthBenefitID],@IDTTID=[IDTTID],@MCASRID=[MCASRID],@NeedsAssessmentID=[NeedsAssessmentID]
      ,@ReEntryIMHSID=[ReEntryIMHSID],@PMHSID=[PMHSID],@DSMID=[DSMID],@LegalDocID=[LegalDocID],@ASMTID=[ASMTID]
      ,@EvaluationID=[EvaluationID],@IRPID=[BHRIRPID], @DSM5ID = [DSM5ID]
  FROM [dbo].[EpisodeTrace] Where EpisodeID  = @EpisodeId

  --SELECT @ClientEpisodeID,@ClientNoteID,@AddressID,@StaffAssignmentID,@HealthBenefitID,@IDTTID,@MCASRID,
  --       @NeedsAssessmentID,@ReEntryIMHSID,@PMHSID,@DSMID,@LegalDocID,@ASMTID,@EvaluationDate,@IRPID

--DECLARE @EpisodeId int = 355036
--DECLARE @RowNumber int = 7
 DECLARE @tempCollection TABLE(
     ClientSmy varchar(20) ,
	 Id int,
	 DateType varchar(70),
	 DateEnrolled varchar(30),
	 smydesc varchar(500)
)


IF ISNULL(@ReEntryIMHSID, 0)= 0  
 BEGIN
    INSERT INTO @tempCollection
    SELECT 'ClinicSmy', 0, 'Re-entry Initial', '', ''
 END
ELSE
 BEGIN
    INSERT INTO @tempCollection
	SELECT 'ClinicSmy', Id, 'Re-entry Initial', convert(varchar(10), DateAction, 110),
		   (SELECT Name From dbo.fn_GetAsstUserName(ActionBy))
	  FROM dbo.CaseReEntryIMHS
	 WHERE ActionStatus != 10 AND Id = @ReEntryIMHSID
 END

IF ISNULL(@IRPID, 0)= 0  
 BEGIN
    INSERT INTO @tempCollection
    SELECT 'ClinicSmy', 0, 'IRP Entered', '', ''
 END
ELSE   
 BEGIN
    INSERT INTO @tempCollection
	SELECT 'ClinicSmy', IRPId AS id, 'IRP Entered', convert(varchar(10), DateAction, 110), (SELECT Name From dbo.fn_GetAsstUserName(ActionBy)) 
	  FROM dbo.CaseBHRIRP
	 WHERE ActionStatus != 10 AND IRPId = @IRPID
 END
 IF ISNULL(@DSM5ID, 0)= 0  
 BEGIN
    INSERT INTO @tempCollection
    SELECT 'ClinicSmy', 0, 'DSM-5 Entered', '', ''
 END
ELSE   
 BEGIN
    INSERT INTO @tempCollection
	SELECT 'ClinicSmy', DSM5ID AS id, 'DSM-5 Entered', convert(varchar(10), DateAction, 110), (SELECT Name From dbo.fn_GetAsstUserName(ActionBy)) 
	  FROM dbo.ClinicalDSM5
	 WHERE ActionStatus != 10 AND DSM5ID = @DSM5ID
 END
IF ISNULL(@NeedsAssessmentID, 0)= 0  
  BEGIN
    INSERT INTO @tempCollection
    SELECT 'ClinicSmy', 0, 'Needs Assessment', '', ''
  END
ELSE   
  BEGIN
    INSERT INTO @tempCollection
	SELECT 'ClinicSmy', Id, 'Needs Assessment', convert(varchar(10), DateAction, 110), (SELECT Name From dbo.fn_GetAsstUserName(ActionBy)) 
	  FROM dbo.CaseNeedsAssessment
	 WHERE ActionStatus != 10 AND Id = @NeedsAssessmentID
  END
IF ISNULL(@MCASRID, 0)= 0  
 BEGIN
    INSERT INTO @tempCollection
    SELECT 'ClinicSmy', 0, 'MCASR Entered', '', '' UNION
	SELECT 'CMMCASRScore', 0, 'MCASR Entered', '', ''
 END
ELSE 
 BEGIN  
    INSERT INTO @tempCollection
	SELECT 'ClinicSmy', Id, 'MCASR Entered', convert(varchar(10), DateAction, 110), (SELECT Name From dbo.fn_GetAsstUserName(ActionBy)) 
	  FROM dbo.CaseMCASR
	 WHERE ActionStatus != 10 AND Id = @MCASRID

	 UNION
	 SELECT 'CMMCASRScore', 0, 'Case MCASR Score', convert(varchar(10), DateAction, 110), 
	        Convert(varchar(10), (SELECT ISNULL(Section1Score, 0) + ISNULL(Section2Score, 0) +
                                         ISNULL(Section3Score, 0) + ISNULL(Section4Score, 0)))
	  FROM dbo.CaseMCASR
	 WHERE ActionStatus != 10 AND Id = @MCASRID
 END

IF NOT EXISTS(SELECT 1 FROM CaseNote WHERE EpisodeID = @EpisodeID and ActionStatus != 10 AND ActionModel='Clinic')
BEGIN
   INSERT INTO @tempCollection
   SELECT 'ClinicSmy', 0, 'Note Entered', '', ''
END
ELSE
BEGIN
    INSERT INTO @tempCollection
	SELECT top 1 'ClinicSmy', Id, 'Note Entered', convert(varchar(10), DateAction, 110),  
	(SELECT Name From dbo.fn_GetAsstUserName(ActionBy)) 
	FROM dbo.CaseNote WHERE EpisodeID = @EpisodeID and ActionStatus != 10 AND ActionModel='Clinic'
	order by DateAction desc
END

IF ISNULL(@PMHSID, 0) = 0
  BEGIN  
    INSERT INTO @tempCollection
    SELECT 'ClinicSmy', 0, 'PMHS Entered', '', ''
  END
ELSE
  BEGIN  
     INSERT INTO @tempCollection
     SELECT 'ClinicSmy', Id, (CASE WHEN ISNULl(PMHSDischargeType, 0) < 1 THEN 'PMHS Entered' ELSE 'PMHS Removed' END), 
             convert(varchar(10), DateAction, 110), (SELECT Name From dbo.fn_GetAsstUserName(ActionBy))
       FROM dbo.ClinicalPMHS
      WHERE ActionStatus != 10 AND Id = @PMHSID
  END
 IF ISNULL(@IDTTID, 0) = 0
  BEGIN
    INSERT INTO @tempCollection
    SELECT 'ClinicSmy', 0, 'IDTT Entered', '', ''
  END
ELSE
  BEGIN
     INSERT INTO @tempCollection
     SELECT 'ClinicSmy', Id, 'IDTT Entered', convert(varchar(10), DateAction, 110), (SELECT Name From dbo.fn_GetAsstUserName(ActionBy))
       FROM dbo.ClinicalIDTT
      WHERE ActionStatus != 10 AND Id = @IDTTID

	 UNION
	 SELECT 'ClinicIDTT', 0, '', '', (CASE WHEN IDTTDecision IS NULL THEN '' ELSE 
       (CASE WHEN IDTTDecision = 1 THEN 'Retain in POC at EOP Level of Care' 
			 WHEN IDTTDecision = 2 THEN 'Change Level of Care to CCCMS'
			 WHEN IDTTDecision = 3 THEN 'Transfer to Community Based Treatment'
			 WHEN IDTTDecision = 4 THEN 'No Longer Meets Criteria for Inclusion in MHSDS'
			 WHEN IDTTDecision = 5 THEN 'Place in POC as Medical Necessity with CCCMS LOC'
			 WHEN IDTTDecision = 6 THEN 'Place in POC with CCCMS LOC'
			 WHEN IDTTDecision = 7 THEN 'Place in POC with EOP LOC' 
		ELSE '' END) END) 
	   FROM dbo.ClinicalIDTT
      WHERE ActionStatus != 10 AND Id = @IDTTID
  END

  IF ISNULL(@ClientEpisodeID, 0) = 0
   BEGIN
     INSERT INTO @tempCollection
     SELECT 'ClientSmy', 0, 'Case', '', '' UNION
	 SELECT 'ClientSmy', 0, 'ISMIP', '', '' UNION
	 SELECT 'ClientSmy', 0, 'MAT Program', '', '' UNION
	 SELECT 'ClientSmy', 0, 'CM Program', '', '' UNION
	 SELECT 'ClientSmy', 0, 'CMRPE', '', '' UNION
	 SELECT 'ClientASAMDate', 0, '', '',  ''
   END
  ELSE
   BEGIN
    INSERT INTO @tempCollection
    SELECT 'ClientSmy'ClientSmy, P1.Id, REPLACE(P1.DateType, '_', ' ')DateType, 
    (CASE WHEN P1.DateEnrolled IS NULL OR P1.DateEnrolled = '01/01/1900' then '' ELSE Convert(varchar(10), P1.DateEnrolled, 110) END )DateEnrolled, 
    (CASE WHEN P2.DateEnrolled IS NULL OR P2.DateEnrolled = '01/01/1900' then '' ELSE Convert(varchar(10), P2.DateEnrolled, 110) END )smydesc from 
     (SELECT ClientEpisodeid as Id, (CASE WHEN IntakeDate IS NOT NULL THEN IntakeDate ELSE '' END) as [Case], 
			 (CASE WHEN ISMIPEnrolledDate IS NOT NULL THEN ISMIPEnrolledDate ELSE '' END)ISMIP,
			 (CASE WHEN MATProgramStartDate IS NOT NULL THEN MATProgramStartDate ELSE '' END)MAT_Program,
			 (CASE WHEN CMProgramStartDate IS NOT NULL THEN CMProgramStartDate ELSE '' END)CM_Program,
			 (CASE WHEN CMRPEStartDate IS NOT NULL THEN CMRPEStartDate ELSE '' END)CMRPE
		FROM ClientEpisode where ClientEpisodeID = @ClientEpisodeID) X
      unpivot
     (DateEnrolled for DateType in ([Case],  ISMIP, MAT_Program, CM_Program, CMRPE)) as P1 LEFT OUTER JOIN

     (SELECT ClientEpisodeid as Id, 
			 (CASE WHEN CaseClosureDate IS NOT NULL THEN CaseClosureDate ELSE '' END)[Case], 
			 (CASE WHEN ISMIPClosedDate IS NOT NULL THEN ISMIPClosedDate ELSE '' END)ISMIP,
			 (CASE WHEN MATProgramClosedDate IS NOT NULL THEN MATProgramClosedDate ELSE '' END)MAT_Program,
			 (CASE WHEN CMProgramClosedDate IS NOT NULL THEN CMProgramClosedDate ELSE '' END)CM_Program,
			 (CASE WHEN CMRPEClosedDate IS NOT NULL THEN CMRPEClosedDate ELSE '' END)CMRPE from
		     ClientEpisode where ClientEpisodeID = @ClientEpisodeID) X1
      unpivot
      (DateEnrolled for DateType in ([Case],  ISMIP, MAT_Program, CM_Program, CMRPE)) as  P2 on P1.DateType = P2.DateType
	  

	 UNION
  
     SELECT 'ClientASAMDate', 0, '', (CASE WHEN ASAMDate IS NOT NULL THEN Convert(varchar(10), ASAMDate, 110) ELSE '' END), '' FROM ClientEpisode 
                              WHERE ClientEpisodeID = @ClientEpisodeID AND ActionStatus != 10 
   END

IF ISNULL(@LegalDocID, 0) = 0  
 BEGIN
   INSERT INTO @tempCollection
   SELECT 'DocSmy', 0, 'Notice Of Privacy Practices', '', ''  UNION
   SELECT 'DocSmy', 0, 'Informed Consent for Treatment', '', '' UNION
   SELECT 'DocSmy', 0, 'Release Info Expiration', '', '' UNION
   SELECT 'DocSmy', 0, 'Other', '', '' UNION
   Select 'OtherDocDesc', 0, '', '', '' 
 END
ELSE
 BEGIN
   INSERT INTO @tempCollection
   SELECT 'DocSmy'ClientSmy, p.Id, REPLACE(p.DateType, '_', ' ')DateType, p.DateEnrolled, '' as smydesc FROM  
	 (select Id, (CASE WHEN DateNoticePrivacyPractice IS NULL OR DateNoticePrivacyPractice = '01/01/1900' THEN '' ELSE Convert(varchar(10),  DateNoticePrivacyPractice, 110) END) as Notice_Of_Privacy_Practices, 
			 (CASE WHEN DateInformedConcentForTreatment IS NULL OR DateInformedConcentForTreatment = '01/01/1900' THEN '' ELSE Convert(varchar(10),DateInformedConcentForTreatment, 110) END)Informed_Consent_for_Treatment, 
			 (CASE WHEN DateReleaseInfoExpiration IS NULL OR DateReleaseInfoExpiration= '01/01/1900' THEN '' ELSE Convert(varchar(10), DateReleaseInfoExpiration, 110) END)Release_Info_Expiration, 
			 Convert(varchar(10), DateAction, 110)[Doc._Entered],
			 (CASE WHEN DateOther IS NULL OR DateOther= '01/01/1900' THEN '' ELSE Convert(varchar(10), DateOther, 110) END)Other FROM dbo.LegalDocument  where ID = @LegalDocID AND ActionStatus != 10) X
		 unpivot
		 ( 
		   DateEnrolled for DateType in (Notice_Of_Privacy_Practices, Informed_Consent_for_Treatment, Release_Info_Expiration, [Doc._Entered],Other)
	  ) as p

	  UNION
	  SELECT 'OtherDocDesc', 0, '', '', 
           (SELECT OtherDdesc FROM dbo.LegalDocument WHERE ActionStatus != 10 AND ID = @LegalDocID)
  END

  INSERT INTO @tempCollection
  SELECT TOP 6 'DSMSmy'ClientSmy, Id, (Select Name FROM dbo.fn_GetAsstUserName(ActionBy))DateType, convert(varchar(10), DateAction, 110)DateEnrolled, Concat(ICDCode, '--' , DSMDesc)smydesc 
  FRom dbo.DsmDiagnosis t1 INNER JOIN dbo.tlkpICD_DX_Codes t2 ON t1.MasterDXId =  t2.MasterDXId  Where ActionStatus != 10 AND DSMID  = @DSMID ORDER BY smydesc

IF EXISTS(SELECT 1 FROM CaseNote Where ActionModel = 'psy' AND ActionStatus != 10 and EpisodeId = @EpisodeID)
BEGIN
  Insert INTO @tempCollection
  SELECT TOP 1 'PsyNote'ClientSmy, Id, 'Psychiatrist Note', convert(varchar(10), DateAction, 110)DateEnrolled, '' FROM CaseNote
     Where ActionModel = 'psy' AND ActionStatus != 10 and EpisodeId = @EpisodeID Order By Id Desc
END

IF EXISTS(SELECT 1 FROM PsychiatryASMT Where EpisodeId = @EpisodeID)
BEGIN
  Insert INTO @tempCollection
  SELECT TOP 1 'PsyMMA'ClientSmy, Id, 'Psychiatrist MMA', convert(varchar(10), ASMTDate, 110)DateEnrolled, '' FROM PsychiatryASMT
     Where EpisodeId = @EpisodeID Order By Id Desc
END

IF @EvaluationID IS NOT NULL
BEGIN
    INSERT INTO @tempCollection
	SELECT TOP 6 'EveSmy'ClientSmy, ID, Convert(varchar(10), ID)DateType, convert(varchar(10), DateAction, 110)DateEnrolled, 
	       (Select Name FROM fn_GetAsstUserName(EvaluatedBy))smydesc
	  FROM  (SELECT ID, EpisodeID, DateAction, EvaluatedBy, ROW_NUMBER() OVER (PARTITION BY EpisodeEvaluationGUID
					ORDER BY ID DESC) AS RowNum
			   FROM EpisodeEvaluation  
			  WHERE EvaluationItemID = 1 AND ActionStatus <> 10 AND EpisodeID  =@EpisodeID ) T
	 WHERE T .RowNum = 1 ORDER BY DateAction DESC
 END



Select * from @tempCollection

SELECT TOP 6 'Assignment'ClientSmy, ID as Id, convert(varchar(10), DateAction, 110)DateEnrolled, 
	    (CASE WHEN ISNULL(CaseManagerUserId, 0) > 0 THEN (Select Name FROM dbo.fn_GetAsstUserName(CaseManagerUserId)) ELSE '' END) AS CaseManager, 
		(CASE WHEN ISNULL(SocialWorkerUserId, 0) > 0 THEN (Select Name FROM dbo.fn_GetAsstUserName(SocialWorkerUserId)) ELSE '' END) AS SocialWorker, 
		(CASE WHEN ISNULL(PsychologistUserId, 0) > 0 THEN (Select Name FROM dbo.fn_GetAsstUserName(PsychologistUserId)) ELSE '' END) AS Psychologist, 
		(CASE WHEN ISNULL(PsychiatristUserId, 0) > 0 THEN (Select Name FROM dbo.fn_GetAsstUserName(PsychiatristUserId)) ELSE '' END) AS Psychiatrist
 FROM StaffAssignment 
WHERE EpisodeID =@EpisodeID AND NOT (ISNULL(PsychologistUserId, 0) = 0 and ISNULL(PsychiatristUserId, 0) = 0 and
    ISNULL(SocialWorkerUserId, 0)= 0 and ISNULL(CaseManagerUserId, 0)= 0) Order BY ID DESC

SELECT DISTINCT top 6 t.AppointmentID AS ID,t.StartDate,'' AS Progress,
    Clinician = STUFF((SELECT ';' + Staffs 
                    FROM 
					(SELECT (SELECT Name FROM dbo.fn_GetAsstUserName(StaffID))Staffs FROM AppointmentWithStaff WHERE AppointmentID  =t.AppointmentID)ta
                    FOR XML PATH('')), 1, 1, ''), (SELECT [dbo].[fnGetApptTypeDesc](t.TypeID)) as EventTypeDescr,
	(CASE t3.ClientEventStatus WHEN 1 THEN 'Absent' WHEN 2 THEN 'Pending' WHEN 3 THEN 'Present' WHEN 4 THEN 'Excused' WHEN 5 THEN 'Canceled' END)as eventstatus	
	FROM Appointment t INNER JOIN AppointmentTrace t1 on t.AppointmentID= t1.AppointmentID INNER JOIN  AppointmentWithStaff t2 ON t.AppointmentID= t2.AppointmentID 
					INNER Join AppointmentWithClient t3 ON t.AppointmentID = t3.AppointmentID WHERE t.ActionStatus <> 10 AND t3.EpisodeID = @EpisodeID Order BY t.StartDate DESC


SELECT ISNULL(ParoleLocationID, 0)ParoleLocationID From Episode Where EpisodeID  = @EpisodeID
--SELECT DISTINCT top 6 t.AppointmentID AS ID,t.StartDate,'' AS Progress,
--     Clinician = STUFF((SELECT ';' + Staffs 
--                      FROM 
--					  (SELECT (SELECT Name FROM dbo.fn_GetAsstUserName(a2.StaffID))Staffs FROM Appointment a0 
--					     INNER JOIN  AppointmentWithStaff a2 ON a0.AppointmentID= a2.AppointmentID 
--					     INNER Join AppointmentWithClient a3 ON a0.AppointmentID = a3.AppointmentID 
--						WHERE a0.ActionStatus <> 10 AND a0.AppointmentID = t.AppointmentID)ta 
--                      FOR XML PATH('')), 1, 1, ''), (SELECT [dbo].[fnGetApptTypeDesc](t.TypeID)) as EventTypeDescr,
--	 (CASE t3.ClientEventStatus WHEN 1 THEN 'Absent' WHEN 2 THEN 'Pending' WHEN 3 THEN 'Present' WHEN 4 THEN 'Excused' WHEN 5 THEN 'Canceled' END)as eventstatus	
--	 FROM Appointment t INNER JOIN AppointmentTrace t1 on t.AppointmentID= t1.AppointmentID INNER JOIN  AppointmentWithStaff t2 ON t.AppointmentID= t2.AppointmentID 
--					  INNER Join AppointmentWithClient t3 ON t.AppointmentID = t3.AppointmentID WHERE t.ActionStatus <> 10 AND t3.EpisodeID = @EpisodeID Order BY t.StartDate DESC
END
GO
GRANT EXECUTE ON [dbo].[spGetClientSummaryList] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetClientSummaryList] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetEpisodeAddress
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeAddress]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeAddress]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeAddress]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
-- =============================================
-- Create date: 2020-04-06
-- Description:	Get Each Type of Latest Address 
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeAddress] 
	@EpisodeID int = null,
	@AddressTypeID int = 0
AS
BEGIN
   
 DECLARE @True BIT = 1
 DeCLARE @False BIT = 0
 IF @AddressTypeID = 0 
SELECT [ID],[EpisodeID],T.[AddressTypeID], @True AS CaseEdit, A.[AddressTypeDesc]AddressTypeName,
       [LivingSituationID]AddressLivingSituationID,B.[LivingSituationDesc],[FacilityName],
	   [StreetAddress],[City],[State],[ZIPCode],[PrimaryNumber],[SecondaryNumber],[FaxNumber],
	   [EffectiveDate],[ExpirationDate],[AddressDetails],T.[DateAction],
	   (SELECT NAME FROM fn_GetAsstUserName(ActionBy))ActionByName,[Inactive],
	   (CASE WHEN T.AddressTypeID=1 THEN @True ELSE @False END) LivingSituationShow, CONVERT(int, Totals)Totals FROM
(SELECT [ID],[EpisodeID],[AddressTypeID],[FacilityName],[StreetAddress]
      ,[City],[State],[ZIPCode],[LivingSituationID],[Inactive]
      ,[EffectiveDate],[ExpirationDate],[AddressDetails],[PrimaryNumber]
      ,[SecondaryNumber],[FaxNumber],[OrderBy],[ActionStatus]
      ,[ActionBy],[DateAction],[ActionModel], 
	   ROW_NUMBER() OVER (PARTITION BY EpisodeID,AddressTypeID ORDER BY ID) AS Totals,
	   ROW_NUMBER() OVER (PARTITION BY EpisodeID,AddressTypeID ORDER BY ID DESC) AS RowNum
  FROM [dbo].[Address]
 where episodeid=@EpisodeID AND ActionStatus <> 10
 Group BY AddressTypeID, [EpisodeID],[ID],[FacilityName],[StreetAddress]
      ,[City],[State],[ZIPCode],[LivingSituationID],[Inactive]
      ,[EffectiveDate],[ExpirationDate],[AddressDetails],[PrimaryNumber]
      ,[SecondaryNumber],[FaxNumber],[OrderBy],[ActionStatus]
      ,[ActionBy],[DateAction],[ActionModel]) T 
	 INNER JOIN tlkpAddressType A ON T.AddressTypeID = A.AddressTypeID
	 LEFT OUTER JOIN tlkpAddressLivingSituation B ON T.LivingSituationID = B.AddressLivingSituationID
 WHERE T.RowNum = 1
 ELSE
 SELECT [ID],[EpisodeID],T.[AddressTypeID], @True AS CaseEdit, [AddressTypeDesc]AddressTypeName,
       [LivingSituationID]AddressLivingSituationID,B.[LivingSituationDesc],[FacilityName],
	   [StreetAddress],[City],[State],[ZIPCode],[PrimaryNumber],[SecondaryNumber],[FaxNumber],
	   [EffectiveDate],[ExpirationDate],[AddressDetails],T.[DateAction],
	   (SELECT NAME FROM fn_GetAsstUserName(ActionBy))ActionByName,[Inactive],
	   (CASE WHEN T.AddressTypeID=1 THEN @True ELSE @False END) LivingSituationShow, 
	   (CASE T.ActionStatus WHEN 1 THEN 'Initial' WHEN 2 THEN 'Update' WHEN 10 THEN 'Delete' END)ActionStatus,
	   0 AS Totals
  FROM [dbo].[Address] T
    INNER JOIN tlkpAddressType A ON T.AddressTypeID = A.AddressTypeID
	LEFT OUTER JOIN tlkpAddressLivingSituation B ON T.LivingSituationID = B.AddressLivingSituationID
 WHERE episodeid=@EpisodeID AND T.AddressTypeID = @AddressTypeID
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeAddress] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeAddress] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetEpisodeAlert
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeAlert]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeAlert]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeAlert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
-- =============================================
-- Create date: 2020-04-06
-- Description:	Get Each Type of Latest Address 
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeAlert] 
	@EpisodeID int,
	@AlertTypeID int = 0
AS
BEGIN   
  DECLARE @val NVarchar(MAX);
  DECLARE @val1 NVarchar(MAX);  
   SELECT @val = COALESCE(@val + ',' + ADAECIDs, ADAECIDs) 
     FROM Appointment t1 INNER JOIN AppointmentTrace t2 on t1.AppointmentID =  t2.AppointmentID	
		     inner join appointmentwithClient t3 on t1.AppointmentID  = t3.AppointmentID  
	WHERE t1.ADAECIDs is not null and t1.StartDate >= DateAdd(year, -1, GetDate())  and t1.ActionStatus <> 10 And 
	         EpisodeID  = @EpisodeID

   SELECT @val1 = COALESCE(@val1 + (char(13) + char(10)) + ADAECDescription, ADAECDescription) FROM [dbo].[tlkpADAOrEC] WHERE ID IN
     (SELECT splitdata FROM [dbo].[fnSplitString](@val, ','))

   DECLARE @lastNote int = (SELECT ClientNoteID FROM dbo.EpisodeTrace WHERE EpisodeID  =  @EpisodeID)
   IF ISNULL(@lastNote, 0) = 0
      SELECT 0 AS ClientNoteID, @EpisodeID AS EpisodeID, 1 as NoteType, ''NoteField, 
          convert(varchar(10), GetDate(), 110)EntryDate, 0 AS EntryID, ''NoteOrComments,
		  1 AS ActionStatus, ''ActionByName, @val1 AS ADAE
   ELSE
      SELECT [ClientNoteID], [EpisodeID], [NoteType], [NoteField], 
	       convert(varchar(10), EntryDate, 110)[EntryDate], EntryID, ISNULL(NoteOrComments,'')NoteOrComments,
	       ActionStatus, (SELECT NAME FROM fn_GetAsstUserName(EntryID))ActionByName, @val1 AS ADAE
	    FROM [dbo].[ClientNote]
       WHERE ClientNoteID =@lastNote AND NoteType  = @AlertTypeID
     --DECLARE @EpisodeID int = 669916
  ----DECLARE @val1 NVarchar(MAX); 
  ----SELECT @val1 = STRING_AGG(ADAECDescription, (char(13)+ char(10))) FROM [dbo].[tlkpADAOrEC] WHERE ID IN
  ----(SELECT distinct splitdata from [dbo].[fnSplitString](   
  ----   (SELECT STRING_AGG(t1.ADAECIDs, ',')
  ----      From Appointment t1 INNER JOIN AppointmentTrace t2 on t1.AppointmentID =  t2.AppointmentID inner join appointmentwithClient t3 on t1.AppointmentID  = t3.AppointmentID  
	 ----  Where t1.ADAECIDs is not null and t1.StartDate >= DateAdd(year, -1, GetDate())  and t1.ActionStatus <> 10 And 
	 ----        EpisodeID  = @EpisodeID), ','))
   --=====================================================================================================
 --Original SP
 --DECLARE @lastNote int = (SELECT ClientNoteID FROM dbo.EpisodeTrace WHERE EpisodeID  =  @EpisodeID)
 
 --IF ISNULL(@lastNote, 0) = 0
 --  SELECT 0 AS ClientNoteID, @EpisodeID AS EpisodeID, 1 as NoteType, ''NoteField, 
 --         convert(varchar(10), GetDate(), 110)EntryDate, 0 AS EntryID, ''NoteOrComments,
	--	  1 AS ActionStatus, ''ActionByName
 --ELSE
 --   SELECT [ClientNoteID], [EpisodeID], [NoteType], [NoteField], 
	--       convert(varchar(10), EntryDate, 110)[EntryDate], EntryID, ISNULl(NoteOrComments,'')NoteOrComments,
	--       ActionStatus, (SELECT NAME FROM fn_GetAsstUserName(EntryID))ActionByName
	--  FROM [dbo].[ClientNote]
 --    WHERE ClientNoteID =@lastNote AND NoteType  = @AlertTypeID
 --===========================================================================================================
END 
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeAlert] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeAlert] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetEpisodeCaseNote
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeCaseNote]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeCaseNote]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeCaseNote]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
-- =============================================
-- Create date: 2020-03-08
-- Update date: 
-- Description:	Retrive Case Note
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeCaseNote]
    @EpisodeID int = 0,
	@CaseNoteID int = 0
AS	
BEGIN
   DECLARE @True bit = 1
   DECLARE @False bit =0
   
   IF  @CaseNoteID = 0 
   BEGIN     
   --DECLARE @True bit = 1
   --DECLARE @False bit =0
      --case note by EpisodeID
	    SELECT Id, t1.CaseNoteId,t1.CaseNoteTypeId, (CASE WHEN DateDiff(hour, t1.DateAction, GetDate()) > 24 THEN @True ELSE @False END) UpdateExpired,
		       (SELECT dbo.fnGetCaseNoteTypeDesc(t1.CaseNoteTypeId))CaseNoteType,t1.CaseContactMethodID,
			   (SELECT dbo.fnGetCaseContactMethodDesc(t1.CaseContactMethodID))CaseContactMethod, Note, t1.DateAction, 
	           (SELECT Name FROm dbo.fn_GetAsstUserName(t1.ActionBy)) ActionByName, t1.ActionModel
			   --, (CASE WHEN t1.Id = t1.CaseNoteId THEN @False ELSE @True END)HasHistory
		FROM dbo.CaseNote t1 INNER JOIN dbo.CaseNoteTrace t2 on t1.Id  = t2.NoteId 
	   WHERE EpisodeID  = @EpisodeID 
	END
	ELSE
	BEGIN
	 --detail note
	 SELECT Id, t1.CaseNoteId, DateAction, Note AS HisNote, (SELECT dbo.fnGetCaseContactMethodDesc(t1.CaseContactMethodID))CaseContactMethod, 
		       (SELECT dbo.fnGetCaseNoteTypeDesc(t1.CaseNoteTypeId))CaseNoteType,
	           (SELECT Name FROm dbo.fn_GetAsstUserName(t1.ActionBy)) ActionByName, 
			   (CASE ActionStatus WHEN 1 THEN 'Inital' When 2 THEN 'Update' ELSE '' END)ActionStatus, t1.ActionModel
		FROM dbo.CaseNote t1 INNER JOIN dbo.CaseNoteTrace t2 on t1.CaseNoteId  = t2.CaseNoteId 
	   WHERE t1.CaseNoteId = @CaseNoteID 
	END
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeCaseNote] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeCaseNote] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetEpisodeClinicalPMHS
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeClinicalPMHS]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeClinicalPMHS]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeClinicalPMHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-06-08
-- Update date: 
-- Description:	Retrive PMHS
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeClinicalPMHS]
    @EpisodeID int = 0,
	@PMHSID int = 0
AS	
BEGIN
   DECLARE @True bit = 1
   DECLARE @False bit =0
   DECLARE @IsLastPMHSSet bit  =0
   IF  @EpisodeID > 0 
   BEGIN
      DECLARE @LPMHSID  int
	  DECLARE @LCEId int
	  DECLARE @MhStatus int = 0
	  SELECT @LPMHSID = ISNULl(PMHSID, 0), @LCEId=ISNULl(ClientEpisodeID,0) FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID

	  IF @LPMHSID = @PMHSID OR @PMHSID = 0
		     SET @IsLastPMHSSet = 1

	  IF @PMHSID > 0 
	        SET @LPMHSID =@PMHSID

	 --IF @LCEId > 0
	 --  SET @MhStatus = (SELECT ISNULl(ParoleMentalHealthLevelOfServiceID,0) FROM ClientEpisode Where ClientEpisodeID  =@LCEId)

	  IF @LPMHSID > 0 
	  BEGIN
	   SELECT Id, (CASE WHEN ISNULL(InclusionInPMHS, 0) = 1 THEN @True 
			         ELSE @False END)InclusionInPMHSNoMeet,
			   (CASE WHEN ISNULL(InclusionInPMHS, 0) = 2 THEN @True 
			         ELSE @False END)InclusionInPMHSMeet,
			   (CASE WHEN ISNULL(InclusionInPMHS, 0) = 3 THEN @True 
			         ELSE @False END)InclusionInPMHSCurrent,
               ISNULL(MentalDisorder, @False)MentalDisorder,   
			   (CASE WHEN MHDesignation = 4 THEN @True ELSE @False END)ForMedicalNecessity, 
               (CASE WHEN MHDesignation = 2 THEN @True ELSE @False END)ForEOP,
			   (CASE WHEN MHDesignation = 7 THEN @True ELSE @False END)ForConstituteToEOP,
			   (CASE WHEN MHDesignation = 3 THEN @True ELSE @False END)ForCCCMS,                   
               (CASE WHEN MHDesignation = 6 THEN @True ELSE @False END)ForConstituteToCCCMS,
               @False AS IsRenew,ISNULl(RefForWelfare, @False)RefForWelfare,
               @False AS IsRenew,ISNULl(RefForWelfare, @False)RefForWelfare,
			   ISNULl(RefToContratedService, @False)RefToContratedService, 
			   RefToContratedServiceNote,
			   ISNULl(RefForResourcePlan, @False)RefForResourcePlan,RefForResourcePlanNote,
			   ISNULl(RefForDischarge, @False)RefForDischarge,ISNULL(Other, @False)Other,OtherNote,
			   LGAFScore, 
			   (CASE WHEN ISNULl(PsychottropicPrescribed,@False) = 1 THEN @True ELSE  @False END)PsychottropicPrescribedYes,
			   (CASE WHEN ISNULl(PsychottropicPrescribed,@False) = 0 THEN @True ELSE  @False END)PsychottropicPrescribedNo,BehavioralAlerts,PMHSChangeDate,PMHSChangeNote,PMHSDischargeNote,
			   PMHSDischargeDate, (SELECT Name FROM dbo.fn_GetAsstUserName(ActionBy))ClinicianName, TeamLeaderName,SupervisorName, TeamLeaderSigDate,SupervisorSigDate,
			   (CASE WHEN ISNULl(PMHSDischargeType, -1) = 1 THEN @True ELSE @False END)PMHSDischargeA, 
			   (CASE WHEN ISNULl(PMHSDischargeType, -1) = 2 THEN @True ELSE @False END)PMHSDischargeB, 
			   (CASE WHEN ISNULl(PMHSDischargeType, -1) = 3 THEN @True ELSE @False END)PMHSDischargeC, 
			   (CASE WHEN ISNULl(PMHSDischargeType, -1) = 4 THEN @True ELSE @False END)PMHSDischargeD,
               ISNULl(PMHSDischargeType, -1)PMHSDischargeType,
			   (CASE WHEN ISNULl(PMHSDischargeType, -1) = 1 THEN PMHSDischargeDate ELSE null END)PMHSDischargeDateA,  
			   (CASE WHEN ISNULl(PMHSDischargeType, -1) = 2 THEN PMHSDischargeDate ELSE null END)PMHSDischargeDateB, DateAction        
       FROM [dbo].[ClinicalPMHS] WHERE EpisodeID  = @EpisodeID AND Id = @LPMHSID
	  END
	  ELSE
	  BEGIN
	   SELECT 0, @False AS InclusionInPMHSNoMeet, @False AS InclusionInPMHSMeet, 
	          @False AS InclusionInPMHSCurrent, @False AS MentalDisorder,
			  @False AS ForMedicalNecessity,@False AS ForEOP,
		      @False AS ForConstituteToEOP,@False AS ForCCCMS, @False AS ForConstituteToCCCMS,
			  @False AS IsRenew, @False AS RefForWelfare,@False AS RefToContratedService,
			  @False AS RefForResourcePlan, '' AS RefForResourcePlanNote,
			  @False AS RefForDischarge, @False AS Other, '' AS OtherNote, 0 AS LGAFScore,
			  @False AS PsychottropicPrescribedYes,
			  @False AS PsychottropicPrescribedNo, '' AS BehavioralAlerts, null AS PMHSChangeDate, 
			  '' AS PMHSChangeNote, '' AS PMHSDischargeNote,null AS PMHSDischargeDate,
			  '' AS ClinicianName, '' AS TeamLeaderName, '' AS SupervisorName, 
			  null AS TeamLeaderSigDate, null AS  SupervisorSigDate,
			  @False AS PMHSDischargeA, @False AS PMHSDischargeB,@False AS PMHSDischargeC,
			  @False AS PMHSDischargeD,-1 AS PMHSDischargeType,
			  null AS PMHSDischargeDateA, null AS PMHSDischargeDateB, GetDate() as DateAction
	  END
	END
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeClinicalPMHS] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeClinicalPMHS] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodeDropDownList
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeDropDownList]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeDropDownList]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeDropDownList]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetEpisodeDropDownList]
    @SearchString varchar(50) = ''
AS	
BEGIN
   
IF @searchString <> ''
BEGIN

SELECT  TOP 100 CONVERT(VARCHAR(10),e.EpisodeID) as Value, CONCAT(CONVERT(VARCHAR(12), o.PID),' - ',
	   e.CDCRNum, ' - ', o.LastName, ',', o.FirstName, ' ', ISNULL(o.MiddleName, ''))[Text] 
  FROM EPISODE e INNER JOIN OFFENDER o ON e.OffenderID  =  o.OffenderID
  WHERE CONCAT(CONVERT(VARCHAR(12), o.PID),' - ',
	   e.CDCRNum, ' - ', o.LastName, ',', o.FirstName, ' ', ISNULL(o.MiddleName, '')) like '%' + @searchString + '%'
ORDER BY (CASE WHEN e.ReleaseDate IS NOT NULL THEN e.ReleaseDate
	            ELSE e.SuggestionDate END) DESC, LastName, FirstName

END
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeDropDownList] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeDropDownList] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodeDSM
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeDSM]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeDSM]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeDSM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-04-06
-- Description:	Get Each Type of Latest Address 
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeDSM] 
	@EpisodeID int,
	@DSMID int = 0
AS
BEGIN
   
 DECLARE @lastDSM int = (SELECT ISNULL(DSMID,0) FROM dbo.EpisodeTrace WHERE EpisodeID  =  @EpisodeID)
 
 IF @lastDSM > 0
  BEGIN
    IF @lastDSM <> @DSMID AND @DSMID > 0
	   SET @lastDSM = @DSMID
    SELECT l1.Id, l1.DsmId, l1.MasterDXId, l1.DateAction AS DateDsmDate, l2.ICDCode, 
           FORMAT(l1.DateAction, 'MM/dd/yyyy')OnsetDate, l2.[Version], 
	       l1.Note AS Comments, l4.Question AS DsmType, l1.DsmTypeId, ISNULl(l1.DsmSpecifierId, 0)
		   DsmSpecifierId, l2.DSMDesc,l5.SubQuestion AS DsmSpecifier, 
		   (SELECT Name FROM dbo.fn_GetAsstUserName(l1.ActionBy))ClinicalName
      FROM dbo.DsmDiagnosis l1 INNER Join dbo.tlkpICD_DX_Codes l2 
	    on l1.MasterDXId = l2.MasterDXId 
      INNER JOIN dbo.[User] l3 on l1.ActionBy = l3.UserID
      LEFT OUTER JOIN dbo.tlkpDsmQuestion l4 on l1.DsmTypeId = l4.Id 
      LEFT OUTER JOIN dbo.tlkpDsmSubQuestion l5 on l1.DsmSpecifierId = l5.Id
     WHERE l1.ActionStatus != 10  AND l1.DsmId = @lastDSM order by l1.Id DESC 
  END
END 
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeDSM] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeDSM] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodeEvaluation
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeEvaluation]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeEvaluation]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeEvaluation]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-03-08
-- Update date: 
-- Description:	Retrive Evaluation
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeEvaluation]
    @EpisodeID int = 0,
	@EvaluationID int = 0   -- ID of (EvaluationItemID = 1)
AS	
BEGIN
   DECLARE @True bit = 1
   DECLARE @False bit =0
   DECLARE @date DateTime
   DECLARE @IsLastEvlID int = 0
   DECLARE @IsLastEvlSet bit = @False
      
	SET @IsLastEvlID = (SELECT ISNULl(EvaluationID,0) FROM EpisodeTrace Where EpisodeID = @EpisodeID )
	IF (@IsLastEvlID > 0 AND @IsLastEvlID = @EvaluationID) OR (@IsLastEvlID = 0 AND @EvaluationID =0)
	   SET @IsLastEvlSet = @True

	IF @EvaluationID > 0 AND @IsLastEvlID <> @EvaluationID
	  SET @IsLastEvlID = @EvaluationID
   
   SET @date = (SELECT DateAction FROM dbo.EpisodeEvaluation WHERE ID  =  @IsLastEvlID)

    IF @EvaluationID > 0
	  BEGIN
	  DECLARE @EvlBy int
	  DECLARE @ActionStatus int
	  DECLARE @DateAction DateTime
	  SELECT @EvlBy = EvaluatedBy, @ActionStatus=ActionStatus, @DateAction = DateAction FROM dbo.EpisodeEvaluation WHERE ID =  @EvaluationID

	  SELECT ISNULL(t2.ID,0)ID, convert(nvarchar(50),EpisodeEvaluationGUID) AS EvaluationGUID, CONVERT(nvarchar(36),ISNULL(t2.EvaluatedBy, @EvlBy))EvaluatedBy, ISNULL(t2.DateAction, @DateAction)DateAction, 
	        (SELECT ISNULL(Name,'') From dbo.fn_GetAsstUserName(ISNULL(t2.EvaluatedBy, @EvlBy))) AS EvaluatedName, 
	        t1.EvaluationItemID, t1.EvaluationItemDescr AS EvaluationItemDesc, 
	        ISNULL(t2.EvaluationNote,'')EvaluationItemNote, 
		    (CASE ISNULL(ActionStatus,@ActionStatus)  WHEN 1 THEN 'Initial' WHEN 2 THEN 'Update' WHEN 3 THEN 'Reinitial' ELSE '' END)EvaluationStatus, @DateAction AS EvaluationDate,
			@IsLastEvlSet AS IsLastEvlSet,@False AS IsInitial
	   FROM dbo.tlkpEvaluationItem t1 LEFT OUTER JOIN (SELECT * FROM dbo.EpisodeEvaluation WHERE DateAction = @DateAction AND EpisodeID = @EpisodeID) t2 
	     ON t1.EvaluationItemID = t2.EvaluationItemId
	  END
	  ELSE IF @EvaluationID = -1
	  BEGIN
	    SELECT ISNULL(t2.ID, 0)ID, convert(nvarchar(50),EpisodeEvaluationGUID) AS EvaluationGUID, CONVERT(nvarchar(36),EvaluatedBy)EvaluatedBy,
	        (SELECT Name From dbo.fn_GetAsstUserName(EvaluatedBy))EvaluatedName, 
	        t1.EvaluationItemID, ISNULl(t1.EvaluationItemDescr,'') AS EvaluationItemDesc, 
	        ISNULL(t2.EvaluationNote,'')EvaluationItemNote, 
		    (CASE ActionStatus WHEN 1 THEN 'Initial' WHEN 2 THEN 'Update' WHEN 3 THEN 'Reinitial' END)EvaluationStatus, t2.DateAction AS EvaluationDate,
			@IsLastEvlSet AS IsLastEvlSet,@False AS IsInitial
	   FROM dbo.tlkpEvaluationItem t1 LEFT OUTER JOIN dbo.EpisodeEvaluation t2 
	     ON t1.EvaluationItemID = t2.EvaluationItemId
	  WHERE EpisodeID  = @EpisodeID
	  ORDER BY t2.DateAction DESC, t1.EvaluationItemID
	  END
	  ELSE
	  BEGIN
	  SELECT 0 AS ID, '' AS EvaluationGUID, 0 AS EvaluatedBy, '' AS EvaluatedName, EvaluationItemID, 
	        EvaluationItemDescr AS EvaluationItemDesc,'' AS EvaluationItemNote, 
			'Initial' AS EvaluationStatus, Getdate() AS EvaluationDate,
			@IsLastEvlSet AS IsLastEvlSet,
            @True AS IsInitial
	   FROM dbo.tlkpEvaluationItem ORDER BY EvaluationItemID
	  END

END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeEvaluation] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeEvaluation] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodeHealthBenefit
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeHealthBenefit]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeHealthBenefit]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeHealthBenefit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-04-06
-- Description:	Get Each Type of Latest Address 
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeHealthBenefit] 
	@EpisodeID int,
	@BenefitTypeID int = 0
AS
BEGIN
   
 DECLARE @True BIT = 1
 DeCLARE @False BIT = 0
 IF @BenefitTypeID = 0 
 BEGIN
SELECT [EpisodeID],[ID],(CASE [BenefitTypeID] WHEN 1 THEN 'SSI' WHEN 2 THEN 'VA' WHEN 3 THEN 'MediCal' 
                         ELSE '' END) BenefitTypeDesc,
	  (CASE WHEN [AppliedOrRefused] IS NULL THEN '' 
	        WHEN [AppliedOrRefused] = 1 THEN 'A' 
	        WHEN [AppliedOrRefused] = 0 THEN 'R' END)AgreeType,[BenefitTypeID],
       [AppliedOrRefusedOnDate],[PhoneInterviewDate],[OutcomeDate],[OutcomeID],
       (CASE WHEN ISNULL([OutcomeID], 0) =0 THEN '(Pending)' ELSE A.Name END)OutCome,[BICNum],
	   [IssuedOnDate],[ArchivedOnDate],[ActionStatus],[ActionBy],     
	  (SELECT Name FROM dbo.fn_GetAsstUserName(ActionBy))ActionByName,[AppliedOrRefused],
	  [NoteOrComment],[DateAction], CONVERT(int, Totals)Totals FROM
(SELECT [EpisodeID],[ID],[BenefitTypeID],[AppliedOrRefusedOnDate],[PhoneInterviewDate]
      ,[OutcomeID],[OutcomeDate],[BICNum],[AppliedOrRefused],[IssuedOnDate]
      ,[ArchivedOnDate],[ActionStatus],[ActionBy],[DateAction],[NoteOrComment],
	   ROW_NUMBER() OVER (PARTITION BY EpisodeID,[BenefitTypeID] ORDER BY ID) AS Totals,
	   ROW_NUMBER() OVER (PARTITION BY EpisodeID,[BenefitTypeID] ORDER BY ID DESC) AS RowNum
  FROM [dbo].[ClientHealthCareBenefit] 
 WHERE EpisodeID  = @EpisodeID AND ActionStatus <> 10)T LEFT OUTER JOIN dbo.tlkpApplicationOutcome A ON T.OutcomeID = A.ApplicationOutcomeID
 WHERE T.RowNum = 1 
 END
 ELSE
 BEGIN
 SELECT [EpisodeID],[ID],(CASE [BenefitTypeID] WHEN 1 THEN 'SSI' WHEN 2 THEN 'VA' WHEN 3 THEN 'MediCal' 
                         ELSE '' END) BenefitTypeDesc,
	  (CASE WHEN [AppliedOrRefused] IS NULL THEN '' 
	        WHEN [AppliedOrRefused] = 1 THEN 'A' 
	        WHEN [AppliedOrRefused] = 0 THEN 'R' END)AgreeType,[BenefitTypeID],
       [AppliedOrRefusedOnDate],[PhoneInterviewDate],[OutcomeDate],[OutcomeID],
       (CASE WHEN ISNULL([OutcomeID], 0) =0 THEN '(Pending)' ELSE A.Name END)OutCome,[BICNum],
	   [IssuedOnDate],[ArchivedOnDate],[ActionStatus],[ActionBy],     
	   (SELECT Name FROM dbo.fn_GetAsstUserName(ActionBy))ActionByName,[AppliedOrRefused],
	   [NoteOrComment],[DateAction], 0 AS Totals
  FROM [dbo].[ClientHealthCareBenefit] T 
       LEFT OUTER JOIN dbo.tlkpApplicationOutcome A ON T.OutcomeID = A.ApplicationOutcomeID
 WHERE EpisodeID  = @EpisodeID AND BenefitTypeID = @BenefitTypeID AND ActionStatus <> 10
 END
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeHealthBenefit] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeHealthBenefit] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodeIDTT
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeIDTT]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeIDTT]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeIDTT]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetEpisodeIDTT]
    @EpisodeID int = 0,
	@IDTTID int = 0
AS	
BEGIN
   DECLARE @True bit = 1;
   DECLARE @False bit =0;
   DECLARE @IsLastIDTTSet bit = @False;

   IF  @EpisodeID > 0 
   BEGIN
       DECLARE @LIDTTID  int = (SELECT ISNULl(IDTTID, 0) 
	                                 FROM dbo.EpisodeTrace 
									WHERE EpisodeID = @EpisodeID)

	  IF @LIDTTID = @IDTTID OR @IDTTID = 0
		     SET @IsLastIDTTSet = @True

	  IF @IDTTID > 0 
	      SET @LIDTTID = @IDTTID

    DECLARE @decision int =(SELECT ISNULl(IDTTDecision, 0) 
	    FROM dbo.ClinicalIDTT WHERE ID = @LIDTTID)
	IF @LIDTTID = 0
	  SELECT 0 AS Id, @EpisodeID AS EpisodeId, '' AS MemeberAttendance, 
	  '' AS OtherMemeberAttendance, GetDate() AS IDTTDate, 
	  0 AS IDTTDecision,'' AS RecommandationForStatus, '' AS ActionByName, 
	  @True AS IsLastIDTT, '' AS FinalDecision
	ELSE	
	 SELECT t1.Id, t1.EpisodeId, t1.MemeberAttendance, 
	        t1.OtherMemeberAttendance,t1.IDTTDate,t1.IDTTDecision,
			t1.RecommandationForStatus, 	        
			(SELECT Name 
			   FROM dbo.fn_GetAsstUserName(t1.ActionBy))ActionByName,
			  @IsLastIDTTSet AS IsLastIDTT,
		    t2.FinalRecommendation AS FinalDecision 
	   FROM dbo.ClinicalIDTT t1 
	  LEFT OUTER JOIN [dbo].[tlkpFinalRecommendation] t2 
	     ON t1.IDTTDecision = t2.Id WHERE t1.Id = @LIDTTID  

	SELECT Id, FinalRecommendation, (CASE WHEN Id = @decision THEN @True ELSE @False END)Selected From tlkpFinalRecommendation
	 WHERE ISNULl(Disabled, 0) = 0
 END
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeIDTT] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeIDTT] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodeIRP
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeIRP]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeIRP]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeIRP]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-03-08
-- Update date: 
-- Description:	Retrive IRP
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeIRP]
    @EpisodeID int = 0,
	@IRPID int = 0
AS	
BEGIN
   DECLARE @True bit = 1
   DECLARE @False bit =0
   DECLARE @IsLastIRPSet bit  =0
   IF  @EpisodeID > 0 
   BEGIN
      DECLARE @LIRPID  int = (SELECT ISNULl(IRPID, 0)IRPID FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID) 

	  IF @LIRPID = @IRPID OR @IRPID = 0
		     SET @IsLastIRPSet = 1

	  IF @IRPID > 0 
	        SET @LIRPID =@IRPID

     
	  DECLARE @IDTTDecision nvarchar(75) = ''
	  DECLARE @IDTTId int  = (SELECT ISNULl(IDTTID, 0)IDTTID FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID)
	  IF @IDTTId > 0
	   SET  @IDTTDecision = (SELECT FinalRecommendation FROM dbo.tlkpFinalRecommendation WHERE ID  = 
	       (SELECT ISNULl(IDTTDecision, 0)IDTTID FROM dbo.ClinicalIDTT WHERE EpisodeID = @EpisodeID AND ID  =@IDTTId))
	  
	  IF @LIRPID > 0 
	  BEGIN
	  DECLARE @iprdate datetime = (Select DateAction From CaseIRP where ID  = @LIRPID) 
      SELECT ISNULl(t2.ID, 0) AS IRPID, t2.NeedID, ISNULL(t2.NeedStatus, 0)NeedStatus, 
         (CASE WHEN ISNULl(t2.NeedStatus, 0) = 1 THEN @True ELSE @False END)NeedStatus1,
		 (CASE WHEN ISNULl(t2.NeedStatus, 0) = 2 THEN @True ELSE @False END)NeedStatus2,
		 (CASE WHEN ISNULl(t2.NeedStatus, 0) = 3 THEN @True ELSE @False END)NeedStatus3,
		 (CASE WHEN ISNULl(t2.NeedStatus, 0) = 4 THEN @True ELSE @False END)NeedStatus4,
		 t3.Name AS Need, DescriptionCurrentNeed, t2.ShortTermGoal, t2.LongTermGoal,
         (CASE WHEN t2.LongTermStatus IS NOT NULL AND  t2.LongTermStatus = 1 THEN @True ELSE @False END)LongTermStatusMet,
		 (CASE WHEN t2.LongTermStatus IS NOT NULL AND  t2.LongTermStatus= 0 THEN @True ELSE @False END)LongTermStatusNoMet,
		  LongTermStatusDate, t2.PlanedIntervention, t2.Note, @IDTTDecision as IDTTDecision, @IsLastIRPSet AS IsLastIRPSet,  t2.ActionStatus, 
		 (SELECT NAME FROM fn_GetAsstUserName(t2.ActionBy))ActionName, t2.DateAction
    FROM dbo.Episode t1 LEFT OUTER JOIN dbo.CaseIRP t2 ON t1.EpisodeID  = t2.EpisodeID 
	                    INNER JOIN [dbo].[tlkpCaseNeeds] t3 on t2.NeedId = t3.NeedId
   WHERE (@iprdate IS NULL AND t1.EpisodeID  = @EpisodeID) OR (t2.DateAction  = @iprdate) Order By NeedID
	END
	ELSE
	BEGIN
	 SELECT 0 AS IRPID, NeedID, NULL AS NeedStatus, 
         @False AS NeedStatus1,
		 @False AS NeedStatus2,
		 @False AS NeedStatus3,
		 @False AS NeedStatus4,
		 Name AS Need, '' AS DescriptionCurrentNeed, '' AS ShortTermGoal, '' AS LongTermGoal,
         @False AS LongTermStatusMet, @False AS LongTermStatusNoMet,
		 NULL AS LongTermStatusDate, NULL AS PlanedIntervention, '' AS Note, @IDTTDecision as IDTTDecision, @True AS IsLastIRPSet, 1 AS ActionStatus, 
		 '' AS ActionName, GetDate() AS DateAction
    FROM [dbo].[tlkpCaseNeeds] Order By NeedID
	END
 END
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeIRP] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeIRP] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetPATSEpisodeIRPToBASS
--============================================================================
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetPATSEpisodeIRPToBASS]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetPATSEpisodeIRPToBASS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2021-09-29
-- Update date: 
-- Description:	Retrive IRP From PATS to BASS
-- =============================================
CREATE PROCEDURE [dbo].[spGetPATSEpisodeIRPToBASS]
    @CDCRNum varchar(6) = '',
	@IRPID int = 0
AS	
BEGIN
   DECLARE @True bit = 1
   DECLARE @False bit =0
   IF @CDCRNum <> ''
    BEGIN
	  DECLARE @EpisodeID int = (SELECT EpisodeID FROM Episode WHERE CDCRNum = @CDCRNum)
	  IF @EpisodeID > 0
	  BEGIN
	     EXEC [dbo].[spGetEpisodeIRP] @EpisodeID, @IRPID
	  END
	  ELSE
	  BEGIN	     
         SELECT 0 AS IRPID, NeedID, NULL AS NeedStatus, 
            @False AS NeedStatus1,
		    @False AS NeedStatus2,
		    @False AS NeedStatus3,
		    @False AS NeedStatus4,
		    Name AS Need, '' AS DescriptionCurrentNeed, '' AS ShortTermGoal, '' AS LongTermGoal,
            @False AS LongTermStatusMet, @False AS LongTermStatusNoMet,
		    NULL AS LongTermStatusDate, NULL AS PlanedIntervention, '' AS Note, '' as IDTTDecision, @True AS IsLastIRPSet, 1 AS ActionStatus, 
		    '' AS ActionName, GetDate() AS DateAction
         FROM [dbo].[tlkpCaseNeeds] Order By NeedID
	  END
	END
	ELSE
	BEGIN
	   SELECT 0 AS IRPID, NeedID, NULL AS NeedStatus, 
            @False AS NeedStatus1,
		    @False AS NeedStatus2,
		    @False AS NeedStatus3,
		    @False AS NeedStatus4,
		    Name AS Need, '' AS DescriptionCurrentNeed, '' AS ShortTermGoal, '' AS LongTermGoal,
            @False AS LongTermStatusMet, @False AS LongTermStatusNoMet,
		    NULL AS LongTermStatusDate, NULL AS PlanedIntervention, '' AS Note, '' as IDTTDecision, @True AS IsLastIRPSet, 1 AS ActionStatus, 
		    '' AS ActionName, GetDate() AS DateAction
         FROM [dbo].[tlkpCaseNeeds] Order By NeedID
	END
   
END
GO
GRANT EXECUTE ON [dbo].[spGetPATSEpisodeIRPToBASS] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetPATSEpisodeIRPToBASS] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodeLegalDoc
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeLegalDoc]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeLegalDoc]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeLegalDoc]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-03-08
-- Update date: 
-- Description:	Retrive Evaluation
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeLegalDoc]
    @EpisodeID int = 0,
	@DocID int = 0   
AS	
BEGIN
   DECLARE @True bit = 1
   DECLARE @False bit =0
   DECLARE @IsLastDocID int = 0
   DECLARE @IsLastDocSet bit = @False
      
	SET @IsLastDocID = (SELECT ISNULl(LegalDocID,0) FROM EpisodeTrace Where EpisodeID = @EpisodeID )
	IF (@IsLastDocID > 0 AND @IsLastDocID = @DocID) OR (@IsLastDocID = 0 AND @DocID =0)
	   SET @IsLastDocSet = @True

	--IF @DocID > 0 AND @IsLastDocID <> @DocID
	--  SET @IsLastDocID = @DocID
   
   IF @IsLastDocID > 0
     SELECT Id, @EpisodeID AS EpisodeId, OtherDdesc,DateNoticePrivacyPractice,
	  DateInformedConcentForTreatment, DateOther,DateReleaseInfoExpiration, ReleaseTo, 
	  ReleaseFrom, ReleaseInformationsNote, 
			 (SELECT Name From dbo.fn_GetAsstUserName(ActionBy))ActionByName, 
			 (CASE WHEN Id =@IsLastDocID THEN @True ELSE @False END)IsLastOne, @False AS Failed
	   FROM [dbo].[LegalDocument] 
	  WHERE ActionStatus <> 10 AND (@DocID <= 0 AND EpisodeID  = @EpisodeID) OR ( @DocID > 0 AND Id = @DocID)
	ELSE
	  SELECT 0 AS Id, @EpisodeID AS EpisodeId, '' AS OtherDdesc, null AS DateNoticePrivacyPractice, 
	         null AS DateInformedConcentForTreatment, null AS DateOther, 
			 null AS DateReleaseInfoExpiration, '' AS ReleaseTo, '' AS ReleaseFrom, 
			 '' AS ReleaseInformationsNote, '' AS ActionByName, @True AS IsLastOne, @False AS Failed	  
END

GRANT EXECUTE ON [dbo].[spGetEpisodeLegalDoc] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeLegalDoc] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeLegalDoc] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodeMCASR
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeMCASR]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeMCASR]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeMCASR]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-03-10
-- Update date: 
-- Description:	Retrive MCASR
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeMCASR]
    @EpisodeID int = 0,
	@MCASRID int = 0
AS	
BEGIN
   DECLARE @True bit = 1
   DECLARE @False bit =0
   DECLARE @IsLastMCASRSet bit  =0
   DECLARE @ID int =0
   DECLARE @Section1Score int = 0
   DECLARE @Section2Score int = 0
   DECLARE @Section3Score int = 0
   DECLARE @Section4Score int = 0
   DECLARE @TotalScore int = 0
   DECLARE @Question1Anwser int = null
   DECLARE @Question2Anwser int	= null
   DECLARE @Question3Anwser int	= null
   DECLARE @Question4Anwser int	= null
   DECLARE @Question5Anwser int	= null
   DECLARE @Question6Anwser int	= null
   DECLARE @Question7Anwser int	= null
   DECLARE @Question8Anwser int	= null
   DECLARE @Question9Anwser int	= null
   DECLARE @Question10Anwser int = null
   DECLARE @Question11Anwser int = null
   DECLARE @Question12Anwser int = null
   DECLARE @Question13Anwser int = null
   DECLARE @Question14Anwser int = null
   DECLARE @Question15Anwser int = null
   DECLARE @Question16Anwser int = null
   DECLARE @Question17Anwser int = null
   DECLARE @ActionUserName nvarchar(70) = ''
  
   IF  @EpisodeID > 0 
   BEGIN
      DECLARE @LMCASRID  int = (SELECT ISNULl(MCASRID, 0)MCASRID FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID) 

	  IF @LMCASRID = @MCASRID OR @MCASRID = 0
		     SET @IsLastMCASRSet = 1

	  IF @MCASRID > 0 
	        SET @LMCASRID =@MCASRID

     
	  DECLARE @IDTTDecision nvarchar(75) = ''
	  DECLARE @IDTTId int  = (SELECT ISNULl(IDTTID, 0)IDTTID FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID)
	  IF @IDTTId > 0
	   SET  @IDTTDecision = (SELECT FinalRecommendation FROM dbo.tlkpFinalRecommendation WHERE ID  = 
	       (SELECT ISNULl(IDTTDecision, 0)IDTTID FROM dbo.ClinicalIDTT WHERE EpisodeID = @EpisodeID AND ID  =@IDTTId))
	  
	  IF @LMCASRID > 0 
	  BEGIN
	   SELECT @ID =id,  @Section1Score =Section1Score, @Section2Score = Section2Score, @Section3Score = Section3Score, @Section4Score = Section4Score,
		      @TotalScore = (ISNULL(Section1Score, 0) + ISNULL(Section2Score, 0) + ISNULL(Section3Score, 0) + ISNULL(Section4Score, 0)),
		      @Question1Anwser = Question1Anwser, @Question2Anwser =Question2Anwser,@Question3Anwser= Question3Anwser, 
			  @Question4Anwser= Question4Anwser,@Question5Anwser= Question5Anwser,@Question6Anwser= Question6Anwser,
		      @Question7Anwser= Question7Anwser,@Question8Anwser= Question8Anwser,  @Question9Anwser= Question9Anwser,
		      @Question10Anwser=Question10Anwser, @Question11Anwser=Question11Anwser,@Question12Anwser=Question12Anwser, 
			  @Question13Anwser=Question13Anwser,@Question14Anwser=Question14Anwser, @Question15Anwser=Question15Anwser,
		      @Question16Anwser=Question16Anwser, @Question17Anwser=Question17Anwser,
			  @ActionUserName = (SELECT Name FROM dbo.fn_GetAsstUserName(ActionBy))
		 FROM [dbo].[CaseMCASR] Where ID = @LMCASRID
	  END
	 
	  SELECT @ID AS MCASRID,  @Section1Score AS Section1Score, @Section2Score AS Section2Score, @Section3Score AS Section3Score, @Section4Score AS Section4Score,
		      @TotalScore AS TotalScore, @ActionUserName AS ActionUserName, @IsLastMCASRSet AS IsLastMCASRSet,@IDTTDecision AS IDTTDecision
		     
			 
			  --@Question1Anwser AS Question1Anwser, @Question2Anwser AS Question2Anwser,@Question3Anwser AS Question3Anwser,  @Question5Anwser AS Question5Anwser,
		      --@Question6Anwser AS Question6Anwser,  @Question7Anwser AS  Question7Anwser,@Question8Anwser AS Question8Anwser,  @Question9Anwser AS Question9Anwser,
		      --@Question10Anwser AS Question10Anwser, @Question11Anwser AS Question11Anwser,@Question12Anwser AS Question12Anwser, @Question13Anwser AS Question13Anwser,
		      --@Question14Anwser AS Question14Anwser, @Question15Anwser AS Question15Anwser, @Question16Anwser AS Question16Anwser, @Question17Anwser AS Question17Anwser,
	          

	  SELECT t1.SectionId,t1.QuestionId,t1.Question,t1.Explanation AS QuestionDescription,  
	           Convert(varchar(3),(CASE WHEN t1.QuestionId = 1 THEN @Question1Anwser 
	                                    WHEN t1.QuestionId = 2 THEN @Question2Anwser
										WHEN t1.QuestionId = 3 THEN @Question3Anwser
										WHEN t1.QuestionId = 4 THEN @Question4Anwser
										WHEN t1.QuestionId = 5 THEN @Question5Anwser
										WHEN t1.QuestionId = 6 THEN @Question6Anwser
										WHEN t1.QuestionId = 7 THEN @Question7Anwser
										WHEN t1.QuestionId = 8 THEN @Question8Anwser
										WHEN t1.QuestionId = 9 THEN @Question9Anwser
										WHEN t1.QuestionId = 10 THEN @Question10Anwser
										WHEN t1.QuestionId = 11 THEN @Question11Anwser
										WHEN t1.QuestionId = 12 THEN @Question12Anwser
										WHEN t1.QuestionId = 13 THEN @Question13Anwser
										WHEN t1.QuestionId = 14 THEN @Question14Anwser
										WHEN t1.QuestionId = 15 THEN @Question15Anwser
										WHEN t1.QuestionId = 16 THEN @Question16Anwser
										WHEN t1.QuestionId = 17 THEN @Question17Anwser END))SelectedAnwser,
			(SELECT'['+ stuff( ( SELECT ',{ "AnwserId": "' + Convert(varchar(3), tb.AnwserId)  
                      + '", "QuestionAnwserId": "' + Convert(varchar(3), tb.QuestionAnwserId) + '","Answer": "' + tb.Anwser +'"}' 
              FROM (SELECT Id AS AnwserId, ScaleAnwserId as QuestionAnwserId, Anwser FROM dbo.tlkpCaseMCASRAnwser Where QuestionId  = t1.QuestionId) tb 
               FOR XML PATH('') ),1,1,'') +']')Answers, NULL as PossibleAnswer  
			FROM [dbo].[tlkpCaseMCASRQuestion] t1

 END
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeMCASR] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeMCASR] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodeMMA
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeMMA]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeMMA]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeMMA]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2019-09-05
-- Description:	Retrive possible MMA
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeMMA] 
	@EpisodeID int,
	@SelectedMMAID int = 0
AS
BEGIN

	SET NOCOUNT ON;
	--DECLARE  @EpisodeID int = 583682
DECLARE @Id int 
DECLARE @MEDICATIONTARGETSYMPTOMSDesc nvarchar(100)
DECLARE @FUNCIMPAIRMENTDesc nvarchar(70)
DECLARE @RECOMMENDATIONSDesc nvarchar(10)
DECLARE @DiscussedDesc nvarchar(10)
DECLARE @LABSREQUESTEDDesc nvarchar(10)
DECLARE @DSMID int
DECLARE @PrevDSMID int
DECLARE @MMADate DateTime
DECLARE @MAXID int =  (SELECT MAX(ID) FROM [dbo].[PsychiatryASMT] WHERE EpisodeID  = @EpisodeID )
DECLARE @ISLatestMMA bit = 0

IF @SelectedMMAID > 0  
BEGIN
   SELECT @Id=ID, @MEDICATIONTARGETSYMPTOMSDesc=MedTargetSymptoms, @FUNCIMPAIRMENTDesc = FuncImpairment, @RECOMMENDATIONSDesc =Recommendations, @DiscussedDesc=Discussed,
          @MMADate =[ASMTDate], @LABSREQUESTEDDesc =LabsRequested FROM [dbo].[PsychiatryASMT] Where EpisodeID  = @EpisodeID AND ID = @SelectedMMAID
 END 
ELSE
BEGIN
   SELECT @Id=ID, @MEDICATIONTARGETSYMPTOMSDesc=MedTargetSymptoms, @FUNCIMPAIRMENTDesc = FuncImpairment, @RECOMMENDATIONSDesc =Recommendations, @DiscussedDesc=Discussed,
          @MMADate=[ASMTDate], @LABSREQUESTEDDesc =LabsRequested
  FROM (SELECT ID,MedTargetSymptoms,FuncImpairment, Recommendations,Discussed,LabsRequested,ASMTDate, ROW_NUMBER() OVER(PARTITION BY EpisodeID ORDER BY ID DESC) AS RowNum 
          FROM [dbo].[PsychiatryASMT]  
         WHERE EpisodeID  = @EpisodeID)t1 Where t1.RowNum =1
END

IF (@MAXID = @Id) OR (NOT EXISTS(SELECT * FROM [dbo].[PsychiatryASMT] Where EpisodeID  = @EpisodeID) )
   SET @ISLatestMMA = 1

 -- SELECT @ID, @MEDICATIONTARGETSYMPTOMSDesc,@FUNCIMPAIRMENTDesc, @RECOMMENDATIONSDesc
SELECT @DSMID = DSMID FROM (select ID AS DSMID, ActionStatus, ROW_NUMBER() OVER(PARTITION BY EpisodeID ORDER BY ID DESC) AS RowNum  from Dsm where 
     (@ISLatestMMA = 1 AND EpisodeID  = @EpisodeID) OR (@ISLatestMMA =0 AND DateAction <= @MMADate AND EpisodeID  = @EpisodeID)) t1 WHERE t1.RowNum =1 AND t1.ActionStatus <> 10
SELECT @PrevDSMID =DSMID FROM (select ID AS DSMID,ActionStatus, ROW_NUMBER() OVER(PARTITION BY EpisodeID ORDER BY ID DESC) AS RowNum  from Dsm where 
     (@ISLatestMMA = 1 AND EpisodeID  = @EpisodeID) OR (@ISLatestMMA =0 AND DateAction <= @MMADate AND EpisodeID  = @EpisodeID)) t1 WHERE t1.RowNum =2 AND t1.ActionStatus <> 10

DECLARE @RECOMMENDATIONS TABLE(
  ID int IDENTITY(1,1),
  RECOMMENDATIONS nvarChar(2)
)
INSERT INTO @RECOMMENDATIONS 
select splitdata from [dbo].[fnSplitString](ISNULL(@RECOMMENDATIONSDesc, ',,,,'), ',')

DECLARE @FUNCIMPAIRMENT TABLE(
  ID int IDENTITY(1,1),
  FUNCIMPAIRMENT nvarChar(2)
)
INSERT INTO @FUNCIMPAIRMENT 
select splitdata from [dbo].[fnSplitString](ISNULL(@FUNCIMPAIRMENTDesc,',,,,,,,,,,,,'), ',')

DECLARE @MEDICATIONTARGETSYMPTOMS TABLE(
   ID int IDENTITY(1,1),
   MEDICATIONTARGETSYMPTOMS nvarchar(2)
)
INSERT INTO @MEDICATIONTARGETSYMPTOMS 
select splitdata from [dbo].[fnSplitString](ISNULL(@MEDICATIONTARGETSYMPTOMSDesc, ',,,,,,,,,,,,,,,,,,,,,,'), ',')

DECLARE @Discussed TABLE(
   ID int IDENTITY(1,1),
   Discussed nvarchar(2)
)
INSERT INTO @Discussed 
select splitdata from [dbo].[fnSplitString](ISNULL(@DiscussedDesc, ',,,,'), ',')

DECLARE @LABSREQUESTED TABLE(
   ID int IDENTITY(1,1),
   LABSREQUESTED nvarchar(2)
)
INSERT INTO @LABSREQUESTED 
select splitdata from [dbo].[fnSplitString](ISNULL(@LABSREQUESTEDDesc, ',,,,,'), ',')

SELECT ISNULL(t1.Id, 0) as MMAID
       ,ISNULL(t1.[ASMTDate], GetDate()) AS MMADATE
       ,t2.CDCRNum AS CDCR
       ,t2.DOB
       ,(SELECT dbo.fnGetlocationDesc(t2.ParoleLocationID)) AS PAROLEOFFICE 
       ,(SELECT Name FROM dbo.fn_GetClientName(@EpisodeID)) AS PAROLEENAME 
       ,(SELECT Name FROM dbo.fn_GetUserName(t1.[PsychiatristId])) AS PSYCHIATRIST 
       ,(SELECT '' + stuff((SELECT DISTINCT TOP 3  ',' + Concat(ICDCode,'-',DSMDesc)  
	                          FROM [dbo].[DsmDiagnosis] a INNER JOIN [dbo].[tlkpICD_DX_Codes] b on a.MasterDXId = b.MasterDXId 
	                         WHERE DsmId  = @DSMID AND a.ActionStatus <>10 for XML Path('') ),1,1,'') +'')  AS DIAGNOSIS
       ,t1.MEDICATIONSIDEEFFECTS
       ,t1.CHIEFCOMPLAINT
	   ,t1.CURRENTMEDICATIONS
       ,t1.DISCONTINUEDMEDICATIONS
       ,t1.MEDICATIONCHANGES 
       ,CONVERT(nvarchar(5),ISNULL(t1.[PrevPsyAdmission],'')) AS PREVPSYCHIATRICADMISSIONS 
       ,CONVERT(nvarchar(5),ISNULL(t1.PREVSUICIDEATTEMPTS, ''))  PREVSUICIDEATTEMPTS
       ,CONVERT(nvarchar(5),ISNULL(t1.[YearOutpatientPsyCare], '')) AS OUTPATIENTPSYCHIATRICCAREYEARS 
       ,(SELECT '' + stuff((SELECT DISTINCT TOP 3  ',' + Concat(ICDCode,'-',DSMDesc)  
	                          FROM [dbo].[DsmDiagnosis] a INNER JOIN [dbo].[tlkpICD_DX_Codes] b on a.MasterDXId = b.MasterDXId 
	                         WHERE DsmId  = @PrevDSMID AND a.ActionStatus <>10 for XML Path('') ),1,1,'') +'')  AS PREVIOUSDIAGNOSIS 
       ,t1.PREVIOUSPSYCHIATRICMEDICATIONS 
       ,t1.PREVDRUGDEPENDENCE 
       ,t1.[CurrDrugDependence] AS CURRENTDRUGDEPENDENCE 
       ,t1.LastDrugUseDate AS DATEOFLASTDRUGUSE 
       ,CONVERT(nvarchar(5),ISNULL(t1.YearDrugUse,'')) AS YEARSOFDRUGUSE 
       ,t1.MEDICATIONALLERGIES
       ,t1.HOSPITALIZATIONS 
       ,t1.SURGERIES 
       ,(CASE WHEN t1.HeadTraumaHistory IS NOT NULL AND  t1.HeadTraumaHistory= 1 THEN 1 ELSE 0 END)HISTORYHEADTRAUMAYES
       ,(CASE WHEN t1.HeadTraumaHistory IS NOT NULL AND  t1.HeadTraumaHistory= 0 THEN 1 ELSE 0 END)HISTORYHEADTRAUMADENIED 
       ,t1.HeadTraumaHistoryNote AS HISTORYHEADTRAUMANOTE
       ,(CASE WHEN t1.StrokeHistory IS NOT NULL AND t1.StrokeHistory = 1 THEN 1 ELSE 0 END)HISTORYSTROKEYES 
       ,(CASE WHEN t1.StrokeHistory IS NOT NULL AND t1.StrokeHistory = 0 THEN 1 ELSE 0 END)HISTORYSTROKEDENIED 
       ,t1.StrokeHistoryNote AS HISTORYSTROKENOTE 
       ,(CASE WHEN t1.LossConsciousnessHistory IS NOT NULL AND t1.LossConsciousnessHistory = 1 THEN 1 ELSE 0 END)HISTORYLOSSCONSCIOUSNESSYES 
       ,(CASE WHEN t1.LossConsciousnessHistory IS NOT NULL AND t1.LossConsciousnessHistory = 0 THEN 1 ELSE 0 END)HISTORYLOSSCONSCIOUSNESSDENIED 
       ,t1.LossConsciousnessHistoryNote AS HISTORYLOSSCONSCIOUSNESSNOTE 
       ,(CASE WHEN t1.SpinalCordInjuries IS NOT NULL AND t1.SpinalCordInjuries = 1 THEN 1 ELSE 0 END)SPINALCORDINJURIESYES 
       ,(CASE WHEN t1.SpinalCordInjuries IS NOT NULL AND t1.SpinalCordInjuries = 0 THEN 1 ELSE 0 END)SPINALCORDINJURIESDENIED 
       ,SPINALCORDINJURIESNOTE 
       ,(CASE WHEN t1.SkeletalFracturesOrBrakes IS NOT NULL AND t1.SkeletalFracturesOrBrakes= 1 THEN 1 ELSE 0 END)SKELETALFRACTURESBRAKESYES 
       ,(CASE WHEN t1.SkeletalFracturesOrBrakes IS NOT NULL AND t1.SkeletalFracturesOrBrakes= 0 THEN 1 ELSE 0 END)SKELETALFRACTURESBRAKESDENIED 
       ,t1.SkeletalFracturesOrBrakesNote AS SKELETALFRACTURESBRAKESNOTE 
       ,(CASE WHEN t1.MVA IS NOT NULL AND t1.MVA= 1 THEN 1 ELSE 0 END)MVAYES 
       ,(CASE WHEN t1.MVA IS NOT NULL AND t1.MVA= 0 THEN 1 ELSE 0 END)MVADENIED 
       ,MVANOTE 
       ,(CASE WHEN t1.GunshotWounds IS NOT NULL AND t1.GunshotWounds = 1 THEN 1 ELSE 0 END)GUNSHOTWOUNDSYES 
       ,(CASE WHEN t1.GunshotWounds IS NOT NULL AND t1.GunshotWounds = 0 THEN 1 ELSE 0 END)GUNSHOTWOUNDSDENIED 
       ,GUNSHOTWOUNDSNOTE 
       ,(CASE WHEN t1.SeizuresHistory IS NOT NULL AND t1.SeizuresHistory = 1 THEN 1 ELSE 0 END)HISTORYOFSEIZURESYES
       ,(CASE WHEN t1.SeizuresHistory IS NOT NULL AND t1.SeizuresHistory = 0 THEN 1 ELSE 0 END)HISTORYOFSEIZURESDENIED 
       ,t1.SeizuresHistoryNote AS HISTORYOFSEIZURESNOTE
       ,(CASE WHEN t1.MigraineHAHistory IS NOT NULL AND t1.MigraineHAHistory = 1 THEN 1 ELSE 0 END)HISTORYMIGRAINEHAYES
       ,(CASE WHEN t1.MigraineHAHistory IS NOT NULL AND t1.MigraineHAHistory = 0 THEN 1 ELSE 0 END)HISTORYMIGRAINEHADENIED 
       ,t1.MigraineHAHistoryNote AS HISTORYMIGRAINEHANOTE
       ,(CASE WHEN t1.HeartDisease IS NOT NULL AND t1.HeartDisease = 1 THEN 1 ELSE 0 END)HEARTDISEASEYES
       ,(CASE WHEN t1.HeartDisease IS NOT NULL AND t1.HeartDisease = 0 THEN 1 ELSE 0 END)HEARTDISEASEDENIED 
       ,HEARTDISEASENOTE 
       ,(CASE WHEN t1.Asthma IS NOT NULL AND t1.Asthma = 1 THEN 1 ELSE 0 END)ASTHMAYES 
       ,(CASE WHEN t1.Asthma IS NOT NULL AND t1.Asthma = 0 THEN 1 ELSE 0 END)ASTHMADENIED 
       ,ASTHMANOTE 
       ,(CASE WHEN t1.COPD IS NOT NULL AND t1.COPD = 1 THEN 1 ELSE 0 END)COPDYES 
       ,(CASE WHEN t1.COPD IS NOT NULL AND t1.COPD = 0 THEN 1 ELSE 0 END)COPDDENIED
       ,COPDNOTE 
       ,(CASE WHEN t1.Diabetes IS NOT NULL AND t1.Diabetes = 1 THEN 1 ELSE 0 END)DIABETESYES 
       ,(CASE WHEN t1.Diabetes IS NOT NULL AND t1.Diabetes = 0 THEN 1 ELSE 0 END)DIABETESDENIED 
       ,DIABETESNOTE 
       ,(CASE WHEN t1.Hyperlipidemia IS NOT NULL AND t1.Hyperlipidemia = 1 THEN 1 ELSE 0 END)HYPERLIPIDEMIAYES 
       ,(CASE WHEN t1.Hyperlipidemia IS NOT NULL AND t1.Hyperlipidemia = 0 THEN 1 ELSE 0 END)HYPERLIPIDEMIADENIED 
       ,HYPERLIPIDEMIANOTE 
       ,(CASE WHEN t1.Hypertension IS NOT NULL AND t1.Hypertension = 1 THEN 1 ELSE 0 END)HYPERTENSIONYES 
       ,(CASE WHEN t1.Hypertension IS NOT NULL AND t1.Hypertension = 0 THEN 1 ELSE 0 END)HYPERTENSIONDENIED
       ,HYPERTENSIONNOTE
       ,(CASE WHEN t1.Hepatitis IS NOT NULL AND t1.Hepatitis = 1 THEN 1 ELSE 0 END)HEPATITISYES
       ,(CASE WHEN t1.Hepatitis IS NOT NULL AND t1.Hepatitis = 0 THEN 1 ELSE 0 END)HEPATITISDENIED 
       ,HEPATITISNOTE 
       ,(CASE WHEN t1.VDOrHIV IS NOT NULL AND t1.VDOrHIV = 1 THEN 1 ELSE 0 END)VDHIVYES 
       ,(CASE WHEN t1.VDOrHIV IS NOT NULL AND t1.VDOrHIV = 0 THEN 1 ELSE 0 END)VDHIVDENIED 
       ,t1.VDOrHIVNote AS VDHIVNOTE 
       ,(CASE WHEN t1.Anemia IS NOT NULL AND t1.Anemia = 1 THEN 1 ELSE 0 END)ANEMIAYES 
       ,(CASE WHEN t1.Anemia IS NOT NULL AND t1.Anemia = 0 THEN 1 ELSE 0 END)ANEMIADENIED
       ,ANEMIANOTE 
       ,(CASE WHEN t1.ThyroidAbnormalities IS NOT NULL AND t1.ThyroidAbnormalities = 1 THEN 1 ELSE 0 END)THYROIDABNORMALITIESYES
       ,(CASE WHEN t1.ThyroidAbnormalities IS NOT NULL AND t1.ThyroidAbnormalities = 0 THEN 1 ELSE 0 END)THYROIDABNORMALITIESDENIED 
       ,THYROIDABNORMALITIESNOTE
       ,(CASE WHEN t1.Glaucoma IS NOT NULL AND t1.Glaucoma= 1 THEN 1 ELSE 0 END)GLAUCOMAYES 
       ,(CASE WHEN t1.Glaucoma IS NOT NULL AND t1.Glaucoma= 0 THEN 1 ELSE 0 END)GLAUCOMADENIED 
       ,GLAUCOMANOTE 
       ,(CASE WHEN t1.AbnormalLabResults IS NOT NULL AND t1.AbnormalLabResults= 1 THEN 1 ELSE 0 END)ABNORMALLABRESULTSYES 
       ,(CASE WHEN t1.AbnormalLabResults IS NOT NULL AND t1.AbnormalLabResults= 0 THEN 1 ELSE 0 END)ABNORMALLABRESULTSDENIED 
       ,ABNORMALLABRESULTSNOTE
       ,(CASE WHEN t1.AbnormalEKG IS NOT NULL AND t1.AbnormalEKG= 1 THEN 1 ELSE 0 END)ABNORMALEKGYES
       ,(CASE WHEN t1.AbnormalEKG IS NOT NULL AND t1.AbnormalEKG= 0 THEN 1 ELSE 0 END)ABNORMALEKGDENIED
       ,ABNORMALEKGNOTE 
       ,(CASE WHEN t1.CurrPregnancy IS NOT NULL AND t1.CurrPregnancy= 0 THEN 1 ELSE 0 END)CURRENTPREGNANCYDENIED 
       ,(CASE WHEN t1.CurrPregnancy IS NOT NULL AND t1.CurrPregnancy= 1 THEN 1 ELSE 0 END)CURRENTPREGNANCYYES 
       ,t1.CurrPregnancyNote AS CURRENTPREGNANCYNOTE 
       ,(CASE WHEN t1.PriapismHistory IS NOT NULL AND t1.PriapismHistory= 1 THEN 1 ELSE 0 END)HISTORYPRIAPISMYES 
       ,(CASE WHEN t1.PriapismHistory IS NOT NULL AND t1.PriapismHistory= 0 THEN 1 ELSE 0 END)HISTORYPRIAPISMDENIED 
       ,t1.PriapismHistoryNote AS HISTORYPRIAPISMNOTE 
       ,(CASE WHEN t1.OtherChronicMediIll IS NOT NULL AND t1.OtherChronicMediIll = 1 THEN 1 ELSE 0 END)OTHERCHRONICMEDICALILLNESSYES
       ,(CASE WHEN t1.OtherChronicMediIll IS NOT NULL AND t1.OtherChronicMediIll = 0 THEN 1 ELSE 0 END)OTHERCHRONICMEDICALILLNESSDENIED 
       ,t1.OtherChronicMediIllNote AS OTHERCHRONICMEDICALILLNESSNOTE 
       ,CONVERT(nvarchar(5),ISNULL(t1.PregnanciesNum, '')) AS NUMBERPREGNANCIES 
       ,CONVERT(nvarchar(5),ISNULL(t1.DeliveryNum, '')) AS NUMBERDELIVERIES 
       ,t1.CurrHousing AS CURRENTHOUSING 
       ,SUPPORTIVERELATIONSHIPS 
       ,t1.CurrEmployment AS CURRENTEMPLOYMENT 
       ,t1.LASTEMPLOYED
       ,HIGHESTGRADECOMPLETED 
       ,(CASE WHEN t1.IdentifyLearnDisablity IS NOT NULL AND t1.IdentifyLearnDisablity = 1 THEN 1 ELSE 0 END)IDENTIFIEDLEARNINGDISABILITY 
       ,(CASE WHEN t1.IntellectualImpairment IS NOT NULL THEN t1.IntellectualImpairment ELSE 0 END) AS INTELLECTUALIMPAIRMENTDENIED 
       ,IntellectualImpairmentNote AS INTELLECTUALIMPAIRMENT
       ,IdentifyLearnDisablityNote AS IDENTIFIEDLEARNINGDISABILITYNOTE 
       ,(CASE WHEN t1.SexPreferenceGender IS NOT NULL AND t1.SexPreferenceGender = 2 THEN 1 ELSE 0 END)SEXPREFERENCEMALE 
       ,(CASE WHEN t1.SexPreferenceGender IS NOT NULL AND t1.SexPreferenceGender = 1 THEN 1 ELSE 0 END)SEXPREFERENCEFEMALE 
       ,WEIGHT
       ,t1.IncarcerationHistory AS HISOTRYINCARCERATION 
       ,t1.SEXPREFERENCENOTE 
       ,(CASE WHEN t1.Appearance IS NOT NULL AND t1.Appearance = 1 THEN 1 ELSE 0 END)APPEARANCEDISHEVELED
       ,(CASE WHEN t1.Appearance IS NOT NULL AND t1.Appearance = 2 THEN 1 ELSE 0 END)APPEARANCEGROOMED 
       ,(CASE WHEN t1.Appearance IS NOT NULL AND t1.Appearance = 3 THEN 1 ELSE 0 END)APPEARANCENOURISHED 
       ,(CASE WHEN t1.Appearance IS NOT NULL AND t1.Appearance = 4 THEN 1 ELSE 0 END)APPEARANCEOBESE
       ,(CASE WHEN t1.AbnormalInvoluntaryMovement IS NOT NULL AND t1.AbnormalInvoluntaryMovement= 2 THEN 1 ELSE 0 END)ABNORMALINVOLUNTARYMOVEMENTABSENT
       ,(CASE WHEN t1.AbnormalInvoluntaryMovement IS NOT NULL AND t1.AbnormalInvoluntaryMovement= 1 THEN 1 ELSE 0 END)ABNORMALINVOLUNTARYMOVEMENTPRESENT 
       ,DISTRACTIBILITY 
       ,IMPULSIVITY 
       ,CONCENTRATION 
       ,t1.MemoRegistration AS MEMORYREGISTRATION 
       ,ANXIETYLEVEL
       ,(CASE WHEN t1.ChildhoodMemo IS NOT NULL AND t1.ChildhoodMemo = 1 THEN 1 ELSE 0 END)CHILDHOODMEMORIESPRESENT
       ,(CASE WHEN t1.ChildhoodMemo IS NOT NULL AND t1.ChildhoodMemo = 2 THEN 1 ELSE 0 END)CHILDHOODMEMORIESABSENT 
       ,(CASE WHEN t1.AdultMemPrevTraumatic IS NOT NULL AND t1.AdultMemPrevTraumatic = 2 THEN 1 ELSE 0 END)ADULTMEMORIESPREVTRAUMATICEVENTABSENT 
       ,(CASE WHEN t1.AdultMemPrevTraumatic IS NOT NULL AND t1.AdultMemPrevTraumatic = 1 THEN 1 ELSE 0 END)ADULTMEMORIESPREVTRAUMATICEVENTPRESENT
       ,(CASE WHEN t1.RptIntentPsyReactTrauMemo IS NOT NULL AND t1.RptIntentPsyReactTrauMemo = 1 THEN 1 ELSE 0 END)RPTINTENSEPSYREACTTRAUMEMOPRESENT 
       ,(CASE WHEN t1.RptIntentPsyReactTrauMemo IS NOT NULL AND t1.RptIntentPsyReactTrauMemo = 2 THEN 1 ELSE 0 END)RPTINTENSEPSYREACTTRAUMEMOABSENT 
       ,(CASE WHEN t1.RptAvoidSAWTrauMemo IS NOT NULL AND t1.RptAvoidSAWTrauMemo = 2 THEN 1 ELSE 0 END)RPTAVOIDSTIMULIABSENT 
       ,(CASE WHEN t1.RptAvoidSAWTrauMemo IS NOT NULL AND t1.RptAvoidSAWTrauMemo = 1 THEN 1 ELSE 0 END)RPTAVOIDSTIMULIPRESENT 
       ,(CASE WHEN t1.RptFlashTrauMemo IS NOT NULL AND t1.RptFlashTrauMemo = 1 THEN 1 ELSE 0 END)RPTFLASHBACKSTRAUMATICMEMPRESENT 
       ,(CASE WHEN t1.RptFlashTrauMemo IS NOT NULL AND t1.RptFlashTrauMemo = 2 THEN 1 ELSE 0 END)RPTFLASHBACKSTRAUMATICMEMABSENT 
       ,(CASE WHEN t1.RptRecurrDistressNMTrau IS NOT NULL AND t1.RptRecurrDistressNMTrau = 1 THEN 1 ELSE 0 END)RPTRECURRDISTRESSNMTRAUPRESENT 
       ,(CASE WHEN t1.RptRecurrDistressNMTrau IS NOT NULL AND t1.RptRecurrDistressNMTrau = 2 THEN 1 ELSE 0 END)RPTRECURRDISTRESSNMTRAUABSENT 
       ,(CASE WHEN t1.ObsessionsCompulsions IS NOT NULL AND t1.ObsessionsCompulsions = 1 THEN 1 ELSE 0 END)OBSESSIONSCOMPULSIONSYES 
       ,(CASE WHEN t1.ObsessionsCompulsions IS NOT NULL AND t1.ObsessionsCompulsions = 0 THEN 1 ELSE 0 END)OBSESSIONSCOMPULSIONSDENIED 
       ,(CASE WHEN t1.Anhedonia IS NOT NULL AND t1.Anhedonia = 1 THEN 1 ELSE 0 END)ANHEDONIAPRESENT 
       ,(CASE WHEN t1.Anhedonia IS NOT NULL AND t1.Anhedonia = 2 THEN 1 ELSE 0 END)ANHEDONIAABSENT
       ,MOOD 
       ,EUPHORIA
       ,DEMEANOR 
       ,(CASE WHEN t1.Sleep IS NOT NULL AND t1.Sleep = 1 THEN 1 ELSE 0 END)SLEEPINSOMINA 
       ,(CASE WHEN t1.Sleep IS NOT NULL AND t1.Sleep = 2 THEN 1 ELSE 0 END)SLEEPINTERRUPED
       ,(CASE WHEN t1.Sleep IS NOT NULL AND t1.Sleep = 3 THEN 1 ELSE 0 END)SLEEPNORMAL 
       ,t1.PridTimeEnergizedSleep AS PERIODSTIMETOOENERGIZEDTOSLEEP
       ,APPETITE
       ,ENERGYLEVEL 
       ,LIBIDO 
       ,(CASE WHEN t1.Irritability IS NOT NULL AND t1.Irritability= 1 THEN 1 ELSE 0 END)IRRITABILITYPRESENT 
       ,(CASE WHEN t1.Irritability IS NOT NULL AND t1.Irritability= 2 THEN 1 ELSE 0 END)IRRITABILITYABSENT 
       ,(CASE WHEN t1.RangeAffect IS NOT NULL AND t1.RangeAffect = 1 THEN 1 ELSE 0 END)RANGEAFFECTFULL 
       ,(CASE WHEN t1.RangeAffect IS NOT NULL AND t1.RangeAffect = 2 THEN 1 ELSE 0 END)RANGEAFFECTCONSTRICTED 
       ,(CASE WHEN t1.RangeAffect IS NOT NULL AND t1.RangeAffect = 3 THEN 1 ELSE 0 END)RANGEAFFECTFLAT
       ,(CASE WHEN t1.AppropriateContentSpeech IS NOT NULL AND t1.AppropriateContentSpeech = 1 THEN 1 ELSE 0 END)APPROPRIATECONTENTSPEECHYES 
       ,(CASE WHEN t1.AppropriateContentSpeech IS NOT NULL AND t1.AppropriateContentSpeech = 0 THEN 1 ELSE 0 END)APPROPRIATECONTENTSPEECHNO
       ,(CASE WHEN t1.MoodCongruent IS NOT NULL AND t1.MoodCongruent = 1 THEN 1 ELSE 0 END)MOODCONGRUENTYES
       ,(CASE WHEN t1.MoodCongruent IS NOT NULL AND t1.MoodCongruent = 0 THEN 1 ELSE 0 END)MOODCONGRUENTNO 
       ,(CASE WHEN t1.HomicidalIdeationPlanOrUntent IS NOT NULL AND t1.HomicidalIdeationPlanOrUntent = 1 THEN 1 ELSE 0 END)HOMICIDALIDEATIONPLANUNTENTPRESENT
       ,(CASE WHEN t1.HomicidalIdeationPlanOrUntent IS NOT NULL AND t1.HomicidalIdeationPlanOrUntent = 2 THEN 1 ELSE 0 END)HOMICIDALIDEATIONPLANUNTENTABSENT 
       ,(CASE WHEN t1.SuicidalIdeation IS NOT NULL AND t1.SuicidalIdeation = 1 THEN 1 ELSE 0 END)SUICIDALIDEATIONPRESENT 
       ,(CASE WHEN t1.SuicidalIdeation IS NOT NULL AND t1.SuicidalIdeation = 2 THEN 1 ELSE 0 END)SUICIDALIDEATIONABSENT 
       ,(CASE WHEN t1.SuicidalPlan IS NOT NULL AND t1.SuicidalPlan = 1 THEN 1 ELSE 0 END)SUICIDALPLANPRESENT 
       ,(CASE WHEN t1.SuicidalPlan IS NOT NULL AND t1.SuicidalPlan = 2 THEN 1 ELSE 0 END)SUICIDALPLANABSENT 
       ,(CASE WHEN t1.SuicidalIntent IS NOT NULL AND t1.SuicidalIntent = 1 THEN 1 ELSE 0 END)SUICIDALINTENTPRESENT 
       ,(CASE WHEN t1.SuicidalIntent IS NOT NULL AND t1.SuicidalIntent = 2 THEN 1 ELSE 0 END)SUICIDALINTENTABSENT 
       ,(CASE WHEN t1.SLArticulation IS NOT NULL AND t1.SLArticulation = 1 THEN 1 ELSE 0 END)ARTICULATIONNORMAL 
       ,(CASE WHEN t1.SLArticulation IS NOT NULL AND t1.SLArticulation = 0 THEN 1 ELSE 0 END)ARTICULATIONABNORMAL
       ,(CASE WHEN t1.SLRate IS NOT NULL AND t1.SLRate = 1 THEN 1 ELSE 0 END)RATENORMAL 
       ,(CASE WHEN t1.SLRate IS NOT NULL AND t1.SLRate = 0 THEN 1 ELSE 0 END)RATEPRESSURED 
       ,(CASE WHEN t1.SLRhythm IS NOT NULL AND t1.SLRhythm = 1 THEN 1 ELSE 0 END)RHYTHMNORMAL
       ,(CASE WHEN t1.SLRhythm IS NOT NULL AND t1.SLRhythm = 0 THEN 1 ELSE 0 END)RHYTHMPRESSURED 
       ,(CASE WHEN t1.VisualHallucinations IS NOT NULL AND t1.VisualHallucinations = 1 THEN 1 ELSE 0 END)VISUALHALLUCINATIONSPRESENT
       ,(CASE WHEN t1.VisualHallucinations IS NOT NULL AND t1.VisualHallucinations = 2 THEN 1 ELSE 0 END)VISUALHALLUCINATIONSABSENT
       ,(CASE WHEN t1.AuditoryHallucinations IS NOT NULL AND t1.AuditoryHallucinations = 1 THEN 1 ELSE 0 END)AUDITORYHALLUCINATIONSPRESENT 
       ,(CASE WHEN t1.AuditoryHallucinations IS NOT NULL AND t1.AuditoryHallucinations = 2 THEN 1 ELSE 0 END)AUDITORYHALLUCINATIONSABSENT 
       ,(CASE WHEN t1.AppearsRespInternStimulus IS NOT NULL AND t1.AppearsRespInternStimulus = 1 THEN 1 ELSE 0 END)APPEARSRESPONDINTERNALSTIMULUSYES
       ,(CASE WHEN t1.AppearsRespInternStimulus IS NOT NULL AND t1.AppearsRespInternStimulus = 0 THEN 1 ELSE 0 END)APPEARSRESPONDINTERNALSTIMULUSNO 
       ,(CASE WHEN t1.ThoughtProcesses IS NOT NULL AND t1.ThoughtProcesses = 1 THEN 1 ELSE 0 END)THOUGHTPROCESSESLAGD
       ,(CASE WHEN t1.ThoughtProcesses IS NOT NULL AND t1.ThoughtProcesses = 2 THEN 1 ELSE 0 END)THOUGHTPROCESSESDISORGANIZED 
       ,(CASE WHEN t1.ThoughtProcesses IS NOT NULL AND t1.ThoughtProcesses = 3 THEN 1 ELSE 0 END)THOUGHTPROCESSESCIRCUMSTANTIAL 
       ,(CASE WHEN t1.ThoughtProcesses IS NOT NULL AND t1.ThoughtProcesses = 4 THEN 1 ELSE 0 END)THOUGHTPROCESSESTANGENTIAL 
       ,(CASE WHEN t1.RacingThoughts IS NOT NULL AND  t1.RacingThoughts = 1 THEN 1 ELSE 0 END)RACINGTHOUGHTSPRESENT
       ,(CASE WHEN t1.RacingThoughts IS NOT NULL AND  t1.RacingThoughts = 2 THEN 1 ELSE 0 END)RACINGTHOUGHTSABSENT 
       ,DELUSIONS 
       ,(CASE WHEN t1.GuardSuspicious IS NOT NULL AND t1.GuardSuspicious = 1 THEN 1 ELSE 0 END)GUARDEDSUSPICIOUSYES
       ,(CASE WHEN t1.GuardSuspicious IS NOT NULL AND t1.GuardSuspicious = 0 THEN 1 ELSE 0 END)GUARDEDSUSPICIOUSNO
       ,(CASE WHEN t1.HyperVigilant IS NOT NULL AND t1.HyperVigilant = 1 THEN 1 ELSE 0 END)HYPERVIGILANTYES
       ,(CASE WHEN t1.HyperVigilant IS NOT NULL AND t1.HyperVigilant = 0 THEN 1 ELSE 0 END)HYPERVIGILANTNO
       ,(CASE WHEN t1.Preoccupation IS NOT NULL AND t1.Preoccupation = 1 THEN 1 ELSE 0 END)PREOCCUPATIONSYES 
       ,(CASE WHEN t1.Preoccupation IS NOT NULL AND t1.Preoccupation = 0 THEN 1 ELSE 0 END)PREOCCUPATIONSDENIED 
       ,(CASE WHEN t1.Insight=1 THEN 1 ELSE 0 END)INSIGHTGOOD 
       ,(CASE WHEN t1.Insight=2 THEN 1 ELSE 0 END)INSIGHTPOOR 
       ,JUDGEMENT
       ,(CASE WHEN t1.ExaggPsySymptoms IS NOT NULL AND t1.ExaggPsySymptoms = 0 THEN 1 ELSE 0 END)APPEARSEXAGGERATEPSYSYMPTOMSNO 
       ,(CASE WHEN t1.ExaggPsySymptoms IS NOT NULL AND t1.ExaggPsySymptoms = 1 THEN 1 ELSE 0 END)APPEARSEXAGGERATEPSYSYMPTOMSYES 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =1) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS1 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =2) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS2 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =3) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS3 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =4) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS4 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =5) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS5 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =6) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS6 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =7) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS7 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =8) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS8 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =9) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS9 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =10) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS10 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =11) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS11 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =12) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS12 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =13) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS13 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =14) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS14 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =15) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS15 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =16) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS16 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =17) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS17 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =18) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS18 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =19) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS19 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =20) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS20 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =21) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS21 
       ,(CASE WHEN (Select ISNULL(MEDICATIONTARGETSYMPTOMS, '') FROM @MEDICATIONTARGETSYMPTOMS WHERE ID =22) = '' THEN 0 ELSE 1 END)MEDICATIONTARGETSYMPTOMS22 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =1) = '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT1 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =2) = '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT2 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =3) = '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT3 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =4) = '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT4 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =5) = '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT5 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =6) = '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT6 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =7) = '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT7 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =8) = '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT8 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =9) = '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT9 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =10)= '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT10 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =11)= '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT11 
       ,(CASE WHEN (Select ISNULL(FUNCIMPAIRMENT,'') FROM @FUNCIMPAIRMENT WHERE ID =12)= '' THEN 0 ELSE 1 END)FUNCIMPAIRMENT12 
       ,(CASE WHEN (SELECT ISNULL(RECOMMENDATIONS,'') FROM @RECOMMENDATIONS WHERE ID =1)= '' THEN 0 ELSE 1 END)RECOMMENDATIONS1 
       ,(CASE WHEN (SELECT ISNULL(RECOMMENDATIONS,'') FROM @RECOMMENDATIONS WHERE ID =2)= '' THEN 0 ELSE 1 END)RECOMMENDATIONS2 
       ,(CASE WHEN (SELECT ISNULL(RECOMMENDATIONS,'') FROM @RECOMMENDATIONS WHERE ID =3)= '' THEN 0 ELSE 1 END)RECOMMENDATIONS3 
       ,(CASE WHEN (SELECT ISNULL(RECOMMENDATIONS,'') FROM @RECOMMENDATIONS WHERE ID =4)= '' THEN 0 ELSE 1 END)RECOMMENDATIONS4 
       ,(CASE WHEN (SELECT ISNULL(LabsRequested,'') FROM @LABSREQUESTED Where ID =1)= '' THEN 0 ELSE 1 END)LABSREQUESTEDCBC 
       ,(CASE WHEN (SELECT ISNULL(LabsRequested,'') FROM @LABSREQUESTED Where ID =2)= '' THEN 0 ELSE 1 END)LABSREQUESTEDCHEM 
       ,(CASE WHEN (SELECT ISNULL(LabsRequested,'') FROM @LABSREQUESTED Where ID =3)= '' THEN 0 ELSE 1 END)LABSREQUESTEDA1C 
       ,(CASE WHEN (SELECT ISNULL(LabsRequested,'') FROM @LABSREQUESTED Where ID =4)= '' THEN 0 ELSE 1 END)LABSREQUESTEDSTUDY
	   ,(CASE WHEN (SELECT ISNULL(LabsRequested,'') FROM @LABSREQUESTED Where ID =5)= '' THEN 0 ELSE 1 END)LABSREQUESTEDOTHER
       ,(CASE WHEN (SELECT ISNULL(Discussed,'') FROM @Discussed Where ID =1)= '' THEN 0 ELSE 1 END)DISCUSSEDPLAN
       ,(CASE WHEN (SELECT ISNULL(Discussed,'') FROM @Discussed Where ID =2)= '' THEN 0 ELSE 1 END)DISCUSSEDSIDE
       ,(CASE WHEN (SELECT ISNULL(Discussed,'') FROM @Discussed Where ID =3)= '' THEN 0 ELSE 1 END)DISCUSSEDFOLLOW
       ,(CASE WHEN (SELECT ISNULL(Discussed,'') FROM @Discussed Where ID =4)= '' THEN 0 ELSE 1 END)DISCUSSEDDIET
       ,(CASE WHEN t1.RTC= 1 THEN 1 ELSE 0 END)RTC1MONTH
       ,(CASE WHEN t1.RTC= 2 THEN 1 ELSE 0 END)RTC2MONTH
       ,(CASE WHEN t1.RTC= 3 THEN 1 ELSE 0 END)RTC3MONTH
       ,(CASE WHEN t1.RTC= 4 THEN 1 ELSE 0 END)RTCWEEKS
       ,CONVERT(nvarchar(5),ISNULl(t1.RTCWeeks, '')) AS RTCAMOUNTWEEKS
       ,LABSREQUESTEDOTHERNOTE
       ,(CASE WHEN t1.PsychomotorActivity= 2 THEN 1 ELSE 0 END)PSYCHOMOTORACTIVITYABNORMAL
       ,(CASE WHEN t1.PsychomotorActivity= 1 THEN 1 ELSE 0 END)PSYCHOMOTORACTIVITYWNL
	   ,@ISLatestMMA AS ISLatestMMA
       ,GetDate() AS PrintDate
 FROM  (SELECT e.EpisodeID, e.OffenderID, e.CDCRNum, o.DOB, e.ParoleLocationID 
       FROM Episode e INNER JOIN Offender o on e.OffenderID  = o.OffenderID WHERE e.EpisodeID = @EpisodeID) t2
	   LEFT OUTER JOIN [dbo].[PsychiatryASMT] t1 on t1.EpisodeId = t2.EpisodeID  
 Where (@Id > 0 AND t1.Id  = @Id) OR (ISNULL(@Id, 0) = 0 AND t2.EpisodeID =@EpisodeID)

	   
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeMMA] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeMMA] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodeNeedsAssessment
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeNeedsAssessment]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeNeedsAssessment]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeNeedsAssessment]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-03-09
-- Update date: 
-- Description:	Retrive NeedsAssessment
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeNeedsAssessment]
    @EpisodeID int = 0,
	@AssessmentID int = 0
AS	
BEGIN
   DECLARE @True bit = 1
   DECLARE @False bit =0
   DECLARE @IsLastOne  bit = 0
   IF  @EpisodeID > 0 
   BEGIN
    DECLARE @LAMID int
	DECLARE @LIRPID int
     SELECT @LAMID = ISNULl(NeedsAssessmentID, 0), @LIRPID = ISNULL(IRPID, 0)
	  FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID

	  IF @LAMID = @AssessmentID OR @AssessmentID = 0 SET @IsLastOne = 1

	  IF @AssessmentID > 0 
	        SET @LAMID =@AssessmentID
	  --IF @LAMID = @AssessmentID
	  --  SET @IsLastOne = 1

   --   IF @AssessmentID > 0 AND @LAMID <> @AssessmentID
	  --BEGIN
	  --   SET @LAMID =@AssessmentID
	  --END

	  DECLARE @MCASRScore int = 0
	  DECLARE @MCASRID int =(SELECT ISNULl(MCASRID,0) FROM dbo.EpisodeTrace Where EpisodeID  = @EpisodeID) 
	  IF @MCASRID > 0
	    SET @MCASRScore  =(SELECT ISNULL(Section1Score, 0) +  ISNULL(Section2Score, 0) + ISNULL(Section3Score, 0) +  ISNULL(Section4Score, 0)  
		                     FROM dbo.CaseMCASR WHERE ID = @MCASRID)
      
      --DECLARE @irpID  int = (Select IRPID FROM dbo.CaseNeedsAssessment Where ID  = @LAMID) 
	  							   
	  IF @LAMID > 0 			   
	  BEGIN
      SELECT ISNULl(t2.ID, 0) AS AssessmentId, t2.AdditionalInformation,  
		  (CASE WHEN ISNULl(t2.ServiceNeeds, 0) = 1 THEN @True ELSE @False END)ServiceHighNeeds,
		  (CASE WHEN ISNULl(t2.ServiceNeeds, 0) = 2 THEN @True ELSE @False END)ServiceModNeeds,
		  (CASE WHEN ISNULl(t2.ServiceNeeds, 0) = 3 THEN @True ELSE @False END)ServiceLowNeeds,	
		  (CASE WHEN ISNULl(t2.InterpreterNeeded, 0) = 1 THEN @True ELSE @False END)InterpreterNeededYes,
		  (CASE WHEN ISNULl(t2.InterpreterNeeded, 0) = 0 THEN @True ELSE @False END)InterpreterNeededNo, AssessmentLauguage,
		  t2.DateAction AS AssessmentDate, ISNULL(t2.IRPID, @LIRPID)IRPID,  @MCASRScore as MCASRScore,
		  (SELECT NAME FROM fn_GetAsstUserName(t2.ActionBy))ActionName, @IsLastOne AS IsLastNeedsAssessmentSet
      FROM dbo.Episode t1 LEFT OUTER JOIN dbo.CaseNeedsAssessment t2 ON t1.EpisodeID  = t2.EpisodeID
     WHERE t2.Id  = @LAMID
	END
	ELSE
	BEGIN
	 SELECT 0 AS AssessmentId, '' AS AdditionalInformation, NULL AS InterpreterNeededYes, NULl AS InterpreterNeededNo,
			NULL AS ServiceHighNeeds,NULL AS ServiceModNeeds,NULL AS ServiceLowNeeds, NULL AS InterpreterNeededYes, NULL AS InterpreterNeededNo,
			'' AS AssessmentLauguage, GetDate() AS AssessmentDate, @LIRPID AS IRPID, @MCASRScore as MCASRScore, '' AS ActionName, @IsLastOne AS IsLastNeedsAssessmentSet
  END

	EXEC [dbo].[spGetEpisodeIRP] @EpisodeID, @LIRPID

 END
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeNeedsAssessment] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeNeedsAssessment] to [ACCOUNTS\Svc_CDCRPATSUser]
GO 
--============================================================================
--spGetEpisodePMHProfile
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodePMHProfile]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodePMHProfile]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodePMHProfile]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-03-10
-- Update date: 
-- Description:	Retrive PMH Profile
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodePMHProfile]
    @EpisodeID int = 0,
	@NeedFacility bit = 0
AS	
BEGIN
    DECLARE @True bit = 1
    DECLARE @False bit =0

    DECLARE @CDCNUMBER varchar(6)
    DECLARE @PAROLEENAME nvarchar(70) 
    DECLARE @PAROLEEAGENT nvarchar(70)
    --DECLARE @DATE  DateTime = null
    DECLARE @NORTHERN bit = @False
    DECLARE @SOUTHERN bit = @False
    DECLARE @MALE bit = @False
    DECLARE @FEMALE bit = @False
    DECLARE @PAROLEUNIT nvarchar(50)
    DECLARE @StaffAssigned nvarchar(150) = (SELECT (SELECT Name FROM dbo.fn_GetAsstUserName(ISNULL(t1.SocialWorkerUserID,0))) 
	                                          FROM StaffAssignment t1 inner join EpisodeTrace t2 on t1.EpisodeID = t2.EpisodeID AND t1.ID = t2.StaffAssignmentID
											  WHERE t1.EpisodeID  = @EpisodeID)
    DECLARE @StreetAddress nvarchar(70) = ''
    DECLARE @City nvarchar(50) = ''
    DECLARE @ZIPCode nvarchar(10) = ''
    DECLARE @State varchar(2) = 'CA'
    DECLARE @DOB DateTime = null
	DECLARE @AddressID int = 0
	DECLARE @FacilityID int = 0
    DECLARE @SOCIALSECURITYNUMBER nvarchar(11) = null
    DECLARE @Married bit = @False
    DECLARE @Separated bit = @False
    DECLARE @Divorced bit = @False
    DECLARE @Widowed bit = @False
    DECLARE @Cohabitating bit = @False
    DECLARE @Single bit = @False
    DECLARE @DomesticPartner bit = @False
	DECLARE @ParoleePhoneResidence nvarchar(25)
    DECLARE @ParoleePhoneWork nvarchar(25) = ''
    DECLARE @EmergencyContactName nvarchar(70) = ''
    DECLARE @EmergencyContactPhoneResidence nvarchar(25) = ''
    DECLARE @EmergencyContactPhoneWork nvarchar(25) = ''
	DECLARE @EmergencyContactID int = 0
	DECLARE @ParoleeWorkID int = 0
	DECLARE @White bit= @False
    DECLARE @AmericanIndian bit= @False
    DECLARE @Asian bit= @False
    DECLARE @AfricanAmerican bit= @False
    DECLARE @Hispanic bit= @False
    DECLARE @Other bit= @False
	DECLARE @CCCMS bit= @False
    DECLARE @EOP bit= @False
    DECLARE @MHNONE bit= @False
	DECLARE @NCF bit= @False
    DECLARE @NDD bit= @False
    DECLARE @DD0 bit= @False
    DECLARE @DD1 bit= @False
    DECLARE @DD2 bit= @False
    DECLARE @DD3 bit= @False
    DECLARE @DDPNone bit= @False
	DECLARE @RECENTRELEASEDATE DateTime = null
    DECLARE @CSRASCORE nvarchar(10)
    DECLARE @DISCHARGEREVIEWDATE DateTime = null
	DECLARE @Prison bit= @False
    DECLARE @CountyJail bit= @False
    DECLARE @CourtWalkover bit= @False
    DECLARE @ReleaseTypeNone bit= @False
    DECLARE @Mobility bit= @False
    DECLARE @Hearing bit= @False
	DECLARE @Speech bit= @False
    DECLARE @Vision bit= @False
    DECLARE @DPPSTATUSNone bit= @False
    DECLARE @COMPASCRIMINOGENICNEEDS nvarchar(100)
    DECLARE @CONTROLLINGDISCHARGEDATE DateTime = null
    DECLARE @CCIINSTITUTIONINFORMATION nvarchar(255)
    DECLARE @ADDITIONALINFORMATION nvarchar(255)
	DECLARE @DATE DateTime

	DECLARE @region varchar(1) = (select Region from tlkpCounty WHERE CountyID  = (SELECT ISNULl(ReleaseCountyID, 0) FROM EPisode Where EpisodeID  = @EpisodeID))
		
	SELECT @CDCNUMBER = e.CDCRNum, 
	       @PAROLEENAME=o.LastName + ', ' + o.FirstName + ' ' + ISNULl(o.MiddleName, ''), 
	       @PAROLEEAGENT= e.ParoleAgent,
	       @NORTHERN = (CASE WHEN @region = 'N' THEN @True ELSE @False END), 
		   @SOUTHERN = (CASE WHEN @region = 'S' THEN @True ELSE @False END),
		   @MALE = (CASE WHEN ISNULl(o.GenderID, 0) = 2 THEN @True ELSE @False END), 
		   @FEMALE =(CASE WHEN ISNULl(o.GenderID, 0) = 1 THEN @True ELSE @False END),
		   @PAROLEUNIT = e.ParoleUnit,
		   @SOCIALSECURITYNUMBER = o.SSN, 
		   @DOB = o.DOB, 
		   @RECENTRELEASEDATE = e.ReleaseDate, 
		   @FacilityID = ISNULl(e.CustodyFacilityID,0),
		   @CCIINSTITUTIONINFORMATION=(CASE WHEN ISNULL(e.CustodyFacilityID, 0) = 0 THEN '' ELSE (SELECT Name FROM tlkpFacility WHERE FacilityID  = e.CustodyFacilityID ) END),
		   @NCF = (CASE WHEN ISNULL(o.DDP, '') = 'NCF'  THEN @True ELSE @False END),
           @NDD = (CASE WHEN ISNULL(o.DDP, '') = 'NDD'  THEN @True ELSE @False END),
           @DD0 = (CASE WHEN ISNULL(o.DDP, '') = 'DD0'  THEN @True ELSE @False END),
           @DD1 = (CASE WHEN ISNULL(o.DDP, '') = 'DD1'  THEN @True ELSE @False END),
           @DD2 = (CASE WHEN ISNULL(o.DDP, '') = 'DD2'  THEN @True ELSE @False END),
           @DD3 = (CASE WHEN ISNULL(o.DDP, '') = 'DD3'  THEN @True ELSE @False END),
           @DDPNone = (CASE WHEN ISNULL(o.DDP, '')=''  THEN @True ELSE @False END),
		   @Mobility= (CASE WHEN ISNULL(o.DPPMobility, '')=''  THEN @False ELSE @True END),
		   @Hearing =(CASE WHEN ISNULL(o.DPPHearing, '')=''  THEN @False ELSE @True END),
		   @Speech =(CASE WHEN ISNULL(o.DPPSpeech, '')=''  THEN @False ELSE @True END),
		   @Vision =(CASE WHEN ISNULL(o.DPPVision, '')=''  THEN @False ELSE @True END),
		   @Date = e.InitialDate 		                       
	  FROM Episode e INNER JOIN Offender o ON e.OffenderID  = o.OffenderID Where EpisodeID  = @EpisodeID
	  
	  DECLARE @ClientEpisodeID int =(SELECT ClientEpisodeID FROM EpisodeTrace Where EpisodeID = @EpisodeID)
      IF @ClientEpisodeID > 0 
	  BEGIN
	      SELECT @Married = (CASE WHEN ISNULl(SignificantOtherStatusCode, '') ='M' THEN @True ElSE @False END),
		         @Separated  =(CASE WHEN ISNULl(SignificantOtherStatusCode, '')='S' THEN @True ElSE @False END),
		         @Divorced  = (CASE WHEN ISNULl(SignificantOtherStatusCode, '')='D' THEN @True ElSE @False END),
		         @Widowed=(CASE WHEN ISNULl(SignificantOtherStatusCode, '')='W' THEN @True ElSE @False END),
		         @Cohabitating  = (CASE WHEN ISNULl(SignificantOtherStatusCode, '')='O' THEN @True ElSE @False END),
		         @Single = (CASE WHEN ISNULl(SignificantOtherStatusCode, '')='N' THEN @True ElSE @False END),
				 @DomesticPartner =(CASE WHEN ISNULl(SignificantOtherStatusCode, '')='P' THEN @True ElSE @False END),
				 @DISCHARGEREVIEWDATE = DischargeReviewDate, 
				 @CSRASCORE = CSRASCORE, 
				 @COMPASCRIMINOGENICNEEDS =COMPASCRIMINOGENICNEEDS,
				 @CONTROLLINGDISCHARGEDATE = CONTROLLINGDISCHARGEDATE, 
				 @ADDITIONALINFORMATION =ADDITIONALINFORMATION,
				 @Asian = (CASE WHEN ISNULL(EthnicityID, 0) = 1 THEN @True ELSE @False END), @AfricanAmerican = (CASE WHEN ISNULL(EthnicityID, 0) =3 THEN @True ELSE @False END),
				 @White = (CASE WHEN ISNULL(EthnicityID, 0) = 4 THEN @True ELSE @False END), @Hispanic = (CASE WHEN ISNULL(EthnicityID, 0) =5 THEN @True ELSE @False END),
				 @AmericanIndian = (CASE WHEN EthnicityID = 6 THEN @True ELSE @False END), @Other = (CASE WHEN ISNULL(EthnicityID, 0) =7 THEN @True ELSE @False END),
				 @CCCMS=(CASE WHEN ISNULL(ParoleMentalHealthLevelOfServiceID, 0) in (3, 6) THEN @True ELSE @False END ),
				 @EOP=(CASE WHEN ISNULL(ParoleMentalHealthLevelOfServiceID, 0) in (2, 7) THEN @True ELSE @False END ),
				 @MHNONE=(CASE WHEN ISNULL(ParoleMentalHealthLevelOfServiceID, 0) NOT in (2,3, 6, 7) THEN @True ELSE @False END ),
				 @Prison = (CASE WHEN ISNULL(CaseReferralSourceCode, '') = 'I' THEN @True ELSE @False END),
				 @CountyJail = (CASE WHEN ISNULL(CaseReferralSourceCode, '') = 'J' THEN @True ELSE @False END),
				 @CourtWalkover = (CASE WHEN ISNULL(CaseReferralSourceCode, '') = 'W' THEN @True ELSE @False END),
				 @ReleaseTypeNone= (CASE WHEN ISNULL(CaseReferralSourceCode, '') = '' THEN @True ELSE @False END),
				 @Date = DateAction
		    FROM dbo.ClientEpisode  Where EpisodeID  = @EpisodeID AND ClientEpisodeID  = @ClientEpisodeID
	  END

	  IF EXISTS(SELECT 1 FROM ADDRESS WHERE AddressTypeID = 1 AND Inactive= 0 AND ActionStatus <> 10 AND EpisodeID  = @EpisodeID)
	  BEGIN
	  SELECT @AddressID=t1.ID, @StreetAddress=StreetAddress, @City=City, @ZIPCode=ZIPCode, @State ='CA', @ParoleePhoneResidence = PrimaryNumber, @ParoleePhoneWork=SecondaryNumber 
	    FROM ADDRESS t1 INNER JOIN EpisodeTrace t2 ON t1.EpisodeID  = t2.EpisodeID AND t1.ID  = t2.AddressID 
	   WHERE AddressTypeID = 1 AND Inactive= 0 AND ActionStatus <> 10 AND t1.EpisodeID = @EpisodeID 
	  END
	  IF EXISTS(SELECT 1 FROM ADDRESS WHERE AddressTypeID = 4 AND Inactive= 0 AND ActionStatus <> 10 AND EpisodeID  = @EpisodeID)
	  BEGIN
	  SELECT @ParoleeWorkID=ID, @ParoleePhoneWork = PrimaryNumber FROM
	      (SELECT ID, PrimaryNumber, ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY ID DESC) AS RowNum FROM ADDRESS 
		    WHERE AddressTypeID = 4 AND Inactive= 0 AND ActionStatus <> 10 AND EpisodeID  = @EpisodeID) d WHERE d.RowNum = 1 
	  END 	   
	  IF EXISTS(SELECT 1 FROM ADDRESS WHERE AddressTypeID = 3 AND Inactive= 0 AND ActionStatus <> 10 AND EpisodeID  = @EpisodeID)
	  BEGIN
	   SELECT @EmergencyContactID=ID, @EmergencyContactName=FacilityName, @EmergencyContactPhoneResidence = PrimaryNumber, @EmergencyContactPhoneWork =SecondaryNumber  FROM
	      (SELECT ID, FacilityName, PrimaryNumber, SecondaryNumber, ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY ID DESC) AS RowNum FROM ADDRESS 
		    WHERE AddressTypeID = 3 AND Inactive= 0 AND ActionStatus <> 10 AND EpisodeID  = @EpisodeID) d WHERE d.RowNum = 1 
	  END 		
	     
	SELECT @CDCNUMBER AS CDCNUMBER,@PAROLEENAME AS PAROLEENAME,@PAROLEEAGENT AS PAROLEEAGENT,@NORTHERN AS NORTHERN,@SOUTHERN AS SOUTHERN,
	       @MALE AS MALE, @FEMALE AS FEMALE, @PAROLEUNIT AS PAROLEUNIT, @StaffAssigned AS StaffAssigned,@StreetAddress AS StreetAddress,
		   @City AS City,@ZIPCode AS ZIPCode,@State AS State,@DOB AS DOB,@AddressID AS AddressID, @FacilityID as FacilityID, @SOCIALSECURITYNUMBER AS SOCIALSECURITYNUMBER,
		   @Married AS Married,@Separated AS Separated,@Divorced AS Divorced,@Widowed AS Widowed, @Cohabitating AS Cohabitating,
		   @Single AS Single, @DomesticPartner AS DomesticPartner, @ParoleePhoneResidence AS ParoleePhoneResidence,@ParoleePhoneWork AS ParoleePhoneWork,
		   @EmergencyContactName AS EmergencyContactName,@EmergencyContactPhoneResidence AS EmergencyContactPhoneResidence,
		   @EmergencyContactPhoneWork AS EmergencyContactPhoneWork,@EmergencyContactID AS EmergencyContactID,@ParoleeWorkID AS ParoleeWorkID, 
		   @White AS White, @AmericanIndian AS AmericanIndian,@Asian AS Asian,@AfricanAmerican AS AfricanAmerican,@Hispanic AS Hispanic,@Other AS Other,   
		   @CCCMS AS CCCMS,@EOP AS EOP,@MHNONE AS MHNONE,@NCF AS NCF,@NDD AS NDD,@DD0 AS DD0,@DD1 AS DD1,@DD2 AS DD2,@DD3 AS DD3,@DDPNone AS DDPNone, 
		   @RECENTRELEASEDATE AS RECENTRELEASEDATE,@CSRASCORE AS CSRASCORE,@DISCHARGEREVIEWDATE AS DISCHARGEREVIEWDATE,@Prison AS Prison, @CountyJail AS CountyJail, 
		   @CourtWalkover AS CourtWalkover, @ReleaseTypeNone AS ReleaseTypeNone, @Mobility AS Mobility,@Hearing AS Hearing,@Vision AS Vision,
		   @DPPSTATUSNone AS DPPSTATUSNone, @COMPASCRIMINOGENICNEEDS AS COMPASCRIMINOGENICNEEDS, @CONTROLLINGDISCHARGEDATE AS CONTROLLINGDISCHARGEDATE,
		   @CCIINSTITUTIONINFORMATION AS CCIINSTITUTIONINFORMATION,@ADDITIONALINFORMATION AS ADDITIONALINFORMATION, @Date As [DATE]
	 
IF @NeedFacility = 1
  SELECT [FacilityID],[OrgCommonID],[SomsLoc], [Abbr], [Name], [Disabled],
        [IsHospital], [IsOutOfState], [IsMCCF] From tlkpFacility
  WHERE ISNULl([Disabled],0) = 0
	

END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodePMHProfile] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodePMHProfile] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetEpisodeProfile
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeProfile]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeProfile]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeProfile]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetEpisodeProfile]
    @EpisodeID int = 0,
	@PID int = 0,
	@CDCRNum varchar(6) = '',
	@Matches bit = 0
AS	
BEGIN
   
   IF  @EpisodeID > 0
   BEGIN
 
SELECT  T1.EpisodeID,T1.CDCRNum as CDCRNumber,ISNULL(T1.ReleaseCountyID, 0) as CountyId, 
        (SELECT ComplexID FROM tlkpLocation WHERE LocationID  = ISNULL(T1.ParoleLocationID, 0))ComplexId,
        ISNULL(T3.EthnicityID, 0)EthnicityId, 
        T1.PID, T1.GenderID as GenderId, T3.PlaceOfBirth as POB, T1.LastName, T1.FirstName,ISNULL(T1.MiddleName, '')MidName,
		T1.DOB, T1.SSN, T3.Alias, (CASE WHEN T3.SignificantOtherStatusCode IS NULL THEN '' ELSE T3.SignificantOtherStatusCode END)SignificantOtherStatus,
		(CASE WHEN T3.ParoleMentalHealthLevelOfServiceID IS NULL THEN 0 ELSE T3.ParoleMentalHealthLevelOfServiceID END) as MHLevelOfService, 
		 T3.InTakeDate, T3.CaseBankedDate, T3.CaseReferralSourceCode as CaseReferral, T3.ParoleDisChargeDate, 
	     T1.ReleaseDate, ISNULl(T1.ParoleLocationID, 0)SelectedLocationId,T1.ParoleUnit, T1.PC290, T1.PC457, T1.Lifer,  
		 T1.USVet, T3.IsConvictedOfStalking,T3.CaseClosureReasonCode as CaseClosureReasonID, T3.CaseClosureDate, 
		 T3.ISMIPReferredDate, T3.ISMIPEnrolledDate, T3.ISMIPClosedDate,T3.CMProgramStartDate, T3.CMProgramClosedDate, 
		 T3.MATProgramStartDate, T3.MATProgramClosedDate, T3.CMRPEStartDate, T3.CMRPEClosedDate, T1.ParoleAgent, T3.ASAMDate, 
		 (CASE WHEN EXISTS(SELECT 1 FROM ClientUploadFile WHERE EpisodeId= T1.EpisodeID) THEN (SELECT TOP 1 ID FROM ClientUploadFile WHERE EpisodeId= T1.EpisodeID) ELSE 0 END)AsamFileId,
		 (CASE WHEN T3.InclusionCriteriaMet IS NOT NULL AND T3.InclusionCriteriaMet = 1 THEN  Convert(bit, 1) ELSE  Convert(bit, 0) END )InclusionCriteriaMetYes,
		 (CASE WHEN T3.InclusionCriteriaMet IS NOT NULL AND T3.InclusionCriteriaMet = 0 THEN  Convert(bit, 1) ELSE  Convert(bit, 0) END )InclusionCriteriaMetNo, 
		 T3.ASAMComments FROM
	(Select e.EpisodeID, e.OffenderID, e.ReleaseDate, e.CDCRNum, e.SuggestionDate, e.ReleaseCountyID, e.ParoleLocationID, e.ParoleUnit,ct.ClientEpisodeID,
	  o.PID, o.GenderID, o.PC290, o.PC457, e.Lifer, o.USVet,o.LastName, o.FirstName, o.MiddleName,o.DOB, o.SSN,
	  e.ParoleAgent FROM Episode e INNER JOIN  Offender o on e.OffenderID  = o.OffenderID
	   INNER JOIN EpisodeTrace ct on e.EpisodeID = ct.EpisodeID 
	  where e.EpisodeID = @EpisodeID) T1 	
	Left Outer Join dbo.ClientEpisode T3 on T1.ClientEpisodeID = T3.ClientEpisodeID
	

END
ELSE IF (@PID > 0 AND EXISTS(select 1 from Offender Where PID  = @PID)) OR 
        (@CDCRNum <> '' AND EXISTS(select 1 from Episode Where CDCRNum like  '%' + @CDCRNum + '%'))
BEGIN
   IF @Matches = 1
   BEGIN
      DECLARE @OffenderID  int =(SELECT OffenderID FROM Episode Where CDCRNum = @CDCRNum)
      SELECT T1.PID, T1.EpisodeID, T1.CDCRNum as CDCRNumber, (T1.LastName + ', ' + T1.FirstName)Name, CONVERT(VARCHAR(10), T1.DOB, 23)DOB,
		     T1.GenderID as MatchGender, T1.ReleaseDate, 
			 (CASE WHEN T2.CaseClosureDate IS NULL THEN '' ELSE CONVERT(VARCHAR(10), T2.CaseClosureDate, 23) END)CaseClosureDate, 
			 (CASE WHEN ISNULL(t2.CaseClosureReasonCode, '') = '' THEN '' ELSE 
			          (SELECT CaseClosureReasonDescShort 
			             FROM [dbo].tlkpCaseClosureReason WHERE CaseClosureReasonCode = t2.CaseClosureReasonCode) END) CaseCloseReason
        FROM
	     (SELECT EpisodeID, e.OffenderID, e.ReleaseDate, e.CDCRNum, o.PID, o.GenderID, o.LastName, o.FirstName, o.DOB
	        FROM Episode e INNER JOIN  Offender o on e.OffenderID  = o.OffenderID where o.PID = @PID OR e.OffenderID = @OffenderID) t1 	
	       LEFT OUTER JOIN 
	     (SELECT c1.ClientEpisodeID, c1.EpisodeID, CaseClosureDate, CaseClosureReasonCode
            FROM [dbo].[ClientEpisode] c1 INNER JOIN [dbo].[EpisodeTrace] c2 on c1.ClientEpisodeID = c2.ClientEpisodeID)t2
              ON t1.EpisodeID  =  t2.EpisodeID
   END
   ELSE
   BEGIN
    IF NOT EXISTS(SELECT 1 FROM Episode WHERE CDCRNum = @CDCRNum ) AND EXISTS(SELECT 1 FROM Offender WHERE PID = @PID)	
	SELECT  0, @CDCRNum as CDCRNumber,0 as CountyId, 0 AS ComplexId,NULL AS EthnicityId, PID, GenderID as GenderId, '' as POB, LastName, FirstName,ISNULL(MiddleName, '')MidName,
			DOB, SSN, NULL AS Alias, NULL AS SignificantOtherStatus, NULL as MHLevelOfService, 
			NULL as InTakeDate, NULL as CaseBankedDate, NULL as CaseReferral, NULL as ParoleDisChargeDate, 
			NULL AS ReleaseDate, NULL AS SelectedLocationId, NULL AS ParoleUnit, 0 AS PC290, 0 AS PC457, 0 AS Lifer,
			0 AS USVet, NULL AS IsConvictedOfStalking, NULL as CaseClosureReasonID, NULL AS CaseClosureDate, 
		    NULL AS ISMIPReferredDate, NULL AS ISMIPEnrolledDate, NULL AS ISMIPClosedDate,NULL AS CMProgramStartDate, NULL AS CMProgramClosedDate, 
		    NULL AS MATProgramStartDate, NULL AS MATProgramClosedDate, NULL AS CMRPEStartDate, NULL AS CMRPEClosedDate, NULL AS ParoleAgent, NULL AS ASAMDate, 
		   NULL AS AsamFileId,NULL AS InclusionCriteriaMetNo,NULL AS ASAMComment
	 FROM Offender Where PID = @PID
   ELSE IF EXISTS(SELECT 1 FROM Episode WHERE CDCRNum = @CDCRNum ) AND EXISTS(SELECT 1 FROM Offender WHERE PID = @PID)
    SELECT TOP 1 T1.EpisodeID,@CDCRNum as CDCRNumber,ISNULL(T1.ReleaseCountyID, 0) as CountyId, 
           (SELECT ComplexID FROM tlkpLocation WHERE LocationID  = ISNULL(T1.ParoleLocationID, 0))ComplexId,
			ISNULL(T3.EthnicityID, 0)EthnicityId, 
			T1.PID, T1.GenderID as GenderId, T3.PlaceOfBirth as POB, T1.LastName, T1.FirstName,ISNULL(T1.MiddleName, '')MidName,
			T1.DOB, T1.SSN, T3.Alias, 
			(CASE WHEN T3.SignificantOtherStatusCode IS NULL THEN '' ELSE T3.SignificantOtherStatusCode END)SignificantOtherStatus,
			(CASE WHEN T3.ParoleMentalHealthLevelOfServiceID IS NULL THEN 0 ELSE T3.ParoleMentalHealthLevelOfServiceID END) as MHLevelOfService, 
			T3.InTakeDate, T3.CaseBankedDate, T3.CaseReferralSourceCode as CaseReferral, T3.ParoleDisChargeDate, 
			T1.ReleaseDate, ISNULL(T1.ParoleLocationID, 0)SelectedLocationId, T1.ParoleUnit, T1.PC290, T1.PC457, T1.Lifer,
			T1.USVet, T3.IsConvictedOfStalking, T3.CaseClosureReasonCode as CaseClosureReasonID, T3.CaseClosureDate, 
		    T3.ISMIPReferredDate, T3.ISMIPEnrolledDate, T3.ISMIPClosedDate,T3.CMProgramStartDate, T3.CMProgramClosedDate, 
		    T3.MATProgramStartDate, T3.MATProgramClosedDate, T3.CMRPEStartDate, T3.CMRPEClosedDate, T1.ParoleAgent, T3.ASAMDate, 
		   (CASE WHEN EXISTS(SELECT 1 FROM ClientUploadFile WHERE EpisodeId= T1.EpisodeID) 
		         THEN (SELECT TOP 1 ID FROM ClientUploadFile WHERE EpisodeId= T1.EpisodeID) ELSE 0 END)AsamFileId,
		   (CASE WHEN T3.InclusionCriteriaMet IS NOT NULL AND T3.InclusionCriteriaMet = 1 
		         THEN  Convert(bit, 1) ELSE  Convert(bit, 0) END )InclusionCriteriaMetYes,
		   (CASE WHEN T3.InclusionCriteriaMet IS NOT NULL AND T3.InclusionCriteriaMet = 0 
		         THEN  Convert(bit, 1) ELSE  Convert(bit, 0) END )InclusionCriteriaMetNo,T3.ASAMComments 
	 FROM
	   (SELECT e.EpisodeID, e.OffenderID, e.ReleaseDate, e.CDCRNum, e.SuggestionDate, e.ReleaseCountyID, e.ParoleLocationID, e.ParoleUnit,
	           o.PID, o.GenderID, o.PC290, o.PC457, e.Lifer, o.USVet,o.LastName, o.FirstName, o.MiddleName,o.DOB, o.SSN, c.ClientEpisodeID,
	           e.ParoleAgent 
		  FROM Episode e INNER JOIN  Offender o on e.OffenderID  = o.OffenderID
		       INNER JOIN dbo.EpisodeTrace c on e.EpisodeID  = c.EpisodeID where o.PID = @PID OR e.CDCRNum = @CDCRNum) T1 	
	     LEFT OUTER JOIN dbo.ClientEpisode T3 on T1.ClientEpisodeID = T3.ClientEpisodeID
		 ORDER BY EpisodeID DESC
   END
END
ELSE
BEGIN
  SELECT @EpisodeID as EpisodeID, @CDCRNum as CDCRNumber, 0 as CountyId, 0 as ComplexId, 0 as EthnicityId, 
        @PID as PID, 0 as GenderId, NULL as POB, '' as LastName, '' as FirstName, NULL as MidName,
		NULL as DOB, NULL as SSN, NULL as Alias, NULL as SignificantOtherStatus,
		NULL as MHLevelOfService, NULL as InTakeDate, NULL as CaseBankedDate, 
		NULL as CaseReferral, NULL as ParoleDisChargeDate, 
	    NULL as ReleaseDate, 0 as SelectedLocationId, NULL as ParoleUnit, 
		Convert(bit, 0) as PC290, Convert(bit, 0) as PC457, Convert(bit, 0) as Lifer, Convert(bit, 0) as USVet, NULL as IsConvictedOfStalking,
		NULL as  CaseClosureReasonID, NULL as CaseClosureDate, NULL as ISMIPReferredDate,NULL as ISMIPEnrolledDate, 
		NULL as ISMIPClosedDate, NULL as CMProgramStartDate, NULL as CMProgramClosedDate,NULL as MATProgramStartDate,  
		NULL as MATProgramClosedDate, NULL as CMRPEStartDate, NULL as CMRPEClosedDate, NULL as ParoleAgent, NULL as ASAMDate, 
		NULL as AsamFileId, Convert(bit, 0) as InclusionCriteriaMetYes, Convert(bit, 0) as InclusionCriteriaMetNo, NULL as ASAMComments
END 
--All lookup tables for client episode
 IF @Matches = 0
 BEGIN
    SELECT DISTINCT ComplexID, ComplexDesc FROM tlkpLocation WHERE ISNULL(Disabled, 0) = 0 AND ISNULL(ComplexID, 0) >  0 ORDER BY ComplexDesc
    SELECT [EthnicityID], [EthnicityDesc], [Disabled], [ActionBy],[DateAction] 
      FROM tlkpEthnicity WHERE ISNULL(Disabled, 0) = 0
    SELECT [GenderID],[Code],[Name],[Disabled] 
      FROM tlkpGENDER WHERE ISNULL(Disabled, 0) = 0
    SELECT [SignificantOtherStatusCode],[SignificantOtherStatusDesc],[Disabled], [ActionBy], [DateAction]
      FROM tlkpSignificantOtherStatus WHERE ISNULL(Disabled, 0) = 0
    SELECT [CaseClosureReasonCode],[CaseClosureReasonDescLong],[CaseClosureReasonDescShort],[Disabled] 
      FROM tlkpCaseClosureReason WHERE ISNULL(Disabled, 0) = 0
    SELECT [CaseReferralSourceCode],[CaseReferralSourceDesc],[Disabled] FROM tlkpCaseReferralSource WHERE ISNULL(Disabled, 0) = 0
    SELECT [ParoleMentalHealthLevelOfServiceID],[ParoleMentalHealthLevelOfServiceDescLong],[ParoleMentalHealthLevelOfServiceDescShort],[Disabled]
      FROM tlkpParoleMentalHealthLevelOfService WHERE ISNULL(Disabled, 0) = 0 AND ParoleMentalHealthLevelOfServiceID < 6
 END
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeProfile] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeProfile] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetEpisodeProfile
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeReEntryIMHS]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeReEntryIMHS]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeReEntryIMHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetEpisodeReEntryIMHS]
    @EpisodeID int = 0,
	@CaseReEntryIMHSID int = 0
AS	
BEGIN
   DECLARE @True bit = 1;
   DECLARE @False bit =0;
   DECLARE @CLEID int
   DECLARE @LReentryID  int
   DECLARE @MhStatus int
   DECLARE @IsLastReentrySet bit = 0;

   IF  @EpisodeID > 0 
   BEGIN
       SELECT @LReentryID = ISNULl(ReEntryIMHSID, 0), @CLEID = ISNULl(ClientEpisodeID, 0)
	                                 FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID

	  IF @LReentryID = @CaseReEntryIMHSID OR @CaseReEntryIMHSID = 0
		     SET @IsLastReentrySet = 1

	  IF @CaseReEntryIMHSID > 0 
	        SET @LReentryID = @CaseReEntryIMHSID

      SET @MhStatus = (SELECT ISNULL(ParoleMentalHealthLevelOfServiceID, 0) FROM ClientEpisode WHERE ClientEpisodeID = @CLEID)

	   --DECLARE @EpisodeID  int = 583682 
	     SELECT  ISNULL(t2.Id, 0) AS CaseReEntryID, Observasion,
		 (CASE WHEN CommunicationBarrier IS NOT NULL AND CommunicationBarrier = 1 THEN @True ELSE @False END)CommunicationBarrierYes,
		 (CASE WHEN CommunicationBarrier IS NOT NULL AND CommunicationBarrier = 0 THEN @True ELSE @False END)CommunicationBarrierNo, CommunicationBarrierNote,
		 (CASE WHEN BadNewsWorriesStress IS NOT NULL AND BadNewsWorriesStress = 1 THEN @True ELSE @False END)BadNewsWorriesStressYes,
		 (CASE WHEN BadNewsWorriesStress IS NOT NULL AND BadNewsWorriesStress = 0 THEN @True ELSE @False END)BadNewsWorriesStressNo, BadNewsWorriesStressNote,
		 (CASE WHEN HearingVoice IS NOT NULL AND HearingVoice= 1 THEN @True ELSE @False END)HearingVoiceYes,
		 (CASE WHEN HearingVoice IS NOT NULL AND HearingVoice= 0 THEN @True ELSE @False END)HearingVoiceNo, HearingVoice_Note, 
		 (CASE WHEN SeeingThingsNotThere IS NOT NULL AND SeeingThingsNotThere = 1 THEN @True ELSE @False END)SeeingThingsNotThereYes,
		 (CASE WHEN SeeingThingsNotThere IS NOT NULL AND SeeingThingsNotThere = 0 THEN @True ELSE @False END)SeeingThingsNotThereNo, SeeingThingsNotThereNote,   	
		 (CASE WHEN TakingPsychotropicMed IS NOT NULL AND TakingPsychotropicMed = 1 THEN @True ELSE @False END)TakingPsychotropicMedYes,
		 (CASE WHEN TakingPsychotropicMed IS NOT NULL AND TakingPsychotropicMed = 0 THEN @True ELSE @False END)TakingPsychotropicMedNo,TakingPsychotropicMedNote,
		 (CASE WHEN DoSupplyMed IS NOT NULL AND DoSupplyMed = 1 THEN @True ELSE @False END)DoSupplyMedYes, 
		 (CASE WHEN DoSupplyMed IS NOT NULL AND DoSupplyMed = 0 THEN @True ELSE @False END)DoSupplyMedNo, MedicationNumber, LastTimeMedTakenDate, 
		 (CASE WHEN BridgeMedsRequested IS NOT NULL AND BridgeMedsRequested = 1 THEN @True ELSE @False END)BridgeMedsRequestedYes, 
		 (CASE WHEN BridgeMedsRequested IS NOT NULL AND BridgeMedsRequested = 0 THEN @True ELSE @False END)BridgeMedsRequestedNo,		
		 (CASE WHEN ThoughtsHurtingOrCommittimgSuicide IS NOT NULL AND ThoughtsHurtingOrCommittimgSuicide = 1 THEN @True ELSE @False END)ThoughtsHurtingOrCommittimgSuicideYes,
		 (CASE WHEN ThoughtsHurtingOrCommittimgSuicide IS NOT NULL AND ThoughtsHurtingOrCommittimgSuicide = 0 THEN @True ELSE @False END)ThoughtsHurtingOrCommittimgSuicideNo,ThoughtsHurtingOrCommittimgSuicide_Note,
		 (CASE WHEN ThoughtsHurtingSomeElse IS NOT NULL AND ThoughtsHurtingSomeElse = 1 THEN @True ELSE @False END)ThoughtsHurtingSomeElseYes,
		 (CASE WHEN ThoughtsHurtingSomeElse IS NOT NULL AND ThoughtsHurtingSomeElse = 0 THEN @True ELSE @False END) ThoughtsHurtingSomeElseNo,ThoughtsHurtingSomeElse_Note,
		 ThoughtsHurtingWho,
		 (CASE WHEN TakeMedicationForMedicalIssues IS NOT NULL AND TakeMedicationForMedicalIssues = 1 THEN @True ELSE @False END)TakeMedicationForMedicalIssuesYes,				 
		(CASE WHEN TakeMedicationForMedicalIssues IS NOT NULL AND TakeMedicationForMedicalIssues = 0 THEN @True ELSE @False END)TakeMedicationForMedicalIssuesNo,TakeMedicationForMedicalIssues_Note,
		(CASE WHEN FollowupAppointment IS NOT NULL AND FollowupAppointment = 1 THEN @True ELSE @False END)FollowupAppointmentYes,
		(CASE WHEN FollowupAppointment IS NOT NULL AND FollowupAppointment = 0 THEN @True ELSE @False END)FollowupAppointmentNo,FollowupAppointmentNote,
		(CASE WHEN AllergiesToMedication IS NOT NULL AND AllergiesToMedication = 1 THEN @True ELSE @False END)AllergiesToMedicationYes,
		(CASE WHEN AllergiesToMedication IS NOT NULL AND AllergiesToMedication = 0 THEN @True ELSE @False END)AllergiesToMedicationNo,AllergiesToMedicationNote,
		(CASE WHEN DrugOrAlcoholProblem IS NOT NULL AND DrugOrAlcoholProblem = 1 THEN @True ELSE @False END)DrugOrAlcoholProblemYes,
		(CASE WHEN DrugOrAlcoholProblem IS NOT NULL AND DrugOrAlcoholProblem = 0 THEN @True ELSE @False END)DrugOrAlcoholProblemNo,DrugOrAlcoholProblemNote, AcuteRemandedTo, UrgentNextAppointmentNote,IntermediateNextAppointmentNote,RoutineNextAppointmentNote,
		(CASE WHEN MHChronoCompleted IS NOT NULL AND MHChronoCompleted = 1 THEN @True ELSE @False END)MHChronoCompletedYes,     
		(CASE WHEN MHChronoCompleted IS NOT NULL AND MHChronoCompleted = 0 THEN @True ELSE @False END)MHChronoCompletedNo,
		(CASE WHEN NewLevelCare IS NOT NULL AND NewLevelCare= 2 THEN @True ELSE @False END)NewLevelCareEOP,								
		(CASE WHEN NewLevelCare IS NOT NULL AND NewLevelCare= 3 THEN @True ELSE @False END)NewLevelCareCCCMS,								
		(CASE WHEN NewLevelCare IS NOT NULL AND NewLevelCare= 4 THEN @True ELSE @False END)NewLevelCareMedNecessity, ScreeningNote,
		(CASE WHEN UrgentCurrentlyPreScribedMed IS NOT NULL AND UrgentCurrentlyPreScribedMed = 1 THEN @True ELSE @False END)UrgentCurrentlyPreScribedMedYes,
		(CASE WHEN UrgentCurrentlyPreScribedMed IS NOT NULL AND UrgentCurrentlyPreScribedMed = 0 THEN @True ELSE @False END)UrgentCurrentlyPreScribedMedNo,	
		(CASE WHEN UrgentHasMed IS NOT NULL AND UrgentHasMed = 1 THEN @True ELSE @False END)UrgentHasMedYes,
		(CASE WHEN UrgentHasMed IS NOT NULL AND UrgentHasMed = 0 THEN @True ELSE @False END)UrgentHasMedNo,	
		(CASE WHEN UrgentBridgeMedRequested IS NOT NULL AND  UrgentBridgeMedRequested = 1 THEN @True ELSE @False END)UrgentBridgeMedRequestedYes,
		(CASE WHEN UrgentBridgeMedRequested IS NOT NULL AND UrgentBridgeMedRequested = 0 THEN @True ELSE @False END)UrgentBridgeMedRequestedNo,
		(CASE WHEN InterMediateCurrentlyPreScribedMed IS NOT NULL AND InterMediateCurrentlyPreScribedMed = 1 THEN @True ELSE @False END)InterMediateCurrentlyPreScribedMedYes,	
		(CASE WHEN InterMediateCurrentlyPreScribedMed IS NOT NULL AND  InterMediateCurrentlyPreScribedMed = 0 THEN @True ELSE @False END)InterMediateCurrentlyPreScribedMedNo,
		(CASE WHEN InterMediateHasMed IS NOT NULL AND InterMediateHasMed = 1 THEN @True ELSE @False END)InterMediateHasMedYes,
		(CASE WHEN InterMediateHasMed IS NOT NULL AND InterMediateHasMed = 0 THEN @True ELSE @False END)InterMediateHasMedNo,
		(CASE WHEN InterMediateBridgeMedRequested IS NOT NULL AND InterMediateBridgeMedRequested = 1 THEN @True ELSE @False END)InterMediateBridgeMedRequestedYes,		
		(CASE WHEN InterMediateBridgeMedRequested IS NOT NULL AND InterMediateBridgeMedRequested = 0 THEN @True ELSE @False END)InterMediateBridgeMedRequestedNo,
		(CASE WHEN RoutineHasMed IS NOT NULL AND RoutineHasMed = 1 THEN @True ELSE @False END)RoutineHasMedYes,
		(CASE WHEN RoutineHasMed IS NOT NULL AND RoutineHasMed = 0 THEN @True ELSE @False END)RoutineHasMedNo,
		(CASE WHEN RoutineCurrentlyPreScribedMed IS NOT NULL AND RoutineCurrentlyPreScribedMed = 1 THEN  @True ELSE @False END)RoutineCurrentlyPreScribedMedYes,		
		(CASE WHEN RoutineCurrentlyPreScribedMed IS NOT NULL AND RoutineCurrentlyPreScribedMed = 0 THEN @True ELSE @False END)RoutineCurrentlyPreScribedMedNo,
		(CASE WHEN RoutineBridgeMedRequested IS NOT NULL AND RoutineBridgeMedRequested = 1 THEN @True ELSE @False END)RoutineBridgeMedRequestedYes,		
		(CASE WHEN RoutineBridgeMedRequested IS NOT NULL AND RoutineBridgeMedRequested = 0 THEN @True ELSE @False END)RoutineBridgeMedRequestedNo,	
		(CASE WHEN UnApptNecessary IS NOT NULL AND UnApptNecessary= 1 THEN @True else @False end)UnApptNecessary, 		 		 	 		  	
		(CASE WHEN MHStatue IS NOT NULL AND MHStatue = 1 THEN @True ELSE @False END)MHStatusWNL,
		(CASE WHEN MHStatue IS NOT NULL AND MHStatue = 2 THEN @True ELSE @False END)MHStatusABWNL, (CASE WHEN HistoryMHTreatment IS NOT NULL AND HistoryMHTreatment = 1 THEN @True ELSE @False END)HisMHTreatmentYes,
		(CASE WHEN HistoryMHTreatment IS NOT NULL AND HistoryMHTreatment = 0 THEN @True ELSE @False END)HisMHTreatmentNo,	
		(CASE WHEN @MhStatus= 2 THEN @True ELSE @False END)CurrentDESCEOP,
		(CASE WHEN @MhStatus= 3 THEN @True ELSE @False END)CurrentDESCCCCMS,
		(CASE WHEN @MhStatus= 1 THEN @True ELSE @False END)CurrentDESCNone,		  
		 (SELECT Name from DBO.fn_GetAsstUserName(ActionBy))ActionName, 		 
		t2.DateAction as CaseReEntryDate, @IsLastReentrySet AS IsLastReentrySet,		 	'' as PrintUrl			     
		FROM dbo.Episode t1 LEFT OUTER JOIN dbo.CaseReEntryIMHS t2 ON t1.EpisodeID  = t2.EpisodeID 			                 
		   WHERE (@LReentryID =0 AND t1.EpisodeID  = @EpisodeID) OR (t2.Id = @LReentryID)
   --END
 END
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeReEntryIMHS] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeReEntryIMHS] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetEpisodeSummary
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetEpisodeSummary]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeSummary]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeSummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-03-31
-- Update date: 
-- Description:	Retrive PMH Profile
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeSummary]
    @EpisodeID int = 0
AS	
BEGIN
    DECLARE @True bit = 1
    DECLARE @False bit =0
	DECLARE @LastClientNoteID int
	DECLARE @LastCEpisodeID int
	DECLARE @LastAssignedID int 
	DECLARE @ClientNote NVARCHAR(500) = ''
	DECLARE @CNEntryDate NVARCHAR(10) = ''
	DECLARE @CountyRegion CHAR(1)
	DECLARE @IDTTID int
	DECLARE @ADAECID nvarchar(100)
	--DECLARE @EpisodeID int = 659013
	IF @EpisodeID  > 0
	BEGIN
	SELECT @LastCEpisodeID = ISNULL(ClientEpisodeID, 0), 
	       @LastClientNoteID = ISNULL(ClientNoteID, 0),
		   @LastAssignedID = ISNULL(StaffAssignmentID, 0),
		   @IDTTID = ISNULl(IDTTID, 0)
	  FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID
	  	
	Declare @val NVarchar(MAX);
  SELECT TOP 1 @ADAECID = ADAECIDs, @CNEntryDate = CONVERT(NVARCHAR(10), StartDate, 110) FROM Appointment t1 
                     INNER JOIN AppointmentTrace t2 on t1.AppointmentID =  t2.AppointmentID 
                     INNER JOIN appointmentwithClient t3 on t1.AppointmentID  = t3.AppointmentID  
   WHERE t1.ADAECIDs IS NOT NULL AND t1.StartDate >= DateAdd(year, -1, GetDate()) AND t1.ActionStatus <> 10 AND 
	         EpisodeID  = @EpisodeID 
     ORDER BY t1.StartDate DESC
 IF @ADAECID IS NOT NULL
 BEGIN
    select @val = COALESCE(@val + (char(13) + char(10)) + ADAECDescription, ADAECDescription) FROM [dbo].[tlkpADAOrEC] WHERE ID in
        (Select splitdata from [dbo].[fnSplitString](@ADAECID, ','))
	SET @ClientNote = @val
    --SET  @ClientNote,  @CNEntryDate	  
 END
    ELSE 
    BEGIN   
	IF @LastClientNoteID > 0
	   SELECT @ClientNote = NoteOrComments,  
	          @CNEntryDate = CONVERT(NVARCHAR(10), EntryDate, 110)
	     FROM dbo.ClientNote 
		WHERE EpisodeID = @EpisodeID AND ClientNoteID  =@LastClientNoteID
 END

	SET @CountyRegion = (SELECT Region From tlkpCounty WHERE CountyID  = (SELECT ReleaseCountyID FROM Episode WHERE EpisodeID  = @EpisodeID))
    
  SELECT (CASE WHEN LEN(@ClientNote) > 100 THEN SubString(@ClientNote, 1, 100) 
          ELSE @ClientNote END)ClientNote, @EpisodeID AS EpisodeID, 
	    (o.LastName + ', ' + o.FirstName + ' ' + ISNULl(o.MiddleName, ''))LastFirstMI,   
         ISNULl(o.SSN, '')SSN, e.CDCRNum as CDCRNumber,
	    (CASE o.GenderID WHEN 1 THEN 'Female' WHEN 2 THEN 'Male' WHEN 3 THEN 'Transgender' 
		 ELSE '' END)Gender, 
		 ISNULl(e.ParoleUnit, '')ParoleUnit,
		 (CASE WHEN  ISNULl(e.ParoleLocationID, 0) = 0 THEN 0 ELSE (SELECT ComplexID FROM dbo.tlkpLocation WHERE LocationID = ParoleLocationID ) END)SelectedLocationId,
        (CASE WHEN o.DOB IS NULL THEN '' 
		 ELSE CONVERT(NVARCHAR(3), DateDiff(month, o.DOB, GetDate())/12) END)CalculatedAge,
       (CASE WHEN o.DOB IS NULL THEN '' 
	    ELSE CONVERT(NVARCHAR(10), o.DOB, 110) END)DateOfBirth,
	    CONVERT(NVARCHAR(10), o.PID)SomsOffenderID,
       (CASE WHEN ISNULL(e.ReleaseCountyID, 0) = 0 THEN '' 
	    ELSE (SELECT [dbo].[fnGetCountyName](e.ReleaseCountyID)) END)CountyText,
       (CASE WHEN ISNULL(e.ParoleLocationID, 0) = 0 THEN '' 
	    ELSE (SELECT [dbo].[fnGetlocationDesc](e.ParoleLocationID)) END)OfficeLocationText,
	   Lifer, PC290,
       (CASE ISNULL(o.MHStatus, 0) WHEN 2 THEN 'EOP' WHEN 3 THEN 'CCCMS' ELSE '' END)MHSINST,
       (CASE ISNULL(c.ParoleMentalHealthLevelOfServiceID, 0) 
			WHEN 2 THEN 'EOP'   WHEN 7 THEN 'EOP' WHEN 3 THEN 'CCCMS' 
			WHEN 6 THEN 'CCCMS' WHEN 1 THEN 'Not Specified' 
			WHEN 4 THEN 'Medical Necessity' WHEN 5 THEN 'Removed' ELSE '' END)MHSPOC,
   ((CASE WHEN ISNULl(o.DDP, '') = '' THEN '' ELSE o.DDP + ',' END) + 
	(CASE WHEN ISNULl(o.DPPHearing, '') = '' THEN '' ELSE o.DPPHearing + ',' END) +
	(CASE WHEN ISNULl(o.DPPMobility, '') = '' THEN '' ELSE o.DPPMobility + ',' END) +
	(CASE WHEN ISNULl(o.DPPSpeech, '') = '' THEN '' ELSE o.DPPSpeech + ',' END) +
	(CASE WHEN ISNULl(o.DPPVision, '') = '' THEN '' ELSE o.DPPVision + ',' END))Disabilities, 
    (CASE WHEN c.ParoleDischargeDate IS NULL THEN '' 
	 ELSE CONVERT(NVARCHAR(10), c.ParoleDischargeDate, 110) END )ParoleDischargeDate,
	(CASE WHEN e.ReleaseDate IS NULL THEN '' 
	 ELSE CONVERT(NVARCHAR(10), e.ReleaseDate, 110) END )ReleaseDate,
    (CASE @CountyRegion WHEN 'S' THEN 'Southern' WHEN 'N' THEN 'Northern' ELSE '' END)Region,
    (CASE ISNULL(c.EthnicityID, 0) WHEN 0 THEN '' 
	 ELSE (SELECT [dbo].[fnGetEthnicityDesc](c.EthnicityID)) END)EthnicityText,
	 @CNEntryDate AS CNEntryDate,
    (CASE WHEN c.CaseClosureDate IS NULL AND c.CaseBankedDate IS NULL THEN 'Active' 
		  WHEN c.CaseClosureDate IS NOT NULL AND c.CaseBankedDate IS NULL THEN 'Closed'
		  WHEN c.CaseBankedDate IS NOT NULL AND c.CaseClosureDate IS NULL THEN 'Banked' 
	  ELSE '' END)ParoleStatus,
    (CASE WHEN c.IntakeDate IS NULL THEN ''  
	 ELSE CONVERT(NVARCHAR(10), c.IntakeDate, 110) END)CaseIntakeDate,
    (CASE WHEN c.CaseClosureDate IS NULL THEN '' 
	 ELSE CONVERT(NVARCHAR(10), c.CaseClosureDate, 110) END)CaseClosureDate,
    (CASE WHEN c.CaseBankedDate IS NULL THEN '' 
	 ELSE CONVERT(NVARCHAR(10), c.CaseBankedDate, 110) END)CaseBankedDate, 
    (CASE WHEN c.ISMIPEnrolledDate IS NOT NULL AND c.ISMIPClosedDate IS NULL THEN @True 
	 ELSE @False END)ISMIPEnrolled,
    (CASE WHEN c.MATProgramStartDate IS NOT NULL AND c.MATProgramClosedDate IS NULL THEN @True
	 ELSE @False END)MATEnrolled,
    (CASE WHEN c.CMProgramStartDate IS NOT NULL AND CMProgramClosedDate IS NULL THEN @True
	 ELSE @False END)CMEnrolled,
    (CASE WHEN c.CMRPEStartDate IS NOT NULL AND CMRPEClosedDate IS NULL THEN @True 
	 ELSE @False END)CMRPEEnrolled,
    (CASE WHEN c.ASAMDate IS NOT NULL THEN @True ELSE @False END)Asam,
	ISNULl(e.ParoleAgent, '')ParoleAgent,
	(CASE WHEN @IDTTID > 0 THEN @True ELSE @False END)HasIDTT
   FROM dbo.Episode e INNER JOIN Offender o ON e.OffenderID = o.OffenderID 
        LEFT OUTER JOIN  
	   (SELECT EpisodeID, EthnicityID,IntakeDate, CaseBankedDate,CaseClosureDate, 
	           ISMIPEnrolledDate,ISMIPClosedDate, ParoleDischargeDate, 
			   ParoleMentalHealthLevelOfServiceID,
			   MATProgramStartDate,MATProgramClosedDate,
			   CMProgramStartDate,CMProgramClosedDate, 
			   CMRPEStartDate,CMRPEClosedDate, ASAMDate
	      FROM dbo.ClientEpisode 
		 WHERE ClientEpisodeID = @LastCEpisodeID) c
		 ON e.EpisodeID  = c.EpisodeID
  WHERE e.EpisodeID  = @EpisodeID AND e.EpisodeID  = @EpisodeID

  SELECT ID, CONVERT(NVARCHAR(10), DateAction, 110)DateEnrolled,
    --(Select Name FROM dbo.fn_GetAsstUserName(ISNULL(CaseManagerUserId, 0)))CaseManager,
    (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(SocialWorkerUserId, 0)))SocialWorker,         (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(PsychologistUserId, 0)))Psychologist,
	(Select Name FROM dbo.fn_GetAsstUserName(ISNULL(PsychiatristUserId, 0)))Psychiatrist
   FROM StaffAssignment WHERE EpisodeID  = @EpisodeID AND ID  = @LastAssignedID
	END
	ELSE
	BEGIN
	  SELECT ''ClientNote, 0 AS EpisodeID, ''LastFirstMI,''SSN, ''CDCRNumber,
             ''Gender,''ParoleUnit,0 AS SelectedLocationId,''CalculatedAge,''DateOfBirth,''SomsOffenderID,
             ''CountyText,''OfficeLocationText,@False AS Lifer,@False AS PC290,
             ''MHSINST,''MHSPOC,''Disabilities,''ParoleDischargeDate,''ReleaseDate,
             ''Region,''EthnicityText,''CNEntryDate,''ParoleStatus,''CaseIntakeDate,
             ''CaseClosureDate,''CaseBankedDate,@False AS ISMIPEnrolled,
             @False AS MATEnrolled,@False AS CMEnrolled, @False AS CMRPEEnrolled,
             @False AS Asam,''ParoleAgent,@False AS HasIDTT

	  SELECT 0 AS ID, ''DateEnrolled,''SocialWorker,''Psychologist,
	         ''Psychiatrist
	END 
END
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeSummary] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeSummary] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetOffenderEpisodes
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetOffenderEpisodes]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetOffenderEpisodes]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetOffenderEpisodes]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetOffenderEpisodes]
    @EpisodeID int
AS	
BEGIN
--DECLARE @EpisodeID int = 587645
DECLARE @OffenderID int =(SELECT OffenderID FROM Episode WHERE EpisodeID = @EpisodeID )
DECLARE @MaxEpisodeID int = (SELECT MAX(EpisodeID) FROM Episode WHERE OffenderID  = @OffenderID)

SELECT CONVERT(VARCHAR(10),e.EpisodeID) as Value, 
       ((RIGHT(SPACE(7) + (CASE WHEN ISNULL(e.ReleaseDate, e.SuggestionDate) IS NULL THEN 'NA' ELSE 
	     CONVERT(VARCHAR(7),(DateDiff(day, GetDate(), ISNULL(e.ReleaseDate, e.SuggestionDate)))) END), 7))
        + ' - ' +
	   (CASE WHEN ISNULL(ReleaseDate, SuggestionDate) IS NULL THEN '' ELSE
	              FORMAT(ISNULL(ReleaseDate, SuggestionDate), 'MM/dd/yyyy') END) + ' - ' + e.CDCRNum
				  + (CASE WHEN el.CaseClosureDate IS NOT NULL THEN ' - Closed' ELSE '' END) +
	   CASE WHEN e.EpisodeID = @MaxEpisodeID THEN '*' ELSE '' END) AS Text  
  FROM Episode e LEFT OUTER JOIN 
      (SELECT a.EpisodeID, CaseClosureDate FROM ClientEpisode a INNER JOIN EpisodeTrace b ON a.ClientEpisodeID = b.ClientEpisodeID) el on e.EpisodeID = el.EpisodeID
 WHERE OffenderID = @OffenderID Order BY e.EpisodeID DESC
END
GO
GRANT EXECUTE ON [dbo].[spGetOffenderEpisodes] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetOffenderEpisodes] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetStaffAssignmentList
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetStaffAssignmentList]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetStaffAssignmentList]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetStaffAssignmentList]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetStaffAssignmentList]
    @EpisodeId int = 0,
	@LocationId int = 0,
	@StaffID int = 0
AS
BEGIN
   IF @EpisodeID > 0
	BEGIN
	  --DECLARE  @EpisodeId int = 16871
	SELECT e.EpisodeID,e.CDCRNum, e.ParoleLocationID, ISNULL(c.LocationDesc, '') as LocationDesc, ISNULl(c.ComplexID, 0),
		    ISNULl(c.ComplexDesc, 'Unknown'), (SELECT Name From dbo.fn_GetClientName(e.EpisodeID))ClientName, s.ID, 
			e.ParoleAgent As ParoleAgentName,s.SocialWorkerUserId, s.PsychiatristUserId, s.PsychologistUserId,
			 (stuff((
 SELECT ',{ "PATSUserId": "' + Convert(varchar(10),ISNULL(s.SocialWorkerUserId, 0)) 
  + '","PATSUserName": "' + (CASE WHEN ISNULL(s.SocialWorkerUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.SocialWorkerUserId, 0))) END)
  + '","CaseWorkerTypeId": "'+ convert(varchar(3), 5)
  + '"}' FOR XML PATH('')),1,1,''))SocialWorker,
   (stuff((
 SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.PsychiatristUserId, 0)) 
  + '","PATSUserName": "' + (CASE WHEN ISNULL(s.PsychiatristUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.PsychiatristUserId, 0))) END)
  + '","CaseWorkerTypeId": "'+ convert(varchar(3), 3)
  + '"}' FOR XML PATH('')),1,1,''))Psychiatrist,
   (stuff((
 SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.PsychologistUserId, 0)) 
  + '","PATSUserName": "' + (CASE WHEN ISNULL(s.PsychologistUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.PsychologistUserId, 0))) END)
  + '","CaseWorkerTypeId": "'+ convert(varchar(3), 4)
  + '"}' FOR XML PATH('')),1,1,''))Psychologist,
 -- (stuff((
 --SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.CaseManagerUserId, 0)) 
 -- + '","PATSUserName": "' + (CASE WHEN ISNULL(s.CaseManagerUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.CaseManagerUserId, 0))) END)
 -- + '","CaseWorkerTypeId": "'+ convert(varchar(3), 2)
 -- + '"}' FOR XML PATH('')),1,1,''))CaseManager,
			(CASE WHEN ISNULL(O.MhStatus, 0) = 0 THEN 
				    (CASE WHEN ISNULL(l.ParoleMentalHealthLevelOfServiceID ,0) = 0 THEN '' WHEN l.ParoleMentalHealthLevelOfServiceID = 2 THEN 'EOP' WHEN l.ParoleMentalHealthLevelOfServiceID = 3 THEN 'CCCMS' ELSE '' END) 
				    WHEN O.MhStatus = 2 THEN 'EOP'  
					WHEN O.MhStatus = 3 THEN 'CCCMS' 
					ELSE '' END ) as MHStatus,  
			(CASE WHEN ISNULL(l.CaseClosureDate, '') <> '' THEN 'CLOSED' 
					WHEN ISNULL(l.CaseBankedDate, '') <> '' THEN 'BANKED' 
					ELSE 'ACTIVE' END) AS CaseStatus 
		FROM
		Episode e 
   INNER JOIN (SELECT EpisodeID, ClientEpisodeID, StaffAssignmentID FROM EpisodeTrace WHERE IsLastOne =1 )t ON e.EpisodeID = t.EpisodeID 
   LEFT OUTER JOIN dbo.StaffAssignment s ON e.EpisodeID = s.EpisodeID AND t.StaffAssignmentID = s.ID
   LEFT OUTER JOIN [dbo].[ClientEpisode] l ON e.EpisodeID = e.EpisodeID AND l.ClientEpisodeID =  t.ClientEpisodeID
   INNER JOIN Offender o on e.OffenderID = o.OffenderID	
   LEFT OUTER JOIN dbo.tlkpLocation c on c.LocationID = ISNULL(e.ParoleLocationID,0)  
  WHERE e.EpisodeID = @EpisodeID
	END
   ELSE IF @LocationId > 0
    BEGIN
    DECLARE @IntakeDate DateTime = DateAdd(YEAR, -5, GetDate())

  SELECT e.EpisodeID, e.CDCRNum, e.ParoleLocationID, ISNULL(c.LocationDesc, '') as LocationDesc, c.ComplexID, 
       c.ComplexDesc, l.IntakeDate, (SELECT Name From dbo.fn_GetClientName(e.EpisodeID))ClientName, ISNULL(s.ID, -1) AS Id, 
	   s.SocialWorkerUserId, s.PsychiatristUserId, s.PsychologistUserId, 
	  (stuff((
 SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.SocialWorkerUserId, 0)) 
  + '","PATSUserName": "' + (CASE WHEN ISNULL(s.SocialWorkerUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.SocialWorkerUserId, 0))) END)
  + '","CaseWorkerTypeId": "'+ convert(varchar(3), 5)
  + '"}' FOR XML PATH('')),1,1,''))SocialWorker,
   (stuff((
 SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.PsychiatristUserId, 0)) 
  + '","PATSUserName": "' + (CASE WHEN ISNULL(s.PsychiatristUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.PsychiatristUserId, 0))) END)
  + '","CaseWorkerTypeId": "'+ convert(varchar(3), 3)
  + '"}' FOR XML PATH('')),1,1,''))Psychiatrist,
   (stuff((
 SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.PsychologistUserId, 0)) 
  + '","PATSUserName": "' + (CASE WHEN ISNULL(s.PsychologistUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.PsychologistUserId, 0))) END)
  + '","CaseWorkerTypeId": "'+ convert(varchar(3), 4)
  + '"}' FOR XML PATH('')),1,1,''))Psychologist,
 -- (stuff((
 --SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.CaseManagerUserId, 0)) 
 -- + '","PATSUserName": "' + (CASE WHEN ISNULL(s.CaseManagerUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.CaseManagerUserId, 0))) END)
 -- + '","CaseWorkerTypeId": "'+ convert(varchar(3), 2)
 -- + '"}' FOR XML PATH('')),1,1,''))CaseManager,
	   (CASE WHEN ISNULl(l.ParoleMentalHealthLevelOfServiceID, 0) = 0 THEN 
			   (CASE WHEN ISNULL(O.MhStatus, 0)= 2 THEN 'EOP' 
					 WHEN ISNULL(O.MhStatus, 0)= 3 THEN 'CCCMS'
					 ELSE '' END) ELSE 
		   (CASE WHEN ISNULL(l.ParoleMentalHealthLevelOfServiceID, 0)= 2 THEN 'EOP' 
		         WHEN ISNULL(l.ParoleMentalHealthLevelOfServiceID, 0)= 3 THEN 'CCCMS'
				 ELSE '' END) END )MHStatus, 		
		  (CASE WHEN l.CaseClosureDate IS NOT NULL AND l.CaseBankedDate IS NULL THEN 'CLOSED' 
				WHEN l.CaseBankedDate IS NOT NULL  AND l.CaseClosureDate IS NULL THEN 'BANKED' 
				WHEN l.CaseBankedDate IS NULL AND l.CaseClosureDate IS NULL THEN 'ACTIVE'
				ELSE '' END) AS CaseStatus,l.IntakeDate
	   FROM Episode e 
   INNER JOIN (SELECT EpisodeID, ClientEpisodeID, StaffAssignmentID FROM EpisodeTrace WHERE IsLastOne =1 )t ON e.EpisodeID = t.EpisodeID 
   LEFT OUTER JOIN dbo.StaffAssignment s ON e.EpisodeID = s.EpisodeID AND t.StaffAssignmentID = s.ID
   LEFT OUTER JOIN [dbo].[ClientEpisode] l ON e.EpisodeID = l.EpisodeID AND l.ClientEpisodeID =  t.ClientEpisodeID
   INNER JOIN Offender o on e.OffenderID = o.OffenderID	
   LEFT OUTER JOIN (SELECT LocationID, LocationDesc, ComplexID, ComplexDesc FROM dbo.tlkpLocation WHERE ComplexID = @LocationID) c on c.LocationID = ISNULL(e.ParoleLocationID,0)  
  WHERE (e.ParoleLocationID is null OR e.ParoleLocationID = c.LocationId) AND l.IntakeDate >= @IntakeDate ORDER BY e.CDCRNum
	END
	ELSE IF @StaffID > 0
	 BEGIN
	   --==============================================================================
	  --DECLARE @StaffID int = 67
      --  DECLARE @StaffID int = 597
 DECLARE @caseWorkerTypeID int = (SELECT CaseWorkerTypeId FROM dbo.[User] Where UserID =@StaffID)
SELECT s.EpisodeID, e.CDCRNUm,e.ParoleLocationID, ISNULL(c.LocationDesc, '') as LocationDesc, ISNULl(c.ComplexID, 0)ComplexID, 
	         ISNULl(c.ComplexDesc, '')ComplexDesc, (SELECT Name From dbo.fn_GetClientName(e.EpisodeID))ClientName, s.ID, 
			 ISNULL(s.SocialWorkerUserId, 0)SocialWorkerUserId, ISNULL(s.PsychiatristUserId, 0)PsychiatristUserId, 
			 ISNULL(s.PsychologistUserId, 0)PsychologistUserId,
			 (stuff((
 SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.SocialWorkerUserId, 0)) 
  + '","PATSUserName": "' + (CASE WHEN ISNULL(s.SocialWorkerUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.SocialWorkerUserId, 0))) END)
  + '","CaseWorkerTypeId": "'+ convert(varchar(3), 5)
  + '"}' FOR XML PATH('')),1,1,''))SocialWorker,
   (stuff((
 SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.PsychiatristUserId, 0)) 
  + '","PATSUserName": "' + (CASE WHEN ISNULL(s.PsychiatristUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.PsychiatristUserId, 0))) END)
  + '","CaseWorkerTypeId": "'+ convert(varchar(3), 3)
  + '"}' FOR XML PATH('')),1,1,''))Psychiatrist,
   (stuff((
 SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.PsychologistUserId, 0)) 
  + '","PATSUserName": "' + (CASE WHEN ISNULL(s.PsychologistUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.PsychologistUserId, 0))) END)
  + '","CaseWorkerTypeId": "'+ convert(varchar(3), 4)
  + '"}' FOR XML PATH('')),1,1,''))Psychologist,
 -- (stuff((
 --SELECT ',{ "PATSUserId": "' + Convert(varchar(10), ISNULL(s.CaseManagerUserId, 0)) 
 -- + '","PATSUserName": "' + (CASE WHEN ISNULL(s.CaseManagerUserId, 0)= 0 THEN '' ELSE (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(s.CaseManagerUserId, 0))) END)
 -- + '","CaseWorkerTypeId": "'+ convert(varchar(3), 2)
 -- + '"}' FOR XML PATH('')),1,1,''))CaseManager,
			 e.ParoleAgent AS ParoleAgentName, s.DateAction, s.ActionStatus, s.ActionBy, 
			 l.CaseBankedDate,
			 (CASE WHEN ISNULL(l.ParoleMentalHealthLevelOfServiceID, 0) = 2 THEN 'EOP'
				   WHEN ISNULL(l.ParoleMentalHealthLevelOfServiceID, 0) = 3 THEN 'CCCMS'
				   ELSE
						(CASE WHEN ISNULL(O.MhStatus, 0) = 2 THEN 'EOP' 
							  WHEN ISNULL(O.MhStatus, 0) = 3 THEN 'CCCMS'
							  ELSE '' END) 
				   END)MHStatus, 
			(CASE WHEN l.CaseClosureDate IS NULL AND l.CaseBankedDate IS NULL THEN 'ACTIVE'
			      WHEN l.CaseClosureDate IS NOT NULL AND l.CaseBankedDate IS NULL THEN 'CLOSED'
				  WHEN l.CaseClosureDate IS NULL AND l.CaseBankedDate IS NOT NULL THEN 'BANKED'
				  ELSE '' END)CaseStatus  
	FROM Episode e 
   INNER JOIN (SELECT EpisodeID, ClientEpisodeID, StaffAssignmentID FROM EpisodeTrace WHERE IsLastOne =1 )t ON e.EpisodeID = t.EpisodeID 
   INNER JOIN dbo.StaffAssignment s ON e.EpisodeID = s.EpisodeID AND t.StaffAssignmentID = s.ID
   LEFT OUTER JOIN [dbo].[ClientEpisode] l ON e.EpisodeID = e.EpisodeID AND l.ClientEpisodeID =  t.ClientEpisodeID
   INNER JOIN Offender o on e.OffenderID = o.OffenderID	
   LEFT OUTER JOIN dbo.tlkpLocation c on c.LocationID = ISNULL(e.ParoleLocationID,0)  
  WHERE ((@caseWorkerTypeID = 3  AND s.PsychiatristUserId = @StaffID) OR
		(@caseWorkerTypeID = 4  AND  s.PsychologistUserId = @StaffID) OR
		(@caseWorkerTypeID = 5  AND  s.SocialWorkerUserId = @StaffID)) ORDER BY e.CDCRNum
  
      END
END
GO
GRANT EXECUTE ON [dbo].[spGetStaffAssignmentList] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetStaffAssignmentList] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetUser
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetUser]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetUser]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetUser]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetUser]
	@UserID int
AS
BEGIN
	SET NOCOUNT ON;

    SELECT * FROM [User] WHERE UserID = @UserID
END
GO
GRANT EXECUTE ON [dbo].[spGetUser] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetUser] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetUserByUsername
--============================================================================
/****** Object:  StoredProcedure [dbo].[spGetUserByUsername]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetUserByUsername]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetUserByUsername]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetUserByUsername]
	-- Add the parameters for the stored procedure here
	@Username nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [User] WHERE Username = @Username
END
GO
GRANT EXECUTE ON [dbo].[spGetUserByUsername] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetUserByUsername] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptClientEpisodeProfileSummary
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptClientEpisodeProfileSummary]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptClientEpisodeProfileSummary]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptClientEpisodeProfileSummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptClientEpisodeProfileSummary] 
	-- Add the parameters for the stored procedure here
	@EpisodeID int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 SELECT t2.EpisodeID , (Select name from fn_GetClientName(t2.EpisodeID)) ClientName
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
GRANT EXECUTE ON [dbo].[spRptClientEpisodeProfileSummary] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptClientEpisodeProfileSummary] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptClientInactive
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptClientInactive]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptClientInactive]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptClientInactive]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2020-01-15
-- Description:	Retrive appointment
-- =============================================
CREATE PROCEDURE [dbo].[spRptClientInactive] 
	@DaysInactive smallint = 30,
	@CaseWorkerIds nvarchar(200)='',
	@StartDate datetime = Null
AS
BEGIN
	SET NOCOUNT ON;

    IF @CaseWorkerIds IS NUll
	  SET @CaseWorkerIds = ''

--DECLARE @StartDate DateTime ='2019-10-01'
--Declare @StaffIDs nvarchar(100) = '608'
--=======================================
  --get all assigned parolee
--========================================
DECLARE @EpisodeTB TABLE(
	   EpisodeID int PRIMARY KEY, 
	   CDCRNum varchar(6), 
	   Location nvarchar(100),
	   ClientName nvarchar(120), 
	   StaffInfo nvarchar(200), 
	   MH_Status nvarchar(5),
	   LStartDate DateTime NULL,
	   HStartDate DateTime NULL,
	   ComplexDesc nvarchar(100),
	   LastAppointment nvarchar(300), 
	   NextAppointment nvarchar(300)
	) 
    INSERT INTO @EpisodeTB
	SELECT e.EpisodeID, e.CDCRNUm, (CASE WHEN ISNULL(e.ParoleLocationID, 0) = 0 THEN '' 
	                                      ELSE (SELECT ComplexDesc From tlkpLocation Where LocationID  =ParoleLocationID ) END)Location,
	       (o.LastName + ', ' + o.FirstName)ClientName, (CASE WHEN ISNULL(s.PsychiatristUserId, 0) = 0 THEN '' ELSE    
				   (SELECT 'Psychiatrist: ' + Name + CHAR(13) + CHAR(10) FROM dbo.fn_GetAsstUserName(ISNULL(s.PsychiatristUserId, 0))) END) + 
				(CASE WHEN ISNULL(s.PsychologistUserId, 0) = 0 THEN '' ELSE 
				   (SELECT 'Psychologist: ' + Name + CHAR(13) + CHAR(10) FROM dbo.fn_GetAsstUserName(ISNULL(s.PsychologistUserId, 0))) END) + 
				(CASE WHEN ISNULL(s.SocialWorkerUserId, 0) = 0 THEN '' ELSE
				   (SELECT 'Social Worker: ' +  Name + CHAR(13) + CHAR(10) FROM dbo.fn_GetAsstUserName(ISNULL(SocialWorkerUserId, 0))) END) StaffInfo, 
				 (CASE e2.ParoleMentalHealthLevelOfServiceID WHEN 2 THEN 'EOP' WHEN 3 THEN 'CCCMS' ELSE '' END)MH_Status, NULL AS LStartDate, NULL AS HStartDate, 
				    ''ComplexDesc, ''LastAppointment, ''NextAppointment from Episode e INNER JOIN EpisodeTrace e1 on e.EpisodeID  = e1.EpisodeID Inner JOIN Offender o on e.OffenderID  = o.OffenderID
INNER JOIN StaffAssignment  s on e.EpisodeID  = s.EpisodeID AND s.ID = e1.StaffAssignmentID
LEFT OUTER JOIN dbo.ClientEpisode e2 on e1.ClientEpisodeID = e2.ClientEpisodeID
 WHERE s.DateAction > DateAdd(year, -3, @StartDate) AND e2.CaseClosureDate IS NULL 
						       AND ((LEN(@CaseWorkerIds) = 0 AND e.EpisodeID  = e.EpisodeID) OR (LEN(@CaseWorkerIds)> 0 AND 
							  (s.SocialWorkerUserId in (SELECT * FROM [dbo].[fnSplitString](@CaseWorkerIds, ',')) OR 
							   s.PsychiatristUserId in (SELECT * FROM [dbo].[fnSplitString](@CaseWorkerIds, ',')) OR 
							   s.PsychologistUserId in (SELECT * FROM [dbo].[fnSplitString](@CaseWorkerIds, ',')))))
	--SELECT t1.EpisodeID, e.CDCRNUm, (CASE WHEN ISNULL(e.ParoleLocationID, 0) = 0 THEN '' 
	--                                      ELSE (SELECT ComplexDesc From tlkpLocation Where LocationID  =ParoleLocationID ) END)Location,
	--       (o.LastName + ', ' + o.FirstName)ClientName, (CASE WHEN ISNULL(t1.PsychiatristUserId, 0) = 0 THEN '' ELSE    
	--			   (SELECT 'Psychiatrist: ' + Name + CHAR(13) + CHAR(10) FROM dbo.fn_GetAsstUserName(ISNULL(t1.PsychiatristUserId, 0))) END) + 
	--			(CASE WHEN ISNULL(t1.PsychologistUserId, 0) = 0 THEN '' ELSE 
	--			   (SELECT 'Psychologist: ' + Name + CHAR(13) + CHAR(10) FROM dbo.fn_GetAsstUserName(ISNULL(t1.PsychologistUserId, 0))) END) + 
	--			(CASE WHEN ISNULL(t1.CaseManagerUserId, 0) = 0 THEN '' ELSE 
	--			   (SELECT 'Case Manager: ' + Name + CHAR(13) + CHAR(10) FROM dbo.fn_GetAsstUserName(ISNULL(t1.CaseManagerUserId, 0))) END) +
	--			(CASE WHEN ISNULL(t1.SocialWorkerUserId, 0) = 0 THEN '' ELSE
	--			   (SELECT 'Social Worker: ' +  Name + CHAR(13) + CHAR(10) FROM dbo.fn_GetAsstUserName(ISNULL(SocialWorkerUserId, 0))) END) StaffInfo, 
	--			 (CASE c.MI_Class WHEN 2 THEN 'EOP' WHEN 3 THEN 'CCCMS' ELSE '' END)MH_Status, NULL AS LStartDate, NULL AS HStartDate, 
	--			    ''ComplexDesc, ''LastAppointment, ''NextAppointment
	--				--FROM (SELECT s1.EpisodeID, SocialWorkerUserId, PsychiatristUserId, PsychologistUserId, CaseManagerUserId, s1.DateAction
	--				        FROM StaffAssignment s1 INNER JOIN EpisodeTrace s2 on s1.ID = s2.StaffAssignmentID
	--						INNER JOIN 
	--						--(SELECT e1.EpisodeID, OffenderID, CDCRNum, ParoleLocationID 
	--						   --FROM 
	--						 Episode s3 on s1.EpisodeID = s3.EpisodeID AND s2.EpisodeID = s3.EpisodeID --INNER JOIN dbo.vwEpisodeIDs e2 on e1.EpisodeID  = e2.EpisodeID) e on t1.EpisodeID  =  e.EpisodeID 
	--						INNER JOIN Offender o on s3.OffenderID  = o.OffenderID
	--					  LEFT OUTER JOIN 
	--					  (SELECT EpisodeID, CaseClosureDate, ParoleMentalHealthLevelOfServiceID as MI_Class, ParoleDischargedate
 --                            FROM dbo.ClientEpisode c1 INNER JOIN [dbo].[vwClientEpisodeIDs] c2 on c1.ClientEpisodeID  =  c2.ClientEpisodeID)c 
	--						   on t1.EpisodeID  = c.EpisodeID
	--					 WHERE t1.DateAction > DateAdd(year, -3, @StartDate) AND c.CaseClosureDate IS NULL 
	--					       AND ((LEN(@CaseWorkerIds) = 0 AND t1.EpisodeID  = t1.EpisodeID) OR (LEN(@CaseWorkerIds)> 0 AND 
	--						  (t1.SocialWorkerUserId in (SELECT * FROM [dbo].[fnSplitString](@CaseWorkerIds, ',')) OR 
	--						   t1.PsychiatristUserId in (SELECT * FROM [dbo].[fnSplitString](@CaseWorkerIds, ',')) OR 
	--						   t1.CaseManagerUserId in (SELECT * FROM [dbo].[fnSplitString](@CaseWorkerIds, ',')) OR
	--						   t1.PsychologistUserId in (SELECT * FROM [dbo].[fnSplitString](@CaseWorkerIds, ',')))))
  --==============================================================
    --get last and next appointmentIDs based on the assigned cases.
  --==============================================================
  DECLARE @EpisodeRpt TABLE(
	   EpisodeID int PRIMARY KEY, 
	   LAppointmentID int null,
	   HAppointmentID int null
	) 
 INSERT INTO @EpisodeRpt 
 SELECT EpisodeID, NULL AS LAppointmentID, NULL AS HAppointmentID FROM @EpisodeTB
 

 Update tgr Set LAppointmentID = scr.AppointmentID FROM @EpisodeRpt tgr INNER JOIN
 (SELECT b.EpisodeID, b.AppointmentID, ROW_NUMBER() OVER(PARTITION BY b.EpisodeID ORDER BY d.StartDate DESC) AS RankL 
      FROM (SELECT EpisodeID, AppointmentID FROM AppointmentWithClient WHERE EpisodeID  in (Select EpisodeID FROM @EpisodeTB)) b 
       INNER JOIN dbo.AppointmentTrace c ON b.AppointmentID  = c.AppointmentID INNER JOIN Appointment d on b.AppointmentID  = d.AppointmentID
	   WHERE d.ActionStatus <> 10 AND d.StatusID <> 6  AND DateDiff(Hour, StartDate, @StartDate ) > 0 )scr
	   --WHERE d.ActionStatus <> 10 AND d.StatusID <> 6  and d.TypeID <> 5 AND DateDiff(Hour, StartDate, @StartDate ) > 0
	   
        on tgr.EpisodeID  = scr.EpisodeID WHERE scr.RankL = 1

Update tgr Set HAppointmentID = scr.AppointmentID FROM @EpisodeRpt tgr INNER JOIN 
 (SELECT b.EpisodeID, b.AppointmentID, ROW_NUMBER() OVER(PARTITION BY b.EpisodeID ORDER BY d.StartDate ASC) AS RankH 
      FROM (SELECT EpisodeID, AppointmentID FROM AppointmentWithClient WHERE EpisodeID  in (Select EpisodeID FROM @EpisodeTB)) b 
	     INNER JOIN dbo.AppointmentTrace c ON b.AppointmentID  = c.AppointmentID INNER JOIN Appointment d on b.AppointmentID  = d.AppointmentID
		 WHERE d.ActionStatus <> 10 AND d.StatusID <> 6  AND DateDiff(Hour, StartDate, @StartDate ) < 0)scr
	  --WHERE d.ActionStatus <> 10 AND d.StatusID <> 6  and d.TypeID <> 5 AND DateDiff(Hour, StartDate, @StartDate ) < 0)scr
	  on tgr.EpisodeID  =  scr.EpisodeID Where scr.RankH = 1
	--=======================================================
	--Update @EpisodeTB Lowest StartDate and LastAppointment
	--=======================================================
	UPDATE tgr SET tgr.LStartDate = scr.StartDate, tgr.Location = (CASE WHEN tgr.Location = '' THEN scr.ComplexDesc ELSE tgr.Location END),
                   tgr.LastAppointment = scr.LastAppointment
      FROM @EpisodeTB tgr INNER JOIN 
       (SELECT a2.EpisodeID, a1.StartDate, a4.ComplexDesc,
            (CASE WHEN a1.StartDate IS NULL THEN '' ELSE 
			  (a3.EvtTShortDescr + char(13)+char(10) +
               (Convert(nvarchar(10), a1.StartDate, 101) + ' ' + 
               LTRIM(substring(Convert(nvarchar(30), a1.StartDate, 109),12, 5))) + 
              substring(Convert(nvarchar(30), a1.StartDate, 109),24, 4) + '-' + 
              LTRIM(substring(Convert(nvarchar(30),a1.EndDate, 109),12, 5)) +
              substring(Convert(nvarchar(30),a1.EndDate, 109),24, 4) + char(13)+char(10) + a4.ComplexDesc) END)LastAppointment 
		FROM Appointment a1 INNER JOIN @EpisodeRpt a2 on a1.appointmentID  = a2.LAppointmentID 
		                    INNER JOIN tlkpAppointmentType a3  on a1.TypeID = a3.ID 
			                INNER JOIN (SELECT DISTINCT ComplexID, ComplexDesc FROM tlkpLocation WHERE ComplexDesc <> 'NULL')a4 ON a1.ComplexID = a4.ComplexID)scr 
		ON tgr.EpisodeID  = scr.EpisodeID

	--=========================================================
	--Update @EpisodeTB Hightest StartDate and NextAppointment
	--=========================================================
	UPDATE tgr SET tgr.HStartDate = scr.StartDate, tgr.Location = (CASE WHEN tgr.Location = '' THEN scr.ComplexDesc ELSE tgr.Location END),
                   tgr.NextAppointment = scr.NextAppointment
     FROM @EpisodeTB tgr INNER JOIN 
       (SELECT a2.EpisodeID, a1.StartDate, a4.ComplexDesc,
           (CASE WHEN a1.StartDate IS NULL THEN '' ELSE
			  (a3.EvtTShortDescr + char(13)+char(10) +
               (Convert(nvarchar(10), a1.StartDate, 101) + ' ' + 
               LTRIM(substring(Convert(nvarchar(30), a1.StartDate, 109),12, 5))) + 
              substring(Convert(nvarchar(30), a1.StartDate, 109),24, 4) + '-' + 
              LTRIM(substring(Convert(nvarchar(30),a1.EndDate, 109),12, 5)) +
              substring(Convert(nvarchar(30),a1.EndDate, 109),24, 4) + char(13)+char(10) + a4.ComplexDesc) END)NextAppointment 
		  FROM Appointment a1 INNER JOIN @EpisodeRpt a2 on a1.appointmentID  = a2.HAppointmentID 
		                      INNER JOIN tlkpAppointmentType a3  on a1.TypeID = a3.ID 
			                  INNER JOIN (SELECT DISTINCT ComplexID, ComplexDesc FROM tlkpLocation WHERE ComplexDesc <> 'NULL')a4 ON a1.ComplexID = a4.ComplexID)scr 
		 ON tgr.EpisodeID  = scr.EpisodeID
	--=========================================================
	--get result
	--=========================================================
	SELECT CDCRNum, Location, ClientName, StaffInfo,MH_Status, LastAppointment, NextAppointment FROM @EpisodeTB
	WHERE 1=(CASE WHEN LStartDate IS NULL OR HStartDate IS NULL THEN 1
				  WHEN LStartDate IS NOT NULL AND HStartDate IS NOT NULL AND DateDiff(day, LStartDate, HStartDate)> @DaysInactive THEN 1 ELSE 0 END) 
END
GO
GRANT EXECUTE ON [dbo].[spRptClientInactive] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptClientInactive] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptClientPendingReleaseByLocation
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptClientPendingReleaseByLocation]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptClientPendingReleaseByLocation]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptClientPendingReleaseByLocation]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptClientPendingReleaseByLocation] 
	-- Add the parameters for the stored procedure here
	@Region nvarchar(6)='',
	@StartDate datetime = Null,
	@EndDate datetime = Null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON
		
	IF @StartDate IS NULL 
	   SET @StartDate = GetDate()
    IF @EndDate IS NULL
	   SET @EndDate=DATEADD(day, 60, @StartDate)

    -- Insert statements for procedure here
	SELECT t1.EpisodeID
		 ,t4.LastName
		 ,t4.FirstName
         ,t3.Name County
	     ,(CASE when ISNULL( t1.ParoleUnit, '')='' then (SELECT [dbo].[fnGetLocationDesc](ISNULL(t1.ParoleLocationID, 0))) else t1.ParoleUnit end)Location
         ,(CASE WHEN t3.Region='N' THEN 'Northern' WHEN t3.Region='S' THEN 'Southern' ELSE '' END) Region
         ,t1.ReleaseDate EPRD
		 ,t1.CDCRNum
         ,(SELECT [dbo].[fnGetMHStatusDesc](ISNULL(t2.ClientEpisodeID, 0), t1.EpisodeID))MH_Class         
FROM Episode t1 
INNER JOIN [Offender] t4 ON t1.OffenderID=t4.OffenderID  
LEFT OUTER JOIN 
  (SELECT ClientEpisodeID, EpisodeID FROM 
      (SELECT ClientEpisodeID, EpisodeID, 
         ParoleDischargeDate, ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY ClientEpisodeID DESC) AS nRowNum FROM ClientEpisode ) sub 
               WHERE sub.nRowNum = 1) t2 
   ON t2.EpisodeID  =  t1.EpisodeID
   LEFT OUTER JOIN dbo.tlkpCounty t3 on t3.CountyID = t1.ReleaseCountyID
  WHERE (ISNULL(t1.ReleaseDate, t1.SuggestionDate) >= @StartDate AND  t1.ReleaseDate<=@EndDate) AND t3.Region=@Region
  order by t1.ReleaseDate
END
GO
GRANT EXECUTE ON [dbo].[spRptClientPendingReleaseByLocation] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptClientPendingReleaseByLocation] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptInactiveBHRCaseload
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptInactiveBHRCaseload]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptInactiveBHRCaseload]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptInactiveBHRCaseload]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptInactiveBHRCaseload]
	@DaysInactive smallint = 60,
	@ExcludeWithPlannedAppointment bit = 1, 
	@CaseWorkerIds nvarchar(200)='',
	@StartDate datetime = Null
AS
BEGIN
	SET NOCOUNT ON
    
	DECLARE @ReturnValue int
	--DECLARE @CaseWorkerIds nvarchar(100)= '48,561'
	--DECLARE @DaysInactive int = -1 * 60
	--DECLARE @StartDate datetime = '2018-10-30'
	--DECLARE @ExcludeWithPlannedAppointment bit = 1

	SET @DaysInactive = -1 * @DaysInactive
	IF @StartDate IS NULL 
	   SET @StartDate = GetDate()
	SET @StartDate = DATEADD(day, @DaysInactive, @StartDate)


SELECT StaffID AS CaseWorkerID, (Select Name FROM [dbo].[fn_GetUserName](StaffID))CaseWorkerName, 
(SELECT [dbo].[fnGetLocationDesc](ISNULL(M.LocationId, 0)))Location, M.EpisodeID, M.CDCRNum, 
(SELECT Name FROM [dbo].[fn_GetClientName](EpisodeID)) Offender, 
(select [dbo].[fnGetMHStatusDesc](ISNULL(M.ClientEpisodeID, 0), M.EpisodeID)) MI_Class,M.PC290, 
MAX(LastAppointmentPresent)LastAppointmentPresent, 
MIN(LastAppointmentNotPresent)LastAppointmentNotPresent, 
MAX(LastAppointmentNoOutcome)LastAppointmentNoOutcome, 
SUM(TotalLastAppointmentNotPresent)TotalLastAppointmentNotPresent, 
MIN(NextPlannedAppointment)NextPlannedAppointment, 
SUM(TotalAppointmentNoOutcome)TotalAppointmentNoOutcome

FROM 
	(SELECT d.StaffID, b.ClientEpisodeID, d.EpisodeID, b.CDCRNum, b.MHStatus,b.PC290, d.StartDate,
		(CASE WHEN d.StatusID = 4 THEN d.StartDate ELSE NULL END)LastAppointmentPresent,  
		(CASE WHEN d.StatusID NOT IN (2, 4) THEN d.StartDate ELSE NULL END)LastAppointmentNotPresent, 
		(CASE WHEN d.StatusID NOT IN (2, 4) THEN 1 ELSE 0 END)TotalLastAppointmentNotPresent,
		(CASE WHEN d.StatusID = 2 THEN d.StartDate ELSE NULL END)LastAppointmentNoOutcome,
		(CASE WHEN d.StatusID = 2 THEN 1 ELSE 0 END)TotalAppointmentNoOutcome,
		(Select [dbo].fnGetCWNextApptDate(d.StaffID, d.EpisodeID, @StartDate))NextPlannedAppointment, d.LocationID
	FROM 
	(SELECT t1.StartDate, t2.EpisodeID, t1.StatusID, t1.AppointmentID, t1.locationID, t3.StaffID,
	ROW_NUMBER() OVER (PARTITION BY t1.AppointmentTraceID ORDER BY t1.AppointmentId DESC) AS RowNum  
	FROM Appointment t1 INNER JOIN AppointmentWithClient t2 on t1.AppointmentID  =  t2.AppointmentID 
	inner join AppointmentWithStaff t3 on t1.AppointmentID = t3.AppointmentID
	WHERE t1.StartDate >= DateAdd(year, -3, @StartDate) and t1.StartDate <= @StartDate  and 
	      DateDiff(day, t1.StartDate, @StartDate)>((-1) * @DaysInactive) AND
	      t3.StaffID in (SELECT splitdata FROM [dbo].[fnSplitString](@CaseWorkerIds, ',')) and
		  t1.ActionStatus <> 10) d
	 INNER JOIN 
	
	(SELECT e.EpisodeID, CDCRNum, PC290, MHStatus, ParoleMentalHealthLevelOfServiceID MI_Class, c.ClientEpisodeID FROM Episode e 
	        INNER JOIN Offender o on e.OffenderID  =  o.OffenderID 
			INNER JOIN EpisodeTrace r ON e.EpisodeID  = r.EpisodeID
			LEFT OUTER JOIN ClientEpisode c ON e.EpisodeID = c.EpisodeID AND  c.ClientEpisodeID = r.ClientEpisodeID
	  Where r.IsLastOne = 1 AND CaseClosureDate IS NULL AND CaseBankedDate IS NULL AND ISNULL(CDCRNum, '') <> '' ) b on d.EpisodeID = b.EpisodeID )M	
	--(SELECT EpisodeID, CDCRNum, PC290, MHStatus FROM EPISODE e INNER JOIN 
	--        Offender o on e.OffenderID  =  o.OffenderID) b on d.EpisodeID = b.EpisodeID 			
	-- LEFT OUTER JOIN 
	
	--(SELECT ClientEpisodeID, EpisodeID, ParoleMentalHealthLevelOfServiceID MI_Class FROM
	--(SELECT ClientEpisodeID, EpisodeID, ParoleMentalHealthLevelOfServiceID,
	--     ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY ClientEpisodeID DESC) AS nRowNum FROM ClientEpisode 
	--  WHERE CaseClosureDate IS NULL ) sub WHERE sub.nRowNum = 1) s 
	--on d.EpisodeID  =  s.EpisodeID ) M
	
WHERE (@ExcludeWithPlannedAppointment = 0 ) 
    OR (@ExcludeWithPlannedAppointment = 1 AND
	   (M.NextPlannedAppointment is NULL OR DateDiff(day, M.NextPlannedAppointment, @StartDate) > 0  ))
		    
GROUP BY LocationId, StaffID, M.EpisodeID, M.CDCRNum, M.MHStatus,M.PC290, ClientEpisodeID
END
GO
GRANT EXECUTE ON [dbo].[spRptInactiveBHRCaseload] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptInactiveBHRCaseload] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptClientPendingDischarge
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptClientPendingDischarge]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptClientPendingDischarge]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptClientPendingDischarge]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptClientPendingDischarge] 
    @StartDate DateTime,
	@EndDate DateTime,
	@caseWorkerTypeID int,
	@StaffIDs nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;
	--DECLARE @StartDate DateTime = '01-01-2017'
    --DECLARE @EndDate DateTime = '01-01-2021'
	--DECLARE @StaffID int  =597
	--DECLARE @StaffIDs nvarchar(100) = '597'
	--DECLARE @True bit = 1
	--DECLARE @False bit = 0
	
	IF @StartDate IS NULL 
	   SET @StartDate = GetDate()

	IF @EndDate IS NULL
      SET @EndDate = DATEADD(month, 12, @StartDate)

	DECLARE @User TABLE(
	  UserID int,
	  Name nvarchar(70),
	  CAseWorkerTypeID int,
	  CaseWorkerTypeDesc nvarchar(30)
	)
	INSERT INTO @User
	SELECT UserID, (LastName + ', ' + SUBSTRING(FirstName, 1, 2))Name, u.CaseWorkerTypeId, c.CaseWorkerTypeDesc 
	  FROM [User] u INNER JOIN tlkpCaseWorkerType c ON u.CaseWorkerTypeId = c.CaseWorkerTypeId
	 WHERE UserID in (SELECT * FROM [dbo].[fnSplitString](@StaffIDs, ','))

	 DECLARE @ETable TABLE(
	    EpisodeID int,
		CDCRNum varchar(6),
		ClientName nvarchar(70),
		LocationDesc nvarchar(35),
		Clinician nvarchar(300) NULL,
		MHStatus nvarchar(30) NULL,
		ParoleDischargeDate Date NULL
	 )

	 INSERT INTO @ETable(EpisodeID, CDCRNum, ClientName, LocationDesc, Clinician, MHStatus, ParoleDischargeDate) 
	 SELECT e.EpisodeID, e.CDCRNum, (o.LastName + ',' + o.FirstName)ClientName, 
		(CASE WHEN e.ParoleLocationID IS NULL THEN '' ELSE 
	        (SELECT [dbo].[fnGetlocationDesc](e.ParoleLocationID)) END)LocationDesc,
		(CASE WHEN @caseWorkerTypeID =3 AND ISNULL(s.PsychiatristUserId, 0) > 0 THEN (SELECT Name FROM [dbo].[fn_GetAsstUserName](s.PsychiatristUserId)) + ' - Psychiatrist'
			  WHEN @caseWorkerTypeID =4 AND ISNULL(s.PsychologistUserId, 0) > 0 THEN (SELECT Name FROM [dbo].[fn_GetAsstUserName](s.PsychologistUserId))  + ' - Psychologist'
			  WHEN @caseWorkerTypeID =5 AND ISNULL(s.SocialWorkerUserId, 0) > 0 THEN (SELECT Name FROM [dbo].[fn_GetAsstUserName](s.SocialWorkerUserId))  + ' - Social Worker'
		   ELSE '' END)Clinician,
			(CASE WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 2 THEN 'EOP'
		     WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 3 THEN 'CCCMS'
		ELSE
			(CASE WHEN ISNULL(o.MhStatus, 0) = 2 THEN 'EOP' 
				  WHEN ISNULL(o.MhStatus, 0) = 3 THEN 'CCCMS'
			 ELSE '' END) END)MHStatus, cl.ParoleDischargeDate
       FROM Episode e 
	      INNER JOIN Offender o ON e.OffenderID  = o.OffenderID
	      INNER JOIN (SELECT EpisodeID, ClientEpisodeID, StaffAssignmentID 
		                FROM EpisodeTrace WHERE IsLastOne =1) t ON e.EpisodeID = t.EpisodeID
		  LEFT OUTER JOIN (SELECT EpisodeID, CaseClosureDate, CaseBankedDate, ParoleDischargeDate, ClientEpisodeID, ParoleMentalHealthLevelOfServiceID FROM ClientEpisode )cl ON e.EpisodeID = cl.EpisodeID AND t.ClientEpisodeID = cl.ClientEpisodeID
					INNER JOIN  StaffAssignment s ON e.EpisodeID = s.EpisodeID AND t.StaffAssignmentID = s.ID
	                INNER JOIN @User u ON (s.SocialWorkerUserId = UserID OR s.PsychologistUserId=UserID) 
	  WHERE cl.CaseClosureDate IS NULL AND cl.CaseBankedDate Is NULL AND (cl.ParoleDischargeDate IS NULL OR (cl.ParoleDischargeDate >=@StartDate AND cl.ParoleDischargeDate <=@EndDate))
    UNION
    SELECT e.EpisodeID, e.CDCRNum, (o.LastName + ',' + o.FirstName)ClientName, 
		(CASE WHEN e.ParoleLocationID IS NULL THEN '' ELSE 
	        (SELECT [dbo].[fnGetlocationDesc](e.ParoleLocationID)) END)LocationDesc,
			(CASE WHEN @caseWorkerTypeID =3 AND ISNULL(a.StaffID, 0) > 0 THEN (SELECT Name FROM [dbo].[fn_GetAsstUserName](a.StaffID)) + ' - Psychiatrist'
			  WHEN @caseWorkerTypeID =4 AND ISNULL(a.StaffID, 0) > 0 THEN (SELECT Name FROM [dbo].[fn_GetAsstUserName](a.StaffID))  + ' - Psychologist'
			  WHEN @caseWorkerTypeID =5 AND ISNULL(a.StaffID, 0) > 0 THEN (SELECT Name FROM [dbo].[fn_GetAsstUserName](a.StaffID))  + ' - Social Worker'
		   ELSE '' END)Clinician,
			(CASE WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 2 THEN 'EOP'
		     WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 3 THEN 'CCCMS'
		ELSE
			(CASE WHEN ISNULL(o.MhStatus, 0) = 2 THEN 'EOP' 
				  WHEN ISNULL(o.MhStatus, 0) = 3 THEN 'CCCMS'
			 ELSE '' END) END)MHStatus, cl.ParoleDischargeDate
     FROM Episode e INNER JOIN Offender o ON e.OffenderID  = o.OffenderID
	                INNER JOIN 
	(SELECT EpisodeID, ClientEpisodeID, StaffAssignmentID FROM EpisodeTrace WHERE IsLastOne =1) t ON e.EpisodeID = t.EpisodeID
					LEFT OUTER JOIN 
	(SELECT EpisodeID, ClientEpisodeID, ParoleMentalHealthLevelOfServiceID, CaseClosureDate, CaseBankedDate, ParoleDischargeDate        
	   FROM ClientEpisode)cl ON e.EpisodeID = cl.EpisodeID AND t.ClientEpisodeID = cl.ClientEpisodeID
					INNER JOIN 
					(SELECT AppointmentID, StartDate, EpisodeID, StaffID FROM
                      (SELECT t1.AppointmentID, StartDate, EpisodeID, StaffID, ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY t1.AppointmentID DESC)rum  FROM Appointment t1 
							INNER JOIN AppointmentWithStaff t2 ON t1.AppointmentID = t2.AppointmentID 
							INNER JOIN AppointmentWithClient t3 ON t1.AppointmentID = t3.AppointmentID 
	                WHERE t2.StaffID in (SELECT UserID FROM @User) AND t1.ActionStatus <> 10)appt 
					WHERE appt.rum = 1)a ON e.EpisodeID  = a.EpisodeID
	  WHERE cl.CaseClosureDate IS NULL AND cl.CaseBankedDate Is NULL AND (cl.ParoleDischargeDate IS NULL OR (cl.ParoleDischargeDate >=@StartDate AND cl.ParoleDischargeDate <=@EndDate))
	 UNION
	 SELECT e.EpisodeID, e.CDCRNum, (o.LastName + ',' + o.FirstName)ClientName, 
		(CASE WHEN e.ParoleLocationID IS NULL THEN '' ELSE 
	        (SELECT [dbo].[fnGetlocationDesc](e.ParoleLocationID)) END)LocationDesc,
			(CASE WHEN @caseWorkerTypeID =3 AND ISNULL(n.ActionBy, 0) > 0 THEN (SELECT Name FROM [dbo].[fn_GetAsstUserName](n.ActionBy)) + ' - Psychiatrist'
			  WHEN @caseWorkerTypeID =4 AND ISNULL(n.ActionBy, 0) > 0 THEN (SELECT Name FROM [dbo].[fn_GetAsstUserName](n.ActionBy))  + ' - Psychologist'
			  WHEN @caseWorkerTypeID =5 AND ISNULL(n.ActionBy, 0) > 0 THEN (SELECT Name FROM [dbo].[fn_GetAsstUserName](n.ActionBy))  + ' - Social Worker'
		   ELSE '' END)Clinician,
			(CASE WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 2 THEN 'EOP'
		     WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 3 THEN 'CCCMS'
		ELSE
			(CASE WHEN ISNULL(o.MhStatus, 0) = 2 THEN 'EOP' 
				  WHEN ISNULL(o.MhStatus, 0) = 3 THEN 'CCCMS'
			 ELSE '' END) END)MHStatus, cl.ParoleDischargeDate
     FROM Episode e INNER JOIN Offender o ON e.OffenderID  = o.OffenderID
	                INNER JOIN (SELECT EpisodeID, ClientEpisodeID, StaffAssignmentID FROM EpisodeTrace WHERE IsLastOne =1) t ON e.EpisodeID = t.EpisodeID
					LEFT OUTER JOIN (SELECT EpisodeID, ClientEpisodeID, ParoleDischargeDate,CaseClosureDate, CaseBankedDate,     ParoleMentalHealthLevelOfServiceID FROM ClientEpisode)cl ON e.EpisodeID = cl.EpisodeID AND t.ClientEpisodeID = cl.ClientEpisodeID
					INNER JOIN 
					(SELECT CaseNoteID, DateAction, EpisodeID, ActionBy FROM
                      (SELECT n1.CaseNoteID, n1.DateAction, n1.EpisodeID, ActionBy, ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY n1.ID DESC)rum  FROM CaseNote n1 
							INNER JOIN CaseNoteTrace n2 ON n1.ID = n2.NoteID 
	                WHERE n1.ActionBy in (SELECT UserID FROM @User) AND n1.DateAction >=@StartDate AND n1.DateAction <= @EndDate and n1.ActionStatus <> 10)cn where cn.rum = 1)n ON e.EpisodeID  = n.EpisodeID
	WHERE cl.CaseClosureDate IS NULL AND cl.CaseBankedDate Is NULL AND (cl.ParoleDischargeDate IS NULL OR (cl.ParoleDischargeDate >=@StartDate AND cl.ParoleDischargeDate <=@EndDate))				 
	SELECT * FROM @ETable Order BY CDCRNum
END
GO
GRANT EXECUTE ON [dbo].[spRptClientPendingDischarge] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptClientPendingDischarge] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spRptAssignmentCaseload
--============================================================================
/****** Object:  StoredProcedure [dbo].[spRptAssignmentCaseload]    Script Date: 2/4/2021 3:37:31 PM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spRptAssignmentCaseload]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spRptAssignmentCaseload]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spRptAssignmentCaseload]
	@CaseWorkerIds nvarchar(200)=Null,
	@StartDate datetime = Null,
	@EndDate DateTime = Null
AS
BEGIN
	SET NOCOUNT ON
    
	--DECLARE @StartDate DateTime = '01-01-2019'
 --   DECLARE @EndDate DateTime = null
	--DECLARE @StaffID int  =597
	--DECLARE @CaseWorkerIds nvarchar(100) = '597'
	DECLARE @True bit = 1
	DECLARE @False bit = 0
	
	IF @StartDate IS NULL 
	   SET @StartDate = GetDate()

	IF @EndDate IS NULL
      SET @EndDate = DATEADD(month, 12, @StartDate)

	DECLARE @User TABLE(
	  UserID int,
	  Name nvarchar(70),
	  CAseWorkerTypeID int,
	  CaseWorkerTypeDesc nvarchar(30)
	)
	INSERT INTO @User
	SELECT UserID, (LastName + ', ' + SUBSTRING(FirstName, 1, 2))Name, u.CaseWorkerTypeId, c.CaseWorkerTypeDesc From [User] u INNER JOIN tlkpCaseWorkerType c ON u.CaseWorkerTypeId = c.CaseWorkerTypeId
	 WHERE UserID in (SELECT * FROM [dbo].[fnSplitString](@CaseWorkerIds, ','))

	 DECLARE @ETable TABLE(
	    EpisodeID int,
		County nvarchar(35),
		CDCRNum varchar(6),
		ClientName nvarchar(70),
		Location nvarchar(35),
		SocialWorker nvarchar(70) NULL,
		Psychologist nvarchar(70) NULL,
		Clinician nvarchar(300) NULL,
		MHStatus nvarchar(30) NULL,
		LatestApptDate nvarchar(10) NULL,
		LatestNoteDate nvarchar(20) NULL
	 )
	 INSERT INTO @ETable(EpisodeID, County, CDCRNum, ClientName, Location, MHStatus) 
	 SELECT e.EpisodeID, (CASE WHEN e.ReleaseCountyID IS NULL THEN '' ELSE (SELECT [dbo].[fnGetCountyName](e.ReleaseCountyID)) END)County,
		 e.CDCRNum, (o.LastName + ',' + o.FirstName)ClientName, 
		(CASE WHEN e.ParoleLocationID IS NULL THEN '' ELSE 
	        (SELECT [dbo].[fnGetlocationDesc](e.ParoleLocationID)) END)Location,
			(CASE WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 2 THEN 'EOP'
		     WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 3 THEN 'CCCMS'
		ELSE
			(CASE WHEN ISNULL(o.MhStatus, 0) = 2 THEN 'EOP' 
				  WHEN ISNULL(o.MhStatus, 0) = 3 THEN 'CCCMS'
			 ELSE '' END) END)MHStatus
       FROM Episode e INNER JOIN Offender o ON e.OffenderID  = o.OffenderID
	                INNER JOIN (SELECT EpisodeID, ClientEpisodeID, StaffAssignmentID FROM EpisodeTrace WHERE IsLastOne =1) t ON e.EpisodeID = t.EpisodeID
					LEFT OUTER JOIN (SELECT EpisodeID, ClientEpisodeID,ParoleMentalHealthLevelOfServiceID FROM ClientEpisode)cl ON e.EpisodeID = cl.EpisodeID AND t.ClientEpisodeID = cl.ClientEpisodeID
					INNER JOIN  StaffAssignment s ON e.EpisodeID = s.EpisodeID AND t.StaffAssignmentID = s.ID
	                INNER JOIN @User u ON (s.SocialWorkerUserId = UserID OR s.CaseManagerUserId =UserID OR s.PsychologistUserId=UserID) 
	  WHERE s.DateAction >=@StartDate AND s.DateAction <=@EndDate
   
    UNION
    SELECT e.EpisodeID, (CASE WHEN e.ReleaseCountyID IS NULL THEN '' ELSE (SELECT [dbo].[fnGetCountyName](e.ReleaseCountyID)) END)County,
		 e.CDCRNum, (o.LastName + ',' + o.FirstName)ClientName, 
		(CASE WHEN e.ParoleLocationID IS NULL THEN '' ELSE 
	        (SELECT [dbo].[fnGetlocationDesc](e.ParoleLocationID)) END)Location,
			(CASE WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 2 THEN 'EOP'
		     WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 3 THEN 'CCCMS'
		ELSE
			(CASE WHEN ISNULL(o.MhStatus, 0) = 2 THEN 'EOP' 
				  WHEN ISNULL(o.MhStatus, 0) = 3 THEN 'CCCMS'
			 ELSE '' END) END)MHStatus
     FROM Episode e INNER JOIN Offender o ON e.OffenderID  = o.OffenderID
	                INNER JOIN (SELECT EpisodeID, ClientEpisodeID, StaffAssignmentID FROM EpisodeTrace WHERE IsLastOne =1) t ON e.EpisodeID = t.EpisodeID
					LEFT OUTER JOIN (SELECT EpisodeID, ClientEpisodeID, ParoleMentalHealthLevelOfServiceID FROM ClientEpisode)cl ON e.EpisodeID = cl.EpisodeID AND t.ClientEpisodeID = cl.ClientEpisodeID
					INNER JOIN 
					(SELECT AppointmentID, StartDate, EpisodeID FROM
                      (SELECT t1.AppointmentID, StartDate, EpisodeID, ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY t1.AppointmentID DESC)rum  FROM Appointment t1 
							INNER JOIN AppointmentWithStaff t2 ON t1.AppointmentID = t2.AppointmentID 
							INNER JOIN AppointmentWithClient t3 ON t1.AppointmentID = t3.AppointmentID 
	                WHERE t2.StaffID in (SELECT UserID FROM @User) AND StartDate >=@StartDate AND StartDate <= @EndDate and t1.ActionStatus <> 10)appt where appt.rum = 1)a ON e.EpisodeID  = a.EpisodeID
	 UNION
	 SELECT e.EpisodeID, (CASE WHEN e.ReleaseCountyID IS NULL THEN '' ELSE (SELECT [dbo].[fnGetCountyName](e.ReleaseCountyID)) END)County,
		 e.CDCRNum, (o.LastName + ',' + o.FirstName)ClientName, 
		(CASE WHEN e.ParoleLocationID IS NULL THEN '' ELSE 
	        (SELECT [dbo].[fnGetlocationDesc](e.ParoleLocationID)) END)Location,
			(CASE WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 2 THEN 'EOP'
		     WHEN ISNULL(cl.ParoleMentalHealthLevelOfServiceID, 0) = 3 THEN 'CCCMS'
		ELSE
			(CASE WHEN ISNULL(o.MhStatus, 0) = 2 THEN 'EOP' 
				  WHEN ISNULL(o.MhStatus, 0) = 3 THEN 'CCCMS'
			 ELSE '' END) END)MHStatus
     FROM Episode e INNER JOIN Offender o ON e.OffenderID  = o.OffenderID
	                INNER JOIN (SELECT EpisodeID, ClientEpisodeID, StaffAssignmentID FROM EpisodeTrace WHERE IsLastOne =1) t ON e.EpisodeID = t.EpisodeID
					LEFT OUTER JOIN (SELECT EpisodeID, ClientEpisodeID, ParoleMentalHealthLevelOfServiceID FROM ClientEpisode)cl ON e.EpisodeID = cl.EpisodeID AND t.ClientEpisodeID = cl.ClientEpisodeID
					INNER JOIN 
					(SELECT CaseNoteID, DateAction, EpisodeID FROM
                      (SELECT n1.CaseNoteID, n1.DateAction, n1.EpisodeID, ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY n1.ID DESC)rum  FROM CaseNote n1 
							INNER JOIN CaseNoteTrace n2 ON n1.ID = n2.NoteID 
	                WHERE n1.ActionBy in (SELECT UserID FROM @User) AND n1.DateAction >=@StartDate AND n1.DateAction <= @EndDate and n1.ActionStatus <> 10)cn where cn.rum = 1)n ON e.EpisodeID  = n.EpisodeID				
					
	--update from staffassignment	
	UPDATE tgr SET SocialWorker = scr.SocialWorker, Psychologist = scr.Psychologist 
	  FROM @ETable tgr INNER JOIN (SELECT a.EpisodeID,SocialWorkerUserId,PsychologistUserId, 
           (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(SocialWorkerUserId, 0)))SocialWorker, 
		   (Select Name FROM dbo.fn_GetAsstUserName(ISNULL(PsychologistUserId, 0)))Psychologist
              FROM StaffAssignment a INNER JOIN EpisodeTrace e ON a.ID = e.StaffAssignmentID
			       INNER JOIN @User u ON (a.SocialWorkerUserId = UserID OR a.CaseManagerUserId =UserID OR a.PsychologistUserId=UserID))scr
	  ON tgr.EpisodeID = scr.EpisodeID 
		
     --update from appointment
	UPDATE tgr SET SocialWorker = (CASE WHEN ISNULL(tgr.SocialWorker, '') = '' AND scr.SocialWorker <> ''  THEN scr.SocialWorker ELSE tgr.SocialWorker END),
				   Psychologist = (CASE WHEN ISNULL(tgr.Psychologist, '') = '' AND scr.Psychologist<>'' THEN scr.Psychologist ELSE tgr.Psychologist END), 
	               LatestApptDate = CONVERT(VARCHAR(10), StartDate, 111)
	  FROM @ETable tgr INNER JOIN 
	  (SELECT AppointmentID, StartDate, EpisodeID, (CASE WHEN CaseWorkerTypeId = 5 THEN Name ELSE '' END)SocialWorker,
	          (CASE WHEN CaseWorkerTypeId = 4 THEN Name ELSE '' END)Psychologist
	     FROM
       (SELECT t1.AppointmentID, StartDate, EpisodeID, Name, CaseWorkerTypeId, ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY t1.AppointmentID DESC)rum  FROM Appointment t1 
            INNER JOIN AppointmentWithStaff t2 ON t1.AppointmentID = t2.AppointmentID 
		    INNER JOIN AppointmentWithClient t3 ON t1.AppointmentID = t3.AppointmentID
			INNER JOIN @User u ON t2.StaffID  =  u.UserID 
	     WHERE StartDate >= @StartDate AND StartDate <= @EndDate and t1.ActionStatus <> 10)t where t.rum = 1)scr
	  ON tgr.EpisodeID = scr.EpisodeID 
	
	--update from casenote
	UPDATE tgr SET SocialWorker = (CASE WHEN ISNULL(tgr.SocialWorker, '') = '' AND scr.SocialWorker <> ''  THEN scr.SocialWorker ELSE tgr.SocialWorker END),
				   Psychologist = (CASE WHEN ISNULL(tgr.Psychologist, '') = '' AND scr.Psychologist<>'' THEN scr.Psychologist ELSE tgr.Psychologist END), 
	               LatestNoteDate = CONVERT(VARCHAR(10), DateAction, 111)
	  FROM @ETable tgr INNER JOIN 
	  (SELECT CaseNoteID, DateAction, EpisodeID, (CASE WHEN CaseWorkerTypeId = 5 THEN Name ELSE '' END)SocialWorker,
	          (CASE WHEN CaseWorkerTypeId = 4 THEN Name ELSE '' END)Psychologist
	     FROM
       (SELECT n1.CaseNoteID, n1.DateAction, n1.EpisodeID,u.caseWorkerTypeID, Name, ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY n1.ID DESC)rum  FROM CaseNote n1 
				   INNER JOIN CaseNoteTrace n2 ON n1.ID = n2.NoteID 
				   INNER JOIN @User u on n1.ActionBy= u.UserID
	                WHERE n1.DateAction >=@StartDate AND n1.DateAction <= @EndDate and n1.ActionStatus <> 10)cn where cn.rum = 1)scr
	  ON tgr.EpisodeID = scr.EpisodeID 

	  --update clinician
	  UPDATE @ETable SET Clinician=CONCAT((CASE WHEN LEN(SocialWorker) = 0 THEN '' ELSE SocialWorker + '- Social Worker '  + char(13) + char(10) END),
	                       (CASE WHEN LEN(Psychologist) = 0 THEN '' ELSE Psychologist + ' - Psychologist ' END))
	  

	SELECT EpisodeID, County, CDCRNum, ClientName, Location, SocialWorker, Psychologist, Clinician, MHStatus, LatestApptDate, LatestNoteDate FROM @ETable Order BY EpisodeID	
END

GO
GRANT EXECUTE ON [dbo].[spRptAssignmentCaseload] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spRptAssignmentCaseload] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spAgent_POCAttendance
--============================================================================
/****** Object:  StoredProcedure [dbo].[spAgent_POCAttendance]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spAgent_POCAttendance]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spAgent_POCAttendance]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAgent_POCAttendance]
	@CDCNum char(6)
AS
BEGIN
	SET NOCOUNT ON
	
DECLARE @EpisodeID int = (SELECT EpisodeID FROM Episode WHERE CDCRNum = @CDCNum)
  --==================================================================================
      /*comment it out to allow all cdcrs's appointments to show on the report */
  --==================================================================================
	   --DECLARE @CaseClosureDate datetime = (SELECT CaseClosureDate FROM dbo.fn_GetLatestClientEpisode(@EpisodeID ))
       --if @CaseClosureDate is null
       --    BEGIN
   --==================================================================================
       SELECT @EpisodeID as EpisodeID, AppointmentID, AppointmentTraceID, StartDate, EndDate, ta1.ComplexID, TypeID, StatusId,  
                     IsCompleted, IsAllDay, EvtTShortDescr,  ActionStatus, StaffID, @CDCNum CDCRNum, ClientName, 
					 --(SELECT [dbo].[fnGetLocationDesc](ISNULL(ta1.ComplexID, 0)))Location, 
					 (SELECT [dbo].[fnGetComplexDesc](ISNULL(ta1.ComplexID, 0)))Location, 
					 (SELECT Name FROM [dbo].[fn_GetUserName](ta1.StaffID)) CaseWorker, 
					 (SELECT [dbo].[fnCaseWorkerTypeDesc](ISNULL(ta1.StaffID, 0))) WorkerType,
					 (CASE ClientEventStatus WHEN 1 THEN 'Absent' WHEN 2 THEN 'Pending' WHEN 3 THEN 'Present' WHEN 4 THEN 'Excused' END)ClientAttendStatus FROM  
        (SELECT @EpisodeID as EpisodeID, t1.AppointmentID, AppointmentTraceID, StartDate, EndDate, ComplexID, TypeID, StatusId,  
                     IsCompleted, IsAllDay, EvtTShortDescr, t1.ActionStatus, t3.StaffID,t2.ClientEventStatus
              FROM 
               (SELECT AppointmentID, AppointmentTraceID, StartDate, EndDate, ComplexID, TypeID, StatusId, ADAECIDs, ActionStatus,Note,
                     IsCompleted, IsAllDay, ROW_NUMBER() OVER (PARTITION BY AppointmentTraceID ORDER BY AppointmentID DESC) AS RowNum  
                  FROM Appointment
                 WHERE StartDate >= DateAdd(year, -10, getdate()) AND EndDate < DateAdd(year, 5, getdate()))t1 
                           INNER JOIN 
               (SELECT DISTINCT AppointmentID,ClientEventStatus FROM AppointmentWithClient WHERE EpisodeID  = @EpisodeID) t2 on t1.AppointmentID =  t2.AppointmentID
                           INNER JOIN 
               (SELECT  AppointmentID, staffID FROM AppointmentWithStaff) t3 on t1.AppointmentID  = t3.AppointmentID 
                      INNER JOIN tlkpAppointmentType D on t1.TypeID = D.ID
         WHERE t1.RowNum = 1 AND t1.ActionStatus <> 10)ta1 INNER JOIN 
         (SELECT e.EpisodeID, e.cdcrnum, e.OffenderID, concat(o.lastname, ',', o.firstname, ' ', ISNULL(o.Middlename, ''))clientname 
		 FROM Episode e inner join offender o on e.OffenderID  = o.OffenderID) ta2
         on ta1.EpisodeID  = ta2.EpisodeID 
		 INNER JOIN [dbo].[User] t7 ON t7.UserID=ta1.StaffID
		 ORDER BY StartDate DESC
         END
--END
GO
GRANT EXECUTE ON [dbo].[spAgent_POCAttendance] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spAgent_POCAttendance] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spDeleteAppointment
--============================================================================
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spDeleteAppointment]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spDeleteAppointment]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteAppointment] 
	@AppointmentTraceID int = 0	
AS
BEGIN
	SET NOCOUNT ON;

IF @AppointmentTraceID > 0
BEGIN
   --DECLARE @ApptTaceID int  = (SELECT AppointmentTraceID  FROM dbo.Appointment 
   --                             WHERE AppointmentID  = @AppointmentID)
   DECLARE @ApptIDTable TABLE(
     AppointmentID int
   )
   INSERT INTO @ApptIDTable
   SELECT AppointmentID FROM dbo.Appointment WHERE AppointmentTraceID = @AppointmentTraceID
   
   UPDATE tgr SET tgr.ActionStatus = 10 
     FROM dbo.Appointment tgr INNER JOIN
   (SELECT t1.AppointmentID
     FROM Appointment t1 INNER JOIN @ApptIDTable t2 ON t1.AppointmentID  = t2.AppointmentID)scr 
	ON tgr.AppointmentID =  scr.AppointmentID

	UPDATE tgr SET tgr.ActionStatus = 10 
     FROM dbo.AppointmentWithStaff tgr INNER JOIN
   (SELECT t1.AppointmentID
     FROM Appointment t1 INNER JOIN @ApptIDTable t2 ON t1.AppointmentID  = t2.AppointmentID)scr 
	ON tgr.AppointmentID =  scr.AppointmentID


	UPDATE tgr SET tgr.ActionStatus = 10 
     FROM dbo.AppointmentWithClient tgr INNER JOIN
   (SELECT t1.AppointmentID
     FROM Appointment t1 INNER JOIN @ApptIDTable t2 ON t1.AppointmentID  = t2.AppointmentID)scr 
	ON tgr.AppointmentID =  scr.AppointmentID
  END
END

GO
GRANT EXECUTE ON [dbo].[spDeleteAppointment] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spDeleteAppointment] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spGetEpisodeDSM5
--============================================================================
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spGetEpisodeDSM5]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spGetEpisodeDSM5]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Create date: 2022-03-06
-- Description:	Get clinicalDMS5  
-- =============================================
CREATE PROCEDURE [dbo].[spGetEpisodeDSM5] 
	@EpisodeID int,
	@CurrentUserID int,
	@DSM5ID int = 0	
AS
BEGIN
   DECLARE @True bit = 1
   DECLARE @False bit =0
   DECLARE @IsLastDSM5Set bit  = 0
   
   IF  @EpisodeID > 0 
   BEGIN
     DECLARE @LDSM5ID  int = (SELECT ISNULl(DSM5ID, 0)DSM5ID FROM dbo.EpisodeTrace WHERE EpisodeID = @EpisodeID) 
	
	 IF @LDSM5ID = @DSM5ID OR @LDSM5ID = 0
		     SET @IsLastDSM5Set = 1

	DECLARE  @CanEdit bit  = (SELECT (CASE WHEN ((IsPOCAdmin = 1 OR IsPOCSocialWorker = 1)) THEN 1 ELSE 0 END ) FROM [User] WHERE UserID  = @CurrentUserID)
	
     IF @DSM5ID > 0 
	    SELECT DSM5ID, EpisodeID, @CanEdit AS CanEdit, @IsLastDSM5Set AS IsLastDSM5Set, DSM5Json, ActionBy, (SELECT Name FROM [dbo].[fn_GetAsstUserName](ActionBy))ActionName 
		  FROM dbo.ClinicalDSM5 where DSM5ID  = @DSM5ID
     ELSE 
	 BEGIN
	   IF @LDSM5ID = 0
	    BEGIN
		DECLARE @Json nvarchar(max) = (select '[' + STUFF((
         SELECT 
            ',{"DSM5ItemID":'  + cast(DSM5ItemID as varchar(3))
			+ ',"GroupID":' + cast(DSM5GroupID as varchar(2))
			+ ',"ItemScore":' + cast(-1 as varchar(2))
			+ ',"DSM5ItemDesc":"' + DSM5ItemDescr + '"'
            +'}'
          FROM [dbo].[tlkpDSM5Items]  for xml path(''), type).value('.', 'varchar(max)'), 1, 1, '') + ']')

	      SELECT 0 AS DSM5ID, @EpisodeID AS EpisodeID, @CanEdit AS CanEdit, @True AS IsLastDSM5Set, @Json AS DSM5Json, @CurrentUserID AS ActionBy, 
		      (SELECT Name FROM [dbo].[fn_GetAsstUserName](@CurrentUserID))ActionName 
		END
	   ELSE
	     SELECT DSM5ID, EpisodeID, @CanEdit AS CanEdit, @True AS IsLastDSM5Set, DSM5Json, ActionBy, (SELECT Name FROM [dbo].[fn_GetAsstUserName](ActionBy))ActionName 
		   FROM dbo.ClinicalDSM5 where DSM5ID  = @LDSM5ID
     END
  END
END 
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeDSM5] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spGetEpisodeDSM5] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
--============================================================================
--spImportSomsRecordToPats
--============================================================================
/****** Object:  StoredProcedure [dbo].[spImportSomsRecordToPats]    Script Date: 8/19/2020 10:35:02 AM ******/
IF EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'[dbo].[spImportSomsRecordToPats]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
  DROP PROCEDURE [dbo].[spImportSomsRecordToPats]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spImportSomsRecordToPats] 
	@SomsOffenderId int = 0 ,
	@SomsUploadId int = 0,
	@ResultMessage nvarchar(max) output 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	
	Declare @RowCount nvarchar(30)
	IF @SomsUploadId = 0 
	  SET @SomsUploadId = (SELECT MAX(SomsUploadID) from [BassWeb].[dbo].SomsUpload)
	
	Declare @NewCDCR int = (select Count(s.cdcnumber) from [BassWeb].dbo.SomsRecord s left outer join episode e 
          on s.cdcnumber = e.cdcrnum where s.somsuploadid = @SomsUploadId and e.cdcrnum is null )

    IF @NewCDCR = 0 
	   SET @ResultMessage = 'No new cdcr found.'
	ELSE
	   SET @ResultMessage = Convert(varchar(5), @NewCDCR) + ' new cdcr found.'
	
	/*-------------------------------------------------------------
	--Do update for all mapped records on episode and Offender 
	---------------------------------------------------------------*/
	--1. Offender
	DECLARE @SsiDeterminString nvarchar(200) ='DPW,DPO,DPM,DNM,DPH,DNH,DPS,DNS,DPV,DKD,DLT,DD1,DD2,DD3,DSH,ICF,APU,MHC,EOP,ACU'
	Update tgr Set LastName = scr.InmateLastName, FirstName = scr.InmateFirstName,DOB = scr.InmateDateOfBirth,
		   GenderID = (SELECT GenderID FROM tlkpGender Where Code = IsNULL(scr.InmateSexCode, 'U') ), 
		   SSN = (CASE WHEN SSN in ( '999-99-9999', '111-11-1111', '', ISNULl(SSN, '')) THEN ISNULL(scr.SSNum, '999-99-9999') ELSE
		   SSN END), PC290=(CASE WHEN LEN(ISNULL(scr.PENALCODE, '')) > 0 THEN 1 ELSE 0 END),
		   PhysDisabled=(CASE WHEN scr.DPPHearingCode <> '' or scr.DPPMobilityCode <> '' or scr.DPPSpeechCode <> '' or scr.DPPVisionCode <> '' THEN 1 ELSE 0 END),
		   MhStatus = (CASE WHEN CHARINDEX('ACUTE', scr.MhDesc) > 0  OR CHARINDEX('AltHs', scr.MhDesc) > 0 OR 
		                         CHARINDEX('ASU', scr.MhDesc) > 0  OR CHARINDEX('ASUhb', scr.MhDesc) > 0 OR 
								 CHARINDEX('DMH', scr.MhDesc) > 0  OR CHARINDEX('EOP', scr.MhDesc) > 0 OR 
								 CHARINDEX('ICF', scr.MhDesc) > 0  OR CHARINDEX('MHCB', scr.MhDesc) > 0 THEN 2
		                    WHEN CHARINDEX('CCCMS', scr.MhDesc) > 0 THEN 3
							 ELSE 1 END),
		   DevDisabled = (CASE WHEN scr.DevelopDisabledEvaluation in ('DD1', 'DD2', 'DD3') THEN 1 ELSE 0 END ), 
		   DDP = scr.DevelopDisabledEvaluation,DPPHearing = scr.DPPHearingCode, DPPMobility= scr.DPPMobilityCode, 
		   DPPSpeech = scr.DPPSpeechCode, DPPVision = scr.DPPVisionCode, PID = scr.PID, SomsUploadID = @SomsUploadId
		   From Offender tgr INNER JOIN  
	(Select e.ReleaseDate, o.OffenderID, o.PID, s.DevelopDisabledEvaluation, s.PENALCODE,
		   ISNULL(s.DPPHearingCode, '') as DPPHearingCode, ISNULL(s.DPPMobilityCode, '') AS DPPMobilityCode, 
		   ISNULL(s.DPPSpeechCode, '') AS DPPSpeechCode, ISNULL(s.DPPVisionCode, '') as DPPVisionCode, s.FileDate,
		   s.InmateFirstName, s.InmateLastName,s.InmateSexCode, ScheduledReleaseDate, s.MhDesc, s.InmateDateOfBirth,
		   s.SomsUploadID, s.SSNum, s.Unit from Episode e Inner join Offender o on e.OffenderID = o.OffenderID 
		   inner join  [BassWeb].dbo.SomsRecord s on s.SomsOffenderID = o.PID and s.CDCNumber =  e.CDCRNum
	Where s.SomsUploadID = @SomsUploadId )scr ON tgr.OffenderID = scr.OffenderID 
	SET @RowCount = convert(nvarchar(30),@@ROWCOUNT)
	IF @@ROWCOUNT = 0  
	 SET @ResultMessage = @ResultMessage + char(13) + char(10) + 'Warning: No rows has updated in Offender table.'; 
	ELSE 
	  SET @ResultMessage = @ResultMessage + char(13) + char(10) + @RowCount + ' rows have been updated in Offender table.'; 
	
	--2. Episode
	Update tgr Set ReleaseDate = scr.ScheduledReleaseDate, Lifer = (CASE WHEN scr.Lifer ='Y' THEN 1 ELSE 0 END),
	       ReleaseCountyID = (CASE WHEN ISNULL(scr.CountyOfRelease, '') <> '' AND EXISTS(SELECT 1 FROM tlkpCounty WHERE Name =scr.CountyOfRelease) THEN (SELECT CountyID FROM tlkpCounty WHERE Name =scr.CountyOfRelease ) ELSE NULL END ),
		   CustodyFacilityID = (CASE WHEN scr.Unit = 'PRCCF' OR scr.Unit ='PUCCF' THEN 
		                          (select top 1 FacilityID from tlkpFacility where OrgCommonID = scr.Unit and Disabled <> 1 and 
								    substring(SomsLoc, CHARINDEX( '-', SomsLoc)+1, len(SomsLoc)) = substring(scr.Loc, CHARINDEX( '-', scr.Loc)+1, len(scr.Loc)))
                                     ELSE (select top 1 FacilityID from tlkpFacility where OrgCommonID = scr.Unit and Disabled <> 1) END),
		   ParoleLocationID = (CASE WHEN (ISNULL(scr.PAROLEUNIT, '') = '' OR 
		     (NOT EXISTS(SELECT 1 FROM tlkpLocation WHERE LocationDesc = ISNULL(scr.PAROLEUNIT, '')) 
			              AND ISNULL(tgr.ParoleLocationID, 0) <> 0)) THEN tgr.ParoleLocationID ELSE
		                        (SELECT top 1 LocationID FROM tlkpLocation Where LocationDesc = 
							  (CASE WHEN scr.PAROLEUNIT in ('San Jose 3', 'San Jose 5', 'San Jose 7') THEN 'San Jose 3, 5, 7'
						            WHEN scr.PAROLEUNIT in ('San Jose 1', 'San Jose 2') THEN 'San Jose 1&2'
								    WHEN scr.PAROLEUNIT = 'Contra Costa 1' THEN 'Concord 1'
									WHEN scr.PAROLEUNIT = 'Contra Costa 2' THEN 'Concord 2'
								    WHEN scr.PAROLEUNIT = 'Santa Rosa 2' THEN 'Santa Rosa'
									WHEN scr.PAROLEUNIT = 'El Cajon' THEN 'El Cajon 1'
									WHEN scr.PAROLEUNIT = 'El Monte GPS 2' THEN 'El Monte GPS'
									WHEN scr.PAROLEUNIT = 'Antelope Valley 1' THEN 'Ant Val 1'
		                            WHEN scr.PAROLEUNIT = 'REG4 RIVERSIDE #2' THEN 'Riverside GPS'
									WHEN scr.PAROLEUNIT = 'Ind/Plm Spr GPS' THEN 'Indio Palm Springs GPS'
									WHEN scr.PAROLEUNIT = 'East Bay' THEN 'Oakland 1' 
									WHEN scr.PAROLEUNIT = 'Escondido 1' THEN 'Escondido' 
									WHEN scr.PAROLEUNIT = 'ESCONDIDO #2' THEN 'Escondido 2'
									WHEN scr.PAROLEUNIT = 'Fresno 3' THEN 'Fresno 2'
									WHEN scr.PAROLEUNIT = 'CCTRP-Stockton' THEN 'CCTRP Stockton'
									WHEN scr.PAROLEUNIT = 'CCTRP-Bakersfld' THEN 'CCTRP Bakersfield'
									WHEN scr.PAROLEUNIT = 'CCTRP-Sacramento' THEN 'CCTRP Sacramento'
									WHEN scr.PAROLEUNIT = 'CCTRP-SF Spring' THEN 'CCTRP-SF Springs'
									WHEN scr.PAROLEUNIT = 'Hntgtn Park GPS' THEN 'Huntington Park GPS'
									WHEN scr.PAROLEUNIT = 'MCRP - BUTTE' THEN 'MCRP Butte'
									WHEN scr.PAROLEUNIT = 'MCRP-Kern' THEN 'MCRP Kern'
									WHEN scr.PAROLEUNIT = 'MCRP-LA1' THEN 'MCRP Los Angeles 1'
									WHEN scr.PAROLEUNIT = 'MCRP-LA2' THEN 'MCRP Los Angeles 2'
									WHEN scr.PAROLEUNIT = 'MCRP-LA3' THEN 'MCRP Los Angeles 3'
									WHEN scr.PAROLEUNIT = 'Salinas 1' THEN 'Salinas 1 GPS'
									WHEN scr.PAROLEUNIT = 'San Bern 1' THEN 'San Bernardino 1'
									WHEN scr.PAROLEUNIT = 'San Bern 2' THEN 'San Bernardino 2'
									WHEN scr.PAROLEUNIT = 'San Berdo GPS 1' THEN 'San Bernardino GPS'
									ELSE scr.PAROLEUNIT END ) AND ISNULl(Disabled, 0) = 0) END), 
		    ParoleUnit = (CASE WHEN ISNULl(scr.PAROLEUNIT, '')='' THEN tgr.ParoleUnit ELSE scr.PAROLEUNIT END), 
		   ParoleAgent = (CASE WHEN ISNULl(scr.PAROLEAGENTLASTNAME, '') = '' THEN tgr.ParoleAgent ELSE
			 (CASE WHEN ISNULL(scr.PAROLEAGENTFIRSTNAME, '') = '' THEN scr.PAROLEAGENTLASTNAME ELSE scr.PAROLEAGENTLASTNAME + ',' END) + ' ' + 
				 ISNULl(scr.PAROLEAGENTFIRSTNAME, '') + ' ' + ISNULL(scr.PAROLEAGENTMIDDLENAME, '') END),
		   SomsUploadID = @SomsUploadId, SuggestionDate = FileDate
		   From Episode tgr INNER JOIN  
	(Select e.EpisodeID,e.ReleaseDate, s.FileDate, ScheduledReleaseDate, s.PAROLEUNIT, s.PAROLEAGENTFIRSTNAME,s.CountyOfRelease,
	        s.PAROLEAGENTLASTNAME, s.PAROLEAGENTMIDDLENAME, s.PrimaryBedUse,s.SomsUploadID, s.Unit, s.Loc, s.Lifer 
	   from Episode e Inner join Offender o on e.OffenderID = o.OffenderID 
		   inner join  [BassWeb].dbo.SomsRecord s on s.SomsOffenderID = o.PID and s.CDCNumber =  e.CDCRNum
	Where s.SomsUploadID = @SomsUploadId )scr ON tgr.EpisodeID = scr.EpisodeID 
	SET @RowCount = convert(nvarchar(30),@@ROWCOUNT)
	IF @@ROWCOUNT = 0  
	 SET @ResultMessage = @ResultMessage +  char(13) + char(10) +   'Warning: No rows were updated in Episode Table.'; 
	ELSE 
	  SET @ResultMessage = @ResultMessage + char(13) + char(10) + @RowCount + ' rows have been updated in Episode Table.'; 

	/*-------------------------------------------------------------
	--Do insert for all new episodes and parolees
	---------------------------------------------------------------*/
--3. Update no mapped data. get all unmapped record from somsRecord table 
--insert all new parolees
INSERT INTO Offender (FirstName, LastName, GenderID, SSN, DOB, MHStatus, PhysDisabled,DevDisabled,
		      DDP, DPPHearing, DPPMobility, DPPSpeech, DPPVision, PC290, PC457, USVet, PID, InitialDate, SomsUploadID)
			 SELECT s.InmateFirstName, s.InmateLastName, (select GenderID from tlkpGender where Code= s.InmateSexCode), 
			  ISNULL(s.SSNum, ''), s.InmateDateOfBirth,
			  (CASE WHEN CHARINDEX('ACUTE', s.MhDesc) > 0  OR CHARINDEX('AltHs', s.MhDesc) > 0 OR 
		                 CHARINDEX('ASU', s.MhDesc) > 0  OR CHARINDEX('ASUhb', s.MhDesc) > 0 OR 
						 CHARINDEX('DMH', s.MhDesc) > 0  OR CHARINDEX('EOP', s.MhDesc) > 0 OR 
						 CHARINDEX('ICF', s.MhDesc) > 0  OR CHARINDEX('MHCB', s.MhDesc) > 0 THEN 2
		            WHEN CHARINDEX('CCCMS', s.MhDesc) > 0 THEN 3
					ELSE 1 END),
			    (CASE WHEN s.DPPHearingCode <> '' or s.DPPMobilityCode <> '' or s.DPPSpeechCode <> '' or s.DPPVisionCode <> '' THEN 1 ELSE 0 END),
				(CASE WHEN s.DevelopDisabledEvaluation in ('DD1', 'DD2', 'DD3') THEN 1 ELSE 0 END ),
				 s.DevelopDisabledEvaluation, s.DPPHearingCode, s.DPPMobilityCode, s.DPPSpeechCode, s.DPPVisionCode,				
			     (CASE WHEN LEN(ISNULL(s.PENALCODE, '')) > 0 THEN 1 ELSE 0 END)PC290, ISNULL(t1.PC457, 0), ISNULL(t1.USVet, 0), s.SomsOffenderID, GetDate(), SomsUploadID = @SomsUploadId
		       FROM [BassWeb].dbo.SomsRecord s left Outer join dbo.Offender t1 
			 on s.SomsOffenderID = t1.PID
			 where s.somsuploadId = @SomsUploadId and t1.PID is null
	SET @RowCount = convert(nvarchar(30),@@ROWCOUNT)
    IF @@ROWCOUNT = 0  
	 SET @ResultMessage = @ResultMessage +  char(13) + char(10) +   ' No new PID add to Offender table.'; 
	ELSE 
	  SET @ResultMessage = @ResultMessage + char(13) + char(10) + @RowCount + ' pid have been added into Offender table.'; 

	  --insert all new episodes
   INSERT INTO Episode (OffenderID, ReleaseDate, ParoleUnit,ReleaseCountyID, ParoleAgent, CDCRNum, SuggestionDate,
		      Lifer, ParoleLocationID, InitialDate,CustodyFacilityID, SomsUploadID) 
			   SELECT o.OffenderID, ScheduledReleaseDate, s.PAROLEUNIT, 
			   (CASE WHEN ISNULl(s.CountyOfRelease, '') <> '' AND EXISTS(select 1 from tlkpCounty where Name =s.CountyOfRelease) THEN 
			         (select CountyID from tlkpCounty where Name =s.CountyOfRelease) ELSE NULL END),
			    (CASE WHEN  ISNULl(PAROLEAGENTLASTNAME, '') = '' THEN  ISNULl(PAROLEAGENTFIRSTNAME,'') + ' ' + ISNULl(PAROLEAGENTMIDDLENAME,'')
				    ELSE ISNULl(PAROLEAGENTLASTNAME, '')  + ', ' + ISNULl(PAROLEAGENTFIRSTNAME,'') + ' ' + ISNULl(PAROLEAGENTMIDDLENAME,'') END ),
			   s.CDCNumber, FileDate, (CASE WHEN s.Lifer ='Y' THEN 1 ELSE 0 END),
			    (SELECT TOP 1 LocationID FROM tlkpLocation WHERE LocationDesc = 
			                  (CASE WHEN s.PAROLEUNIT in ('San Jose 3', 'San Jose 5', 'San Jose 7') THEN 'San Jose 3, 5, 7'
						            WHEN s.PAROLEUNIT in ('San Jose 1', 'San Jose 2') THEN 'San Jose 1&2'
			                        WHEN s.PAROLEUNIT = 'Contra Costa 1' THEN 'Concord 1'
									WHEN s.PAROLEUNIT = 'Contra Costa 2' THEN 'Concord 2'
			                        WHEN s.PAROLEUNIT = 'Santa Rosa 2' THEN 'Santa Rosa'
									WHEN s.PAROLEUNIT = 'El Cajon' THEN 'El Cajon 1'
									WHEN s.PAROLEUNIT = 'Antelope Valley 1' THEN 'Ant Val 1'
		                            WHEN s.PAROLEUNIT = 'REG4 RIVERSIDE #2' THEN 'Riverside GPS'
									WHEN s.PAROLEUNIT = 'El Monte GPS 2' THEN 'El Monte GPS'
									WHEN s.PAROLEUNIT = 'Ind/Plm Spr GPS' THEN 'Indio Palm Springs GPS'
									WHEN s.PAROLEUNIT = 'East Bay' THEN 'Oakland 1' 
									WHEN s.PAROLEUNIT = 'Escondido 1' THEN 'Escondido' 
									WHEN s.PAROLEUNIT = 'ESCONDIDO #2' THEN 'Escondido 2'
									WHEN s.PAROLEUNIT = 'Fresno 3' THEN 'Fresno 2'
									WHEN s.PAROLEUNIT = 'CCTRP-Stockton' THEN 'CCTRP Stockton'
									WHEN s.PAROLEUNIT = 'CCTRP-Bakersfld' THEN 'CCTRP Bakersfield'
									WHEN s.PAROLEUNIT = 'CCTRP-Sacramento' THEN 'CCTRP Sacramento'
									WHEN s.PAROLEUNIT = 'CCTRP-SF Spring' THEN 'CCTRP-SF Springs'
									wHEN s.PAROLEUNIT = 'Hntgtn Park GPS' THEN 'Huntington Park GPS'
									WHEN s.PAROLEUNIT = 'MCRP - BUTTE' THEN 'MCRP Butte'
									WHEN s.PAROLEUNIT = 'MCRP-Kern' THEN 'MCRP Kern'
									WHEN s.PAROLEUNIT = 'MCRP-LA1' THEN 'MCRP Los Angeles 1'
									WHEN s.PAROLEUNIT = 'MCRP-LA2' THEN 'MCRP Los Angeles 2'
									WHEN s.PAROLEUNIT = 'MCRP-LA3' THEN 'MCRP Los Angeles 3'
									WHEN s.PAROLEUNIT = 'Salinas 1' THEN 'Salinas 1 GPS'
									WHEN s.PAROLEUNIT = 'San Bern 1' THEN 'San Bernardino 1'
									WHEN s.PAROLEUNIT = 'San Bern 2' THEN 'San Bernardino 2'
									WHEN s.PAROLEUNIT = 'San Berdo GPS 1' THEN 'San Bernardino GPS'
									ELSE s.PAROLEUNIT END )), GetDate(),
			   (CASE WHEN s.Unit = 'PRCCF' OR s.Unit ='PUCCF' THEN 
		                          (select TOP 1 FacilityID from tlkpFacility where OrgCommonID = s.Unit and Disabled <> 1 and SomsLoc = s.Loc )
                                     ELSE (select top 1 FacilityID from tlkpFacility where OrgCommonID = s.Unit and Disabled <> 1) END),
				SomsUploadID = @SomsUploadId
			  FROM [BassWeb].dbo.SomsRecord s Left Outer Join Episode e on s.CDCNumber = e.CDCRNum
			      inner join Offender o on s.SomsOffenderID = o.PID
		     where s.somsuploadId = @SomsUploadId and e.CDCRNum is null
   SET @RowCount = convert(nvarchar(30),@@ROWCOUNT)
   IF @@ROWCOUNT = 0  
	 SET @ResultMessage = @ResultMessage +  char(13) + char(10) +   ' No new CDCR add to Episode table.'; 
   ELSE 
	  SET @ResultMessage = @ResultMessage + char(13) + char(10) + @RowCount + ' new cdcr have been added into Episode table.'; 

	  --insert episodeid to episodetrace table
	  INSERT INTO EpisodeTrace(EpisodeID, ClientEpisodeID, DateAction) 
SELECT t1.EpisodeID, t2.ClientEpisodeID, ISNULL(t2.DateAction, GetDate()) FROM Episode t1 left outer join 
(Select EpisodeID, ClientEpisodeID, DateAction FROM 
(SELECT EpisodeID, ClientEpisodeID, DateAction, 
        ROW_NUMBER() OVER (PARTITION BY EpisodeID ORDER BY ClientEpisodeID DESC) AS RowNum 
   FROM clientEpisode)e WHERE e.RowNum = 1) t2 ON t1.EpisodeID = t2.EpisodeID
  LEFT OUTER JOIN EpisodeTrace t3 ON t1.EpisodeID = t3.EpisodeID
WHERE t3.EpisodeID IS NULL

	DECLARE @ret varchar(max)
	--check missing PID
	IF EXISTS(select s.cdcnumber, s.somsoffenderid from [BassWeb].dbo.SomsRecord s left outer join offender e 
         on s.somsoffenderId = e.pid where s.somsuploadid = @SomsUploadId and e.pid is null)
	BEGIN
	   SET @ret = (select'['+
		stuff(
		 ( select ',{ "CDCR": "' + tb.cdcnumber + '", "PID": "' + convert(varchar, tb.somsoffenderid)
		  +'"}' from (select s.cdcnumber, s.somsoffenderid from [BassWeb].dbo.SomsRecord s left outer join offender e 
		on s.somsoffenderId = e.pid where s.somsuploadid = @SomsUploadId and e.pid is null ) tb  for XML Path('')
		 ),1,1,'' ) +']')
       SET @ResultMessage = @ResultMessage + char(13) + char(10) + 'Looking into DB for the following missing PID:'
	   SET @ResultMessage = @ResultMessage + char(13) + char(10) + @ret
 	END 

	--check missing CDCR
	IF EXISTS(select s.cdcnumber, s.somsoffenderid from [BassWeb].dbo.SomsRecord s left outer join episode e 
                  on s.cdcnumber = e.cdcrnum where s.somsuploadid = @SomsUploadId and e.cdcrnum is null)
	BEGIN
	   SET @ret = (select'['+
		stuff(
		 ( select ',{ "CDCR": "' + tb.cdcnumber + '", "PID": "' + convert(varchar, tb.somsoffenderid)
		  +'"}' from (select s.cdcnumber, s.somsoffenderid from [BassWeb].dbo.SomsRecord s left outer join episode e 
                  on s.cdcnumber = e.cdcrnum where s.somsuploadid = @SomsUploadId and e.cdcrnum is null) tb  for XML Path('')
		 ),1,1,'' ) +']')
	  SET @ResultMessage = @ResultMessage + char(13) + char(10) + 'Looking into DB for the following missing CDCR:'
      SET @ResultMessage = @ResultMessage + char(13) + char(10) + @ret
 	END 
	--check duplicate PID
	IF EXISTS(select OffenderID, PID from 
	(select OffenderID, PID, ROW_NUMBER() OVER(PARTITION BY PID ORDER BY OffenderID DESC) as RowNum from Offender ) d
	where d.RowNum > 1 AND d.PID > 0)
	BEGIN
	SET @ret = (select'['+
		stuff(
		 ( select ',{ "OffenderID": "' + convert(varchar, tb.OffenderID) + '", "PID": "' + convert(varchar, tb.PID)
		  +'"}' from (select OffenderID, PID from 
	(select OffenderID, PID, ROW_NUMBER() OVER(PARTITION BY PID ORDER BY OffenderID DESC) as RowNum from Offender ) d
	where d.RowNum > 1 AND d.PID > 0) tb  for XML Path('')
		 ),1,1,'' ) +']')
		select @ret
	  SET @ResultMessage = @ResultMessage + char(13) + char(10) + 'Looking into DB for the following duplicated PID:'
      SET @ResultMessage = @ResultMessage + char(13) + char(10) + @ret
	END

	--check duplicate CDCR
	IF EXISTS(select OffenderID, CDCRNum from 
	(select OffenderID, CDCRNum, ROW_NUMBER() OVER(PARTITION BY CDCRNum ORDER BY EpisodeID DESC) as RowNum from Episode ) d
	where d.RowNum > 1)
	BEGIN
	SET @ret = (select'['+
		stuff(
		 ( select ',{ "OffenderID": "' + convert(varchar, tb.OffenderID) + '", "CDCR": "' + tb.CDCRNum
		  +'"}' from (select OffenderID, CDCRNum from 
	(select OffenderID, CDCRNum, ROW_NUMBER() OVER(PARTITION BY CDCRNum ORDER BY EpisodeID DESC) as RowNum from Episode ) d
	where d.RowNum > 1) tb  for XML Path('')
		 ),1,1,'' ) +']')
		select @ret
	  SET @ResultMessage = @ResultMessage + char(13) + char(10) + 'Looking into DB for the following duplicated CDCR:'
      SET @ResultMessage = @ResultMessage + char(13) + char(10) + @ret
	END

	UPDATE EpisodeTrace SET IsLastOne = null

	UPDATE tgr SET IsLastOne = 1
	FROM EpisodeTrace tgr INNER JOIN
	(SELECT EpisodeID FROM
	(SELECT EpisodeID, ROW_NUMBER() OVER (PARTITION BY OffenderID ORDER BY EpisodeID DESC)rum FROM Episode)e WHERE e.rum =1)scr ON tgr.EpisodeID  = scr.EpisodeID

	SET @ResultMessage = @ResultMessage + char(13) + char(10) + 'Import Completed.'
End
GO
GRANT EXECUTE ON [dbo].[spImportSomsRecordToPats] to [ACCOUNTS\Svc_CDCRBASSSQLWte]
GO
GRANT EXECUTE ON [dbo].[spImportSomsRecordToPats] to [ACCOUNTS\Svc_CDCRPATSUser]
GO
