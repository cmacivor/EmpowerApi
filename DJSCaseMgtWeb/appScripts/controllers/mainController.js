/// <reference path="C:\Dev\JusticeServices\Main\Source\DJSCaseMgt\DJSCaseMgtWeb\views/common/unauth.html" />
/// <reference path="C:\Dev\JusticeServices\Main\Source\DJSCaseMgt\DJSCaseMgtWeb\views/common/unauth.html" />
/// <reference path="C:\Dev\JusticeServices\Main\Source\DJSCaseMgt\DJSCaseMgtWeb\views/common/unauth.html" />
// Common controller for all needs
app.controller('HomeController', ['$scope', '$location', '$http', '$rootScope', 'authService', function ($scope, $location, $http, $rootScope, authService) {
    //httpCRUDService.GetAll('Login/GetAuthentication').then(function (result) {
    //    if (result.StatusCode != 200) {

    //        $window.location.href = "/unauth.html"
   
    //    }
    //    else {
    //        $window.location.href = "/unauth.html"
    //    }

    //});
    // Activates the Carousel
    if ($rootScope.SystemID == "1" || $rootScope.SystemID == "2")
    {

    }
    $('.carousel').carousel({
        interval: 5000
    });

    // Activates Tooltips for Social Links
    $('.tooltip-social').tooltip({
        selector: "a[data-toggle=tooltip]"
    })
    
    $scope.authentication = authService.authentication;
}]);

// Cotroller for under construction page
app.controller('UnderConstructionController', ['$scope', function ($scope) {
    

}]);
//filter for placement




// Menu Configuration Controller, to generate menu items 
app.controller('MenuConfigController', ['$scope', '$rootScope', '$cookieStore', '$timeout', '$route', 'ConfigService', 'authService', '$location', '$window', 'localStorageService', 'CaseMgtService', function ($scope, $rootScope, $cookieStore, $timeout, $route, ConfigService, authService, $location, $window, localStorageService, CaseMgtService) {
    
    $rootScope.validGroupUser = false;
    // Get all Docuemnt Menu Items from database
    $scope.DocumentMenuItems = ConfigService.GetDocumentMenuItems();
    // Get all Admin Menu Items
    $scope.AdminMenuItems = ConfigService.GetAdminMenuItems();


    //regsiter all users from staff table 

    $scope.registerallusers = function () {


        var reall = ConfigService.RegsisterAll();
        return reall;
    }
    $rootScope.registerallusers = angular.copy($scope.registerallusers);

    // to reset the password 

    //$scope.ResetPasswordbyusername = function () {


    //    var resetpassword = ConfigService.ResetPassword();
    //    return reall;
    //}



    //to get userName
    ConfigService.GetUserName().then(function (result) {

        $scope.currentuser = result.data;
        $rootScope.CurrentUser = angular.copy($scope.currentuser);

    });

    ConfigService.GetCurrentUser().then(function (result) {
    
     
     $scope.CurrentUserole = angular.copy(result.data);
     $rootScope.CurrentUserole = angular.copy($scope.CurrentUserole);

     //get all reports 
    if ($rootScope.CurrentUserole == "AdultAdmin")
    {
        alert("City of Richmond *** W A R N I N G ***  EMPOWER contains privileged, confidential client information which may include sensitive information from other Local, State and Federal government agencies. Access to this application is restricted to authorized users ONLY. Unauthorized access, use, misuse, or modification of this computer system or of the data contained herein or in transit to/from this system is strictly forbidden. This system and equipment are subject to monitoring to ensure proper performance of applicable security features or procedures. Such monitoring may result in the acquisition, recording and analysis of all data being communicated, transmitted, processed or stored in this system by a user. If monitoring reveals possible evidence of criminal activity, such evidence may be provided to Law Enforcement Personnel. By continuing, you consent to such monitoring and agree to only use the application to review client records and any information contained therein specifically for the purpose of service provision for those clients and their families assigned to you as part of your normal job duties.");
        $scope.ReportsMenuItems = ConfigService.GetAdultReportsMenuItems();
       // $.scope.DeletePendingProfile = "";
        $scope.AdminMenuItems = ConfigService.GetAdminAdultMenuItems();
        $scope.JuvenileHeader = false;
        $scope.AdultHeader = true;
        $scope.CWBHeader = false;
        //$scope.showReportCaseManager = false;
        $rootScope.SystemID = "2";
        $scope.lblApplicationName = "EMPOWER Referral for Services";
        
    }
    else if ($rootScope.CurrentUserole == "AdultCaseManager") {
        alert("City of Richmond *** W A R N I N G ***  EMPOWER contains privileged, confidential client information which may include sensitive information from other Local, State and Federal government agencies. Access to this application is restricted to authorized users ONLY. Unauthorized access, use, misuse, or modification of this computer system or of the data contained herein or in transit to/from this system is strictly forbidden. This system and equipment are subject to monitoring to ensure proper performance of applicable security features or procedures. Such monitoring may result in the acquisition, recording and analysis of all data being communicated, transmitted, processed or stored in this system by a user. If monitoring reveals possible evidence of criminal activity, such evidence may be provided to Law Enforcement Personnel. By continuing, you consent to such monitoring and agree to only use the application to review client records and any information contained therein specifically for the purpose of service provision for those clients and their families assigned to you as part of your normal job duties.");
        $scope.ReportsMenuItems = ConfigService.GetAdultReportsMenuItems();
        // $.scope.DeletePendingProfile = "";
        $scope.AdminMenuItems = ConfigService.GetAdminAdultMenuItems();
        $scope.JuvenileHeader = false;
        $scope.AdultHeader = false;
        $scope.CWBHeader = false;
        //$scope.showReportCaseManager = true;
        $rootScope.SystemID = "2";
        $scope.lblApplicationName = "EMPOWER Referral for Services";

    }
    else if ($rootScope.CurrentUserole == "admin" || $rootScope.CurrentUserole == "csu" || $rootScope.CurrentUserole == "djs" || $rootScope.CurrentUserole == "superuser")
    {
        alert("City of Richmond *** W A R N I N G ***  EMPOWER contains privileged, confidential client information which may include sensitive information from other Local, State and Federal government agencies. Access to this application is restricted to authorized users ONLY. Unauthorized access, use, misuse, or modification of this computer system or of the data contained herein or in transit to/from this system is strictly forbidden. This system and equipment are subject to monitoring to ensure proper performance of applicable security features or procedures. Such monitoring may result in the acquisition, recording and analysis of all data being communicated, transmitted, processed or stored in this system by a user. If monitoring reveals possible evidence of criminal activity, such evidence may be provided to Law Enforcement Personnel. By continuing, you consent to such monitoring and agree to only use the application to review client records and any information contained therein specifically for the purpose of service provision for those clients and their families assigned to you as part of your normal job duties.");
        $scope.ReportsMenuItems = ConfigService.GetReportsMenuItems();
        //$.scope.DeletePendingProfile = "Delete Pending Profile(s)";
        $scope.AdminMenuItems = ConfigService.GetAdminMenuItems();
        $scope.JuvenileHeader = true;
        $scope.AdultHeader = false;
        $scope.CWBHeader = false;
        //$scope.showReportCaseManager = false;
        $rootScope.SystemID = "1";
        $scope.lblApplicationName = "EMPOWER Referral for Services";
    }

    else if ($rootScope.CurrentUserole == "OCWBAdmin")
    {
        //alert("City of Richmond *** W A R N I N G ***  EMPOWER contains privileged, confidential client information which may include sensitive information from other Local, State and Federal government agencies. Access to this application is restricted to authorized users ONLY. Unauthorized access, use, misuse, or modification of this computer system or of the data contained herein or in transit to/from this system is strictly forbidden. This system and equipment are subject to monitoring to ensure proper performance of applicable security features or procedures. Such monitoring may result in the acquisition, recording and analysis of all data being communicated, transmitted, processed or stored in this system by a user. If monitoring reveals possible evidence of criminal activity, such evidence may be provided to Law Enforcement Personnel. By continuing, you consent to such monitoring and agree to only use the application to review client records and any information contained therein specifically for the purpose of service provision for those clients and their families assigned to you as part of your normal job duties.");
        $scope.ReportsMenuItems = ConfigService.GetOCWBReportsMenuItems();
        // $.scope.DeletePendingProfile = "";
        $scope.AdminMenuItems = ConfigService.GetAdminOCWBMenuItems();
        $scope.JuvenileHeader = false;
        $scope.AdultHeader = false;
        $scope.CWBHeader = true;
        //$scope.showReportCaseManager = true;
        $rootScope.SystemID = "3";
        $scope.lblApplicationName = "Office of Community Wealth Building Case Managment";

    }
    else if ($rootScope.CurrentUserole == "OCWBCaseManager") {
        //alert("City of Richmond *** W A R N I N G ***  EMPOWER contains privileged, confidential client information which may include sensitive information from other Local, State and Federal government agencies. Access to this application is restricted to authorized users ONLY. Unauthorized access, use, misuse, or modification of this computer system or of the data contained herein or in transit to/from this system is strictly forbidden. This system and equipment are subject to monitoring to ensure proper performance of applicable security features or procedures. Such monitoring may result in the acquisition, recording and analysis of all data being communicated, transmitted, processed or stored in this system by a user. If monitoring reveals possible evidence of criminal activity, such evidence may be provided to Law Enforcement Personnel. By continuing, you consent to such monitoring and agree to only use the application to review client records and any information contained therein specifically for the purpose of service provision for those clients and their families assigned to you as part of your normal job duties.");
        $scope.ReportsMenuItems = ConfigService.GetOCWBReportsMenuItems();
        // $.scope.DeletePendingProfile = "";
        $scope.AdminMenuItems = ConfigService.GetAdminOCWBMenuItems();
        $scope.JuvenileHeader = false;
        $scope.AdultHeader = false;
        $scope.CWBHeader = false;
        //$scope.showReportCaseManager = true;
        $rootScope.SystemID = "3";
        $scope.lblApplicationName = "Office of Community Wealth Building Case Managment";

    }

     if ($rootScope.CurrentUserole == "csu") {

         $rootScope.group = true;
         $rootScope.csu = true;
     }
     if ($rootScope.CurrentUserole == "admin" || $rootScope.CurrentUserole == "AdultAdmin" || $rootScope.CurrentUserole == "AdultCaseManager" || $rootScope.CurrentUserole == "OCWBAdmin" || $rootScope.CurrentUserole == "OCWBCaseManager") {

        
         $rootScope.admin = true;
         $rootScope.djs = true;
         $rootScope.group = true;
     }
     if ($rootScope.CurrentUserole == "superuser" ) {

         $rootScope.super = true;
         $rootScope.admin = true;
         $rootScope.djs = true;
         $rootScope.group = true;
     }
     if ($rootScope.CurrentUserole == "djs") {

         $rootScope.group = true;
         $rootScope.djs = true;
         $scope.showReport = true;

     }
     });
    
                $location.path('/home');

                var authData =  $rootScope.AD;
       
  
                
    //Notification for the pending delete clients
                $scope.notifiation = function () {


                    CaseMgtService('ClientProfile/InActiveClients').GetClientProfileToDelete(function (response) {
                        $scope.rowCollection = response;
                    }).$promise.then(function () {
                        $scope.CanShowNew = true;
                        $scope.rowCount = $scope.rowCollection.length;
                        if ($scope.rowCount > 0)
                        {
                            alert("Please delete the " + $scope.rowCount + " pending inactive clients. ");
                        }
                          
                    });
                }
    //End of notification for the pending delete clients
                   
    //Keep track of no of alerts for superuser.
                $scope.FunCall = function () {

                    CaseMgtService('ClientProfile/InActiveClients').GetClientProfileToDelete(function (response) {
                        $scope.rowCollection = response;
                    }).$promise.then(function () {
                        $scope.CanShowNew = true;
                        $scope.rowCount = $scope.rowCollection.length;
                        if ($scope.rowCount > 0) {
                            $scope.alertcount = 1;
                        }
                        else
                        {
                            $scope.alertcount = 0;
                        }

                    });
                    
                }
    //End of Keep track of no of alerts for superuser.
  
    $scope.logOut = function () {
        authService.logOut();
        $location.path('/login');
        $rootScope.ShowNavbar = false;
        $cookieStore.put('authData', null);
        //  window.location = "login.html";
    }
    var authData = $rootScope.AD;

    //$rootScope.ShowNavbar = authData;
    //$cookieStore
    if (!authData) {
        // window.location = "login.html";
        $location.path('/login');
        $rootScope.ShowNavbar = false;
        return;
    } 
   
    //get CSU users
    //ConfigService.GetCSUUsers().then(function (result) {
    //    $scope.csu = result.data;    
           
    ////});


    // Get all Reports Menu Items
   
    $rootScope.$on('UpdateDocumentsMenu', function (event, data) {
        $timeout(
            function () {
                $scope.$apply(function () {
                    // Remove existing items from Documents Menu
                    for (var i = 0; i < $scope.DocumentMenuItems.length; i++) {
                        $scope.DocumentMenuItems.splice(i);
                    }
                    // Get all the updated items from database again and bind
                    $scope.DocumentMenuItems = ConfigService.GetDocumentMenuItems();                    
                });                
                }, 2000
        );
    });
}]);
// auto slashes
function addSlashes(input) {
    var v = input.value;
    if (v.match(/^\d{2}$/) !== null) {
        input.value = v + '/';
    } else if (v.match(/^\d{2}\/\d{2}$/) !== null) {
        input.value = v + '/';
    }
}






  
// Used to show confirmation / modal window behavior
app.controller('ConfirmationController', ['$scope', '$timeout', '$modalInstance', 'message', 'BaseService', function ($scope, $timeout, $modalInstance, message, BaseService) {
    $scope.ConfirmationMessage = message;    
    $scope.CloseModal = function () {
        $modalInstance.close();
    };

    // Begin: DatePicker Functionality
    $scope.dt = '';
    $scope.open = function () {
        $timeout(function () {
            $scope.opened = true;
        });
    };

    $scope.dateOptions = {        
        startingDay: 1,
        showWeeks: 'false'    
    };
    // End: DatePicker Functionality
}]);

//algorithm to avoid duplicate entries.

var soundex = function (s) {
    var a = s.toLowerCase().split(''),
        f = a.shift(),
        r = '',
        codes = {
            a: '', e: '', i: '', o: '', u: '',
            b: 1, f: 1, p: 1, v: 1,
            c: 2, g: 2, j: 2, k: 2, q: 2, s: 2, x: 2, z: 2,
            d: 3, t: 3,
            l: 4,
            m: 5, n: 5,
            r: 6
        };

    r = f +
        a
        .map(function (v, i, a) { return codes[v] })
        .filter(function (v, i, a) {
            return ((i === 0) ? v !== codes[f] : v !== a[i - 1]);
        })
        .join('');

    return (r + '000').slice(0, 4).toUpperCase();
};

var EncodeFirstName = function (s) {
    var a = s.toUpperCase().split(''),

        r = '',
         Fixed = {
             ALBERT: 20, FRANK: 260, MARVIN: 580,
             ALICE: 20, GEORGE: 300, MARY: 580,
             ANN: 40, GRACE: 300, MELVIN: 600,
             ANNA: 40, HAROLD: 340, MILDRED: 600,
             ANNE: 40, HARRIET: 340, PATRICIA: 680,
             ANNIE: 40, HARRY: 360, PAUL: 680,
             ARTHUR: 40, HAZEL: 360, RICHARD: 740,
             BERNARD: 80, HELEN: 380, ROBERT: 760,
             BETTE: 80, HENRY: 380, RUBY: 740,
             BETTIE: 80, JAMES: 440, RUTH: 760,
             BETTY: 80, JANE: 440, THELMA: 820,
             CARL: 120, JAYNE: 440, THOMAS: 820,
             CATHERINE: 120, JEAN: 460, WALTER: 900,
             CHARLES: 140, JOAN: 480, WANDA: 900,
             DORTHY: 180, JOHN: 460, WILLIAM: 920,
             EDWARD: 220, JOSEPH: 480, WILMA: 920,
             ELIZABETH: 220, MARGARET: 560,
             FLORENCE: 260, MARTIN: 560,
             DONALD: 180,
             CLARA: 140
         };

    var exist = Fixed[s.toUpperCase()];
    if (exist != undefined)
        return exist;
    codes = {
        A: 0, H: 320, O: 640, V: 860,
        B: 60, I: 400, P: 660, W: 880,
        C: 100, J: 420, Q: 700, X: 940,
        D: 160, K: 500, R: 720, Y: 960,
        E: 200, L: 520, S: 780, Z: 980,
        F: 240, M: 540, T: 800,
        G: 280, N: 620, U: 840
    };
    return (codes[a[0]]);
   
};

var replacespacewithgzero = function (s) {
    var Reverse = s.toString().split("").reverse().join("");
    s= (Reverse + '000' + s).slice(0, 3);
    var res = s.split("").reverse().join("");
    return res;
}

var EncodeInitial = function (s) {
    var a = s.toUpperCase().split(''),

        r = '',

        codes = {
            A: 1, H: 8, O: 14, V: 18,
            B: 2, I: 9, P: 15, W: 19,
            C: 3, J: 10, Q: 15, X: 19,
            D: 4, K: 11, R: 16, Y: 19,
            E: 5, L: 12, S: 17, Z: 19,
            F: 6, M: 13, T: 18, 
            G: 7, N: 14, U: 18
        };
    return (codes[a[0]]);
};
/*JS print click handler*/

