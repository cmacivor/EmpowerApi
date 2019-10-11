// Handles all configuration related functionalities
app.factory('ConfigService', ['CRUDService', 'CustomCRUDService', 'httpCRUDService', 'locationURL', 'reportServerURL', 'CWBreportServerURL', function (CRUDService, CustomCRUDService, httpCRUDService, locationURL, reportServerURL, CWBreportServerURL) {
    // Admin menu items for Juvinile
    var adminMenuItems = [
         { "Title": "AddressType", "DisplayName": "AddressType", "Template": "#/admin_addresstype" },                 
         { "Title": "AssessmentType", "DisplayName": "AssessmentType", "Template": "#/admin_assesstype" },
         { "Title": "AssessmentSubtype", "DisplayName": "AssessmentSubType", "Template": "#/admin_assesssubtype" },
         { "Title": "EducationLevel","DisplayName": "EducationLevel", "Template": "#/admin_educationlevel" },         
         { "Title": "JobStatus", "DisplayName": "JobStatus", "Template": "#/admin_jobstatus" },
         { "Title": "Judge", "DisplayName": "Judge", "Template": "#/admin_judge" },
         { "Title": "Offense", "DisplayName": "Offense", "Template": "#/admin_offense" },
         { "Title": "Race", "DisplayName": "Race", "Template": "#/admin_race" },
         { "Title": "Relationship", "DisplayName": "Relationship", "Template": "#/admin_relationship" },
         //{ "Title": "SanctionIncentives", "DisplayName": "Sanction Incentives", "Template": "#/admin_sanctionincentives" },
         //{ "Title": "School", "DisplayName": "School", "Template": "#/admin_school" },
         { "Title": "ServiceCategory", "DisplayName": "ServiceCategory", "Template": "#/admin_servicecategory" },
         { "Title": "ServiceOutcome", "DisplayName": "Reason", "Template": "#/admin_serviceoutcome" },
         //{ "Title": "ServiceProgram", "DisplayName": "Service Program", "Template": "#/admin_serviceprogram" },
         { "Title": "ServiceProgramCategory", "DisplayName": "Service Program Category", "Template": "#/ServiceProCat" },
         //{ "Title": "ServiceProvider", "DisplayName": "Service Provider", "Template": "#/admin_serviceprovider" },
         { "Title": "ServiceRelease", "DisplayName": "Case Status", "Template": "#/admin_servicerelease" },
         //{ "Title": "ServiceUnit", "DisplayName": "Service Unit", "Template": "#/admin_serviceunit" },         
         { "Title": "Suffix", "DisplayName": "Suffix", "Template": "#/admin_suffix" },
         { "Title": "signup", "DisplayName": "Create & Update User", "Template": "#/signup" },
         {"Title": "Contact Type", "DisplayName": "Contact type", "Template": "#/admin_contacttype"}
        
        // { "Title": "LoginRole", "DisplayName": "Login Role", "Template": "#/admin_LoginRole" },
        // { "Title": "RoleAccess", "DisplayName": "Role Access", "Template": "#/admin_RoleAccess" },
        // { "Title": "Internal(GIS)", "DisplayName": "Internal (GIS) Address", "Template": "#/admin_internal(GIS)" },
        //{ "Title": "External(Bing)", "DisplayName": "External (Bing) Address", "Template": "#/admin_external(Bing)" }
    ];
    // Report menu items for Juvinile 
    var reportsMenuItems = [
         { "Title": "JuvenilesbySpecificService", "DisplayName": "Juveniles by Specific Service", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AVXn4xkCXD9Jpn45EgTAkus&sIDType=CUID&sType=wid&sRefresh=Y") },
         { "Title": "ServicebyStaff", "DisplayName": "Service by Staff", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AVqZ3hzdklZJm68UbcoU7_E&sIDType=CUID&sType=wid&sRefresh=Y") },
         { "Title": "PrintableFamilyProfileReport", "DisplayName": "Printable Family Profile Report", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=Ae6kCMbv7kpHharsnteckcY&sIDType=CUID&sType=wid&sRefresh=Y") },
         { "Title": "EnrollmentReport", "DisplayName": "Enrollment Report", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AWq2i.hM8SZOmoQr3Ij9sOg&sIDType=CUID&sType=wid&sRefresh=Y") },
         { "Title": "Open Cases By Service", "DisplayName": " Open Cases By Service", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AbZv0hzu0FtLhchw_f8.OkA&sIDType=CUID&sType=wid&sRefresh=Y&lsMEnter%20value(s)%20for%20Service%20program%20Name=?") },
         { "Title": "Crime Control Service Units By Month", "DisplayName": " Crime Control Service Units By Month", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AVst0R91nI5KhamoSfw3o8A&sIDType=CUID&sType=wid&sRefresh=Y&lsMEnter%20value(s)%20for%20Month=?&lsMEnter%20value(s)%20for%20Year=?") },
         { "Title": "CrimeControlReport", "DisplayName": "Crime Control Report", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=ARmvPFVMljNBgx4zV2g0dZw&sIDType=CUID&sType=wid&sRefresh=Y&lsSEnter%20End%20Fiscal%20Year%3A=?&lsMEnter%20FY%20Ending%20Months%3A=?&lsSEnter%20Start%20Fiscal%20Year%3A=?&lsMEnter%20FY%20Start%20Months%3A=?&lsSEnter%20Service%20program%20Name%3A=?")
}
      
    ];

    //Report menu items for Adults

    var adminAdultMenuItems = [

        { "Title": "AssessmentType", "DisplayName": "AssessmentType", "Template": "#/admin_assesstype" },
        { "Title": "AssessmentSubtype", "DisplayName": "AssessmentSubType", "Template": "#/admin_assesssubtype" },
        { "Title": "JobStatus", "DisplayName": "JobStatus", "Template": "#/admin_jobstatus" },
        { "Title": "Judge", "DisplayName": "Judge", "Template": "#/admin_judge" },
        { "Title": "Offense", "DisplayName": "Offense", "Template": "#/admin_offense" },
        { "Title": "Race", "DisplayName": "Race", "Template": "#/admin_race" },
        { "Title": "Relationship", "DisplayName": "Relationship", "Template": "#/admin_relationship" },
        { "Title": "ServiceCategory", "DisplayName": "ServiceCategory", "Template": "#/admin_servicecategory" },
        { "Title": "ServiceOutcome", "DisplayName": "Reason", "Template": "#/admin_serviceoutcome" },
        //{ "Title": "ServiceProgram", "DisplayName": "Service Program", "Template": "#/admin_serviceprogram" },
        { "Title": "ServiceProgramCategory", "DisplayName": "Service Program Category", "Template": "#/ServiceProCat" },
        { "Title": "ServiceRelease", "DisplayName": "Case Status", "Template": "#/admin_servicerelease" },
        //{ "Title": "ServiceUnit", "DisplayName": "Service Unit", "Template": "#/admin_serviceunit" },         
        { "Title": "Suffix", "DisplayName": "Suffix", "Template": "#/admin_suffix" },
        { "Title": "signup", "DisplayName": "Create & Update User", "Template": "#/signup" },
        { "Title": "Contact Type", "DisplayName": "Contact type", "Template": "#/admin_contacttype" }

       // { "Title": "LoginRole", "DisplayName": "Login Role", "Template": "#/admin_LoginRole" },
       // { "Title": "RoleAccess", "DisplayName": "Role Access", "Template": "#/admin_RoleAccess" },
       // { "Title": "Internal(GIS)", "DisplayName": "Internal (GIS) Address", "Template": "#/admin_internal(GIS)" },
       //{ "Title": "External(Bing)", "DisplayName": "External (Bing) Address", "Template": "#/admin_external(Bing)" }
    ];

    var reportsAdultMenuItems = [
        { "Title": "ClientSpecificService", "DisplayName": "Client Specific Service", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AU1KhmKoacJClsfZVdfrc_4&sIDType=CUID&sType=wid&sRefresh=Y&lsSEnter%20value(s)%20for%20Referral%20Date%20(Start)=?&lsSEnter%20value(s)%20for%20Referral%20Date%20(End)=?&lsSEnter%20value(s)%20for%20Service%20program%20Name=?") },
        { "Title": "ServicebyStaff", "DisplayName": "Service by Staff", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AeK_rUkhe3RMr15CQFyUehI&sIDType=CUID&sType=wid&sRefresh=Y&lsSEnter%20value(s)%20for%20Referral%20Date%20(Start)=?&lsSEnter%20value(s)%20for%20Referral%20Date%20(End)=?&lsMEnter%20value(s)%20for%20Referral%20Full%20Name=?&lsMEnter%20value(s)%20for%20Counselor%20Full%20name=?") },
        { "Title": "EnrollmentReport", "DisplayName": "Enrollment Report", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AfUaACvB1DdOsYu0xI6xb_o&sIDType=CUID&sType=wid&sRefresh=Y") },
        { "Title": "Open Cases By Service", "DisplayName": " Open Cases By Service", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AfXA6PHg7ApDj6c993lRvkM&sIDType=CUID&sType=wid&sRefresh=Y&lsMEnter%20value(s)%20for%20Service%20program%20Name=?") },
        { "Title": "Service Units by Month", "DisplayName": "Service Units by Month", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=ASJ9HyvHANlKicSKmfY9zZs&sIDType=CUID&sType=wid&sRefresh=Y&lsMEnter%20value(s)%20for%20Service%20program%20Name=?&lsMEnter%20value(s)%20for%20Month=?&lsMEnter%20value(s)%20for%20Year=?") }

    ];
    //End of Report menu items for Adults

    // Admin Menu Items for OCWB
    var adminOCWBMenuItems = [

        { "Title": "AssessmentType", "DisplayName": "Assessment Type", "Template": "#/admin_assesstype" },
        { "Title": "AssessmentSubtype", "DisplayName": "Assessment SubType", "Template": "#/admin_assesssubtype" },
        { "Title": "AssistanceType", "DisplayName": "Assistance Type", "Template": "#/admin_assistancetype" },
        { "Title": "CareerPathway", "DisplayName": "Career Pathway", "Template": "#/admin_careerpathway" },
        { "Title": "JobStatus", "DisplayName": "JobStatus", "Template": "#/admin_jobstatus" },
        //{ "Title": "Offense", "DisplayName": "Placement Charges", "Template": "#/admin_offense" },
        { "Title": "Race", "DisplayName": "Race", "Template": "#/admin_race" },
        { "Title": "Relationship", "DisplayName": "Relationship", "Template": "#/admin_relationship" },
        { "Title": "ServiceCategory", "DisplayName": "ServiceCategory", "Template": "#/admin_servicecategory" },
        { "Title": "ServiceOutcome", "DisplayName": "Referral Source", "Template": "#/admin_serviceoutcome" },
        //{ "Title": "ServiceProgram", "DisplayName": "Service Program", "Template": "#/admin_serviceprogram" },
        { "Title": "ServiceProgramCategory", "DisplayName": "Service Program Category", "Template": "#/ServiceProCat" },
        { "Title": "ServiceRelease", "DisplayName": "Case Status", "Template": "#/admin_servicerelease" },
        { "Title": "Suffix", "DisplayName": "Suffix", "Template": "#/admin_suffix" },
        { "Title": "signup", "DisplayName": "Create & Update User", "Template": "#/signup" },
        { "Title": "ContactType", "DisplayName": "Contact type", "Template": "#/admin_contacttype" }
             
    ];

    //Report mentu Items for OCWB
    var reportsOCWBMenuItems = [
       { "Title": "ClientSpecificService", "DisplayName": "Participant Specific Service", "Template": (CWBreportServerURL + "reports/powerbi/HumanServices/CWB/ParticipantBySpecificService") },
       //{ "Title": "ServicebyStaff", "DisplayName": "Service by Staff", "Template": ("http://dit-busobj-pv:6405/BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AeK_rUkhe3RMr15CQFyUehI&sIDType=CUID&sType=wid&sRefresh=Y&lsSEnter%20value(s)%20for%20Referral%20Date%20(Start)=?&lsSEnter%20value(s)%20for%20Referral%20Date%20(End)=?&lsMEnter%20value(s)%20for%20Referral%20Full%20Name=?&lsMEnter%20value(s)%20for%20Counselor%20Full%20name=?") },
       //{ "Title": "Case Load Report by case Manager", "DisplayName": "Case Load Report by case Manager", "Template": ("http://dit-busobj-pv:6405/BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AfUaACvB1DdOsYu0xI6xb_o&sIDType=CUID&sType=wid&sRefresh=Y") },
       { "Title": "Enrollment Report", "DisplayName": "Enrollment Report", "Template": (CWBreportServerURL + "reports/powerbi/HumanServices/CWB/ParticipantEnrollmentForm") },
       //{ "Title": "Employment Report", "DisplayName": "Employment Report", "Template": ("http://dit-busobj-pv:6405/BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=ASJ9HyvHANlKicSKmfY9zZs&sIDType=CUID&sType=wid&sRefresh=Y&lsMEnter%20value(s)%20for%20Service%20program%20Name=?&lsMEnter%20value(s)%20for%20Month=?&lsMEnter%20value(s)%20for%20Year=?") }
       { "Title": "Career Station Programmatic Outcomes – Combined", "DisplayName": "Career Station Programmatic Outcomes – Combined", "Template": (CWBreportServerURL + "reports/powerbi/HumanServices/CWB/Career%20Station%20Programmatic%20Outcomes%20-%20Combined") },
       { "Title": "Career Station Programmatic Outcomes – Monthly", "DisplayName": "Career Station Programmatic Outcomes – Monthly", "Template": (CWBreportServerURL + "reports/powerbi/HumanServices/CWB/Career%20Station%20Programmatic%20Outcomes%20-%20Monthly") }

    ];


    



    // Document menu items
    var documentItems = [];
    var getAllDocuments = function () {
        CustomCRUDService('Document', 'GetAll').GetAll(function (response) {

      
            var docs = response;
            if (response.active == true);
            for (var i = 0; i < docs.length; i++) {
                documentItems.push({
                    Title: docs[i].Name,
                    Link:  locationURL + docs[i].FileName
                    //,Template: "#/SelectedDocument"
                });
            }
        })
    };
    var usr = '';
    // Case Management Tab Options
    var getCurrentUser = function () {
        return httpCRUDService.GetAll('Account/getuser');
    };
    //user name
    var getUserName = function () {
        return httpCRUDService.GetAll('Account/Username');
    };
    // to registerall
    var registerall = function () {
        return httpCRUDService.GetAll('Account/RegisterAll');
    };
    //tyo reset the password
    //var resetpassword = function () {
    //    return httpCRUDService.GetAll('Account/Reset');
    //};

    // to mention the user groups

    var getcurrentgroups= function(){
        return httpCRUDService.GetAll('Login/getgroups');
    }
    //to get CSU users
  //var getCSUUsers=  function(){
  //      return httpCRUDService.GetAll('Aspnetusers');
  //  }


    var tabItems = [
        { "heading": "Search", "active": true, "disabled": false, "template": "views/casemanagement/search.html" },
        { "heading": "Juvenile Info", "active": false, "disabled": true, "template": "views/casemanagement/clientinfo.html" },
        { "heading": "Supplemental", "active": false, "disabled": true, "template": "views/casemanagement/supplemental.html" },
        { "heading": "Address", "active": false, "disabled": true, "template": "views/casemanagement/address.html" },
        { "heading": "Family Info", "active": false, "disabled": true, "template": "views/casemanagement/familyInfo.html" },
        { "heading": "Referral", "active": false, "disabled": true, "template": "views/casemanagement/referral.html" },        
        { "heading": "Assessment", "active": false, "disabled": true, "template": "views/casemanagement/assessment.html" }
    ];


    var tabAdultItems = [
        { "heading": "Search", "active": true, "disabled": false, "template": "views/casemanagement/search.html" },
        { "heading": "Adult Info", "active": false, "disabled": true, "template": "views/casemanagement/clientinfo.html" },
        { "heading": "Supplemental", "active": false, "disabled": true, "template": "views/casemanagement/supplemental.html" },
        { "heading": "Address", "active": false, "disabled": true, "template": "views/casemanagement/address.html" },
        { "heading": "Family Info", "active": false, "disabled": true, "template": "views/casemanagement/familyInfo.html" },
        { "heading": "Referral", "active": false, "disabled": true, "template": "views/casemanagement/referral.html" },
        { "heading": "Assessment", "active": false, "disabled": true, "template": "views/casemanagement/assessment.html" }
        
    ];

    var tabOCWBItems = [
       { "heading": "Search", "active": true, "disabled": false, "template": "views/casemanagement/search.html" },
       { "heading": "Participant Info", "active": false, "disabled": true, "template": "views/casemanagement/clientinfo.html" },
       { "heading": "Supplemental", "active": false, "disabled": true, "template": "views/casemanagement/supplemental.html" },
       { "heading": "Address", "active": false, "disabled": true, "template": "views/casemanagement/address.html" },
       { "heading": "Family Info", "active": false, "disabled": true, "template": "views/casemanagement/familyInfo.html" },
       { "heading": "Program", "active": false, "disabled": true, "template": "views/casemanagement/referral.html" },
       { "heading": "Assessment", "active": false, "disabled": true, "template": "views/casemanagement/assessment.html" }
       
    ];
    return {

        GetAdminMenuItems: function () { return adminMenuItems; },
        GetAdminAdultMenuItems: function () { return adminAdultMenuItems; },
        GetAdminOCWBMenuItems: function () { return adminOCWBMenuItems; },
        
        GetReportsMenuItems: function () { return reportsMenuItems; },
        GetAdultReportsMenuItems: function () { return reportsAdultMenuItems; },
        GetOCWBReportsMenuItems: function () { return reportsOCWBMenuItems; },

        GetDocumentMenuItems: function () { getAllDocuments(); return documentItems; },

        GetTabItems: function () { return tabItems; },
        GetAdultTabItems: function () { return tabAdultItems; },
        GetOCWBTabItems: function () { return tabOCWBItems; },

        Getusergroups: function () { return getcurrentgroups(); },
        GetCurrentUser: function () { return getCurrentUser(); },
        GetCSUUsers: function () { return getCSUUsers(); },
        GetUserName: function () { return getUserName(); },
        RegsisterAll: function () { return registerall(); }
        //ResetPassword: function () { return resetpassword();}

    };

}]);


app.factory('ConfigAdultService', ['CRUDAdultService', 'CustomCRUDAdultService', 'httpCRUDAdultService', 'locationURL', function (CRUDAdultService, CustomCRUDService, httpCRUDService, locationURL) {
    // Admin menu items
    var adminMenuItems = [
         { "Title": "AddressType", "DisplayName": "AddressType", "Template": "#/admin_addresstype" },
         { "Title": "AssessmentType", "DisplayName": "AssessmentType", "Template": "#/admin_assesstype" },
         { "Title": "AssessmentSubtype", "DisplayName": "AssessmentSubType", "Template": "#/admin_assesssubtype" },
         { "Title": "EducationLevel", "DisplayName": "EducationLevel", "Template": "#/admin_educationlevel" },
         { "Title": "JobStatus", "DisplayName": "JobStatus", "Template": "#/admin_jobstatus" },
         { "Title": "Judge", "DisplayName": "Judge", "Template": "#/admin_judge" },
         { "Title": "Offense", "DisplayName": "Offense", "Template": "#/admin_offense" },
         { "Title": "Race", "DisplayName": "Race", "Template": "#/admin_race" },
         { "Title": "Relationship", "DisplayName": "Relationship", "Template": "#/admin_relationship" },
         //{ "Title": "SanctionIncentives", "DisplayName": "Sanction Incentives", "Template": "#/admin_sanctionincentives" },
         //{ "Title": "School", "DisplayName": "School", "Template": "#/admin_school" },
         { "Title": "ServiceCategory", "DisplayName": "ServiceCategory", "Template": "#/admin_servicecategory" },
         { "Title": "ServiceOutcome", "DisplayName": "ServiceOutcome", "Template": "#/admin_serviceoutcome" },
         //{ "Title": "ServiceProgram", "DisplayName": "Service Program", "Template": "#/admin_serviceprogram" },
         { "Title": "ServiceProgramCategory", "DisplayName": "Service Program Category", "Template": "#/ServiceProCat" },
         //{ "Title": "ServiceProvider", "DisplayName": "Service Provider", "Template": "#/admin_serviceprovider" },
         { "Title": "ServiceRelease", "DisplayName": "Case Status", "Template": "#/admin_servicerelease" },
         //{ "Title": "ServiceUnit", "DisplayName": "Service Unit", "Template": "#/admin_serviceunit" },         
         { "Title": "Suffix", "DisplayName": "Suffix", "Template": "#/admin_suffix" },
         { "Title": "signup", "DisplayName": "Create & Update User", "Template": "#/signup" },
         { "Title": "Contact Type", "DisplayName": "Contact type", "Template": "#/admin_contacttype" }

        // { "Title": "LoginRole", "DisplayName": "Login Role", "Template": "#/admin_LoginRole" },
        // { "Title": "RoleAccess", "DisplayName": "Role Access", "Template": "#/admin_RoleAccess" },
        // { "Title": "Internal(GIS)", "DisplayName": "Internal (GIS) Address", "Template": "#/admin_internal(GIS)" },
        //{ "Title": "External(Bing)", "DisplayName": "External (Bing) Address", "Template": "#/admin_external(Bing)" }
    ];
    // Report menu items
    var reportsMenuItems = [
         { "Title": "JuvenilesbySpecificService", "DisplayName": "Juveniles by Specific Service", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AVXn4xkCXD9Jpn45EgTAkus&sIDType=CUID&sType=wid&sRefresh=Y") },
         { "Title": "ServicebyStaff", "DisplayName": "Service by Staff", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AVqZ3hzdklZJm68UbcoU7_E&sIDType=CUID&sType=wid&sRefresh=Y") },
         { "Title": "PrintableFamilyProfileReport", "DisplayName": "Printable Family Profile Report", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=Ae6kCMbv7kpHharsnteckcY&sIDType=CUID&sType=wid&sRefresh=Y") },
         { "Title": "EnrollmentReport", "DisplayName": "Enrollment Report", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AWq2i.hM8SZOmoQr3Ij9sOg&sIDType=CUID&sType=wid&sRefresh=Y") },
         { "Title": "Open Cases By Service", "DisplayName": " Open Cases By Service", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AbZv0hzu0FtLhchw_f8.OkA&sIDType=CUID&sType=wid&sRefresh=Y&lsMEnter%20value(s)%20for%20Service%20program%20Name=?") },
         { "Title": "Crime Control Service Units By Month", "DisplayName": " Crime Control Service Units By Month", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=AVst0R91nI5KhamoSfw3o8A&sIDType=CUID&sType=wid&sRefresh=Y&lsMEnter%20value(s)%20for%20Month=?&lsMEnter%20value(s)%20for%20Year=?") },
         {
           "Title": "CrimeControlReport", "DisplayName": "Crime Control Report", "Template": (reportServerURL + "BOE/OpenDocument/opendoc/openDocument.jsp?iDocID=ARmvPFVMljNBgx4zV2g0dZw&sIDType=CUID&sType=wid&sRefresh=Y&lsSEnter%20End%20Fiscal%20Year%3A=?&lsMEnter%20FY%20Ending%20Months%3A=?&lsSEnter%20Start%20Fiscal%20Year%3A=?&lsMEnter%20FY%20Start%20Months%3A=?&lsSEnter%20Service%20program%20Name%3A=?")
         }

    ];

    // Document menu items
    var documentItems = [];
    var getAllDocuments = function () {
        CustomCRUDService('Document', 'GetAll').GetAll(function (response) {


            var docs = response;
            if (response.active == true);
            for (var i = 0; i < docs.length; i++) {
                documentItems.push({
                    Title: docs[i].Name,
                    Link: locationURL + docs[i].FileName
                    //,Template: "#/SelectedDocument"
                });
            }
        })
    };
    var usr = '';
    // Case Management Tab Options
    var getCurrentUser = function () {
        return httpCRUDAdultService.GetAll('Account/getuser');
    };
    //user name
    var getUserName = function () {
        return httpCRUDAdultService.GetAll('Account/Username');
    };
    // to registerall
    var registerall = function () {
        return httpCRUDAdultService.GetAll('Account/RegisterAll');
    };
    //tyo reset the password
    //var resetpassword = function () {
    //    return httpCRUDService.GetAll('Account/Reset');
    //};

    // to mention the user groups

    var getcurrentgroups = function () {
        return httpCRUDAdultService.GetAll('Login/getgroups');
    }
    //to get CSU users
    //var getCSUUsers=  function(){
    //      return httpCRUDService.GetAll('Aspnetusers');
    //  }


    var tabItems = [
        { "heading": "Search", "active": true, "disabled": false, "template": "views/casemanagement/search.html" },
        { "heading": "Juvenile Info", "active": false, "disabled": true, "template": "views/casemanagement/clientinfo.html" },
        { "heading": "Supplemental", "active": false, "disabled": true, "template": "views/casemanagement/supplemental.html" },
        { "heading": "Address", "active": false, "disabled": true, "template": "views/casemanagement/address.html" },
        { "heading": "Family Info", "active": false, "disabled": true, "template": "views/casemanagement/familyInfo.html" },
        { "heading": "Referral", "active": false, "disabled": true, "template": "views/casemanagement/referral.html" },
        { "heading": "Assessment", "active": false, "disabled": true, "template": "views/casemanagement/assessment.html" }
    ];
    return {

        GetAdminMenuItems: function () { return adminMenuItems; },
        GetReportsMenuItems: function () { return reportsMenuItems; },
        GetAdultReportsMenuItems: function () { return reportsAdultMenuItems; },
        GetDocumentMenuItems: function () { getAllDocuments(); return documentItems; },
        GetTabItems: function () { return tabItems; },
        Getusergroups: function () { return getcurrentgroups(); },
        GetCurrentUser: function () { return getCurrentUser(); },
        GetCSUUsers: function () { return getCSUUsers(); },
        GetUserName: function () { return getUserName(); },
        RegsisterAll: function () { return registerall(); }
        //ResetPassword: function () { return resetpassword();}

    };

}]);

// To Handle all Admin Maintenance Pages CRUD functionality
app.factory('CRUDService', ['$resource', 'servicesURL', 'localStorageService', '$rootScope', '$location', function ($resource, servicesURL, localStorageService, $rootScope, $location) {
    return function (entityName) {
        //var serviceBase = ngAuthSettings.apiServiceBaseUri;
       //var authData = localStorageService.get('authorizationData');
       // $rootScope.ShowNavbar = angular.copy(authData);
       // if (!authData) {
       //     // window.location = "login.html";
       //     $location.path('/login');
       //     return;
       // }
        return $resource(servicesURL + entityName + '/:ID', { ID: '@id' }, {
            'GetAll': { method: 'GET', isArray: true }, // returns all entities
            'Find': { method: 'GET' }, // returns selected entity using ID
            'Update': { method: 'PUT' }, // Updates entity using ID
            'Create': { method: 'POST' },  // Creates new entity   
            'Delete': { method: 'POST'},  // Deletes entity   
        });
    };
}]);


//app.factory('CRUDAdultService', ['$resource', 'servicesAdultURL', 'localStorageService', '$rootScope', '$location', function ($resource, servicesAdultURL, localStorageService, $rootScope, $location) {
//    return function (entityName) {
//        //var serviceBase = ngAuthSettings.apiServiceBaseUri;
//        //var authData = localStorageService.get('authorizationData');
//        // $rootScope.ShowNavbar = angular.copy(authData);
//        // if (!authData) {
//        //     // window.location = "login.html";
//        //     $location.path('/login');
//        //     return;
//        // }
//        return $resource(servicesAdultURL + entityName + '/:ID', { ID: '@id' }, {
//            'GetAll': { method: 'GET', isArray: true }, // returns all entities
//            'Find': { method: 'GET' }, // returns selected entity using ID
//            'Update': { method: 'PUT' }, // Updates entity using ID
//            'Create': { method: 'POST' },  // Creates new entity   
//            'Delete': { method: 'POST' },  // Deletes entity   
//        });
//    };
//}]);

//custom crud servive  for admin module
app.factory('CustomCRUDService', ['$resource', 'servicesURL', function ($resource, servicesURL) {
    return function (entityName, operation) {
        //var serviceBase = ngAuthSettings.apiServiceBaseUri;
        return $resource(servicesURL + entityName + '/' + operation + '/:ID', { ID: '@id' }, {
            'GetAll': { method: 'GET', isArray: true }, // returns all entities
            'Find': { method: 'GET' }, // returns selected entity using ID
            'Update': { method: 'PUT' }, // Updates entity using ID
            'Create': { method: 'POST' },  // Creates new entity   
            'Delete': { method: 'GET' },  // Deletes entity   
        });
    };
}]);


//app.factory('CustomCRUDAdultService', ['$resource', 'servicesAdultURL', function ($resource, servicesAdultURL) {
//    return function (entityName, operation) {
//        //var serviceBase = ngAuthSettings.apiServiceBaseUri;
//        return $resource(servicesAdultURL + entityName + '/' + operation + '/:ID', { ID: '@id' }, {
//            'GetAll': { method: 'GET', isArray: true }, // returns all entities
//            'Find': { method: 'GET' }, // returns selected entity using ID
//            'Update': { method: 'PUT' }, // Updates entity using ID
//            'Create': { method: 'POST' },  // Creates new entity   
//            'Delete': { method: 'GET' },  // Deletes entity   
//        });
//    };
//}]);


//Common factory for create, update, read(get), delete operations
app.service('httpCRUDService', ['$rootScope', '$http', '$q', 'servicesURL', function ($rootScope, $http, $q, servicesURL) {
    
    var parseUrl = servicesURL;

    return {
        //Create a db object on server
        Post: function (ActionName, data) {
            var url = parseUrl + ActionName;
            var reqObj = JSON.parse(JSON.stringify(data));
            var request = $http.post(
                  url,
                  reqObj,
                  reqconfig
              );
            return (request.then(handleSuccess, handleError));
        },
        //Post a db object on server with id
        PostById: function (ActionName, data, Id) {
                var url = parseUrl + ActionName + '/' + Id;
                var reqObj = JSON.parse(JSON.stringify(data));
                var request = $http.post(
                      url,
                      reqObj,
                      reqconfig
                  );
                return (request.then(handleSuccess, handleError));
            },
        //Update a db object on server
        Put: function (EntityName, data, Id) {
            var url = parseUrl + EntityName + '/' + Id;
            //  var reqObj = JSON.parse(JSON.stringify(data));
            var request = $http.post(
				url,
				data,
				reqconfig
			)
            return (request.then(handleSuccess, handleError));
        },
        //Get a db object by id
        GetAll: function (EntityName) {
            var rurl = parseUrl + EntityName;
            var request = $http({
                method: 'GET',
                withCredentials: true,
                data: 'json',
                url: rurl
            });
            return (request.then(handleSuccess, handleError));
        },
        //Get a list of db objects with query
        Get: function (EntityName, Id) {
            var rurl = parseUrl + EntityName + '/' + Id;
            var request = $http({
                method: 'GET',
                data: 'json',
                url: rurl
            });
            return (request.then(handleSuccess, handleError));
        },
        //Remove a db object
        Remove: function (EntityName, objectId) {
            var request = $http['delete']( //['delete'] to get around using delete js keyword
				parseUrl + EntityName + '/' + objectId
			);
            return (request.then(handleSuccess, handleError));

        }
    };

    //transform the successful response, unwrapping the application data
    // from the API response payload.
    function handleSuccess(response) {
        var result = {};
        result.data = response.data;
        result.StatusCode = response.status;
        result.StatusMessage = response.StatusMessage;
        return (result);
    }
    // transform the error response, unwrapping the application dta from
    // the API response payload.
    function handleError(response) {
        // The API response from the server should be returned in a
        // nomralized format. However, if the request was not handled by the
        // server (or what not handles properly - ex. server error), then we
        // may have to normalize it on our end, as best we can.

        var result = {};

        result.data = response.data;
        result.StatusCode = response.status;
        result.StatusMessage = response.data.Message;

        return (result);

    }
}]);


//app.service('httpCRUDAdultService', ['$rootScope', '$http', '$q', 'servicesAdultURL', function ($rootScope, $http, $q, servicesAdultURL) {
    
//    var parseUrl = servicesAdultURL;

//    return {
//        //Create a db object on server
//        Post: function (ActionName, data) {
//            var url = parseUrl + ActionName;
//            var reqObj = JSON.parse(JSON.stringify(data));
//            var request = $http.post(
//                  url,
//                  reqObj,
//                  reqconfig
//              );
//            return (request.then(handleSuccess, handleError));
//        },
//        //Post a db object on server with id
//        PostById: function (ActionName, data, Id) {
//                var url = parseUrl + ActionName + '/' + Id;
//                var reqObj = JSON.parse(JSON.stringify(data));
//                var request = $http.post(
//                      url,
//                      reqObj,
//                      reqconfig
//                  );
//                return (request.then(handleSuccess, handleError));
//            },
//        //Update a db object on server
//        Put: function (EntityName, data, Id) {
//            var url = parseUrl + EntityName + '/' + Id;
//            //  var reqObj = JSON.parse(JSON.stringify(data));
//            var request = $http.post(
//				url,
//				data,
//				reqconfig
//			)
//            return (request.then(handleSuccess, handleError));
//        },
//        //Get a db object by id
//        GetAll: function (EntityName) {
//            var rurl = parseUrl + EntityName;
//            var request = $http({
//                method: 'GET',
//                withCredentials: true,
//                data: 'json',
//                url: rurl
//            });
//            return (request.then(handleSuccess, handleError));
//        },
//        //Get a list of db objects with query
//        Get: function (EntityName, Id) {
//            var rurl = parseUrl + EntityName + '/' + Id;
//            var request = $http({
//                method: 'GET',
//                data: 'json',
//                url: rurl
//            });
//            return (request.then(handleSuccess, handleError));
//        },
//        //Remove a db object
//        Remove: function (EntityName, objectId) {
//            var request = $http['delete']( //['delete'] to get around using delete js keyword
//				parseUrl + EntityName + '/' + objectId
//			);
//            return (request.then(handleSuccess, handleError));

//        }
//    };

//    //transform the successful response, unwrapping the application data
//    // from the API response payload.
//    function handleSuccess(response) {
//        var result = {};
//        result.data = response.data;
//        result.StatusCode = response.status;
//        result.StatusMessage = response.StatusMessage;
//        return (result);
//    }
//    // transform the error response, unwrapping the application dta from
//    // the API response payload.
//    function handleError(response) {
//        // The API response from the server should be returned in a
//        // nomralized format. However, if the request was not handled by the
//        // server (or what not handles properly - ex. server error), then we
//        // may have to normalize it on our end, as best we can.

//        var result = {};

//        result.data = response.data;
//        result.StatusCode = response.status;
//        result.StatusMessage = response.data.Message;

//        return (result);

//    }
//}]);

var reqconfig = {
    responsetype: 'json',
    headers: {
        'Accept': 'application/json', 'Content-Type': 'application/json'
    }
};


// Factory to make all Case Management use case service calls
app.factory('CaseMgtService', ['$resource', 'servicesURL', '$rootScope', 'localStorageService', '$location', function ($resource, servicesURL, $rootScope, localStorageService, $location) {
    return function (entityName) {
        // var serviceBase = ngAuthSettings.apiServiceBaseUri;
         //var authData = localStorageService.get('authorizationData');
         //$rootScope.ShowNavbar = authData;
         //if (!authData) {
         //    // window.location = "login.html";
         //    $location.path('/login');
         //    return;
         //}
         return $resource(servicesURL + entityName + '/:ID', { ID: '@id' }, {
            'SearchClientProfile': { method: 'POST', isArray: true },  // returns all matching Client Profiles
            'SearchClientProfile1': { method: 'GET', isArray: true },  // returns all matching Client Profiles
            'GetClientProfileToDelete': { method: 'GET', isArray: true },  // returns all matching Client which are updated as inactive
            'DeleteClientProfile': { method: 'GET' },//Inactive the client
            'ActivateClient': {method: 'GET'},//Active the client
            'DeleteMultipleClients': { method: 'POST', isArray: false },
            'SearchServiceProgram': { method: 'GET' , isArray: true  },//Active the client'
            'GetPlacementsByClientProfile': { method: 'GET', isArray: true },  // returns collection of Placements
            'Deleteplacementbyid': { method: 'GET' },
            'GetEnrollmentsByPlacements': { method: 'GET', isArray: true },  // returns collection of Enrollments 
            'DeleteEnrollmentsByPlacements': { method: 'GET', isArray: false },  //deletes the enrollments
            'UpdateEnrollment': { method: 'PUT', isArray: false },
            'UpdateProgressNote': { method: 'PUT', isArray: false },
            'UpdateServiceUnit': { method: 'PUT', isArray: false },
            'GetServiceUnitsForEnrollment': { method: 'GET', isArray: true },  // returns collection of ServiceUnits
            'DeleteServiceUnitforEnrollment': { method: 'GET', isArray: false },  // deletes collection of ServiceUnits
            'GetProgressNotesForEnrollment': { method: 'GET', isArray: true },  // returns collection of ProgressNotes
            'DeleteProgressNotesForEnrollment': { method: 'GET', isArray: false },  // Deletes collection of ProgressNotes   
            'GetFamilyProfilesForPerson': { method: 'GET', isArray: true },  // returns collection of FamilyProfiles
            'DeleteFamilyProfilesForPerson': { method: 'GET', isArray: false },
            'GetAllPersonsWithNoClientProfile': { method: 'GET', isArray: true },  // returns collection of Persons without ClientProfile   
            'GetAssessmentsForClientProfile': { method: 'GET', isArray: true },  // returns collection of Assessments for ClientProfileId   
            'DeleteAssessmentbyid': { method: 'GET', isArray: false },
            'GetduplicatePersons': { method: 'GET', isArray: true },
             //Employment and action plan.
            'UpdateEmploymentPlan': { method: 'PUT', isArray: false },
            'UpdateActionPlan': { method: 'PUT', isArray: false },
            'GetEmploymentForEnrollment': { method: 'GET', isArray: true },
            'DeleteEmploymentPlan': { method: 'GET', isArray: false },
            'GetActionPlansForEmploymentPlan': { method: 'GET', isArray: true },
            'DeleteActionPlansForEmploymentPlan': { method: 'GET', isArray: false },
             

        });
    };
}]);


//app.factory('CaseMgtAdultService', ['$resource', 'servicesAdultURL', '$rootScope', 'localStorageService', '$location', function ($resource, servicesAdultURL, $rootScope, localStorageService, $location) {
//    return function (entityName) {
//        // var serviceBase = ngAuthSettings.apiServiceBaseUri;
//        //var authData = localStorageService.get('authorizationData');
//        //$rootScope.ShowNavbar = authData;
//        //if (!authData) {
//        //    // window.location = "login.html";
//        //    $location.path('/login');
//        //    return;
//        //}
//        return $resource(servicesAdultURL + entityName + '/:ID', { ID: '@id' }, {
//            'SearchClientProfile': { method: 'POST', isArray: true },  // returns all matching Client Profiles
//            'SearchClientProfile1': { method: 'GET', isArray: true },  // returns all matching Client Profiles
//            'GetClientProfileToDelete': { method: 'GET', isArray: true },  // returns all matching Client which are updated as inactive
//            'DeleteClientProfile': { method: 'GET' },//Inactive the client
//            'ActivateClient': { method: 'GET' },//Active the client
//            'DeleteMultipleClients': { method: 'POST', isArray: false },
//            'SearchServiceProgram': { method: 'GET', isArray: true },//Active the client'
//            'GetPlacementsByClientProfile': { method: 'GET', isArray: true },  // returns collection of Placements
//            'Deleteplacementbyid': { method: 'GET' },
//            'GetEnrollmentsByPlacements': { method: 'GET', isArray: true },  // returns collection of Enrollments 
//            'DeleteEnrollmentsByPlacements': { method: 'GET', isArray: false },  //deletes the enrollments
//            'UpdateEnrollment': { method: 'PUT', isArray: false },
//            'UpdateProgressNote': { method: 'PUT', isArray: false },
//            'UpdateServiceUnit': { method: 'PUT', isArray: false },
//            'GetServiceUnitsForEnrollment': { method: 'GET', isArray: true },  // returns collection of ServiceUnits
//            'DeleteServiceUnitforEnrollment': { method: 'GET', isArray: false },  // deletes collection of ServiceUnits
//            'GetProgressNotesForEnrollment': { method: 'GET', isArray: true },  // returns collection of ProgressNotes
//            'DeleteProgressNotesForEnrollment': { method: 'GET', isArray: false },  // Deletes collection of ProgressNotes   
//            'GetFamilyProfilesForPerson': { method: 'GET', isArray: true },  // returns collection of FamilyProfiles
//            'DeleteFamilyProfilesForPerson': { method: 'GET', isArray: false },
//            'GetAllPersonsWithNoClientProfile': { method: 'GET', isArray: true },  // returns collection of Persons without ClientProfile   
//            'GetAssessmentsForClientProfile': { method: 'GET', isArray: true },  // returns collection of Assessments for ClientProfileId   
//            'DeleteAssessmentbyid': { method: 'GET', isArray: false },
//            'GetduplicatePersons': { method: 'GET', isArray: true },


//        });
//    };
//}]);

// Consume Bing service to retrive matching addresses for addressLine
app.factory('BingService', ['$resource', function ($resource) {
    return function (addressLine) {
        var url = "https://dev.virtualearth.net/REST/v1/Locations?countryRegion=US&addressLine=" + addressLine + "&jsonp=JSON_CALLBACK&key=AioE2WYI4PFEB6QJ05ws3SYzEfBmT4Dq4GcO-ACemmZnFi5pyKjXeE44i9Qz0QOS";

        return $resource(url, { }, {
            'GetMatchingAddresses': { method: 'JSONP' },

        });
    };
}]);

// Consume GIS service to retrive matching addresses for addressLine
//app.factory('GISService', ['$resource', 'GISServiceURL','$http', function ($resource, GISServiceURL,$http) {
//    return function (term) {
       
//        return $resource("https://gis.richmondgov.com/ArcGIS/rest/services/Geocode/RichmondAddress/GeocodeServer/findAddressCandidates?callback=?&outFields=*&f=json&Street=" + term, {},
//            {

//                'GetAllAddresses': { type: 'GET', crossDomain: true, } // returns all matching addresses 
//            });
        
//    };
//}]);



 // WORKING ONE WITH $http
app.factory('GISService', ['$resource', 'GISServiceURL', '$rootScope', 'httpCRUDService', function ($resource, GISServiceURL, $rootScope, httpCRUDService) {
    return function (term) {
        $rootScope.Addresses = {};

        return url = $.getJSON("gis.richmondgov.com/ArcGIS/rest/services/Geocode/RichmondAddress/GeocodeServer/findAddressCandidates?callback=?", {
            f: "pjson", Street: term, outFields: "*"
        }, function (data) {
            return data.candidates;
        }
           );
    };
    return {


}

}]);

// Used to update datbase migration data from Admin menu
app.factory('BingServiceDB', ['$resource', function ($resource) {
    
    return function (addressLine, locality) {
        var url = "https://dev.virtualearth.net/REST/v1/Locations?countryRegion=US&addressLine=" + addressLine + "&locality=" + locality + "&jsonp=JSON_CALLBACK&key=AioE2WYI4PFEB6QJ05ws3SYzEfBmT4Dq4GcO-ACemmZnFi5pyKjXeE44i9Qz0QOS";

        return $resource(url, { }, {
            'GetLocationDetails': { method: 'JSONP' },
        });
    };

}]);

// Used to update datbase migration data from Admin menu
app.factory('GISServiceDB', ['$resource', function ($resource) {
    return function (GISCode) {
        var url = "http://eservices.ci.richmond.va.us/services/GIS/geodata/addresses/" +GISCode + "?f=json";

    return $resource(url, { }, {
            'GetAddressDetails' : { method: 'GET'},
    });
    };
}]);



app.factory('Commonfunction', ['$rootScope', '$http', '$q', 'servicesURL', function ($rootScope, $http, $q, servicesURL) {

    var arr = servicesURL.split("/");
    //var jasonformat = {};
    var returnobj = [];
    var _DJSState = 0;
    var _CWBState = 0;
	
    if ((arr.indexOf('AdultService') > 0) || (arr.indexOf('empoweradultapi') > 0))
    {
        _DJSState = 1;
        _CWBState = 0;
        
	
    }
    if ((arr.indexOf('services') > 0) || (arr.indexOf('empowerjuvenileapi') > 0)) {
        _DJSState = 1;
        _CWBState = 0;
    }
    if ((arr.indexOf('CWBService') > 0) || (arr.indexOf('empowercwbapi') > 0))
    {
        _DJSState = 0;
        _CWBState = 1;
    }
    returnobj = 
	{
	    "DJSState":  _DJSState,
	    "CWBState": _CWBState,
	}
    
    return {

        //GetDocumentMenuItems: function () { getAllDocuments(); return documentItems; },
        GetSystemState: function ()
        {
            return returnobj;
            //scope.coloredContent = [];
			
        }
    }

}])

