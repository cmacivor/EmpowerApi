//'use strict';
app.controller('homeController', ['$scope', '$rootScope', '$location', '$cookieStore', 'servicesURL', 'ConfigService', 'authService', 'ngAuthSettings', 'localStorageService', 'Commonfunction', function ($scope, $rootScope, $location, $cookieStore, servicesURL, ConfigService, authService, ngAuthSettings, localStorageService, Commonfunction) {
    var systemstate = Commonfunction.GetSystemState();
    if (systemstate.DJSState == 1) {
        $scope.IsVisibleDJS = true;
        $scope.IsVisibleCWB = false;

    }
    if (systemstate.CWBState == 1) {
        $scope.IsVisibleDJS = false;
        $scope.IsVisibleCWB = true;

    }


}]);