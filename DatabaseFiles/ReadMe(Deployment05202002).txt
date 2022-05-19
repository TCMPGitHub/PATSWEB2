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