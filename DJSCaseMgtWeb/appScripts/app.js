/*** Main AngularJS Web Application */
var app = angular.module('DJSCaseMgtApp', [
  'ngRoute',
  'angularFileUpload',
  'ngCookies',
  'ui.bootstrap',
  'ui.utils',
  'smart-table',
  'lrDragNDrop',
  'ngResource',
  'ngTagsInput',
  'LocalStorageModule'
]);
//assigning the systemid value to differentaite adult and juvenile

//app.constant('SystemIDJuvenile', '1');
//app.constant('SystemIDAdult', '2');

//app.constant('servicesURL', 'http://localhost:70/services/api/');
//app.constant('servicesURL', 'http://localhost:70/AdultService/api/');
app.constant('servicesURL', 'http://localhost:70/CWBService/api/');

//app.constant('uploadServiceURL', 'http://localhost:70/AdultService/api/Upload/');
//app.constant('locationURL', 'http://localhost:70/DJSProfiles/');
//app.constant('GISServiceURL', 'http://gis.richmondgov.com/ArcGIS/rest/services/Geocode/RichmondAddress/GeocodeServer/findAddressCandidates?callback=?&outFields=*&f=json&Street=');
//app.constant('clientType', 'Juvenile');


//app.constant('ngAuthSettings', {

//    clientId: 'Juvenile'
//});

app.constant('ngAuthSettings', {

    clientId: 'Adult'
});

app.config(function ($httpProvider) {
    $httpProvider.interceptors.push('authInterceptorService');
    if (!$httpProvider.defaults.headers.get) {
        $httpProvider.defaults.headers.get = {};
    }

    // Answer edited to include suggestions from comments
    // because previous version of code introduced browser-related errors

    //disable IE ajax request caching
    // $httpProvider.defaults.headers.get['If-Modified-Since'] = 'Mon, 26 Jul 1997 05:00:00 GMT';
    // extra
    $httpProvider.defaults.headers.get['Cache-Control'] = 'no-cache';
    $httpProvider.defaults.headers.get['Pragma'] = 'no-cache';

});

app.run(['authService', function (authService) {
    authService.fillAuthData();
}]);
//directive for date time

//Testing the Merge function on the DJS Branch