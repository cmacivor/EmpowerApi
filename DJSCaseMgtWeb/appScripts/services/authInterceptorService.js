
app.factory('authInterceptorService', [ '$q', '$injector','$cookieStore', '$location', '$window', 'localStorageService', '$rootScope', function ($q, $injector,$cookieStore, $location, $window, localStorageService, $rootScope) {
    
  
  
    var authInterceptorServiceFactory = {};
    var _request = function (config,getuser) {
       // var user = getuser.user;
        config.headers = config.headers || {};
        if (config.url.indexOf('.html') == -1 ) {
           // var ConfigService = $injector.get('ConfigService');
        //   ConfigService.GetCurrentUser().then(function (result) {
              //  if (result.StatusCode == 200) {
                  //  if (result.data.group != "InvalidGroup") {
                       // var authData = result.data.username;
                        //console.log(getuser());
                       
                   // }
              //  }  
          //  if (!authData) {

                var authData = localStorageService.get('authorizationData');
                if (authData) {
                    config.headers.Authorization = 'Bearer ' + authData.token;
                    $rootScope.ShowNavbar = true;
                }
                else {
                    $rootScope.ShowNavbar = false;
                    $location.path('/login');
                }
           // }
           // else {
           // }
        //   });
            
        }
        return config;
}
    var _responseError = function (rejection) {
        if (rejection.status === 401) {
            var authService = $injector.get('authService');
            var authData = localStorageService.get('authorizationData');
            if (authData) {
                if (authData.useRefreshTokens) {
                    $location.path('/refresh');
                    return $q.reject(rejection);
                }
            }
            authService.logOut();
            $rootScope.ShowNavbar = false;
           // window.location = "login.html";
           $location.path('/login');
        }
        return $q.reject(rejection);
    }
    authInterceptorServiceFactory.request = _request;
    authInterceptorServiceFactory.responseError = _responseError;
    return authInterceptorServiceFactory;
}]);