'use strict';
app.controller('refreshController', ['$scope', '$location','$window', 'authService', function ($scope, $location,$window, authService) {

    $scope.authentication = authService.authentication;
    $scope.tokenRefreshed = false;
    $scope.tokenResponse = null;

    $scope.refreshToken = function () {

        authService.refreshToken().then(function (response) {
            $scope.tokenRefreshed = true;
            $scope.tokenResponse = response;
        },
         function (err) {
           //  window.location = "login.html";
             $location.path('login');
         });
    };

}]);