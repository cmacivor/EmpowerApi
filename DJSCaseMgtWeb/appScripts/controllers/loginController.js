
app.controller('loginController', ['$scope', '$rootScope', '$location', '$cookieStore', 'servicesURL', 'ConfigService', 'authService', 'ngAuthSettings', 'localStorageService', 'Commonfunction', function ($scope, $rootScope, $location, $cookieStore, servicesURL, ConfigService, authService, ngAuthSettings, localStorageService, Commonfunction) {
   var systemstate = Commonfunction.GetSystemState();
    if (systemstate.DJSState == 1)
    {
          $scope.IsVisibleDJS = true;
          $scope.IsVisibleCWB = false;

    }
    if (systemstate.CWBState == 1)
    {
        $scope.IsVisibleDJS = false;
        $scope.IsVisibleCWB = true;
        
    }

 

    $scope.loginData = {
        userName: "",
        password: "",
        useRefreshTokens: false
    };
    $scope.Reset = function() {
        $scope.loginData.userName = "";
        $scope.loginData.password = "";
    };
    $rootScope.validGroupUser = false;
    $scope.isLoading=false;
    //$scope.message = "";
    //$rootScope.CurrentUser = "";
    //$rootScope.ShowNavbar = false;
    //$rootScope.isWindowsAuhentication = false;
    $scope.login = function () {
        
        //ConfigService.GetCurrentUser().then(function (result) {         
        //    $rootScope.CurrentUser = result.data;
        //   // authService.authentication.v = result.StatusCode;
        //    if (result.StatusCode != 200) {
      //  ConfigService.GetCurrentUser().then(function (result) {
            //$scope.grp = result.data;
            //if ($scope.grp.indexOf("RICHVA\\DIT Services Team") == -1 && $scope.grp.indexOf("RICHVA\\DJS_Admins") == -1 && $scope.grp.indexOf("RICHVA\\DJS_SuperUsers") == -1 && $scope.grp.indexOf("RICHVA\\DJS_Users") == -1) {
              
            //result.data.group != "RICHVA\\DIT Services Team" || result.data.group != "RICHVA\\Empower_Admins" ||
                    //  if (result.data.group == "InvalidGroup") {

                            //var authData = localStorageService.get('authorizationData');
                            //$cookieStore.put('authData', localStorageService.get('authorizationData'));
                            //if (authData) {
                            //    $scope.currentuser = authData.userName;
                            //    $rootScope.CurrentUser = angular.copy($scope.currentuser);

                            //}
                            authService.login($scope.loginData).then(function (response) {


                             $scope.currentuser = response.userName;
                              $rootScope.CurrentUser = angular.copy($scope.currentuser)

                                //$location.path('index.html#/home');
                              //  $rootScope.ShowNavbar = true;
                                $scope.isLoading = false;
                                window.location = 'Index.html#/casemgt';
                                var requestUrl = window.location.href;
                                $rootScope.requesturl = servicesURL;
                                
                                window.location.reload();
                            },

                                    function (err) {
                                        $scope.isLoading = false;
                                        $scope.message = err.error_description;
                                        $rootScope.ShowNavbar = false;
                                        $location.path('/login');
                                    });
                            
                      //  }
                      
                        //else{
                        //                $rootScope.isWindowsAuhentication = true;
                        //                // authService.authentication.v = 200;
                        //                $rootScope.ShowNavbar = true;
                        //                $rootScope.validGroupUser = true;
                                      
                        //                window.location = 'Index.html#/casemgt';
                        //}
                         
                      //  });

        //$scope.isLoading = true;
        //authService.login($scope.loginData).then(function (response) {

        //    //$location.path('index.html#/home');
        //    $scope.isLoading = false;
        //    window.location = 'Index.html#/casemgt';
        //},
        // function (err) {
        //     $scope.isLoading = false;
        //     $scope.message = err.error_description;
        // });
    };
    //$scope.windowslogin = function () {
    //    $scope.isLoading = true;

    //    ConfigService.GetCurrentUser().then(function (result) {
          
    //        $rootScope.CurrentUser = angular.copy($scope.CurrentUser);
    //        $rootScope.isWindowsAuhentication = true;
    //    },
    //     function (err) {
    //         $scope.isLoading = false;
    //         $scope.message = err.error_description;
    //     });
    //};
    

    //$scope.authExternalProvider = function (provider) {

    //    var redirectUri = location.protocol + '//' + location.host + '/authcomplete.html';

    //    var externalProviderUrl = ngAuthSettings.apiServiceBaseUri + "api/Account/ExternalLogin?provider=" + provider
    //                                                                + "&response_type=token&client_id=" + ngAuthSettings.clientId
    //                                                                + "&redirect_uri=" + redirectUri;
    //    window.$windowScope = $scope;

    //   // var oauthWindow = window.open(externalProviderUrl, "Authenticate Account", "location=0,status=0,width=600,height=750");
    //};

    $scope.authCompletedCB = function (fragment) {

        $scope.$apply(function () {

            if (fragment.haslocalaccount == 'False') {

                authService.logOut();
                authService.externalAuthData = {
                    provider: fragment.provider,
                    userName: fragment.external_user_name,
                    externalAccessToken: fragment.external_access_token
                };
                $location.path('/associate');
            }
            else {
                //Obtain access token and redirect to orders
                var externalData = { provider: fragment.provider, externalAccessToken: fragment.external_access_token };
                authService.obtainAccessToken(externalData).then(function (response) {
                    window.location = 'Index.html#/casemgt';
                    window.location.reload();

                },
             function (err) {
                 $scope.message = err.error_description;
             });
            }

        });
    }
}]);
