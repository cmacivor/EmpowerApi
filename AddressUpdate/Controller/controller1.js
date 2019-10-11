/*** Admin Menu: External (Bing) Address Controller */
app.controller('ExternalController', ['$scope', 'CRUDService', 'BaseService', 'BingServiceDB', '$timeout', '$filter', '$http', '$q', function ($scope, CRUDService, BaseService, BingServiceDB, $timeout, $filter, $http, $q) {

    $scope.AllExternalAddresses = [];

    var FilterOnAddressType = function (item) {
        // Use below filter to work with all external addresses 
        //return item.AddressTypeID == 3; 

        // use below filter to work with all giscode external addresses 
        if (item.AddressTypeID == 1 && item.GISCode.indexOf("-") > -1)
            return item;
    };

    // Get all Person Address for External address type
    var GetExternalAddresses = function () {
        CRUDService('PersonAddress').GetAll(function (response) {
            if (response.length > 0) {
                var externalAddresses = response.filter(FilterOnAddressType);
                $scope.AllExternalAddresses = response.filter(FilterOnAddressType);
            }
        });
    };

    var Test = function (address) {
        var addressVal = address.AddressLineOne + ', ' + address.City;

        $.ajax({
            url: "https://dev.virtualearth.net/REST/v1/Locations",
            dataType: "jsonp",
            data: {
                key: "AioE2WYI4PFEB6QJ05ws3SYzEfBmT4Dq4GcO-ACemmZnFi5pyKjXeE44i9Qz0QOS",
                addressLine: addressVal, //existingAddresses[address.AddressLineOne], //request.term,
                countryRegion: "US",
                userLocation: "37.553,-77.637",
                maxResults: "10",
            },
            jsonp: "jsonp",
            success: function (data) {
                var result = data.resourceSets[0];
                if (result) {
                    if (result.estimatedTotal > 0) {
                        alert(addressVal + '    ' + result.estimatedTotal);
                        return ($.map(result.resources, function (item) {
                            address.Latitude = item.point.coordinates[0];
                            address.Longitude = item.point.coordinates[1];

                            alert('AddressTypeID :' + address.AddressTypeID);
                            alert('Latitude :' + address.Latitude);
                            alert('Longitude :' + address.Longitude);
                        }));
                    }
                }
            }
        });
    }

    var UpdateAddressPoints = function () {
        //var existingAddresses = $scope.AllExternalAddresses;

        jQuery.each($scope.AllExternalAddresses, function (address) {
            var addressVal = address.AddressLineOne + ', ' + address.City;
            $.ajax({
                url: "https://dev.virtualearth.net/REST/v1/Locations",
                dataType: "jsonp",
                data: {
                    key: "AioE2WYI4PFEB6QJ05ws3SYzEfBmT4Dq4GcO-ACemmZnFi5pyKjXeE44i9Qz0QOS",
                    addressLine: addressVal, //request.term,
                    countryRegion: "US",
                    userLocation: "37.553,-77.637",
                    maxResults: "10",
                },
                jsonp: "jsonp",
                success: function (data) {
                    var result = data.resourceSets[0];
                    if (result) {
                        if (result.estimatedTotal > 0) {
                            return ($.map(result.resources, function (item) {
                                //alert(item.point.coordinates[0]);
                                //alert(item.point.coordinates[1]);
                                address.Latitude = item.point.coordinates[0];
                                address.Latitude = item.point.coordinates[1];
                                //displaySelectedItem(item);
                            }));
                        }
                    }
                }
            });
        });
        $scope.AllExternalAddresses = existingAddresses;
    };

    $scope.FillAddressPoints = function () {

        var totalExternalAddresses = $scope.AllExternalAddresses.length;
        var totalMatchedAddresses = 0;

        for (var i = 0; i < 7647; i++) {
            (function (index) {
                // use the index variable - it is assigned to the value of 'i'
                // that was passed in during the loop iteration.
                var addressLine = $scope.AllExternalAddresses[index].AddressLineOne;
                var locality = $scope.AllExternalAddresses[index].City;

                if ($scope.AllExternalAddresses[index].Latitude == null && $scope.AllExternalAddresses[index].Longitude == null) {
                    BingServiceDB(addressLine, locality).GetLocationDetails(function (response) {
                        var result = response.resourceSets[0];
                        if (result) {
                            if (result.estimatedTotal > 0) {
                                var resource = result.resources[0];

                                var address = resource.address;
                                var location = resource.point;

                                totalMatchedAddresses = totalMatchedAddresses + 1;

                                $scope.AllExternalAddresses[index].Latitude = location.coordinates[0];
                                $scope.AllExternalAddresses[index].Longitude = location.coordinates[1];
                            }
                            else {
                                $scope.AllExternalAddresses[index].Longitude = "NA";
                            }
                        }
                    });
                }
            })(i);
        }
    };

    $scope.Update = function (personAddress) {
        for (var i = 0; i < 7647; i++) {
            CRUDService('PersonAddress').Update({ ID: $scope.AllExternalAddresses[i].ID }, $scope.AllExternalAddresses[i]);
        }
        BaseService.openSmallDialog('PersonAddress', 'Updated');
    };

    GetExternalAddresses();
}]);

/*** Admin Menu: Internal (GIS) Address Controller */
app.controller('InternalController', ['$scope', 'CRUDService', 'BaseService', 'GISServiceDB', '$timeout', '$filter', '$http', '$q', function ($scope, CRUDService, BaseService, GISServiceDB, $timeout, $filter, $http, $q) {

    $scope.AllInternalAddresses = [];
    $scope.isLoading = false;
    $scope.message = 'Loading Data Please Wait...';
    $scope.showMessage = true;
    var FilterOnAddressType = function (item) {
        // use below filter to work with all giscode internal addresses 
        if (item.AddressTypeID == 1 && item.GISCode.indexOf("-") == -1)
            return item;
    };

    // Get all Person Address for External address type
    var GetInternalAddresses = function () {
        CRUDService('PersonAddress').GetAll(function (response) {
            if (response.length > 0) {
                //To avoid rows that do not have GISCode 
                response = response.filter(function (element) { return element.GISCode != null; })
                //Filter for internal addresses
                var externalAddresses = response.filter(FilterOnAddressType);

                response.filter(FilterOnAddressType);
                //take top 100 records  to avoid loading time
                response = response.slice(1, 100);
                $scope.AllInternalAddresses = response;
                $scope.showMessage = false;
            }
        });
    };

    $scope.FillAddressPoints = function () {

        var totalExternalAddresses = $scope.AllInternalAddresses.length;
        var totalMatchedAddresses = 0;
        $scope.message = 'Updating Points Please Wait...';
        $scope.showMessage = true;
        for (var i = 0; i < totalExternalAddresses; i++) {
            (function (index) {
                // use the index variable - it is assigned to the value of 'i'
                // that was passed in during the loop iteration.
                var GISCode = $scope.AllInternalAddresses[index].GISCode;

                if ($scope.AllInternalAddresses[index].AddressLineOne == null) {
                    GISServiceDB(GISCode).GetAddressDetails(function (response) {
                        if (response) {
                            if (response.IsSubaddress == false)
                                $scope.AllInternalAddresses[index].AddressLineOne = response.AddressLabel;
                            else {
                                $scope.AllInternalAddresses[index].AddressLineOne = response.ParcelAddress.AddressLabel;
                                $scope.AllInternalAddresses[index].AddressLineTwo = response.UnitType + " " + response.UnitValue;
                            }
                            $scope.showMessage = false;
                            //alert($scope.AllInternalAddresses[index].AddressLineOne);
                        }
                        else {
                            $scope.AllInternalAddresses[index].AddressLineOne = "NA";
                        }
                    });

                }
            })(i);
        }
    };

    $scope.Update = function (personAddress) {
        $scope.message = 'Updating Data Please Wait...';
        $scope.showMessage = true;
        for (var i = 0; i < $scope.AllInternalAddresses.length; i++) {
            CRUDService('PersonAddress').Update({ ID: $scope.AllInternalAddresses[i].ID }, $scope.AllInternalAddresses[i]);
            BaseService.openSmallDialog('PersonAddress', 'Updated');
            $scope.showMessage = false;

        }

    };

    GetInternalAddresses();
}]);