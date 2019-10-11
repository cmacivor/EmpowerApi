USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwAdmissionRelease]    Script Date: 03/14/2016 13:31:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View dbo.vwAdmissionRelease    Script Date: 12/6/2005 2:46:51 PM ******/
CREATE VIEW [dbo].[vwAdmissionRelease]
AS
SELECT TOP (100) PERCENT 
	C.PersonID as JuvenileID, 
	P.Lastname as LName, 
	P.FirstName as FName, 
	P.MiddleName as MName, 
    U.Name as SufName, 
    B.Name as RaceID, 
    G.Name as Gender, 
    P.SSN, 
    (SELECT VCCCode + ', ' FROM Offense INNER JOIN PlacementOffense ON PlacementOffense.OffenseID = Offense.ID WHERE PlacementOffense.PlacementID = R.ID
	FOR XML PATH('')) AS Offenses,
    --dbo.fnOffenseList(R.ID, '') AS Offenses,
    dbo.fnFamilyMember(C.PersonID, 'M', '') AS Mother, 
    dbo.fnFamilyMember(C.PersonID, 'F', '') AS Father, 
    dbo.fnFamilyMember(C.PersonID, 'G', '') AS Guardian, 
    dbo.fnFamilyMemberPhone(C.PersonID, 'F', '') AS FatherPhone, 
    dbo.fnFamilyMemberPhone(C.PersonID, 'M', '') AS MotherPhone, 
    dbo.fnFamilyMemberPhone(C.PersonID, 'G', '') AS GuardianPhone, 
    dbo.fnFamilyMemberSSN(C.PersonID, 'F', '') AS FatherSSN, 
    dbo.fnFamilyMemberSSN(C.PersonID, 'M', '') AS MotherSSN, 
    dbo.fnFamilyMemberMarital(C.PersonID, 'F', '') AS FatherMarital, 
    dbo.fnFamilyMemberMarital(C.PersonID, 'M', '') AS MotherMarital, 
	dbo.fnGetPersonAddress(P.ID, 1, 1, '') AS HomeAddrID,
    dbo.fnGetPersonAddress(P.ID, 1, 1, '') AS StAddrID,
    '' as CareOf, 
    dbo.fnGetPersonAddress(P.ID, 1, 7, '') AS POBox,
    '' as RuralRoute, 
    dbo.fnGetPersonAddress(P.ID, 1, 4, '') AS City,
    dbo.fnGetPersonAddress(P.ID, 1, 5, '') AS State,
    dbo.fnGetPersonAddress(P.ID, 1, 6, '') AS Zip,
    dbo.fnGetPersonAddress(P.ID, 1, 1, '') AS AddrID, 
    dbo.fnGetPersonAddress(P.ID, 1, 1, '') AS Cor_Addr_Num, 
    '' as Building_Num, 
    '' as Bd_Num_Suffix, 
    '' as St_Direction, 
    '' as Nomenclature, 
    '' as Extended_Type, 
    '' as Extended_Num, 
	P.DOB as DOB, 
    L.POB as POB, 
    S.ID as StaffID, 
    S.Phone as Phone, 
    S.Agency as Agency, 
    S.LastName AS CLName, 
    S.FirstName AS CFName, 
    CONVERT(int, DATEDIFF(d, P.DOB, GETDATE()) / 365.25) AS Age, 
    D.PodRoom, 
    D.Religion, 
    D.HealthAtIntake, 
    D.Pregnant, 
    D.DueDate, 
    D.Hospital, 
    D.Physician, 
    D.PhyAddr, 
    D.PhyPhone, 
    D.Dentist, 
    D.DentAddr, 
    D.DentPhone, 
    D.MedInsurance, 
    D.PlacingAgency, 
    D.CSU, 
    E.CounselorID, 
    E.BeginDate as BeginDt, 
    E.EndDate as EndDt, 
    D.Attorney, 
    D.AdmRemarks, 
    D.ReleasedBy, 
    D.ReleasedTo, 
    D.FwdAddr1, 
    D.FwdAddr2, 
    D.FwdPhone, 
    D.LivingWith, 
    D.LivingWithRel, 
    D.EmerContact, 
    D.EmerContactRel, 
    D.EmerContactAddr, 
    D.EmerContactPhone, 
    E.PlacementID as ReferralID, 
    E.ID as RefServID, 
    L.HomePhone, 
    D.CurrMedication, 
    D.ScarsMarks, 
    L.HasMedicaid as Medicaid, 
    L.HasInsurance as Insurance, 
    L.HairColor as HairColor, 
    L.EyeColor as EyeColor, 
    L.HeightFt, 
    L.HeightIn, 
    L.Weight, 
    dbo.fnDetCount(C.ID, '') AS DetCount, 
    dbo.fnGetPersonAddress(P.ID, 1, 2, '') AS  Street_Name, 
    D.SchoolAtIntake, 
    E.ServiceProgramCategoryID as ServiceProfileID, 
    dbo.fnStaffName(D.AdmittedBy, '') AS AdmittedByName, 
    J.Name as JobTitle, 
    AT.AdmitId, 
    AT.AdmitDesc, 
    WD.WardID, 
    WD.WardDesc, 
    ED.ID as EducID, 
    ED.Name as EducLevelCd, 
    DC.DetCodeID, 
    DC.DetCodeDesc, 
    Sc.ID as SchoolID, 
    Sc.Name as School, 
    Sc.Phone AS SchoolPhone, 
    Sc.Address as Address, 
    Sc.Zip AS SchoolZip, 
    D.GradeAtIntake, 
    D.RelToAddr1, 
    D.RelToAddr2, 
    dbo.fnStaffName(D.ReleasedBy, '') AS RelName, 
    D.AdmittedBy, 
    RC.Text, 
    dbo.fnProbationOfficer(D.PO, '') AS PO, 
    dbo.fnFamilyMemberAddrID(P.ID, 'M', '') AS MoAddrID, 
    dbo.fnFamilyMemberAddrID(P.ID, 'F', '') AS FaAddrID, 
    dbo.fnFamilyMemberAddrID(P.ID, 'G', '') AS GuAddrID
FROM     dbo.Person             AS P INNER JOIN
		 dbo.ClientProfile      AS C ON P.ID = C.PersonID LEFT OUTER JOIN
		 dbo.Suffix             AS U ON P.SuffixID = U.ID LEFT OUTER JOIN
		 dbo.Gender             AS G ON P.GenderID = G.ID LEFT OUTER JOIN
		 dbo.Race               AS B ON P.RaceID = B.ID   INNER JOIN
		 dbo.Placement          AS R ON C.ID = R.ClientProfileID INNER JOIN
		 dbo.Enrollment         AS E ON E.PlacementID = R.ID LEFT OUTER JOIN
		 dbo.Staff              AS S ON S.ID = E.SourceID LEFT OUTER JOIN
		 dbo.ServiceRelease     AS F ON E.ServiceReleaseID = F.ID LEFT OUTER JOIN
		 dbo.PersonSupplemental AS L ON C.ID = L.ID LEFT OUTER JOIN
		 dbo.tblDetentionSupp   AS D ON E.ID = D.RefServID LEFT OUTER JOIN
		 dbo.tblReleaseCodes    AS RC ON D.ReleasedToCode = RC.RelID LEFT OUTER JOIN
		 dbo.EducationLevel		AS ED ON L.EducationLevelID = Ed.ID LEFT OUTER JOIN
		 dbo.School	 		    AS Sc ON L.SchoolID = Sc.ID LEFT OUTER JOIN
		 dbo.JobTitle			AS J ON S.JobTitleID = J.ID LEFT OUTER JOIN
         dbo.tblAdmissionTypes  AS AT ON D.AdmitOnPaper = AT.AdmitId LEFT OUTER JOIN
		 dbo.tblWards			AS WD ON D.WardOf = WD.WardID LEFT OUTER JOIN
		 dbo.tblDetentionCodes  AS DC ON D.DetCd = DC.DetCodeID 
WHERE   E.ServiceProgramCategoryID IN (15, 55) -- Post-D and Detention

GO


/*

CREATE VIEW [dbo].[vwAdmissionRelease]
AS
SELECT     TOP 100 PERCENT dbo.tblJuvenileProfile.JuvenileID, dbo.tblJuvenileProfile.LName, dbo.tblJuvenileProfile.FName, dbo.tblJuvenileProfile.MName, 
                      dbo.tblJuvenileProfile.SufName, dbo.tblJuvenileProfile.RaceID, dbo.tblJuvenileProfile.Gender, dbo.tblJuvenileProfile.SSN, 
                      dbo.fnParceOffenses(dbo.tblReferral.PlacementCharges, '') AS Offenses, dbo.fnFamilyMember(dbo.tblJuvenileProfile.JuvenileID, 'M', '') AS Mother, 
                      dbo.fnFamilyMember(dbo.tblJuvenileProfile.JuvenileID, 'F', '') AS Father, dbo.fnFamilyMember(dbo.tblJuvenileProfile.JuvenileID, 'G', '') AS Guardian, 
                      dbo.fnFatherPhone(dbo.tblJuvenileProfile.JuvenileID, 'F', '') AS FatherPhone, dbo.fnMotherPhone(dbo.tblJuvenileProfile.JuvenileID, 'M', '') 
                      AS MotherPhone, dbo.fnGuardianPhone(dbo.tblJuvenileProfile.JuvenileID, 'G', '') AS GuardianPhone, 
                      dbo.fnFatherSSN(dbo.tblJuvenileProfile.JuvenileID, 'F', '') AS FatherSSN, dbo.fnMotherSSN(dbo.tblJuvenileProfile.JuvenileID, 'M', '') AS MotherSSN, 
                      dbo.fnFatherMarital(dbo.tblJuvenileProfile.JuvenileID, 'F', '') AS FatherMarital, dbo.fnMotherMarital(dbo.tblJuvenileProfile.JuvenileID, 'M', '') 
                      AS MotherMarital, dbo.tblAddress.AddrID AS HomeAddrID, dbo.tblAddress.StAddrID, dbo.tblAddress.CareOf, dbo.tblAddress.POBox, dbo.tblAddress.RuralRoute, 
                      dbo.tblAddress.City, dbo.tblAddress.State, dbo.tblAddress.Zip, dbo.tblAddress.AddrID, dbo.tblAddressOut.Cor_Addr_Num, 
                      dbo.tblAddressOut.Building_Num, dbo.tblAddressOut.Bd_Num_Suffix, dbo.tblAddressOut.St_Direction, dbo.tblAddressOut.Nomenclature, 
                      dbo.tblAddressOut.Extended_Type, dbo.tblAddressOut.Extended_Num, dbo.tblJuvenileProfile.DOB, dbo.tblJuvSupp.POB, dbo.tblStaff.StaffID, 
                      dbo.tblStaff.Phone, dbo.tblStaff.Agency, dbo.tblStaff.LName AS CLName, dbo.tblStaff.FName AS CFName, CONVERT(int, DATEDIFF(d, 
                      dbo.tblJuvenileProfile.DOB, GETDATE()) / 365.25) AS Age, dbo.tblDetentionSupp.PodRoom, dbo.tblDetentionSupp.Religion, 
                      dbo.tblDetentionSupp.HealthAtIntake, dbo.tblDetentionSupp.Pregnant, dbo.tblDetentionSupp.DueDate, dbo.tblDetentionSupp.Hospital, 
                      dbo.tblDetentionSupp.Physician, dbo.tblDetentionSupp.PhyAddr, dbo.tblDetentionSupp.PhyPhone, dbo.tblDetentionSupp.Dentist, 
                      dbo.tblDetentionSupp.DentAddr, dbo.tblDetentionSupp.DentPhone, dbo.tblDetentionSupp.MedInsurance, dbo.tblDetentionSupp.PlacingAgency, 
                      dbo.tblDetentionSupp.CSU, dbo.tblRefServices.CounselorID, dbo.tblRefServices.BeginDt, dbo.tblRefServices.EndDt, dbo.tblDetentionSupp.Attorney, 
                      dbo.tblDetentionSupp.AdmRemarks, dbo.tblDetentionSupp.ReleasedBy, dbo.tblDetentionSupp.ReleasedTo, dbo.tblDetentionSupp.FwdAddr1, 
                      dbo.tblDetentionSupp.FwdAddr2, dbo.tblDetentionSupp.FwdPhone, dbo.tblDetentionSupp.LivingWith, dbo.tblDetentionSupp.LivingWithRel, 
                      dbo.tblDetentionSupp.EmerContact, dbo.tblDetentionSupp.EmerContactRel, dbo.tblDetentionSupp.EmerContactAddr, 
                      dbo.tblDetentionSupp.EmerContactPhone, dbo.tblReferral.ReferralID, dbo.tblRefServices.RefServID, dbo.tblJuvSupp.HomePhone, 
                      dbo.tblDetentionSupp.CurrMedication, dbo.tblDetentionSupp.ScarsMarks, dbo.tblJuvSupp.Medicaid, dbo.tblJuvSupp.Insurance, 
                      dbo.tblJuvSupp.HairColor, dbo.tblJuvSupp.EyeColor, dbo.tblJuvSupp.HeightFt, dbo.tblJuvSupp.HeightIn, dbo.tblJuvSupp.Weight, 
                      dbo.fnDetCount(dbo.tblReferral.JuvenileID, '') AS DetCount, dbo.tblAddressOut.Street_Name, dbo.tblDetentionSupp.SchoolAtIntake, 
                      dbo.tblRefServices.ServiceProfileID, dbo.fnStaffName(dbo.tblDetentionSupp.AdmittedBy, '') AS AdmittedByName, dbo.tblStaff.JobTitle, 
                      dbo.tblAdmissionTypes.AdmitId, dbo.tblAdmissionTypes.AdmitDesc, dbo.tblWards.WardID, dbo.tblWards.WardDesc, dbo.tblEducLevel.EducID, 
                      dbo.tblEducLevel.EducLevelCd, dbo.tblDetentionCodes.DetCodeID, dbo.tblDetentionCodes.DetCodeDesc, dbo.tblSchools.SchoolID, 
                      dbo.tblSchools.School, dbo.tblSchools.Phone AS SchoolPhone, dbo.tblSchools.Address, dbo.tblSchools.Zip AS SchoolZip, 
                      dbo.tblDetentionSupp.GradeAtIntake, dbo.tblDetentionSupp.RelToAddr1, dbo.tblDetentionSupp.RelToAddr2, 
                      dbo.fnStaffName(dbo.tblDetentionSupp.ReleasedBy, '') AS RelName, dbo.tblDetentionSupp.AdmittedBy, dbo.tblReleaseCodes.Text, 
                      dbo.fnProbationOfficer(dbo.tblDetentionSupp.PO, '') AS PO, dbo.fnMotherAddrID(dbo.tblJuvenileProfile.JuvenileID, 'M', '') AS MoAddrID, 
                      dbo.fnFatherAddrID(dbo.tblJuvenileProfile.JuvenileID, 'F', '') AS FaAddrID, dbo.fnGuardianAddrID(dbo.tblJuvenileProfile.JuvenileID, 'G', '') 
                      AS GuAddrID
FROM         dbo.tblStaff RIGHT OUTER JOIN
                      dbo.tblSchools RIGHT OUTER JOIN
                      dbo.tblDetentionSupp ON dbo.tblSchools.SchoolID = dbo.tblDetentionSupp.SchoolAtIntake LEFT OUTER JOIN
                      dbo.tblDetentionCodes ON dbo.tblDetentionSupp.DetCd = dbo.tblDetentionCodes.DetCodeID LEFT OUTER JOIN
                      dbo.tblEducLevel ON dbo.tblDetentionSupp.GradeAtIntake = dbo.tblEducLevel.EducID LEFT OUTER JOIN
                      dbo.tblReleaseCodes ON dbo.tblDetentionSupp.ReleasedToCode = dbo.tblReleaseCodes.RelID LEFT OUTER JOIN
                      dbo.tblWards ON dbo.tblDetentionSupp.WardOf = dbo.tblWards.WardID LEFT OUTER JOIN
                      dbo.tblAdmissionTypes ON dbo.tblDetentionSupp.AdmitOnPaper = dbo.tblAdmissionTypes.AdmitId RIGHT OUTER JOIN
                      dbo.tblJuvenileProfile INNER JOIN
                      dbo.tblRefServices INNER JOIN 
                      dbo.tblReferral ON dbo.tblRefServices.ReferralID = dbo.tblReferral.ReferralID ON 
                      dbo.tblJuvenileProfile.JuvenileID = dbo.tblReferral.JuvenileID LEFT OUTER JOIN
                      dbo.tblJuvSupp LEFT OUTER JOIN
                      dbo.tblAddressOut RIGHT OUTER JOIN
                      dbo.tblAddress ON dbo.tblAddressOut.Cor_Addr_Num = dbo.tblAddress.StAddrID INNER JOIN
					  dbo.tblXRefAddress ON dbo.tblXRefAddress.AddrID = dbo.tblAddress.AddrID ON dbo.tblXRefAddress.XRefAddrID = dbo.tblJuvSupp.HomeAddrID AND dbo.tblXRefAddress.AddrTypeID = 1
--                      dbo.tblAddress ON dbo.tblAddressOut.Cor_Addr_Num = dbo.tblAddress.StAddrID ON dbo.tblJuvSupp.HomeAddrID = dbo.tblAddress.AddrID ON 
                      ON dbo.tblJuvenileProfile.JuvenileID = dbo.tblJuvSupp.JuvenileID ON dbo.tblDetentionSupp.RefServID = dbo.tblRefServices.RefServID ON 
                      dbo.tblStaff.StaffID = dbo.tblRefServices.CounselorID
WHERE     (dbo.tblRefServices.ServiceProfileID in (57, 184))

GO
*/

USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwCommunications]    Script Date: 04/07/2016 13:49:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  View dbo.vwCommunications    Script Date: 12/6/2005 2:46:52 PM ******/
CREATE VIEW [dbo].[vwCommunications]
AS
SELECT TOP 100 PERCENT 
	dbo.Placement.ClientProfileID as JuvenileID, 
	dbo.Enrollment.ID as RefServID, 
	dbo.Enrollment.ServiceProgramCategoryID as ServiceProfileID, 
	dbo.tblDetentionSupp.PodRoom, 
    CONVERT(varchar(11), dbo.tblCommLog.CommDate, 101) AS CommDate, 
    CONVERT(varchar(11), dbo.tblCommLog.CommDate, 108) AS CommTime, 
    dbo.tblCommLog.ContactType AS TypeOfContact, 
    dbo.tblCommLog.Visitor, 
    dbo.tblCommLog.StaffID, 
    dbo.Staff.ID AS Expr1, 
    dbo.Staff.Agency, 
    dbo.Staff.LastName as LName, 
    dbo.Staff.FirstName as FName, 
    rtrim(Staff.LastName) + ', ' + rtrim(Staff.FirstName) AS FullName
FROM   
    dbo.Placement RIGHT OUTER JOIN
    dbo.Enrollment ON dbo.Placement.ID = dbo.Enrollment.PlacementID LEFT OUTER JOIN
    dbo.tblCommLog ON tblCommLog.RefServID = Enrollment.ID LEFT OUTER JOIN
    dbo.Staff ON dbo.tblCommLog.StaffID = dbo.Staff.ID LEFT OUTER JOIN
    dbo.tblDetentionSupp ON dbo.Enrollment.ID = dbo.tblDetentionSupp.RefServID
WHERE
    Enrollment.ServiceProgramCategoryID IN (15, 55) -- Post-D and Detention

GO
/* USE [JJSCaseMgt] */
USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetAdmission]    Script Date: 07/07/2015 18:33:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  View dbo.vwDetAdmission    Script Date: 12/6/2005 2:46:52 PM ******/
CREATE VIEW [dbo].[vwDetAdmission]
AS

SELECT
       D.RefServID, D.DetCd, D.PodRoom, D.PlacingAgency, D.ReleasedBy, D.ReleasedTo, D.LivingWith,
       D.SchoolAtIntake, D.GradeAtIntake, D.MaritalStatus, D.ScarsMarks, D.Religion, D.AuthPhoneNo,
       D.PrevDet, D.Attorney, D.CSU, D.WardOf, D.AdmitOnPaper, D.AdmRemarks, D.FwdAddr1, D.FwdAddr2,
       D.FwdPhone,
       F.Name AS School,
       E.BeginDate AS BeginDt, E.EndDate AS EndDt, E.ID AS RSRefServID, E.PlacementID AS RSReferralID,
       E.PlacementID AS ReferralID, 
       C.PersonID AS JuvenileID,
       R.NextCourtDate AS NextCourtDt,
       Y.ID AS StaffID, Y.LastName AS LName, Y.FirstName AS FName,
       Q.DetCodeID, Q.DetCodeDesc,
       D.GradeAtIntake AS EducID,
       U.Name AS EducLevelCd,
       W.WardID, W.WardDesc,
       F.ID as SchoolID,
       dbo.fnDetCount(R.ClientProfileID, '') AS DetCount, /* ? not returning value */
       E.SourceID AS RefSourceID,
       D.AgeAtIntake, D.ReleasedToCode,
       E.ServiceReleaseID AS ReleaseID,
       D.CreatedBy, D.Gang, D.ParentCalled, D.TimeParentCalled, D.RelToAddr1, D.RelToAddr2, D.EmerContact,
       D.EmerContactRel, D.EmerContactAddr, D.EmerContactPhone, D.LivingWithRel, D.AdmittedBy,
       dbo.fnStaffName(D.AdmittedBy, '') AS AdmittedByName, 
       P.DOB,
       S.Name AS SchoolSupp,
       T.Name AS GradeSupp,
       D.PO,
       dbo.fnStaffName(E.SourceID, '') AS RefSourceName,       
       dbo.fnStaffPhone(E.SourceID, '') AS RefSourcePhone,
       dbo.fnStaffName(D.PO, '') AS POName, 
       dbo.fnStaffPhone(D.PO, '') AS POPhone,
	   dbo.fnFamilyMember(R.ClientProfileID, 'M', '') AS Mother,   /* ? not returning value */
       dbo.fnFamilyMember(R.ClientProfileID, 'F', '') AS Father,   /* ? not returning value */
	   dbo.fnFamilyMember(R.ClientProfileID, 'G', '') AS Guardian  /* ? not returning value */   
FROM
     dbo.ClientProfile      AS C LEFT OUTER JOIN
     dbo.Person             AS P ON C.PersonID = P.ID LEFT OUTER JOIN
     dbo.PersonSupplemental AS L ON P.ID = L.PersonID LEFT OUTER JOIN
     dbo.Placement          AS R ON C.ID = R.ClientProfileID LEFT OUTER JOIN
     dbo.Enrollment         AS E ON R.ID = E.PlacementID LEFT OUTER JOIN
     dbo.tblDetentionSupp   AS D ON E.ID = D.RefServID LEFT OUTER JOIN
     dbo.tblAdmissionTypes  AS M ON D.AdmitOnPaper = M.AdmitId LEFT OUTER JOIN
     dbo.tblWards           AS W ON D.WardOf = W.WardID LEFT OUTER JOIN
     dbo.EducationLevel     AS T ON L.EducationLevelID = T.ID LEFT OUTER JOIN
     dbo.EducationLevel     AS U ON D.GradeAtIntake = U.ID LEFT OUTER JOIN
     dbo.tblDetentionCodes  AS Q ON D.DetCd = Q.DetCodeID LEFT OUTER JOIN
     dbo.Staff              AS Y ON D.ReleasedBy = Y.ID LEFT OUTER JOIN
     dbo.School             AS F ON D.SchoolAtIntake = F.ID LEFT OUTER JOIN
     dbo.School             AS S ON L.SchoolID = S.ID /* LEFT OUTER JOIN */
GO
/*
SELECT dbo.tblDetentionSupp.RefServID, 
       dbo.tblDetentionSupp.DetCd, 
       dbo.tblDetentionSupp.PodRoom, 
       dbo.tblDetentionSupp.PlacingAgency, 
       dbo.tblDetentionSupp.ReleasedBy, 
       dbo.tblDetentionSupp.ReleasedTo, 
       dbo.tblDetentionSupp.LivingWith, 
       dbo.tblDetentionSupp.SchoolAtIntake, 
       dbo.tblDetentionSupp.GradeAtIntake, 
       dbo.tblDetentionSupp.MaritalStatus, 
       dbo.tblDetentionSupp.ScarsMarks, 
       dbo.tblDetentionSupp.Religion, 
       dbo.tblDetentionSupp.AuthPhoneNo, 
       dbo.tblDetentionSupp.PrevDet, 
       dbo.tblDetentionSupp.Attorney, 
       dbo.tblDetentionSupp.CSU, 
       dbo.tblDetentionSupp.WardOf, 
       dbo.tblDetentionSupp.AdmitOnPaper, 
       dbo.tblDetentionSupp.AdmRemarks, 
       dbo.tblDetentionSupp.FwdAddr1, 
       dbo.tblDetentionSupp.FwdAddr2, 
       dbo.tblDetentionSupp.FwdPhone, 
       dbo.tblSchools.School, 
       dbo.tblRefServices.BeginDt, 
       dbo.tblRefServices.EndDt, 
       dbo.tblRefServices.RefServID AS RSRefServID, 
       dbo.tblRefServices.ReferralID AS RSReferralID, 
       dbo.tblReferral.ReferralID, dbo.tblReferral.JuvenileID, 
       dbo.tblReferral.NextCourtDt, 
       dbo.tblStaff.StaffID, 
       dbo.tblStaff.LName, 
       dbo.tblStaff.FName, 
       dbo.tblDetentionCodes.DetCodeID, 
       dbo.tblDetentionCodes.DetCodeDesc, 
       dbo.tblEducLevel.EducID, 
       dbo.tblEducLevel.EducLevelCd, 
       dbo.tblWards.WardID, 
       dbo.tblWards.WardDesc, 
       dbo.tblSchools.SchoolID, 
       dbo.fnDetCount(dbo.tblReferral.JuvenileID, '') AS DetCount, 
       dbo.tblRefServices.RefSourceID, 
       dbo.tblDetentionSupp.AgeAtIntake, 
       dbo.tblDetentionSupp.ReleasedToCode, 
       dbo.tblRefServices.ReleaseID, 
       dbo.tblDetentionSupp.CreatedBy, 
       dbo.tblDetentionSupp.Gang, 
       dbo.tblDetentionSupp.ParentCalled, 
       dbo.tblDetentionSupp.TimeParentCalled, 
       dbo.tblDetentionSupp.RelToAddr1, 
       dbo.tblDetentionSupp.RelToAddr2, 
       dbo.tblDetentionSupp.EmerContact, 
       dbo.tblDetentionSupp.EmerContactRel, 
       dbo.tblDetentionSupp.EmerContactAddr, 
       dbo.tblDetentionSupp.EmerContactPhone, 
       dbo.tblDetentionSupp.LivingWithRel, 
       dbo.tblDetentionSupp.AdmittedBy, 
       dbo.fnStaffName(dbo.tblDetentionSupp.AdmittedBy, '') AS AdmittedByName, 
       dbo.tblJuvenileProfile.DOB, 
       dbo.tblJuvSupp.SchoolID AS SchoolSupp, 
       dbo.tblJuvSupp.EducLevelCD AS GradeSupp, 
       dbo.tblDetentionSupp.PO, 
       dbo.fnStaffName(dbo.tblRefServices.RefSourceID, '') AS RefSourceName, 
       dbo.fnStaffPhone(dbo.tblRefServices.RefSourceID, '') AS RefSourcePhone, 
       dbo.fnStaffName(dbo.tblDetentionSupp.PO, '') AS POName, 
       dbo.fnStaffPhone(dbo.tblDetentionSupp.PO, '') AS POPhone,
	   dbo.fnFamilyMember(tblJuvenileProfile.JuvenileID, 'M', '') AS Mother, 
       dbo.fnFamilyMember(tblJuvenileProfile.JuvenileID, 'F', '') AS Father, 
	   dbo.fnFamilyMember(tblJuvenileProfile.JuvenileID, 'G', '') AS Guardian
FROM dbo.tblJuvenileProfile LEFT OUTER JOIN
     dbo.tblJuvSupp         ON dbo.tblJuvenileProfile.JuvenileID = dbo.tblJuvSupp.JuvenileID RIGHT OUTER JOIN
     dbo.tblReferral        ON dbo.tblJuvenileProfile.JuvenileID = dbo.tblReferral.JuvenileID RIGHT OUTER JOIN
     dbo.tblDetentionSupp   INNER JOIN
     dbo.tblRefServices     ON dbo.tblDetentionSupp.RefServID = dbo.tblRefServices.RefServID LEFT OUTER JOIN
     dbo.tblAdmissionTypes  ON dbo.tblDetentionSupp.AdmitOnPaper = dbo.tblAdmissionTypes.AdmitId LEFT OUTER JOIN
     dbo.tblWards           ON dbo.tblDetentionSupp.WardOf = dbo.tblWards.WardID LEFT OUTER JOIN
     dbo.tblEducLevel       ON dbo.tblDetentionSupp.GradeAtIntake = dbo.tblEducLevel.EducID LEFT OUTER JOIN
     dbo.tblDetentionCodes  ON dbo.tblDetentionSupp.DetCd = dbo.tblDetentionCodes.DetCodeID LEFT OUTER JOIN
     dbo.tblStaff           ON dbo.tblDetentionSupp.ReleasedBy = dbo.tblStaff.StaffID ON dbo.tblReferral.ReferralID = dbo.tblRefServices.ReferralID LEFT OUTER JOIN
     dbo.tblSchools         ON dbo.tblDetentionSupp.SchoolAtIntake = dbo.tblSchools.SchoolID
GO
*/USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetCommLog]    Script Date: 03/11/2016 11:36:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View dbo.vwDetCommLog    Script Date: 12/6/2005 2:46:52 PM ******/
CREATE VIEW [dbo].[vwDetCommLog]
AS

SELECT     dbo.tblCommLog.CommLogID, dbo.tblCommLog.RefServID, dbo.tblCommLog.CommDate, dbo.tblCommLog.ContactType, dbo.tblCommLog.Visitor, 
           dbo.tblCommLog.StaffID, dbo.Staff.ID AS SStaffID, dbo.Staff.LastName as LName, dbo.Staff.FirstName as FName, 1 as Active, 
           dbo.fnStaffName(dbo.Staff.ID, '') AS FullName, dbo.tblCommLog.CreatedBy
FROM       dbo.tblCommLog LEFT OUTER JOIN
           dbo.Staff ON dbo.tblCommLog.StaffID = dbo.Staff.ID

GO
USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetDiscipLog]    Script Date: 03/11/2016 11:43:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  View dbo.vwDetDiscipLog    Script Date: 12/6/2005 2:46:52 PM ******/
CREATE VIEW [dbo].[vwDetDiscipLog]
AS

SELECT    dbo.tblDiscipLog.*, dbo.Staff.ID AS SStaffID, dbo.Staff.LastName AS LName, dbo.Staff.FirstName AS FName, 1 AS Active, 
          dbo.fnStaffName(dbo.Staff.ID, '') AS FullName, dbo.tblDetProblems.DetProbID AS DetProbID, 
          dbo.tblDetProblems.Text AS Text, dbo.tblDetProblems.IsoHours AS IsoHours, dbo.tblDetProblems.Severity AS Severity, 
          dbo.tblDiscipLog.CreatedBy AS Expr1
FROM      dbo.tblDetProblems INNER JOIN
          dbo.tblDiscipLog ON dbo.tblDetProblems.DetProbID = dbo.tblDiscipLog.Problem LEFT OUTER JOIN
          dbo.Staff ON dbo.tblDiscipLog.StaffID = dbo.Staff.ID

/*
SELECT     dbo.tblDiscipLog.*, dbo.tblStaff.StaffID AS SStaffID, dbo.tblStaff.LName AS LName, dbo.tblStaff.FName AS FName, dbo.tblStaff.Active AS Active, 
                      dbo.fnFullName(dbo.tblStaff.LName, dbo.tblStaff.FName, '') AS FullName, dbo.tblDetProblems.DetProbID AS DetProbID, 
                      dbo.tblDetProblems.Text AS Text, dbo.tblDetProblems.IsoHours AS IsoHours, dbo.tblDetProblems.Severity AS Severity, 
                      dbo.tblDiscipLog.CreatedBy AS Expr1
FROM         dbo.tblDetProblems INNER JOIN
                      dbo.tblDiscipLog ON dbo.tblDetProblems.DetProbID = dbo.tblDiscipLog.Problem LEFT OUTER JOIN
                      dbo.tblStaff ON dbo.tblDiscipLog.StaffID = dbo.tblStaff.StaffID

*/





GO


USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetentions]    Script Date: 02/08/2016 09:42:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  View dbo.vwDetentions    Script Date: 12/6/2005 2:46:53 PM ******/
CREATE VIEW [dbo].[vwDetentions]
AS

SELECT TOP (100) PERCENT E.ID as RefServID, 
                         D.DetCd, D.PodRoom, D.LivingWith, D.AgeAtIntake, D.AuthPhoneNo, 
                         E.PlacementID as ReferralID, E.BeginDate as BeginDt, E.EndDate as EndDt, E.CounselorID, 
                         C.ID as JuvenileID, 
                         P.LastName as LName, P.FirstName as FName, P.MiddleName as MName,
                         U.Name as SufName,
                         G.Name as Gender,
                         B.Description as RaceID,
                         P.DOB,
                         E.ServiceProgramCategoryID as ServiceProfileID, 
                         S.ID as StaffID, S.Phone AS CPhone, S.LastName AS CLName, S.FirstName AS CFName,
                         CONVERT(int, DATEDIFF(d, P.DOB, GETDATE()) / 365.25) AS Age,
                         CONVERT(int, DATEDIFF(d, P.DOB, GETDATE() + 10) / 365.25) AS Age2, 
                         '' as PlacementCharges, R.NextCourtDate as NextCourtDt, 
                         dbo.fnDateOnly(R.NextCourtDate, N'') AS NextCourtMDY, 
                         P.SSN, 
                         --dbo.fnParceOffenses('PlacementCharges', '') AS Offenses,
                         (SELECT VCCCode + ', ' FROM Offense INNER JOIN PlacementOffense ON PlacementOffense.OffenseID = Offense.ID WHERE PlacementOffense.PlacementID = R.ID
						 FOR XML PATH('')) AS Offenses,
                         --dbo.fnOffenseList(R.ID, '') AS Offenses,
                         dbo.fnFamilyMember(C.ID, 'M', '') AS Mother, 
                         dbo.fnFamilyMember(C.ID, 'F', '') AS Father, 
                         dbo.fnFamilyMember(C.ID, 'G', '') AS Guardian, 
                         dbo.fnFamilyMember(C.ID, 'O', '') AS Other,
                         dbo.fnGetPersonAddress(P.ID, 1, 1, '') AS HomeAddrID,
                         dbo.fnGetPersonAddress(P.ID, 1, 1, '') AS StAddrID,
                         dbo.fnGetPersonAddress(P.ID, 1, 4, '') AS City,
                         dbo.fnGetPersonAddress(P.ID, 1, 5, '') AS State,
                         dbo.fnGetPersonAddress(P.ID, 1, 6, '') AS Zip,
                         '' AS CareOf,
                         dbo.fnGetPersonAddress(P.ID, 1, 7, '') AS POBox,
                         '' AS RuralRoute,
                         '' AS Building_Num,
                         '' AS Bd_Num_Suffix,
                         '' AS St_Direction,
                         dbo.fnGetPersonAddress(P.ID, 1, 2, '')AS Street_Name,
                         '' As Nomenclature,
                         dbo.fnGetPersonAddress(P.ID, 1, 3, '')As Extended_Type,
                         '' AS Extended_Num,
                         L.POB, 
                         P.JTS, 
                         D.Gang, D.EmerContact, D.EmerContactRel, D.EmerContactAddr, D.EmerContactPhone, 
                         E.SourceID as RefSourceID, 
                         D.HiLite,
                         dbo.fnStaffName(D.AdmittedBy, '') AS AdmittedByName, 
                         dbo.fnProbationOfficer(D.PO, '') AS ProbOfficer, 
                         D.ReleasedToCode, 
                         '' AS ReleaseCodeText, 
                         E.ServiceReleaseID as ReleaseID, 
                         F.ExcludeFromEnrollmentCount
FROM dbo.Person             AS P INNER JOIN
     dbo.ClientProfile      AS C ON P.ID = C.PersonID LEFT OUTER JOIN
     dbo.Suffix             AS U ON P.SuffixID = U.ID LEFT OUTER JOIN
     dbo.Gender             AS G ON P.GenderID = G.ID LEFT OUTER JOIN
     dbo.Race               AS B ON P.RaceID = B.ID   LEFT OUTER JOIN
     dbo.Placement          AS R ON C.ID = R.ClientProfileID LEFT OUTER JOIN
     dbo.Enrollment         AS E ON E.PlacementID = R.ID LEFT OUTER JOIN
	 dbo.Staff              AS S ON S.ID = E.SourceID LEFT OUTER JOIN
     dbo.ServiceRelease     AS F ON E.ServiceReleaseID = F.ID LEFT OUTER JOIN
     dbo.PersonSupplemental AS L ON C.ID = L.ID LEFT OUTER JOIN
     dbo.tblDetentionSupp   AS D ON E.ID = D.RefServID
WHERE ((E.ServiceProgramCategoryID IN (15, 55, 59)) AND (F.ExcludeFromEnrollmentCount IS NULL) OR
      (E.ServiceProgramCategoryID IN (15, 55, 59)) AND (F.ExcludeFromEnrollmentCount = 0))
  AND R.Active = 1
  AND E.Active = 1 
ORDER BY P.LastName, P.FirstName
-- Post-D, Detention, Re-entry



/*
SELECT     TOP (100) PERCENT RS.RefServID, D.DetCd, D.PodRoom, D.LivingWith, D.AgeAtIntake, D.AuthPhoneNo, RS.ReferralID, RS.BeginDt, RS.EndDt, RS.CounselorID, 
                      J.JuvenileID, J.LName, J.FName, J.MName, J.SufName, J.Gender, J.RaceID, J.DOB, RS.ServiceProfileID, S.StaffID, S.Phone AS CPhone, S.LName AS CLName, 
                      S.FName AS CFName, CONVERT(int, DATEDIFF(d, J.DOB, GETDATE()) / 365.25) AS Age, CONVERT(int, DATEDIFF(d, J.DOB, GETDATE() + 10) / 365.25) AS Age2, 
                      R.PlacementCharges, R.NextCourtDt, dbo.fnDateOnly(R.NextCourtDt, N'') AS NextCourtMDY, J.SSN, dbo.fnParceOffenses(R.PlacementCharges, '') AS Offenses, 
                      dbo.fnFamilyMember(J.JuvenileID, 'M', '') AS Mother, dbo.fnFamilyMember(J.JuvenileID, 'F', '') AS Father, dbo.fnFamilyMember(J.JuvenileID, 'G', '') AS Guardian, 
                      dbo.fnFamilyMember(J.JuvenileID, 'O', '') AS Other, JS.HomeAddrID, dbo.tblAddress.StAddrID, dbo.tblAddress.City, dbo.tblAddress.State, dbo.tblAddress.Zip, 
                      dbo.tblAddress.CareOf, dbo.tblAddress.POBox, dbo.tblAddress.RuralRoute, dbo.tblAddressOut.Building_Num, dbo.tblAddressOut.Bd_Num_Suffix, 
                      dbo.tblAddressOut.St_Direction, dbo.tblAddressOut.Street_Name, dbo.tblAddressOut.Nomenclature, dbo.tblAddressOut.Extended_Type, 
                      dbo.tblAddressOut.Extended_Num, JS.POB, J.JTS, D.Gang, D.EmerContact, D.EmerContactRel, D.EmerContactAddr, D.EmerContactPhone, RS.RefSourceID, D.HiLite, 
                      dbo.fnStaffName(D.AdmittedBy, '') AS AdmittedByName, dbo.fnProbationOfficer(D.PO, '') AS ProbOfficer, D.ReleasedToCode, 
                      dbo.tblReleaseCodes.Text AS ReleaseCodeText, RS.ReleaseID, dbo.tblSrvRelease.ExcludeFromEnrollmentCount
FROM         dbo.tblStaff AS S RIGHT OUTER JOIN
                      dbo.tblJuvenileProfile AS J INNER JOIN
                      dbo.tblRefServices AS RS INNER JOIN
                      dbo.tblReferral AS R ON RS.ReferralID = R.ReferralID ON J.JuvenileID = R.JuvenileID LEFT OUTER JOIN
                      dbo.tblSrvRelease ON RS.ReleaseID = dbo.tblSrvRelease.ReleaseId ON S.StaffID = RS.RefSourceID LEFT OUTER JOIN
                      dbo.tblJuvSupp AS JS ON J.JuvenileID = JS.JuvenileID LEFT OUTER JOIN
                      dbo.tblAddressOut RIGHT OUTER JOIN
                      dbo.tblAddress ON dbo.tblAddressOut.Cor_Addr_Num = dbo.tblAddress.StAddrID INNER JOIN
                      dbo.tblXRefAddress ON dbo.tblXRefAddress.AddrID = dbo.tblAddress.AddrID ON JS.HomeAddrID = dbo.tblXRefAddress.XRefAddrID AND 
                      dbo.tblXRefAddress.AddrTypeID = 1 LEFT OUTER JOIN
                      dbo.tblReleaseCodes RIGHT OUTER JOIN
                      dbo.tblDetentionSupp AS D ON dbo.tblReleaseCodes.RelID = D.ReleasedToCode ON RS.RefServID = D.RefServID
WHERE     (RS.ServiceProfileID IN (57, 184, 204)) AND (dbo.tblSrvRelease.ExcludeFromEnrollmentCount IS NULL) OR
                      (RS.ServiceProfileID IN (57, 184, 204)) AND (dbo.tblSrvRelease.ExcludeFromEnrollmentCount = 0)
ORDER BY J.LName, J.FName
*/





GO


USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetFamily]    Script Date: 02/22/2016 12:28:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  View dbo.vwDetFamily    Script Date: 12/6/2005 2:46:52 PM ******/
CREATE VIEW [dbo].[vwDetFamily]
AS
SELECT     TOP 100 PERCENT jf.ClientProfilePersonID as JuvenileId, jf.FamilyMemberID as FamilyProfileId, RS.Name as RoleId, f.LastName as LName, f.FirstName as FName, f.MiddleName as MName, S.Name as SufName, ps.WorkPhone as WorkPhone, '' as WorkPhoneExt, ps.HomePhone as HomePhone, 
                      ps.OtherPhone as OtherPhone, '' as OtherPhoneExt, ms.name as MaritalStatus
FROM         dbo.FamilyProfile jf INNER JOIN
             dbo.Person f ON f.ID = jf.FamilyMemberID INNER JOIN
             dbo.PersonSupplemental ps ON ps.PersonID = f.ID LEFT OUTER JOIN
             dbo.Suffix s ON f.SuffixID = S.ID LEFT OUTER JOIN
             dbo.MaritalStatus ms ON ps.MaritalStatusID = ms.ID LEFT OUTER JOIN
             dbo.Relationship RS ON jf.RelationshipID = RS.ID
WHERE     (RS.Name = 'M') OR
          (RS.Name = 'F') OR
          (RS.Name = 'G') OR
          (RS.Name = 'O')
ORDER BY jf.ClientProfilePersonID

GO


USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetFamilyAddress]    Script Date: 03/04/2016 11:07:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwDetFamilyAddress]
AS

SELECT TOP 100 PERCENT 
dbo.ClientProfile.PersonID as JuvenileId, 
dbo.FamilyProfile.FamilyMemberId as FamilyProfileId, 
dbo.Relationship.Name as RoleId, 
dbo.Person.LastName as LName, 
dbo.Person.FirstName as FName, 
dbo.Person.MiddleName as MName, 
dbo.Suffix.Name as SufName, 
dbo.PersonAddress.ID as AddrID, 
dbo.Person.SSN as SSN, 
dbo.MaritalStatus.Name as MaritalStatus, 
dbo.PersonSupplemental.WorkPhone, 
dbo.PersonSupplemental.HomePhone, 
dbo.PersonSupplemental.OtherPhone, 
'' as WorkPhoneExt, 
'' as OtherPhoneExt, 
dbo.PersonAddress.GISCode as Cor_Addr_Num, 
'' as Building_Num, 
'' as Bd_Num_Suffix, 
'' as St_Direction, 
dbo.PersonAddress.AddressLineOne as Street_Name, 
'' as Nomenclature, 
dbo.PersonAddress.AddressLineTwo as Extended_Type, 
'' as Extended_Num, 
'' AS AddrId2, 
'' as StAddrID, 
'' as CareOf, 
dbo.PersonAddress.POBox, 
'' as RuralRoute,
dbo.PersonAddress.City, 
dbo.PersonAddress.State, 
dbo.PersonAddress.Zip, 
dbo.Enrollment.ID as RefServID, 
dbo.Enrollment.ServiceProgramCategoryID as ServiceProfileID, 
dbo.Placement.ID as ReferralID
FROM				  
dbo.FamilyProfile 
LEFT OUTER JOIN dbo.Relationship ON FamilyProfile.RelationshipID = Relationship.ID 
INNER JOIN dbo.ClientProfile ON ClientProfile.ID = FamilyProfile.ClientProfilePersonID 
INNER JOIN dbo.Person ON FamilyProfile.FamilyMemberID = Person.ID
INNER JOIN dbo.PersonSupplemental ON PersonSupplemental.PersonID = Person.ID
LEFT OUTER JOIN dbo.MaritalStatus ON MaritalStatus.ID = PersonSupplemental.MaritalStatusID
LEFT OUTER JOIN dbo.Suffix ON Suffix.ID = Person.SuffixID
INNER JOIN dbo.Placement ON dbo.Placement.ClientProfileID = dbo.ClientProfile.ID
INNER JOIN dbo.Enrollment ON dbo.Placement.ID = dbo.Enrollment.PlacementID
LEFT OUTER JOIN dbo.PersonAddress ON (PersonAddress.PersonID = Person.ID AND PersonAddress.AddressTypeID = 1)
--INNER JOIN dbo.tblDetentionSupp ON Enrollment.ID = tblDetentionSupp.RefServID
WHERE     
(dbo.Relationship.Name = 'M' OR dbo.Relationship.Name = 'F' OR dbo.Relationship.Name = 'G') 
AND (dbo.Enrollment.ServiceProgramCategoryID in (15, 55)) -- Detention and Post-D
ORDER BY JuvenileID, RoleId


/*
SELECT     TOP 100 PERCENT dbo.FamilyProfile.JuvenileId, dbo.FamilyProfile.FamilyProfileId, dbo.FamilyProfile.RoleId, dbo.tblFamilyProfile.LName, 
                      dbo.tblFamilyProfile.FName, dbo.tblFamilyProfile.MName, dbo.tblFamilyProfile.SufName, dbo.tblAddress.AddrID, dbo.tblFamilyProfile.SSN, 
                      dbo.tblFamilyProfile.MaritalStatus, dbo.tblFamilyProfile.WorkPhone, dbo.tblFamilyProfile.HomePhone, dbo.tblFamilyProfile.OtherPhone, 
                      dbo.tblFamilyProfile.WorkPhoneExt, dbo.tblFamilyProfile.OtherPhoneExt, dbo.tblAddressOut.Cor_Addr_Num, dbo.tblAddressOut.Building_Num, 
                      dbo.tblAddressOut.Bd_Num_Suffix, dbo.tblAddressOut.St_Direction, dbo.tblAddressOut.Street_Name, dbo.tblAddressOut.Nomenclature, 
                      dbo.tblAddressOut.Extended_Type, dbo.tblAddressOut.Extended_Num, dbo.tblAddress.AddrID AS AddrId2, dbo.tblAddress.StAddrID, 
                      dbo.tblAddress.CareOf, dbo.tblAddress.POBox, dbo.tblAddress.RuralRoute, dbo.tblAddress.City, dbo.tblAddress.State, dbo.tblAddress.Zip, 
                      dbo.tblRefServices.RefServID, dbo.tblRefServices.ServiceProfileID, dbo.tblReferral.ReferralID
FROM				  dbo.tblDetentionSupp RIGHT OUTER JOIN
                      dbo.tblRefServices ON dbo.tblDetentionSupp.RefServID = dbo.tblRefServices.RefServID LEFT OUTER JOIN
                      dbo.FamilyProfile INNER JOIN
                      dbo.tblFamilyProfile ON dbo.FamilyProfile.FamilyProfileId = dbo.tblFamilyProfile.FamilyProfileID LEFT OUTER JOIN
					  dbo.tblAddressOut RIGHT OUTER JOIN
                      dbo.tblAddress ON dbo.tblAddressOut.Cor_Addr_Num = dbo.tblAddress.StAddrID INNER JOIN
					  dbo.tblXRefAddress ON dbo.tblXRefAddress.AddrID = dbo.tblAddress.AddrID ON dbo.tblXRefAddress.XRefAddrID = dbo.tblFamilyProfile.AddrID AND dbo.tblXRefAddress.AddrTypeID = 1 RIGHT OUTER JOIN
                      dbo.tblReferral ON dbo.FamilyProfile.JuvenileId = dbo.tblReferral.JuvenileID ON dbo.tblRefServices.ReferralID = dbo.tblReferral.ReferralID
 WHERE     (dbo.FamilyProfile.RoleId = 'M' OR
                      dbo.FamilyProfile.RoleId = 'F' OR
                      dbo.FamilyProfile.RoleId = 'G') AND (dbo.tblRefServices.ServiceProfileID in (57, 184))
ORDER BY dbo.FamilyProfile.JuvenileId, dbo.FamilyProfile.RoleId
*/





GO


USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetFamilyDetail]    Script Date: 03/16/2016 12:58:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View dbo.vwDetFamilyDetail    Script Date: 12/6/2005 2:46:52 PM ******/
CREATE VIEW [dbo].[vwDetFamilyDetail]
AS
SELECT     dbo.ClientProfile.PersonID as JuvenileId, dbo.FamilyProfile.ID as FamilyProfileId, dbo.Relationship.Name as RoleId, dbo.Person.LastName as LName, dbo.Person.FirstName as FName, 
           dbo.Person.MiddleName as MName, dbo.Suffix.Name as SufName, dbo.PersonAddress.ID as AddrID, dbo.Person.SSN, dbo.MaritalStatus.Name as MaritalStatus, 
           dbo.PersonSupplemental.WorkPhone, dbo.PersonSupplemental.HomePhone, dbo.PersonSupplemental.OtherPhone, '' as WorkPhoneExt, 
           '' as OtherPhoneExt
FROM       dbo.FamilyProfile 
INNER JOIN dbo.ClientProfile ON dbo.FamilyProfile.ClientProfilePersonID = dbo.ClientProfile.ID
INNER JOIN dbo.Person	     ON dbo.Person.ID = dbo.FamilyProfile.FamilyMemberID
INNER JOIN dbo.PersonAddress ON dbo.PersonAddress.PersonID = dbo.Person.ID AND dbo.PersonAddress.AddressTypeID = 1
INNER JOIN dbo.Relationship ON Relationship.ID = dbo.FamilyProfile.RelationshipID
INNER JOIN dbo.PersonSupplemental ON PersonSupplemental.PersonID = Person.ID
LEFT OUTER JOIN dbo.MaritalStatus ON MaritalStatus.ID = dbo.PersonSupplemental.MaritalStatusID
LEFT OUTER JOIN dbo.Suffix ON Person.SuffixID = Suffix.ID
WHERE  (dbo.Relationship.Name = 'M') OR
       (dbo.Relationship.Name = 'F') OR
       (dbo.Relationship.Name = 'G')
GO
USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetMedical]    Script Date: 03/11/2016 10:59:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View dbo.vwDetMedical    Script Date: 12/6/2005 2:46:52 PM ******/
CREATE VIEW [dbo].[vwDetMedical]
AS

SELECT     ds.RefServID, p.ID as ReferralID, per.ID as JuvenileID, ds.Pregnant, 
           ds.DueDate, ds.Hospital, ds.Physician, ds.PhyAddr, 
           ds.PhyPhone, ds.Dentist, ds.DentAddr, ds.DentPhone, 
           ds.MedInsurance, ds.CurrMedication, ds.CurrComplaints, ds.SuicideWatch, 
           ds.HealthAtIntake, ds.DrugAllergy, ds.FoodAllergy, ds.OtherAllergy, 
           ds.Behavior, ds.UnderInfluence, ds.Confused, ds.Oriented, 
           ds.Alert, ds.CreatedBy, e.SourceID as ReferralSourceID, dbo.fnAdmittedBy(e.SourceID, '') 
           AS AdmittedBy, gen.Name as Gender
FROM       dbo.tblDetentionSupp as ds INNER JOIN 
		   dbo.Enrollment as e ON e.ID = ds.RefServID INNER JOIN
		   dbo.Placement as p ON p.ID = e.PlacementID INNER JOIN
           dbo.ClientProfile as cp ON cp.ID = p.ClientProfileID INNER JOIN
           dbo.Person as per ON per.ID = cp.PersonID LEFT OUTER JOIN
           dbo.Gender as gen ON gen.ID = per.GenderID

GO

USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetMentalHealth]    Script Date: 03/11/2016 11:27:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  View dbo.vwDetMentalHealth    Script Date: 12/6/2005 2:46:52 PM ******/
CREATE VIEW [dbo].[vwDetMentalHealth]
AS

SELECT     TOP 100 PERCENT dbo.tblMHInterview.*, dbo.Staff.ID AS StaffID, dbo.Staff.NetLogin AS NetLogin, dbo.Staff.LastName AS LName, 
                      dbo.Staff.FirstName AS FName, dbo.tblMHQuestions.MHQuestID AS MHQuestID, dbo.tblMHQuestions.MHQuestOrder AS MHQuestOrder, 
                      dbo.tblMHQuestions.MHQuestText AS MHQuestText, dbo.tblMHQuestions.MHQuestGroup AS MHQuestGroup, 
                      dbo.tblMHQuestions.MHPrintNo AS MHPrintNo, dbo.tblMHQuestions.AllowAnswer AS AllowAnswer, 
                      dbo.tblMHQuestions.AllowComment AS AllowComment, dbo.tblMHQuestions.Active AS Active            
FROM         dbo.tblMHInterview RIGHT OUTER JOIN
             dbo.tblMHQuestions ON dbo.tblMHInterview.MHQuestionID = dbo.tblMHQuestions.MHQuestID LEFT OUTER JOIN
             dbo.Staff ON UPPER(RTRIM(dbo.tblMHInterview.CreatedBy)) = 'RICHVA\' + UPPER(RTRIM(dbo.Staff.NetLogin))
ORDER BY dbo.tblMHInterview.RefServID, dbo.tblMHQuestions.MHQuestGroup, dbo.tblMHQuestions.MHQuestOrder

GO
USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetPersProp]    Script Date: 03/11/2016 10:47:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View dbo.vwDetPersProp    Script Date: 12/6/2005 2:46:53 PM ******/
CREATE VIEW [dbo].[vwDetPersProp]
AS
SELECT     dbo.tblDetPersProp.RefServID, dbo.tblDetPersProp.Quantity, dbo.tblDetPersProp.Money, dbo.tblDetPersProp.Location, dbo.tblPPItems.PPItemDesc, 
                      dbo.tblDetPersProp.PPItemsID, dbo.tblDetPersProp.DetPPID, dbo.tblDetPersProp.CreatedBy
FROM         dbo.tblDetPersProp LEFT OUTER JOIN
                      dbo.tblPPItems ON dbo.tblDetPersProp.PPItemsID = dbo.tblPPItems.PPItemsID







GO


USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDetPersProp2]    Script Date: 03/11/2016 10:48:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View dbo.vwDetPersProp2    Script Date: 12/6/2005 2:46:53 PM ******/
CREATE VIEW [dbo].[vwDetPersProp2]
AS

SELECT     ds.RefServID, ds.ClothingIss, ds.PPReturned, rs.ID AS rsRefServID, rs.PlacementID as ReferralID, r.ID as rReferrralID, cp.PersonID as JuvenileID
FROM         dbo.tblDetentionSupp ds INNER JOIN
             dbo.Enrollment rs ON ds.RefServID = rs.ID INNER JOIN
             dbo.Placement r ON rs.PlacementID = r.ID INNER JOIN
             dbo.ClientProfile cp ON r.ClientProfileID = cp.ID

GO
USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwMealCnts]    Script Date: 03/04/2016 09:10:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  View dbo.vwMealCnts    Script Date: 12/6/2005 2:46:53 PM ******/
CREATE VIEW [dbo].[vwMealCnts]
AS

SELECT  SUM(dbo.fnTally(Breakfast, ''))  	AS Breakfast, 
		SUM(dbo.fnTally(Lunch, ''))	AS Lunch, 
		SUM(dbo.fnTally(Dinner, '')) 	AS Dinner, 
		SUM(dbo.fnTally(Snack, '')) 	AS Snack, 
		mealdate
FROM         dbo.tblDetMeals
WHERE JuvenileID > 0
group by mealdate

GO
USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwMHComments]    Script Date: 04/07/2016 13:37:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View dbo.vwMHComments    Script Date: 12/6/2005 2:46:53 PM ******/
CREATE VIEW [dbo].[vwMHComments]
AS
SELECT     
	dbo.tblDetentionSupp.RefServID, 
	dbo.tblDetentionSupp.MHTherapist, 
	dbo.tblDetentionSupp.MHAddlComments, 
	dbo.Person.LastName as LName, 
	dbo.Person.FirstName as FName, 
	dbo.Person.MiddleName as MName, 
	dbo.Suffix.Name as SufName
FROM
	dbo.tblDetentionSupp INNER JOIN
	dbo.Enrollment ON dbo.tblDetentionSupp.RefServID = dbo.Enrollment.ID INNER JOIN
	dbo.Placement ON dbo.Enrollment.PlacementID = dbo.Placement.ID INNER JOIN
	dbo.ClientProfile ON Placement.ClientProfileID = ClientProfile.ID INNER JOIN
	dbo.Person ON dbo.Person.ID = dbo.ClientProfile.PersonID LEFT OUTER JOIN
	dbo.Suffix ON dbo.Suffix.ID = Person.SuffixID
GO
USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwStaffName]    Script Date: 03/04/2016 10:49:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  View dbo.vwStaffName    Script Date: 12/6/2005 2:46:53 PM ******/
CREATE VIEW [dbo].[vwStaffName]
AS

SELECT     ID as StaffID, LastName as LName, firstName as FName, dbo.fnFixEmpty(RTRIM(LastName) + ', ' + RTRIM(FirstName), '') AS FullName, 1 as Active, Department, Phone
FROM         dbo.Staff
Where TerminationDate is null


/*
SELECT     StaffID, LName, FName, dbo.fnFixEmpty(RTRIM(LName) + ', ' + RTRIM(FName), '') AS FullName, Active, Department, Phone
FROM         dbo.tblStaff
Where Active='0'
*/
GO
USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwStaffNameDetention]    Script Date: 03/04/2016 10:37:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View dbo.vwStaffNameDetention    Script Date: 12/6/2005 2:46:53 PM ******/
CREATE VIEW [dbo].[vwStaffNameDetention]
AS

SELECT     ID as StaffID, LastName as LName, firstName as FName, dbo.fnFixEmpty(RTRIM(LastName) + ', ' + RTRIM(FirstName), '') AS FullName, 1 as Active, Department, Phone
FROM         dbo.Staff
WHERE     (TerminationDate is null) AND (Department = 'Detention Center')

/*
SELECT     StaffID, LName, FName, dbo.fnFixEmpty(RTRIM(LName) + ', ' + RTRIM(FName), '') AS FullName, Active, Department, Phone
FROM         dbo.tblStaff
WHERE     (Active = '0') AND (Department = 'Detention Center')
*/

GO
USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwYouthInfoRpt]    Script Date: 04/07/2016 12:15:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


/****** Object:  View dbo.vwYouthInfoRpt    Script Date: 12/6/2005 2:46:53 PM ******/
CREATE VIEW [dbo].[vwYouthInfoRpt]
AS
SELECT     TOP 100 PERCENT 
	RS.ID as RefServID, 
	DS.PodRoom, 
	DS.LivingWith, 
	DS.AgeAtIntake, 
	DS.AuthPhoneNo, 
	RS.PlacementID as ReferralID, 
	RS.BeginDate as BeginDt, 
	RS.EndDate as EndDt, 
    RS.CounselorID, 
    JP.ID as JuvenileID, 
    JP.LastName as LName, 
    JP.FirstName as FName, 
    JP.MiddleName as MName, 
    Suf.Name as SufName, 
    G.Name as Gender, 
    RC.Name as RaceID, 
    JP.DOB,   
    LTRIM(STR(MONTH(JP.DOB))) + '/' + LTRIM(STR(DAY(JP.DOB))) + '/' + LTRIM(STR(YEAR(JP.DOB))) AS ShortDOB, 
    RS.ServiceProgramCategoryID as ServiceProfileID, 
    S.ID as StaffID, 
    S.Phone AS CPhone, 
    S.LastName as CLName, 
    S.FirstName AS CFName, 
    CONVERT(int, DATEDIFF(d, JP.DOB, GETDATE()) / 365.25) AS Age, 
    '' as PlacementCharges, 
    (SELECT VCCCode + ', ' FROM Offense INNER JOIN PlacementOffense ON PlacementOffense.OffenseID = Offense.ID WHERE PlacementOffense.PlacementID = R.ID
	FOR XML PATH('')) AS Offenses,
    --dbo.fnOffenseList(R.ID, '') AS Offenses,
    dbo.fnFamilyMember(JP.ID, 'M', '') AS Mother, 
    dbo.fnFamilyMember(JP.ID, 'F', '') AS Father, 
    dbo.fnFamilyMember(JP.ID, 'G', '') AS Guardian, 
    DS.CurrMedication, 
    DS.CurrComplaints, 
    R.NextCourtDate as NextCourtDt, 
    '' as ChargeComments,
    dbo.fnProbationOfficer(DS.PO,'') AS PO
FROM   
    dbo.Person JP INNER JOIN
    dbo.ClientProfile CP ON CP.PersonID = JP.ID INNER JOIN
    dbo.Placement R ON CP.ID = R.ClientProfileID INNER JOIN
    dbo.Enrollment RS ON RS.PlacementID = R.ID INNER JOIN
    dbo.tblDetentionSupp DS ON RS.ID = DS.RefServID LEFT OUTER JOIN
    dbo.Staff S ON RS.CounselorID = S.ID LEFT OUTER JOIN
    dbo.Suffix Suf ON JP.SuffixID = Suf.ID LEFT OUTER JOIN
    dbo.Gender G ON JP.GenderID = G.ID LEFT OUTER JOIN
    dbo.Race RC ON JP.RaceID = RC.ID
WHERE 
	RS.ServiceProgramCategoryID in (15, 55) -- Detention and Post-D
ORDER BY 
	JP.LastName, JP.FirstName

GO

USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDashBoardEnrollmentRptDetails]    Script Date: 05/19/2016 11:20:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwDashBoardEnrollmentRptDetails]
AS
SELECT     dbo.Person.LastName as LName, dbo.Person.FirstName as FName, dbo.Enrollment.BeginDate as BeginDt, dbo.Enrollment.EndDate as EndDt, dbo.Enrollment.ServiceReleaseID as ReleaseID, 
                      dbo.Enrollment.ReferralDate as DateofReferral, dbo.Enrollment.CounselorID, dbo.Staff.FirstName AS CounselorFirstName, dbo.Staff.LastName AS CounselorLastName, 
                      dbo.ServiceProgram.Name as ServiceName, '' as ServLevelID, dbo.Enrollment.Comments, dbo.Person.JTS, dbo.Person.DOB, 
                      dbo.Enrollment.ID as RefServID, dbo.ServiceRelease.Description, dbo.Enrollment.UpdatedBy as UpdtBy, dbo.Race.Name as RaceID, dbo.Gender.Name as Gender, 
                      '' as PlacementCharges, dbo.Enrollment.MonitorOption, dbo.Enrollment.SourceID as RefSourceID, dbo.JobTitle.Name as JobTitle, dbo.Enrollment.ServiceProgramCategoryID as ServiceProfileID, 
                      dbo.Person.SSN, dbo.ServiceProgram.ID as ServiceNameID, 0 AS Capacity
FROM         dbo.Enrollment INNER JOIN
                      dbo.ServiceProgramCategory ON dbo.Enrollment.ServiceProgramCategoryID = dbo.ServiceProgramCategory.ID INNER JOIN
                      dbo.ServiceProgram ON dbo.ServiceProgramCategory.ServiceProgramID = dbo.ServiceProgram.ID INNER JOIN
                      dbo.Placement ON dbo.Enrollment.PlacementID = dbo.Placement.ID INNER JOIN
                      dbo.ClientProfile ON dbo.Placement.ClientProfileID = dbo.ClientProfile.ID INNER JOIN
                      dbo.Person ON ClientProfile.PersonID = Person.ID LEFT OUTER JOIN
                      dbo.Staff ON dbo.Enrollment.CounselorID = dbo.Staff.ID LEFT OUTER JOIN
                      dbo.ServiceRelease ON dbo.Enrollment.ServiceReleaseID = dbo.ServiceRelease.ID LEFT OUTER JOIN
                      dbo.Race ON Person.RaceID = dbo.Race.ID LEFT OUTER JOIN
                      dbo.Gender ON Person.GenderID = dbo.Gender.ID LEFT OUTER JOIN
                      dbo.JobTitle ON Staff.JobTitleID = dbo.JobTitle.ID
WHERE     (dbo.ServiceProgram.Active = 1) AND (dbo.Enrollment.EndDate = CONVERT(DATETIME, '1900-01-01 00:00:00', 102) OR
                      dbo.Enrollment.EndDate IS NULL) AND (ISNULL(dbo.ServiceRelease.ExcludeFromEnrollmentCount, 0) = 0) AND (dbo.Enrollment.BeginDate <= GETDATE() OR
                      dbo.Enrollment.BeginDate IS NULL)


GO

USE [JusticeServices]
GO

/****** Object:  View [dbo].[vwDashBoardEnrollmentRpt]    Script Date: 05/19/2016 11:19:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwDashBoardEnrollmentRpt]
AS
SELECT     TOP (100) PERCENT ServiceNameID, ServiceName, Capacity, COUNT(*) AS Enrollment
FROM         dbo.vwDashBoardEnrollmentRptDetails
GROUP BY ServiceName, Capacity, ServiceNameID
ORDER BY ServiceName


GO
