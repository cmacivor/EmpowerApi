/*** Admin Maintenance Tables Controller */
app.controller('AdminCommonController', ['$scope', '$filter', 'CRUDService', '$rootScope', 'CustomCRUDService', 'ConfigService', 'BaseService', '$timeout', '$modal', 'CurrentEntity', 'IsSystemSpecific', function ($scope, $filter, CRUDService,$rootScope ,CustomCRUDService, ConfigService, BaseService, $timeout, $modal, CurrentEntity, IsSystemSpecific) {
    // Intialize default variables
    var SetDefaultVariables = function () {
        $scope.rowCollection = []; // holds the complete collection
        $scope.displayed = [];    // holds the displayed data collection
    };

    // Generate Page Title
    var GeneratePageTitle = function () {
        if ($rootScope.SystemID == 3)
        {
            var adminItems = ConfigService.GetAdminOCWBMenuItems();
        }
        else
        {
            var adminItems = ConfigService.GetAdminMenuItems();
        }

        $scope.PageHeading = $filter('getMenuDisplayNameByTitle')(adminItems, CurrentEntity);
    };

    // Helps to set parameters as per user interactions
    var SetParameters = function (canShowForm, enableNew, canShowReset, canShowSubmit, submitButtonText, canShowDelete) {
        $scope.CanShowForm = canShowForm;
        $scope.EnableNew = enableNew;
        $scope.CanShowReset = canShowReset;
        $scope.CanShowSubmit = canShowSubmit;
        $scope.SubmitButtonText = submitButtonText;
        $scope.CanShowDelete = canShowDelete;
    };

    // Factory call to get the results according to the selected Entity
    var GetorRefreshData = function getData(tableState) {
        $scope.isLoading = true;
        $timeout(
            function () {
                CustomCRUDService(CurrentEntity, 'GetAll').GetAll(function (response) {
                    $scope.rowCollection = response;
                });
                $scope.isLoading = false;
            }, 2000
        );
    };

    // Loads defaults
    var LoadDefaults = function () {
        SetDefaultVariables();
        GeneratePageTitle();
        SetParameters(false, true, false, false, '', false);
        GetorRefreshData();
    };

    // Call Load Default as first call to generate page
    LoadDefaults();

    /** Page Events  **/
    // New button Click Event 
    $scope.CreateNew = function () {
        SetParameters(true, false, false, true, 'Save', false);
    };

    // Edit button Click Event
//    $scope.OnClick = function (
//) {
//        SetParameters(true, false, true, true, 'Update', false);

//        $scope.CurrentSelection = selectedEntity
//        $scope.CurrentObject = angular.copy(selectedEntity)
//    };
    // Edit button Click Event
    $scope.OnClick = function (selectedEntity) {
        SetParameters(true, false, true, true, 'Update', false);
        $scope.CurrentSelection = selectedEntity;
         $scope.CurrentObject = angular.copy(selectedEntity)
    };

    // Delete button Click Event
    $scope.OnDeleteClick = function (selectedEntity) {
        SetParameters(true, false, false, false, '', true);
        $scope.CurrentSelection = selectedEntity;
    };

    // Confirm button Click Event
    $scope.Delete = function (selectedEntity) {
        CustomCRUDService(CurrentEntity, 'Delete').Delete({ ID: selectedEntity.ID}, selectedEntity).$promise.then(function (retVal) {
            if (retVal[0] == "s") {
                BaseService.openSmallDialog(CurrentEntity, 'Deleted');
                GetorRefreshData();
            }
    else {

alert(CurrentEntity+" "+"Cannot be Deleted")
            }

            });

            };

    // Reset button Click Event
    $scope.Reset = function () {
        $scope.submitted = false;
        $scope.CurrentSelection = angular.copy($scope.CurrentObject);
        GetorRefreshData();
    };

    // Cancel button Click Event
    $scope.Cancel = function () {
        SetParameters(false, true, false, false, '');

        $scope.submitted = false;
        $scope.CurrentSelection = null;
        $scope.CurrentObject = null;
        GetorRefreshData();
    };

    // Save / Update button Click Event
    $scope.Update = function (isValid, selectedEntity) {
        $scope.submitted = true;
        if (isValid == true) {
            if (selectedEntity.ID != null) {  // Update entity
                CRUDService(CurrentEntity).Update(selectedEntity).$promise.then(function () {
                    BaseService.openSmallDialog(CurrentEntity, 'Updated');
                });
            }
            else {
                
                    // Create entity
                    // if system specific entity then assign system id for entity before creating it 
                    if (IsSystemSpecific == 'true' )
                    { //ISR 1090
                        if($rootScope.SystemID == "2")
                       // if ($rootScope.CurrentUserole == "AdultAdmin")
                        {
                            selectedEntity.SystemID = 2;
                        }
                        
                        else if ($rootScope.SystemID == "1")
                        {
                            selectedEntity.SystemID = 1;
                        }
                        else if ($rootScope.SystemID == "3") {
                            selectedEntity.SystemID = 3;
                        }
                            
                    } // The value 1 should be coming from some config file

                    // Set Auditing Data to the Newly Crating Entity
                    BaseService.SetAuditingDetails(selectedEntity, true);

                    CRUDService(CurrentEntity).Create(selectedEntity).$promise.then(function (response) {
                        BaseService.openSmallDialog(CurrentEntity, 'Created');
                        GetorRefreshData();
                    });                
                }
            SetParameters(false, true, false, false, '', false);
            $scope.CurrentSelection = null;
            $scope.submitted = false;            
        }
    };
}]);
app.controller('AdminServiceProgramCategory', ['$scope', '$timeout', '$filter', '$rootScope', 'CaseMgtService', 'CRUDService', 'BaseService', '$http', 'servicesURL', '$modal', 'httpCRUDService', 'ViewerRole', 'CustomCRUDService', function ($scope, $timeout, $filter, $rootScope, CaseMgtService, CRUDService, BaseService, $http, servicesURL, $modal, httpCRUDService, ViewerRole, CustomCRUDService) {
    $scope.CanShowNew = false;
    $scope.hasData = false;
    

    // Helps to set parameters as per user interactions
    var SetParameters = function (canShowForm, enableNew, canShowReset, canShowSubmit, submitButtonText, canShowDelete, canShowFormAddServiceProgram) {
        $scope.CanShowForm = canShowForm;
        $scope.EnableNew = enableNew;
        $scope.CanShowReset = canShowReset;
        $scope.CanShowSubmit = canShowSubmit;
        $scope.SubmitButtonText = submitButtonText;
        $scope.CanShowDelete = canShowDelete;
        $scope.CanShowFormAddServiceProgram = canShowFormAddServiceProgram;
       
    };

    $scope.AllServiceCategory = [];
    $scope.AllServiceProgram = [];

    $scope.GetAllServiceProgram = function () {

        $scope.CanShowTitle = true;
        $scope.isLoading = true;
        $scope.CanShowNew = false;
        $scope.CanShowFormAddServiceProgram = false;

        $timeout(
            function () {
                CaseMgtService('ServiceProgram/GetAllServiceProgram').SearchServiceProgram(function (response) {
                    $scope.rowCollection = response;
                }).$promise.then(function () {
                    $scope.CanShowNew = true;
                    $scope.rowCount = $scope.rowCollection.length;
                   
                });
                $scope.isLoading = false;
            }, 2000);

        $scope.hasData = true;
        SetParameters(false, true, false, false, '', false, false);
    };


    // Factory call to get all ServiceCategory
    var GetAllServiceCategory = function () {
        CustomCRUDService('ServiceCategory', 'GetAll').GetAll(function (response) {
            $scope.AllServiceCategory = response;
        });
    };


    // Factory call to get all ServiceProgram
    //Done with this service .
    //var GetAllServiceProgram = function () {
    //    CustomCRUDService('ServiceProgram', 'GetAll').GetAll(function (response) {
    //        $scope.AllServiceProgram = response;
    //    });
    //};

    $scope.OnClick = function (selectedEntity) {
        SetParameters(true, false, true, true, 'Update', false, false);

        GetAllServiceCategory();
        $scope.CurrentSelection = selectedEntity;
        $scope.CurrentSelection.Name = selectedEntity.ServiceName;
      
         //Call service for retrive the service category for edit .
        var url = servicesURL + "ServiceProgramCategory/SelectedServiceCategory/";
        $http.post(url + selectedEntity.ServiceProgramID + "/" + selectedEntity.ServiceName).success(function (resp) {
            //response.CategoryName
            if (resp[0] != null)
            {
                $scope.CurrentSelect = resp[0];
                $scope.CurrentSelectRadio = resp[0];
               // $scope.CurrentSelection.Active = resp[0].active;
                
                // $rootScope.CurrentSelect = angular.copy($scope.CurrentSelect);
                //$scope.CurrentObject = angular.copy(selectedEntity)
            }
           
        })
    .error(function () { alert('Unexpected Error occured.'); });
    }




    $scope.CreateNewService = function () {
        SetParameters(false, true, false, true, '', false, true);
         
        GetAllServiceCategory();

    }

    $scope.AddNewService = function (isValid, selectedEntity) {

        if ((selectedEntity != null)) {
            if (selectedEntity.Active != null) {
                var url = servicesURL + "ServiceProgram/ServiceProgramInsert/";
                $http.post(url + selectedEntity.Name + "/" + selectedEntity.Active).success(function (response) {
                    if (response[0] != '' && response[1] == 's') {
                        $scope.ServiceProgId = response[0];
                        $rootScope.ServiceProgId = angular.copy($scope.ServiceProgId);
                        $scope.CurrentSelection = selectedEntity;
                        InsertProgramServiceCategory($scope.CurrentSelection);//After create of Service Program, insert in the ServiceProgramCategory.
                        BaseService.openSmallDialog('Services Program & Category', 'Added');

                    }
                    if (response[0] == 'e') {

                        BaseService.openSmallDialog('Services Program', 'already Exists');
                        $scope.GetAllServiceProgram();


                    }

                })
               .error(function () { alert('Unexpected Error occured.'); });

            }
            else {
                alert("Please select the Active Y/N.");
                return false;
            }
            
            

        }

        SetParameters(false, true, false, false, '', false, false);
        $scope.CurrentSelection = null;
        $scope.submitted = false;

    };
   

    $scope.Cancel = function () {
        SetParameters(false, true, false, false, '',false,false);

        $scope.submitted = false;
        $scope.CurrentSelection = null;
        $scope.CurrentObject = null;
        $scope.GetAllServiceProgram();
    }

    $scope.OnDeleteClick = function (selectedEntity) {
        SetParameters(false, true, false, false, '', true,false);
        $scope.CurrentSelection = selectedEntity;
        $scope.Delete(selectedEntity);
    };

    $scope.Delete = function (selectedEntity) {
        CustomCRUDService('ServiceProgram', 'Delete').Delete({ ID: selectedEntity.ServiceProgramID }, selectedEntity).$promise.then(function (retVal) {
            if (retVal[0] == "s") {
                BaseService.openSmallDialog('ServiceProgram', 'Deleted');
                $scope.GetAllServiceProgram();
            }
            else {

                alert("ServiceProgram" + " " + "Cannot be Deleted")
            }

        });

    };

    $scope.Update = function (isValid, selectedEntity,selectedServiceCategory,isActive) {

        if ((selectedEntity.ServiceProgramID != null) && (selectedServiceCategory != null) && (isActive != null)) {
            //Update if change in the Service Program.

            var url = servicesURL + "ServiceProgram/ServiceProgramEdit/";
            $http.post(url + selectedEntity.ServiceProgramID + "/" + selectedEntity.Name +"/"+ isActive).success(function (response) {
                if ((response[0] == 's') || (response[0] == 'e')){
                    $scope.CurrentSelection = selectedEntity;
                    // $scope.Update(true, $scope.CurrentSelection);//After create of Service Program, insert in the ServiceProgramCategory.
                    EditProgarmServiceCategory($scope.CurrentSelection, selectedServiceCategory, isActive);

                }
               

            })
           .error(function () { alert('Unexpected Error occured.'); });

            SetParameters(false, true, false, false, '', false, false);
            $scope.CurrentSelection = null;
            $scope.submitted = false;

        };
    }

    var InsertProgramServiceCategory = function(selectedEntity){
            var url = servicesURL + "ServiceProgramCategory/MeargeServiceCategory/";
            if ($rootScope.ServiceProgId != '')
            {
                $http.post(url + $rootScope.ServiceProgId + "/" + selectedEntity.Category.ID).success(function (response) {
                if (response[0] == 's') {
                //Rebind the updatd grid once data added.
                    $scope.GetAllServiceProgram();
                   // BaseService.openSmallDialog('Service Program Category', 'Added');

                 }
                if (response[0] == 'e') {

                    BaseService.openSmallDialog('Services and Category', 'already Exists');
                    $scope.GetAllServiceProgram();
                  }

            })
           .error(function () { alert('Unexpected Error occured.'); });

            }//end of If
            

        }

    var EditProgarmServiceCategory = function (selectedEntity,selectServiceEntity,IsActive) {

            //Two step process.
            //1.Update the Program Name 
            //2.Update in the ServiceProgramCategory table.
            var url = servicesURL + "ServiceProgramCategory/EditServiceProgramCategory/";
          
            $http.post(url + selectedEntity.ServiceProgramID + "/" + selectServiceEntity.ServiceCategoryID + "/" + IsActive).success(function (response) {
                    if (response[0] == 's') {
                        //Rebind the updatd grid once data added.
                       
                        if(IsActive == true)
                            BaseService.openSmallDialog('Service Program Category', 'Activated');
                        else
                            BaseService.openSmallDialog('Service Program Category', 'Inactive');

                        $scope.GetAllServiceProgram();
                    }
                    if (response[0] == 'e') {

                        BaseService.openSmallDialog('Services and Category', 'Activated');
                        $scope.GetAllServiceProgram();
                    }

                })
           .error(function () { alert('Unexpected Error occured.'); });

            }//end of If

}]);//End of Main controller 

   

/*** Admin Menu: Document Table Maintenance Controller */
app.controller('DocumentController', ['$scope', '$filter', '$upload', '$rootScope', 'CRUDService', 'ConfigService', 'BaseService', 'uploadServiceURL', '$timeout', '$modal', 'CurrentEntity', 'CustomCRUDService', function ($scope, $filter, $upload, $rootScope, CRUDService, ConfigService, BaseService, uploadServiceURL, $timeout, $modal, CurrentEntity, CustomCRUDService) {

    // Page Title
    $scope.PageHeading = 'Document';

    // Intialize default variables
    var SetDefaultVariables = function () {
        $scope.rowCollection = []; // holds the complete collection
        $scope.displayed = [];    // holds the displayed data collection
    };

    // Helps to set parameters as per user interactions
    var SetParameters = function (canShowForm, enableNew, canShowReset, submitButtonText, clearFile, canShowUpdate,canShowDelete) {
        $scope.CanShowForm = canShowForm;
        $scope.EnableNew = enableNew;
        $scope.CanShowReset = canShowReset;
        $scope.CanShowUpdate = canShowUpdate;
        $scope.CanShowDelete = canShowDelete;
        $scope.SubmitButtonText = submitButtonText;
        $scope.UploadedFile = (clearFile == true) ? '' : $scope.UploadedFile;
        $scope.$files = (clearFile == true) ? '' : $scope.$files;
      
    };

    // Factory call to get the results according to the selected Entity
    var GetorRefreshData = function getData(tableState) {
        $scope.isLoading = true;
        $timeout(
            function () {
                CustomCRUDService(CurrentEntity, 'GetAll').GetAll(function (response) {
                    $scope.rowCollection = response;
                });
                $scope.isLoading = false;
            }, 2000
        );
    };

    // Loads defaults
    var LoadDefaults = function () {
        SetDefaultVariables();
        SetParameters(false, true, false, '', true, false);
        GetorRefreshData();
    };

    // Call Load Default as first call to generate page
    LoadDefaults();

    /** Page Events  **/
    // New button Click Event 
    $scope.CreateNew = function () {
        SetParameters(true, false, false, 'Upload File & Save', true, false);
    };

    // Edit button Click Event
    $scope.OnClick = function (selectedEntity) {
        SetParameters(true, false, true, 'Update with File', true, true);
        $scope.CurrentSelection = selectedEntity;

        $scope.$files = selectedEntity.FileName;
        $scope.UploadedFile = $scope.$files;

        $scope.CurrentObject = angular.copy(selectedEntity)
    };

    // Reset button Click Event
    $scope.Reset = function () {
        $scope.submitted = false;
        $scope.CurrentSelection = angular.copy($scope.CurrentObject);
        GetorRefreshData();
    };

    // Cancel button Click Event
    $scope.Cancel = function () {
        SetParameters(false, true, false, '', true, false);

        $scope.submitted = false;
        $scope.CurrentSelection = null;
        $scope.CurrentObject = null;
        GetorRefreshData();
    };

    // Funtion to update entity without file changes
    $scope.Update = function (isValid, selectedEntity) {
        SaveOrUpdate(isValid, selectedEntity);
        //$rootScope.$broadcast('rootScope:broadcast', 'Broadcast');
        //hiEventService.$broadcast('rootScope:broadcast', 'Broadcast');
    };

    // Function to save or update entity with file changes 
    $scope.onFileSelect = function ($files, isValid, selectedEntity) {
        $scope.$files = $files;
        //alert($files[0].name);

        $scope.UploadedFile = $files[0].name;
        $upload.upload({
            url: uploadServiceURL,
            file: $files[0],
            progress: function (e) { }
        }).then(function (data, status, headers, config) {
            // after uploading files successfully call Update
            SaveOrUpdate(isValid, selectedEntity);
        });
    }
    //delete functionality
    $scope.OnDeleteClick = function (selectedEntity) {
        
            var decition = confirm("are you sure, want to delete the Document");
            if (decition) {

                CustomCRUDService(CurrentEntity, 'Delete').Delete({ ID: selectedEntity.ID }, selectedEntity).$promise.then(function (retVal) {
                    BaseService.openSmallDialog(CurrentEntity, 'Deleted');

                    $scope.CurrentSelection = null;
                    $scope.CurrentObject = null;
                    GetorRefreshData();
                });
            }
       }
    

    // Confirm button Click Event
    //var Delete = function (selectedEntity) {
    //    CustomCRUDService(CurrentEntity, 'Delete').Delete({ ID: selectedEntity.ID }, selectedEntity).$promise.then(function (retVal) {
    //        BaseService.openSmallDialog(CurrentEntity, 'Deleted');
           
    //        $scope.CurrentSelection = null;
    //        $scope.CurrentObject = null;
    //        GetorRefreshData();
    //    });
    //};
    //refresh data
   
    // Common function to Save / Update entity based on with or without file changes
    var SaveOrUpdate = function (isValid, selectedEntity) {
        $scope.submitted = true;
        if (isValid == true) {
            selectedEntity.FileName = $scope.UploadedFile;
            if (selectedEntity.ID != null) {  // Update entity                 
                CRUDService(CurrentEntity).Update({ ID: selectedEntity.ID }, selectedEntity)
                BaseService.openSmallDialog(CurrentEntity, 'Updated');
            }
            else { // Create entity 
                if ($rootScope.SystemID == "2")
                {
                    selectedEntity.SystemID = 2;
                }
                if ($rootScope.SystemID == "1")
                {
                    selectedEntity.SystemID = 1;
                }
                if ($rootScope.SystemID == "3")
                {
                    selectedEntity.SystemID = 3;
                }
                //alert(selectedEntity.ID);// The value 1 should be coming from some config file
               
                //CreatedDate	CreatedBy	UpdatedDate	UpdatedBy
                //2015-07-16 17:30:26.530	1	2015-07-16 17:30:26.530	1
                BaseService.SetAuditingDetails(selectedEntity, true);
                CRUDService(CurrentEntity).Create(selectedEntity)
                BaseService.openSmallDialog(CurrentEntity, 'Created');
            }
            SetParameters(false, true, false, '', true, false);
            $scope.CurrentSelection = null;
            $scope.submitted = false;
            GetorRefreshData();
            $rootScope.$broadcast('UpdateDocumentsMenu', 'Broadcast');
        }
    };
}]);

/*** Admin Menu: Offense Table Maintenance Controller */
app.controller('OffenseController', ['$scope', 'CRUDService', '$timeout', '$filter', function ($scope, CRUDService, $timeout, $filter) {
    $scope.PageHeading = 'Offense';

}]);

/*** Admin Menu: School Table Maintenance Controller */
app.controller('SchoolController', ['$scope', 'CRUDService', '$timeout', '$filter', 'CurrentEntity', function ($scope, CRUDService, $timeout, $filter, CurrentEntity) {
    $scope.PageHeading = CurrentEntity;

}]);

/*** Admin Menu: External (Bing) Address Controller */
app.controller('ExternalController', ['$scope', 'CRUDService','CustomCRUDService', 'BaseService', 'BingServiceDB', '$timeout', '$filter', '$http', '$q', function ($scope, CRUDService, CustomCRUDService,BaseService, BingServiceDB, $timeout, $filter, $http, $q) {

    $scope.AllExternalAddresses = [];

    var FilterOnAddressType = function (item) {
        // Use below filter to work with all external addresses 
        //return item.AddressTypeID == 3; 

        // use below filter to work with all giscode external addresses 
        if (item.AddressTypeID == 2 || item.AddressTypeID == 4)
            return item;
    };

    // Get all Person Address for External address type
    var GetExternalAddresses = function () {
        CustomCRUDService('PersonAddress', 'GetAll').GetAll(function (response) {
            if (response.length > 0) {
                //To avoid rows that do not have GISCode 
               
                response = response.filter(function (element) { return element.GISCode == null; })
                //response = response.filter(function (element) { return element.AddressLineOne != null; })
                var externalAddresses = response.filter(FilterOnAddressType);
                response.filter(FilterOnAddressType);
                response = response.filter(function (element) { return element.AddressLineOne != null; })
                //response = response.filter(function (element) { return element.GISCode = null; })
                //response = response.filter(function (element) { return element.AddressTypeID != "1"; })
                //response = response.filter(function (element) { return element.AddressTypeID != "3"; })
                $scope.AllExternalAddresses = response;
                $scope.showMessage = false;
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
                                address.Longitude = item.point.coordinates[1];
                                //displaySelectedItem(item);
                            }));
                        }
                    }
                }
            });
        });
        $scope.AllExternalAddresses = response;
    };

    $scope.FillAddressPoints = function () {

        var totalExternalAddresses = $scope.AllExternalAddresses.length;
        var totalMatchedAddresses = 0;

        for (var i = 0; i < totalExternalAddresses; i++) {
            (function (index) {                
                // use the index variable - it is assigned to the value of 'i'
                // that was passed in during the loop iteration.
                var addressLine = $scope.AllExternalAddresses[index].AddressLineOne;
                var locality = $scope.AllExternalAddresses[index].City;
                
                if ($scope.AllExternalAddresses[index].Latitude == null && $scope.AllExternalAddresses[index].Longitude == null)
                {
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
        for (var i = 0; i < $scope.AllExternalAddresses.length; i++) {
            CRUDService('PersonAddress').Update({ ID: $scope.AllExternalAddresses[i].ID }, $scope.AllExternalAddresses[i]);
        }
        BaseService.openSmallDialog('PersonAddress', 'Updated');
    
    };

    GetExternalAddresses();
}]);

/*** Admin Menu: Internal (GIS) Address Controller */
app.controller('InternalController', ['$scope', 'CRUDService','CustomCRUDService', 'BaseService', 'GISServiceDB', '$timeout', '$filter', '$http', '$q', function ($scope, CRUDService,CustomCRUDService, BaseService, GISServiceDB, $timeout, $filter, $http, $q) {

    $scope.AllInternalAddresses = [];
    $scope.isLoading = false;
    $scope.message = 'Loading Data Please Wait...';
    $scope.showMessage = true;
    var FilterOnAddressType = function (item) {
        // use below filter to work with all giscode internal addresses 
        if (item.AddressTypeID == 1 || item.AddressTypeID==3)
            return item;
    };

    // Get all Person Address for External address type
    var GetInternalAddresses = function () {
        CustomCRUDService('PersonAddress','GetAll').GetAll(function (response) {
            if (response.length > 0) {
                //To avoid rows that do not have GISCode 
                //response=response.slice(25 , 250);
                response = response.filter(function (element) { return element.GISCode != null; })
                response = response.filter(function (element) { return element.AddressLineOne == null; })
                response = response.filter(function (element) { return element.GISCode > 0; })
                //Filter for internal addresses
                var externalAddresses = response.filter(FilterOnAddressType);
               
               response.filter(FilterOnAddressType);
                //take top 100 records  to avoid loading time
               
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