using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DJSCaseMgtService.Utility
{
    public class SQLQuery
    {
        public static string ClientSearch =
            @"SELECT 
            	cp.ID, p.LastName, p.FirstName, p.MiddleName, p.JTS, p.SSN, p.DOB, 
            	(SELECT Name FROM Gender WHERE ID = p.GenderID) as Gender
            FROM 
            	Person p
            	INNER JOIN ClientProfile cp ON cp.PersonID = p.ID
            WHERE 
                cp.Active = 1 AND
                cp.SystemID = @SystemID ";

        public static string FamilyProfiles =
            @"SELECT fp.*, fm.*, r.*, suf.*, g.*, race.*, ps.*, el.*, js.*, ms.*, s.*
            FROM 
	            FamilyProfile fp
	            INNER JOIN Person fm ON fp.FamilyMemberID = fm.ID
	            INNER JOIN Relationship r ON fp.RelationshipID = r.ID
	            LEFT JOIN Suffix suf ON fm.SuffixID = suf.ID 
                LEFT JOIN Gender g ON fm.GenderID = g.ID
	            LEFT JOIN Race race ON fm.RaceID = race.ID
	            LEFT JOIN PersonSupplemental ps ON fp.FamilyMemberID = ps.PersonID
				LEFT JOIN EducationLevel el ON ps.EducationLevelID = el.ID
				LEFT JOIN JobStatus js ON ps.JobStatusID = js.ID
				LEFT JOIN MaritalStatus ms ON ps.MaritalStatusID = ms.ID
				LEFT JOIN School s ON ps.SchoolID = s.ID
            WHERE 
                fp.ClientProfilePersonID = @ID";

        public static string Placements = 
            @"SELECT r.*, pl.*, lp.*, j.*
            FROM 
	            Person p
	            INNER JOIN ClientProfile cp ON p.ID = cp.PersonID
	            INNER JOIN Placement r ON cp.ID = r.ClientProfileID
	            LEFT JOIN PlacementLevel pl ON r.PlacementLevelID = pl.ID
	            LEFT JOIN LoginProfile lp ON r.SourceID = lp.ID
	            LEFT JOIN Judge j ON r.JudgeID = j.ID
            WHERE 
	            r.ID IN (
		            SELECT r.ID
		            FROM 
			            Person p
			            INNER JOIN ClientProfile cp ON p.ID = cp.PersonID
			            INNER JOIN Placement r ON cp.ID = r.ClientProfileID
			            LEFT JOIN Enrollment rsp ON r.ID = rsp.PlacementID
		            WHERE
			            cp.Active = 1 and cp.ID = @ID and cp.SystemID = @SystemID
                )";

        public static string Enrollments =
                    @"SELECT e.*, spc.*, sp.*, sprov.*, sc.*, so.*, sr.*, placement2.*, source.*, 
		                     sourcelogin.*, counselor.*, counselorlogin.*, placementSource.*  
                      FROM 
	            	        Enrollment e
	                        INNER JOIN ServiceProgramCategory spc ON e.ServiceProgramCategoryID = spc.ID
			                LEFT JOIN ServiceProgram sp ON spc.ServiceProgramID = sp.ID
			                LEFT JOIN ServiceProvider sprov ON sp.ServiceProviderID = sprov.ID
			                LEFT JOIN ServiceCategory sc ON spc.ServiceCategoryID = sc.ID
			                LEFT JOIN ServiceOutcome so ON e.ServiceOutcomeID = so.ID
	                        LEFT JOIN ServiceRelease sr ON e.ServiceReleaseID = sr.ID
                            INNER JOIN Placement placement2 ON e.PlacementID = placement2.ID
	                        LEFT JOIN Staff source ON e.SourceID = source.ID
                            LEFT JOIN Login sourcelogin ON source.NetLogin = sourcelogin.ID                            
	                        LEFT JOIN Staff counselor ON e.CounselorID = counselor.ID
                            LEFT JOIN Login counselorlogin ON counselor.NetLogin = counselorlogin.ID                            
			                LEFT JOIN LoginProfile placementSource ON placement2.SourceID = placementSource.ID
                      WHERE 
                            e.PlacementID = @PlacementID";

        // GET ClientProfile for given ClientProfileID and SystemID 
        public static string ClientProfileData =
            @"
            /** 01 - personRecord **/
            SELECT cp.*, p.*, ns.*, g.*, r.*, p2.*
            FROM 
	            ClientProfile cp
	            INNER JOIN Person p ON cp.PersonID = p.ID
                LEFT JOIN Suffix ns ON p.SuffixID = ns.ID
                LEFT JOIN Gender g ON p.GenderID = g.ID
	            LEFT JOIN Race r ON p.RaceID = r.ID
                INNER JOIN Person p2 ON cp.PersonID = p2.ID
            WHERE 
                cp.Active = 1 and cp.ID = @ID and cp.SystemID = @SystemID
                
            /* 02 - personSupplemental */
            SELECT ps.*, el.*, js.*, ms.*, s.*
            FROM 
	            Person p
	            INNER JOIN ClientProfile cp ON p.ID = cp.PersonID
	            LEFT JOIN PersonSupplemental ps ON p.ID = ps.PersonID
	            LEFT JOIN EducationLevel el ON ps.EducationLevelID = el.ID
	            LEFT JOIN JobStatus js ON ps.JobStatusID = js.ID
	            LEFT JOIN MaritalStatus ms ON ps.MaritalStatusID = ms.ID
	            LEFT JOIN School s ON ps.SchoolID = s.ID
            WHERE 
                cp.Active = 1 and cp.ID = @ID and cp.SystemID = @SystemID                

            /** 03 - PersonAddress **/
            SELECT pa.*, at.*
            FROM 
	            Person p
	            INNER JOIN ClientProfile cp ON p.ID = cp.PersonID
	            INNER JOIN PersonAddress pa ON p.ID = pa.PersonID
                INNER JOIN  AddressType at ON pa.AddressTypeID = at.ID
            WHERE 
                cp.Active = 1 and cp.ID = @ID and cp.SystemID = @SystemID";

        public static string AssessmentData =
            @"
            SELECT a.*, at.*, ast.*, s.*
            FROM 
	            ClientProfile cp	            
	            INNER JOIN Assessment a ON cp.ID = a.ClientProfileID
                LEFT JOIN AssessmentType at ON a.AssessmentTypeID = at.ID
                LEFT JOIN AssessmentSubType ast ON a.AssessmentSubTypeID = ast.ID
                LEFT JOIN Staff s ON a.StaffID = s.ID
            WHERE 
                cp.Active = 1 and cp.ID = @ID and cp.SystemID = @SystemID";

        public static string PlacementOffenseData =
            @"
            SELECT po.*, o.*
            FROM 
	            PlacementOffense po
                LEFT JOIN Offense o ON po.OffenseID = o.ID
            WHERE 
                po.placementID = @PlacementID";

        public static string ServiceUnitData =
            @"
            SELECT su.*, e2.*
            FROM 
	            ServiceUnit su
	            LEFT JOIN Enrollment e ON su.EnrollmentID = e.PlacementID	
                LEFT JOIN Enrollment e2 ON su.EnrollmentID = e2.ID
            WHERE 
                su.EnrollmentID = @EnrollmentID";

        public static string ProgressNotesData =
            @"
            SELECT pn.*, ct.*, e2.*
            FROM 
	            ProgressNote pn
                LEFT JOIN Enrollment e ON pn.EnrollmentID = e.PlacementID
                LEFT JOIN ContactType ct ON pn.ContactTypeID = ct.ID
	            LEFT JOIN Enrollment e2 ON pn.EnrollmentID = e.ID
            WHERE 
                pn.EnrollmentID = @EnrollmentID";

        public static string PersonsData =
            @"
                SELECT * FROM Person p
                LEFT JOIN Suffix ns ON p.SuffixID = ns.ID
                LEFT JOIN Gender g ON p.GenderID = g.ID
                LEFT JOIN Race r ON p.RaceID = r.ID
                WHERE p.ID NOT IN 
                (SELECT PersonID FROM ClientProfile)
            ";
    }
}