/*** Configure the Routes */
app.config(['$routeProvider', function ($routeProvider) {
 
  
    $routeProvider
        // Home 
        .when("/", { templateUrl: "views/home/home.html", controller: "HomeController" })
        .when("/home", {
            templateUrl: "views/home/home.html", controller: "HomeController"
        })
        //.when("/", { templateUrl: "views/admin/login.html", controller: "loginController" })
         
          //login page
        .when("/login", {
            templateUrl: "views/admin/login.html",
            controller: "loginController"
        })
        //signup page
          .when("/signup", {
        controller: "signupController",
        templateUrl: "views/admin/signup.html"
    })
        // Under Design Page
        .when("/underdesign", { templateUrl: "views/common/underdesign.html", controller: "UnderConstructionController" })

        // Case Management Menu Item
        .when("/casemgt", { templateUrl: "views/casemanagement/index.html", controller: "CaseManagementController" })

        // Reports Menu
            
        // Documents        

        // Admin Menu 
        // Upload a Service Profile
        .when("/admin_document", {
            templateUrl: "views/admin/documentPage.html",
            controller: "DocumentController",
            // Pass Table Name as CurrentEntity
            resolve: { CurrentEntity: function () { return 'Document'; } }
        })
      //Delete the pending clients 
      .when("/deleteProfile", {

          templateUrl: "views/admin/deleteProfile.html",
          controller: "ClientSearchController",
      })
        //Service Program Category
         .when("/ServiceProCat", {

             templateUrl: "views/admin/ServiceProCat.html",
             controller: "AdminServiceProgramCategory",
         })

     
        // Address Type
        .when("/admin_addresstype", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity
            resolve: { CurrentEntity: function () { return 'AddressType'; }, IsSystemSpecific: function () { return 'false'; } }
        })
        // Assessment Type
        .when("/admin_assesstype", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'AssessmentType'; }, IsSystemSpecific: function () { return 'true'; } }
        })
        // Assessment Sub Type
        .when("/admin_assesssubtype", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'AssessmentSubtype'; }, IsSystemSpecific: function () { return 'true'; } }
        })
        // Assistance Type
        .when("/admin_assistancetype", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'AssistanceType'; }, IsSystemSpecific: function () { return 'true'; } }
        })
        // Career Pathway
        .when("/admin_careerpathway", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'CareerPathway'; }, IsSystemSpecific: function () { return 'true'; } }
        })
        // Education Level
        .when("/admin_educationlevel", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'EducationLevel'; }, IsSystemSpecific: function () { return 'false'; } }
        })        
        // Job Status
        .when("/admin_jobstatus", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'JobStatus'; }, IsSystemSpecific: function () { return 'false'; } }
        })
        // Judge
        .when("/admin_judge", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'Judge'; }, IsSystemSpecific: function () { return 'true'; } }
        })
        // Offense
        .when("/admin_offense", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            resolve: { CurrentEntity: function () { return 'Offense'; }, IsSystemSpecific: function () { return 'true'; } }
        })
        //case status
              // Offense
        .when("/admin_CaseStatus", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            resolve: { CurrentEntity: function () { return 'offense/CaseStatus'; }, IsSystemSpecific: function () { return 'true'; } }
        })

        // Race
        .when("/admin_race", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'Race'; }, IsSystemSpecific: function () { return 'false'; } }
        })
        // Relationship
        .when("/admin_relationship", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'Relationship'; }, IsSystemSpecific: function () { return 'false'; } }
        })
        // Sanction Incentives
        .when("/admin_sanctionincentives", {
            templateUrl: "views/common/underdesign.html",
            controller: "UnderConstructionController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'Sanction Incentives'; } }
        })
        // School
        .when("/admin_school", {
            templateUrl: "views/admin/schoolPage.html",
            controller: "SchoolController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'School'; } }
        })
        // Service Category
        .when("/admin_servicecategory", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'ServiceCategory'; }, IsSystemSpecific: function () { return 'true'; } }
        })
        // Service Outcome
        .when("/admin_serviceoutcome", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'ServiceOutcome'; }, IsSystemSpecific: function () { return 'true'; } }
        })
        // Service Program
        .when("/admin_serviceprogram", {
            templateUrl: "views/common/underdesign.html",
            controller: "UnderConstructionController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'Service Program'; } }
        })
        // Service Program Category
        .when("/admin_serviceprogramcategory", {
            templateUrl: "views/common/underdesign.html",
            controller: "UnderConstructionController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'Service Program Category'; } }
        })
        // Service Provider
        .when("/admin_serviceprovider", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'ServiceProvider'; }, IsSystemSpecific: function () { return 'true'; } }
        })
        // Service Release
        .when("/admin_servicerelease", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'ServiceRelease'; }, IsSystemSpecific: function () { return 'true'; } }
        })
         // contact type
        .when("/admin_contacttype", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity, true as IsSystemSpecific if Table contains System as FK, else false
            resolve: { CurrentEntity: function () { return 'ContactType'; }, IsSystemSpecific: function () { return 'true'; } }
        })
        // Suffix
        .when("/admin_suffix", {
            templateUrl: "views/admin/adminCommonPage.html",
            controller: "AdminCommonController",
            // Pass Table Name as CurrentEntity
            resolve: { CurrentEntity: function () { return 'Suffix'; }, IsSystemSpecific: function () { return 'false'; } }
        })
        // Login Role
        .when("/admin_LoginRole", {
            templateUrl: "views/common/underdesign.html",
            controller: "UnderConstructionController"
        })
        // Role Access
        .when("/admin_RoleAccess", {
            templateUrl: "views/common/underdesign.html",
            controller: "UnderConstructionController"
        })
        //address page
         .when("/address", { templateUrl: "views/casemanagement/address.html", controller: "CaseManagementController" })

        // Internal (GIS)
        .when("/admin_internal(GIS)", {
            templateUrl: "views/personAddress/internal(GIS).html",
            controller: "InternalController"
        })
        // External (Bing)
        .when("/admin_external(Bing)", {
            templateUrl: "views/personAddress/external(Bing).html",
            controller: "ExternalController"
        })
         .when("/nf", { templateUrl: "views/common/NotFound.html", controller: "" })

        .when("/associate", {
            controller: "associateController",
            templateUrl: "/views/associate.html"
        })
       

        // If app does not find  any pages
        //.otherwise("/nf", { templateUrl: "views/common/underdesign.html", controller: "UnderConstructionController" });
}]);

