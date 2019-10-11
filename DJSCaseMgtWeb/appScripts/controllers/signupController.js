
app.controller('signupController', ['$scope','$http', '$location', '$timeout', 'authService', 'BaseService', 'servicesURL', function ($scope, $http, $location, $timeout, authService, BaseService, servicesURL) {

    var arr = servicesURL.split("/");

    //if ((arr.includes('AdultService') == true) || (arr.includes('empoweradultapi') == true))
    if (arr.includes('empoweradultapi') == true)
    {
        $scope.IsVisibleAdult = true;
        $scope.IsVisibleCwb = false;
        $scope.IsVisibleJuvenile  = false;
    }
    //if ((arr.includes('services') == true) || (arr.includes('empowerjuvenileapi') == true))
    if (arr.includes('empowerjuvenileapi') == true)
    {
        $scope.IsVisibleJuvenile = true;
        $scope.IsVisibleAdult = false;
        $scope.IsVisibleCwb = false;
    }

    //if ((arr.includes('CWBService') == true) || (arr.includes('empowercwbapi') == true))
    if (arr.includes('empowercwbapi') == true)
    {
        $scope.IsVisibleCwb = true;
        $scope.IsVisibleJuvenile = false;
        $scope.IsVisibleAdult = false;
    }

   
    $scope.pwdmatch=true;
   

    $scope.signUp = function () {

        authService.saveRegistration($scope.registration).then(function (response) {
            if (response.status == 200) {
                BaseService.openSmallDialog('Registration', 'Completed');
                $location.path('/casemgt');
            }
        },
         function (response) {
             var errors = [];
             for (var key in response.data.ModelState) {
                 for (var i = 0; i < response.data.ModelState[key].length; i++) {
                     errors.push(response.data.ModelState[key][i]);
                 }
             }
             $scope.message = "Failed to register user: " + errors.join(' ');
         });
    };
    $scope.Reset = function () {
        $scope.registration = {
            userName: "",
            password: "",
            confirmPassword: ""
        };
    };

  // to reset the password

    $scope.ResetPassword = function () {
        var username = $scope.usernameforreset;
        var password = $scope.resetpassword;
       
        var url = servicesURL + "Account/Reset";
        var req = {
            method: 'POST',
            url:url,
           
            params: { name: username, NewPassword: password}
        }
       

        $http(req).then(function (responce) {
            BaseService.openSmallDialog('Reset Password', 'Completed');
        }, function (responce) {
            alert('Please enter a valid User name!' );
        });;

    }


    // to remove the user

    $scope.RemoveUser = function () {
        var username = $scope.usernameforremove;
      
       
        var url = servicesURL + "Account/remove";
        var req = {
            method: 'POST',
            url:url,
           
            params: { name: username}
        }
       

        $http(req).then(function (responce) {
            BaseService.openSmallDialog('Remove User', 'Completed');
        }, function (responce) {
            alert('Please enter a valid User name!');
        });;

    }


    $scope.validatepwd = function () {
        $scope.message = '';
        if ($scope.registration.password != "" && $scope.registration.password != undefined && $scope.registration.confirmPassword != "" && $scope.registration.confirmPassword != undefined)
            $scope.pwdmatch = ($scope.registration.password == $scope.registration.confirmPassword);
        else
            $scope.pwdmatch = true;
    };
    $scope.Reset();
}]);