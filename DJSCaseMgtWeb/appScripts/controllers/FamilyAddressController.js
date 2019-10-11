// Address Tab Controller
app.controller('FamilyAddressController', ['$scope', '$timeout', '$http', '$resource', '$modal', '$rootScope', 'CRUDService', 'BaseService', 'GISService', 'BingService', function ($scope, $timeout, $http, $resource, $modal , $rootScope, CRUDService, BaseService, GISService, BingService) {
    //$controller('PickAddressController', { $scope: $scope });
    // Create the scope for all the controllers
    var modalScope = $rootScope.$new();
    //  $scope.$broadcast('UpdateFamilyAddress', 'EditAddress');
    $rootScope.$broadcast('UpdateFamilyAddress', 'EditAddress');
    // Set default settings to Client Info Tab
    var SetDefaults = function () {
        $scope.SelectedDJSAddress = null;
        //ISR 1019
        //if ($rootScope.CurrentUserole == "AdultAdmin") 
        if ($rootScope.SystemID == "2" || $rootScope.SystemID == "3")
        {
            $scope.IsVisibleAdult = false;
            $scope.IsAdultVisibleTrue = true;
            $scope.lblAddress = "Family Member Address";
            $scope.placeholdertext = "Start typing Address Line";
        }
        else {
            $scope.IsVisibleAdult = true;
            $scope.IsAdultVisibleTrue = false;
            $scope.placeholdertext = "Start typing DJU Address Line";
            $scope.lblAddress = "DJS Address";
        }
        //ISR 1019

        SetSubmitButtonText();
    };
    //
   
    // Close button event
  
    $scope.CloseAddress = function () {
        $scope.modalInstance.close();
       
    };
    // Default Settings
    var LoadDefaults = function () {
        SetDefaults();
    };
    //$scope.Familyaddress = ($scope.FamilyProfile.FamilyPersonAddress != null) ? $scope.FamilyProfile.FamilyPersonAddress : null;
    //$scope._Familyaddress = ($scope.FamilyProfile.FamilyPersonAddress != null) ? angular.copy($scope.FamilyProfile.FamilyPersonAddress) : null;
    var SetSubmitButtonText = function () {
        if ($scope.FamilyProfile.FamilyPersonAddress != '' || $scope.FamilyProfile.FamilyPersonAddress != null) {
            if ($scope.FamilyProfile.FamilyPersonAddress.length > 0){
                $scope.SubmitButtonText = "Update";
                //$scope.FamilyProfile.FamilyPersonAddressOrg = angular.copy($scope.FamilyProfile.FamilyPersonAddress);
            }
            else if ($scope.FamilyProfile.FamilyPersonAddress.length == 0) {
                //$scope.FamilyProfile.FamilyPersonAddressOrg = [];
                $scope.SubmitButtonText = "Save";
            }
               
        } else {
            $scope.SubmitButtonText = "Save";
        }
    };

    /** Start: Factory and Service Calls  **/

    // Retrieve all address as user start typeing considering as city address
    $scope.Addresses = function (term) {

  return $.getJSON("https://gis.richmondgov.com/ArcGIS/rest/services/Geocode/RichmondAddress/GeocodeServer/findAddressCandidates?callback=?", {
            f: "pjson", Street: term, outFields: "*"
        }, function (data) {
            return data.candidates;
        }).then(function (resp) {
            return resp.candidates;
        });
    };

    // Function to raise as Create New Assessment button is clicked
    var LoadMatchingAddresses = function (matchingAddresses, addressType, addressId) {
        modalScope.modalInstance = $modal.open({
            templateUrl: 'views/casemanagement/matchingAddress.html',
            controller: 'PickAddressController',
            scope: modalScope,
            backdrop: 'static',
            keyboard: false, // restricts esc key usage
            size: 'md',
            resolve: {
                Addresses: function () {
                    return {
                        Address: matchingAddresses,
                        AddressType: addressType,
                        AddressID: addressId
                    }
                }
            }
        });
        modalScope.modalInstance.result.then(function (selectedAddress) {
            if (selectedAddress != null) {
                var formattedAddress = FormatAddress(selectedAddress.SelectedAddress, selectedAddress.SelectedAddressType);
                if($rootScope.SystemID == "2")
                //if ($rootScope.CurrentUserole == "AdultAdmin")
                {
                    FormatAddressMessageForAdults(selectedAddress.SelectedAddressType);
                }
                else
                {
                    FormatAddressMessage(selectedAddress.SelectedAddressType);
                }
                if (selectedAddress.SelectedAddressType == 2) {
                    if ($scope.DJSAddress == '') {
                        $scope.DJSAddress = formattedAddress;
                        $scope.DJSAddress.ID = selectedAddress.AddressID;
                    }
                    else
                        UpdateAddress(formattedAddress, selectedAddress.SelectedAddressType);
                }
                else if (selectedAddress.SelectedAddressType == 4) {
                    if ($scope.CSUAddress == '') {
                        $scope.CSUAddress = formattedAddress;
                        $scope.CSUAddress.ID = selectedAddress.AddressID;
                    }
                    else
                        UpdateAddress(formattedAddress, selectedAddress.SelectedAddressType);
                }
            }
        }, function () { });
    };
    var UpdateClientDetails = function () {
        CRUDService('ClientProfile').Find({ ID: clientProfileID }, function (response) {
          //  $scope.ClientProfile = response;
            $rootScope.FamilyProfiles = response.Person.FamilyProfile;
            //$rootScope.$broadcast('UpdateClientProfile', $rootScope.CurrentClientProfileID);
            $rootScope.$broadcast('UpdateFamilyInfo', 'EditFamilyInfo');
        }).$promise.then(function () {
            $rootScope.$broadcast('UpdateTabs', 'Edit');
        });
    };
    /** End: Factory and Service Calls  **/
    //save or update family profile address
    $scope.CreateOrUpdateAddress = function (isValid, djsAddress, csuAddress) {
        $scope.submitted = true;

        if (isValid == true) {

            if (djsAddress != null) {
                djsAddress.PersonID = $scope.FamilyProfile.FamilyProfile.Person.ID;

                // Save / Update DJSAddress            
                if (djsAddress.ID != null) {
                    CRUDService('PersonAddress').Update({ ID: djsAddress.ID }, djsAddress).$promise.then(function (response) {
                        if($rootScope.SystemID == "3")
                            BaseService.openMediumModal('Person Address', 'Updated');
                        else
                            BaseService.openMediumModal('Person DJS Address', 'Updated');
                       // UpdateClientDetails();
                        $scope.CloseAddress();
                    });
                }
                else {
                    // Set Auditing Data to the Newly Crating Entity
                    BaseService.SetAuditingDetails(djsAddress, true);
                    djsAddress.ID = 0;

                    CRUDService('PersonAddress').Create(djsAddress).$promise.then(function (response) {
                        //$rootScope.$broadcast('UpdateClientProfile', $rootScope.CurrentClientProfileID);
                        if ($rootScope.SystemID == "3")
                            BaseService.openMediumModal('Person Address', 'Created');
                        else
                            BaseService.openMediumModal('Person DJS Address', 'Created');
                       // UpdateClientDetails();
                        $scope.CloseAddress();
                      
                    });
                }
            }

            // Save / Update CSUAddress
            if ((csuAddress != '') && ($rootScope.SystemID =="1")) {
                csuAddress.PersonID = $scope.FamilyProfile.FamilyProfile.Person.ID;

                if (csuAddress.ID != null) {
                    CRUDService('PersonAddress').Update({ ID: csuAddress.ID }, csuAddress).$promise.then(function () {
                        BaseService.openMediumModal('Person CSU Address', 'Updated');
                       // UpdateClientDetails();
                        $modalInstance.close();
                    });
                }
                else {
                    // Set Auditing Data to the Newly Crating Entity
                    BaseService.SetAuditingDetails(csuAddress, true);
                    csuAddress.ID = 0;

                    CRUDService('PersonAddress').Create(csuAddress).$promise.then(function (response) {
                        //$rootScope.$broadcast('UpdateClientProfile', $rootScope.CurrentClientProfileID);
                        BaseService.openMediumModal('Person CSU Address', 'Created');
                       // UpdateClientDetails();
                           $modalInstance.close();
                    });
                }
            }
        };

        $scope.submitted = false;
    };
//
    
            

            
       
    //initialize djscomments
  
  //  $scope.frmAddress.$setPristine(true);
    //same as client address
    $scope.Client = function () {


       
        var decition = confirm("Are you sure you want to set the client's address for this person?");
       
            if (decition) {
                
                var id = $scope.FamilyProfile.FamilyProfile.ClientProfilePersonID;
                CRUDService('ClientProfile').Find({ ID: id }, function (response) {
                    var resp = response.Person.PersonAddress;

                    var add = response.Person.PersonAddress;
                    //$scope.init = function () {

                    //    if ($scope.DJSAddress = '') {
                    //        var a = '.';
                    //        return a;
                    //    }
                    //}

 

                    for (i = 0; i < add.length; i++) {
                        if (add[i].AddressTypeID == 1 || add[i].AddressTypeID == 2) {
                           


                            $scope.frmAddress.$setDirty(true);
                            

                            $scope.DJSAddress.AddressTypeID = add[i].AddressTypeID;
                            $scope.DJSAddress.GISCode = add[i].GISCode;
                            $scope.DJSAddress.Latitude = add[i].Latitude;
                            $scope.DJSAddress.Longitude = add[i].Longitude;
                            $scope.DJSAddress.AddressLineOne = add[i].AddressLineOne;
                            $scope.DJSAddress.AddressLineTwo = add[i].AddressLineTwo;
                            $scope.DJSAddress.City = add[i].City;
                            $scope.DJSAddress.State = add[i].State;
                            $scope.DJSAddress.Zip = add[i].Zip;
                            $scope.DJSAddress.Comments = add[i].Comments;
                            $scope.frmAddress.$setDirty(true);



                        }
                    }
                    for (j = 0; j < add.length; j++) {
                        if (add[j].AddressTypeID == 3 || add[j].AddressTypeID == 4) {
                            $scope.CSUAddress.AddressTypeID = add[j].AddressTypeID;
                            $scope.CSUAddress.GISCode = add[j].GISCode;
                            $scope.CSUAddress.Latitude = add[j].Latitude;
                            $scope.CSUAddress.Longitude = add[j].Longitude;
                            $scope.CSUAddress.AddressLineOne = add[j].AddressLineOne;
                            $scope.CSUAddress.AddressLineTwo = add[j].AddressLineTwo;
                            $scope.CSUAddress.City = add[j].City;
                            $scope.CSUAddress.State = add[j].State;
                            $scope.CSUAddress.Zip = add[j].Zip;
                            $scope.CSUAddress.Comments = add[j].Comments;
                            $scope.frmAddress.$setDirty(true);

                        }
                    }

                });
               
            }

        //if ($("#js-txtComments").val().length > 0) {
        //    $scope.DJSAddress.Comments = $("input[name='txtDJSComments']").val();            

        //    }
        //$scope.x = $("input[name='txtDJSComments']").val();

        
       //Client $scope.CSUAddress = angular.copy($scope.CSUAddressOrg);

    };

    // Reset Address
    $scope.Reset = function () {
       
        $scope.DJSAddress = angular.copy($scope.DJSAddressOrg);
       


        $scope.CSUAddress = angular.copy($scope.CSUAddressOrg);
        
    };

    // Listen to the event whenever there is a change in rootscope person
    $scope.$on('UpdateFamilyAddress', function (event, data) {
        $timeout(
            function () {
                $scope.$apply(function () {
                    if (data == 'NewAddress') {
                        //$scope.DJSAddress = '';
                       // angular.element('#testie').val(".");
                    }
                    else if (data == 'EditAddress') {
                        // PersonAddress
                        // Create one scope for DJS address and one for CSU address
                      //  var personAddress = $rootScope.Person.PersonAddress;
                        var FamilyPersonAddress = $scope.FamilyProfile.FamilyPersonAddress;
                        var personaddress = $scope.FamilyProfile.FamilyProfile.Person.ID;
                        $scope.DJSAddress = {
                           AddressTypeID :'',
                           GISCode  :'',
                           Latitude  :'',
                           Longitude :'',
                           AddressLineOne  :'',
                           AddressLineTwo  :'',
                           City  :'',
                           State  :'',
                           Zip  :'',
                           Comments: ''


                        };
                        $scope.DJSAddressType = '';
                        $scope.CSUAddress = {
                            AddressTypeID: '',
                            GISCode: '',
                            Latitude: '',
                            Longitude: '',
                            AddressLineOne: '',
                            AddressLineTwo: '',
                            City: '',
                            State: '',
                            Zip: '',
                            Comments: ''


                        };
                        $scope.CSUAddressType = '';

                        for (var i = 0; i <= FamilyPersonAddress.length - 1; i++) {

                            switch (FamilyPersonAddress[i].AddressTypeID) {
                                // If AddressType of PersonAddress is 1 or 2 then it is DJS Address
                                case 1:
                                case 2:
                                    $scope.DJSAddress = FamilyPersonAddress[i];
                                    $rootScope.DJSAd = angular.copy($scope.DJSAddress);
                                  //  alert($rootScope.DJSAd.AddressLineOne.length);


                                    $scope.DJSAddressOrg=angular.copy(FamilyPersonAddress[i])
                                    $scope.DJSAddressID = $scope.DJSAddress.ID;
                                    $scope.DJSAddressType = FamilyPersonAddress[i].AddressTypeID;
                                        //if ($rootScope.CurrentUserole == "AdultAdmin")
                                    if($rootScope.SystemID == "2")
                                    {
                                        FormatAddressMessageForAdults(FamilyPersonAddress[i].AddressTypeID);
                                    }
                                    else
                                    {
                                        FormatAddressMessage(FamilyPersonAddress[i].AddressTypeID);
                                    }
                                    
                                    $scope.clientaddress = angular.copy(personaddress[i])
                                    break;
                                    // If AddressType of PersonAddress is 3 or 4 then it is CSU Address
                                case 3:
                                case 4:
                                    $scope.CSUAddress = FamilyPersonAddress[i];
                                    $scope.CSUAddressOrg =angular.copy(FamilyPersonAddress[i]);
                                    $scope.CSUAddressID = $scope.CSUAddress.ID;
                                    $scope.CSUAddressType = FamilyPersonAddress[i].AddressTypeID;
                                    FormatAddressMessage(FamilyPersonAddress[i].AddressTypeID);
                                    break;
                                default:
                                    break;
                            }
                        }
                        LoadDefaults();
                    }
                });
            });
    });

    // For DJS City Addresses call this function on selecting the address
    $scope.OnDJSSelect = function ($item) {
        var djsAddressID = ($scope.DJSAddress != '') ? $scope.DJSAddress.ID : null;

        $timeout(
            function () {
                $scope.$apply(function () {
                    // Get the formatted address
                    var formattedDJSAddress = FormatAddress($item, 1);

                    if ($scope.DJSAddress != '') // Update existing address
                        UpdateAddress(formattedDJSAddress, 1);
                    else  // New address
                        $scope.DJSAddress = FormatAddress($item, 1);

                    // assign ID to the formatted address
                    $scope.DJSAddress.ID = djsAddressID;
                    $scope.DJSAddress.AddressType.Description = "DJS City Address";
                    $scope.DJSAddress.AddressType.ID = 1;
                    $scope.DJSAddress.AddressType.Name = "DJS-City";
                    if($rootScope.SystemID == "2")
                    // if ($rootScope.CurrentUserole == "AdultAdmin")
                    {
                        FormatAddressMessageForAdults(1);
                    }
                    if ($rootScope.SystemID == "3")
                    {
                        FormatAddressMessageForAdults(1);
                    }
                    else
                    {
                        FormatAddressMessage(1);
                    }

                  
                });
            }, 1000); // Delay to complete the selection process before loading address 
    };

    // DJS Non-City address call this function  
    $scope.OnDJSLeaveAddress = function (addressType) {
        var djsAddressID = ($scope.DJSAddress != '') ? $scope.DJSAddress.ID : null;

        if ($scope.SelectedDJSAddress) {
            $scope.isDJSLoading = true;
            BingService($scope.SelectedDJSAddress).GetMatchingAddresses(function (response) {
                $timeout(
                    function () {
                        $scope.$apply(function () {
                            var result = response.resourceSets[0];
                            if (result)
                            {   //Commented to fix the defect PL 399388(esp raised for DJS address)

                                //if (result.estimatedTotal == 1) { // incase only one match found
                                //    var resource = result.resources[0];

                                //    // Get the formatted address
                                //    var formattedDJSAddress = FormatAddress(resource, addressType);
                                //    // assign ID to the formatted address
                                //    formattedDJSAddress.ID = djsAddressID;

                                //    FormatAddressMessage(addressType);

                                //    if ($scope.DJSAddress != '') // in modify exisitng address scenario
                                //        UpdateAddress(formattedDJSAddress, addressType);
                                //    else // in new address scenario                                     
                                //        $scope.DJSAddress = formattedDJSAddress;
                                //}
                                //else 
                                if (result.estimatedTotal >= 1) {    // incase morethan one match found                                      
                                    LoadMatchingAddresses(result.resources, addressType, djsAddressID);
                                }
                                else if (result.estimatedTotal == 0) { // incase no matches found
                                    $scope.CanShowDJSAddressMsg = true;
                                    $scope.DJSAddressMessage = "Not a Valid Address";
                                }
                            }
                        });
                        $scope.isDJSLoading = false;
                    }, 1000);
            });
        };
    };

    // For CSU City Addresses call this function on selecting the address
    $scope.OnCSUSelect = function ($item) {
        var csuAddressID = ($scope.CSUAddress != '') ? $scope.CSUAddress.ID : null;

        $timeout(
            function () {
                $scope.$apply(function () {
                    // Get the formatted address
                    var formattedCSUAddress = FormatAddress($item, 3);

                    if ($scope.CSUAddress != '') // in modify exisitng address scenario
                        UpdateAddress(formattedCSUAddress, 3);
                    else // in new address scenario                                     
                        $scope.CSUAddress = formattedCSUAddress;

                    // assign ID to the formatted address
                    formattedCSUAddress.ID = csuAddressID;
                    $scope.CSUAddress.AddressType.Description = "CSU City Address";
                    $scope.CSUAddress.AddressType.ID = 3;
                    $scope.CSUAddress.AddressType.Name = "CSU-City";
                    FormatAddressMessage(3);
                });
            }, 1000); // Delay to complete the selection process before loading address 
    };

    // Run this function if entered CSU address is not found in City 
    $scope.OnCSULeaveAddress = function (addressType) {
        var csuAddressID = ($scope.CSUAddress != '') ? $scope.CSUAddress.ID : null;

        if ($scope.SelectedCSUAddress) {
            $scope.isCSULoading = true;
            BingService($scope.SelectedCSUAddress).GetMatchingAddresses(function (response) {
                $timeout(
                    function () {
                        $scope.$apply(function () {
                            var result = response.resourceSets[0];
                            if (result) {
                                //Commented to fix the defect PL 399388(esp raised for DJS address)
                                //if (result.estimatedTotal == 1)
                                //{
                                //    var resource = result.resources[0];

                                //    // Get the formatted address
                                //    var formattedCSUAddress = FormatAddress(resource, addressType);
                                //    // assign ID to the formatted address
                                //    formattedCSUAddress.ID = csuAddressID;

                                //    FormatAddressMessage(addressType);

                                //    if ($scope.CSUAddress != '') // in modify exisitng address scenario
                                //        UpdateAddress(formattedCSUAddress, addressType);
                                //    else // in new address scenario                                     
                                //        $scope.CSUAddress = formattedCSUAddress;
                                //}
                                //else 
                                if (result.estimatedTotal >= 1) {
                                    LoadMatchingAddresses(result.resources, addressType, csuAddressID);
                                }
                                else if (result.estimatedTotal == 0) {
                                    $scope.CanShowCSUAddressMsg = true;
                                    $scope.CSUAddressMessage = "Not a Valid Address";
                                }
                            }
                        });
                        $scope.isCSULoading = false;
                    }, 1000);
            });
        };
    };

    // Show / Hide message as per Formated address
    var FormatAddressMessage = function (addressType) {

        switch (addressType) {
            case 1: // DJS City Address                
                $scope.CanShowDJSAddressMsg = true;
                $scope.DJSAddressMessage = "Valid DJS City Address";
                break;
            case 2: // DJS Non-City Address                
                $scope.CanShowDJSAddressMsg = true;
                $scope.DJSAddressMessage = "Valid DJS Non-City Address";
                break;
            case 3: // CSU City Address                
                $scope.CanShowCSUAddressMsg = true;
                $scope.CSUAddressMessage = "Valid CSU City Address";
                break;
            case 4: // CSU Non-City Address                
                $scope.CanShowCSUAddressMsg = true;
                $scope.CSUAddressMessage = "Valid CSU Non-City Address";
                break;
        }
    };

    var FormatAddressMessageForAdults = function (addressType) {

        switch (addressType) {
            case 1: // DJS City Address                
                $scope.CanShowDJSAddressMsg = true;
                $scope.DJSAddressMessage = "Valid City Address";
                break;
            case 2: // DJS Non-City Address                
                $scope.CanShowDJSAddressMsg = true;
                $scope.DJSAddressMessage = "Valid Non-City Address";
                break;
            case 3: // CSU City Address                
                $scope.CanShowCSUAddressMsg = true;
                $scope.CSUAddressMessage = " ";
                break;
            case 4: // CSU Non-City Address                
                $scope.CanShowCSUAddressMsg = true;
                $scope.CSUAddressMessage = " ";
                break;
        }
    };

    // Format address as per selected item
    var FormatAddress = function (item, addressType) {
        $scope.SelectedDJSAddress = null;
        $scope.SelectedCSUAddress = null;

        switch (addressType) {
            case 1: // DJS City Address
            case 3: // CSU City Address                
                return {
                    PersonID: $rootScope.Person.ID,
                    AddressTypeID: addressType,
                    GISCode: item.attributes.Ref_ID,
                    Latitude: '',
                    Longitude: '',
                    AddressLineOne: item.attributes.House + ' ' + item.attributes.PreDir + ' ' + item.attributes.StreetName + ' ' + item.attributes.SufType,
                    AddressLineTwo: item.attributes.UnitType + ' ' + item.attributes.UnitNumber,
                    City: 'Richmond',
                    State: 'VA',
                    Zip: item.attributes.ZIP,
                    Active: 1,
                    CreatedBy: ($scope.DJSAddress != '') ? $scope.DJSAddress.CreatedBy : 1,
                    CreatedDate: ($scope.DJSAddress != '') ? $scope.DJSAddress.CreatedDate : '',
                    UpdatedBy: ($scope.DJSAddress != '') ? $scope.DJSAddress.UpdatedBy : 1,
                    UpdatedDate: ($scope.DJSAddress != '') ? $scope.DJSAddress.UpdatedDate : '',
                };
                break;
            case 2: // DJS Non-City Address
            case 4: // CSU Non-City Address                
                return {
                    PersonID: $rootScope.Person.ID,
                    AddressTypeID: addressType,
                    GISCode: null,
                    Latitude: item.point.coordinates[0],
                    Longitude: item.point.coordinates[1],
                    AddressLineOne: item.address.addressLine,
                    AddressLineTwo: null,
                    City: item.address.locality,
                    State: item.address.adminDistrict,
                    Zip: item.address.postalCode,
                    Active: 1,
                    CreatedBy: ($scope.CSUAddress != '') ? $scope.CSUAddress.CreatedBy : 1,
                    CreatedDate: ($scope.CSUAddress != '') ? $scope.CSUAddress.CreatedDate : '',
                    UpdatedBy: ($scope.CSUAddress != '') ? $scope.CSUAddress.UpdatedBy : 1,
                    UpdatedDate: ($scope.CSUAddress != '') ? $scope.CSUAddress.UpdatedDate : '',
                };
                break;
            default:
                break;
        };
    };

    // Update Address with new Address
    var UpdateAddress = function (address, addressType) {

        switch (addressType) {
            case 1:
            case 2:
                $scope.DJSAddress.AddressTypeID = addressType;
                if ($scope.DJSAddress.AddressType != undefined) {
                    $scope.DJSAddress.AddressType.Description = "DJS Non-City Address";
                    $scope.DJSAddress.AddressType.ID = 2;
                    $scope.DJSAddress.AddressType.Name = "DJS-NonCity";
                }
                $scope.DJSAddress.GISCode = address.GISCode;
                $scope.DJSAddress.Latitude = address.Latitude;
                $scope.DJSAddress.Longitude = address.Longitude;
                $scope.DJSAddress.AddressLineOne = address.AddressLineOne;
                $scope.DJSAddress.AddressLineTwo = address.AddressLineTwo;
                $scope.DJSAddress.City = address.City;
                $scope.DJSAddress.State = address.State;
                $scope.DJSAddress.Zip = address.Zip;
                break;
            case 3:
            case 4:
                $scope.CSUAddress.AddressTypeID = addressType;
                if ($scope.CSUAddress.AddressType != undefined) {
                    $scope.CSUAddress.AddressType.Description = "CSU Non-City Address";
                    $scope.CSUAddress.AddressType.ID = 4;
                    $scope.CSUAddress.AddressType.Name = "CSU-NonCity";
                }
                $scope.CSUAddress.GISCode = address.GISCode;
                $scope.CSUAddress.Latitude = address.Latitude;
                $scope.CSUAddress.Longitude = address.Longitude;
                $scope.CSUAddress.AddressLineOne = address.AddressLineOne;
                $scope.CSUAddress.AddressLineTwo = address.AddressLineTwo;
                $scope.CSUAddress.City = address.City;
                $scope.CSUAddress.State = address.State;
                $scope.CSUAddress.Zip = address.Zip;
                break;
        };
    };

   

}]);