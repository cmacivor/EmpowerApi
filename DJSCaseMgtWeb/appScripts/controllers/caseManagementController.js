
// Case Management Menu Tab Controller
app.controller('CaseManagementController', ['$scope', '$rootScope', '$modal', '$timeout', 'ConfigService', function ($scope, $rootScope, $modal, $timeout, ConfigService) {

        //if ($rootScope.CurrentUserole == "AdultAdmin")
    if($rootScope.SystemID == "2")
    {
        var SetDefaults = function () {
            // Generating Tabs with default settings
            $scope.tabs = ConfigService.GetAdultTabItems();

            for (var i = 1; i < $scope.tabs.length; i++) {
                $scope.tabs[i].disabled = true;
                //$scope.tabs[i].active = false;
            }
            $scope.tabs[0].active = true;
            //Time picker Handles

        };

        // Call Set Defaults
        SetDefaults();
        
        $scope.$on('UpdateTabs', function (event, data) {
            $timeout(
                function () {
                    $scope.$apply(function () {
                        if (data == 'New') {
                            // Enable only the First Tab i.e Client Info
                            $scope.tabs[1].disabled = false;
                            // Disable all other tabs
                            for (var i = 2; i < $scope.tabs.length; i++) {
                                $scope.tabs[i].disabled = true;
                            }
                            $scope.tabs[1].active = true;
                        }
                        else if (data == 'Edit') {
                            // Enable all tabs and load data
                            for (var i = 0; i < $scope.tabs.length; i++) {
                                $scope.tabs[i].disabled = false;
                            }
                            $scope.tabs[1].active = true;
                        }
                        else if (data == 'Clear') {
                            // Disable all tabs 
                            for (var i = 1; i < $scope.tabs.length; i++) {
                                $scope.tabs[i].disabled = true;
                            }
                            $scope.tabs[0].active = true;
                        }
                    });
                });
        });
        
    }
    else if ($rootScope.SystemID == "1")
    {
        // Set defaults
        var SetDefaults = function () {
            // Generating Tabs with default settings
            $scope.tabs = ConfigService.GetTabItems();

            for (var i = 1; i < $scope.tabs.length; i++) {
                $scope.tabs[i].disabled = true;
                //$scope.tabs[i].active = false;
            }
            $scope.tabs[0].active = true;
            //Time picker Handles

        };

        // Call Set Defaults
        SetDefaults();

        $scope.$on('UpdateTabs', function (event, data) {
            $timeout(
                function () {
                    $scope.$apply(function () {
                        if (data == 'New') {
                            // Enable only the First Tab i.e Client Info
                            $scope.tabs[1].disabled = false;
                            // Disable all other tabs
                            for (var i = 2; i < $scope.tabs.length; i++) {
                                $scope.tabs[i].disabled = true;
                            }
                            $scope.tabs[1].active = true;
                        }
                        else if (data == 'Edit') {
                            // Enable all tabs and load data
                            for (var i = 0; i < $scope.tabs.length; i++) {
                                $scope.tabs[i].disabled = false;
                            }
                            $scope.tabs[1].active = true;
                        }
                        else if (data == 'Clear') {
                            // Disable all tabs 
                            for (var i = 1; i < $scope.tabs.length; i++) {
                                $scope.tabs[i].disabled = true;
                            }
                            $scope.tabs[0].active = true;
                        }
                    });
                });
        });
    }

    else if ($rootScope.SystemID == "3") {
        // Set defaults
        var SetDefaults = function () {
            // Generating Tabs with default settings
            $scope.tabs = ConfigService.GetOCWBTabItems();

            for (var i = 1; i < $scope.tabs.length; i++) {
                $scope.tabs[i].disabled = true;
                //$scope.tabs[i].active = false;
            }
            $scope.tabs[0].active = true;
            //Time picker Handles

        };

        // Call Set Defaults
        SetDefaults();

        $scope.$on('UpdateTabs', function (event, data) {
            $timeout(
                function () {
                    $scope.$apply(function () {
                        if (data == 'New') {
                            // Enable only the First Tab i.e Client Info
                            $scope.tabs[1].disabled = false;
                            // Disable all other tabs
                            for (var i = 2; i < $scope.tabs.length; i++) {
                                $scope.tabs[i].disabled = true;
                            }
                            $scope.tabs[1].active = true;
                        }
                        else if (data == 'Edit') {
                            // Enable all tabs and load data
                            for (var i = 0; i < $scope.tabs.length; i++) {
                                $scope.tabs[i].disabled = false;
                            }
                            $scope.tabs[1].active = true;
                        }
                        else if (data == 'Clear') {
                            // Disable all tabs 
                            for (var i = 1; i < $scope.tabs.length; i++) {
                                $scope.tabs[i].disabled = true;
                            }
                            $scope.tabs[0].active = true;
                        }
                    });
                });
        });
    }
}]);

// Search Tab Controller
app.controller('ClientSearchController', ['$scope', '$timeout', '$filter', '$rootScope', 'CaseMgtService', 'CRUDService', 'BaseService', '$http', 'servicesURL', '$modal', 'httpCRUDService', 'ViewerRole', function ($scope, $timeout, $filter, $rootScope, CaseMgtService, CRUDService, BaseService, $http, servicesURL, $modal, httpCRUDService, ViewerRole) {
   
   
        $scope.CanShowNew = false;
        $scope.hasData = false;
        //if ($rootScope.SystemID == "2")
        //    $scope.showJTS = false;
        //else
        //    $scope.showJTS = true;

        $scope.ClientProfile = '';
        $rootScope.Person = '';
        $rootScope.Person.PersonAddress = '';
        $rootScope.Placements = '';
        $rootScope.FamilyProfiles = '';
        $rootScope.Assessments = '';
        // Create the scope for all the controllers
        var modalScope = $rootScope.$new();

        //to test the authorization for keys

        $scope.viewer = ViewerRole;

        //Update All Person Unique IDs 

        $scope.MergePlacements = function (person) {

            $scope.Person = person;
            var uniqueid;
            $scope.Person.UniqueID = uniqueid;
            $scope.submitted = true;

            $rootScope.NewPerson = angular.copy(person);

            var LC = soundex(person.LastName);
            var FC = EncodeFirstName(person.FirstName);
            if (person.MiddleName != undefined) {
                var MC = EncodeInitial(person.MiddleName);
                var b = parseInt(MC);
            }
            var day = moment(person.DOB);
            //var DC = new Date(day.format("MMM Do YY"));
            var Gend = person.GenderID;
            var DayCode = ((day.get('month') + 1) * 40) + day.date() + ((Gend == 1) ? 500 : 0);
            var a = parseInt(FC);
            var c = 0;
            if (person.MiddleName == undefined || person.MiddleName == "") {
                c = a;
            } else {
                c = a + b;
            }

            c = replacespacewithgzero(c);
            DayCode = replacespacewithgzero(DayCode);

            // alert('The Unique Licence Number Is : ' + LC + '-' + c + '-' + (day.get('year') % 100) + '-' + DayCode);
            uniqueid = LC + '-' + c + '-' + (day.get('year') % 100) + '-' + DayCode;
            $rootScope.NewUniqueID = angular.copy(uniqueid);

            //    debugger;

            CaseMgtService('person/GetduplicatePersons').GetduplicatePersons({
                ID: uniqueid
            }, function (response) {
                if (response.length > 0) {
                    response = response.filter(function (obj) {
                        return obj.ClientProfileID !== person.ID;
                    });


                    modalScope.DProwCollection = response;

                }

                modalScope.selectedList = [];
                modalScope.CheckPerson = function (event) {
                    console.log(event);
                };
                modalScope.DProwCollection = response;
                modalScope.modalInstance = $modal.open({
                    templateUrl: 'views/casemanagement/MeargePersonList.html',
                    controller: [
                                    '$scope', '$modalInstance', '$window', '$http', '$rootScope', 'servicesURL', 'BaseService', 'CRUDService', function ($scope, $modalInstance, $window, $http, $rootScope, servicesURL, BaseService, CRUDService) {
                                        $scope.CloseModal = function () {
                                            $modalInstance.close();
                                        };
                                        $scope.MergeClientServices = function () {

                                            // MeargePerson
                                            var pCId = person.ID;
                                            var resObj = modalScope.DProwCollection.filter(function (obj) {
                                                return obj.Checked == true;
                                            });
                                            var ClientProfileIds = [];
                                            for (var i = 0; i < resObj.length; i++) {
                                                ClientProfileIds.push(resObj[i].ClientProfileID)
                                            }

                                            httpCRUDService.PostById('Person/MeargePerson', ClientProfileIds, pCId).then(function (result) {
                                                if (result.StatusCode == 200) {
                                                    alert('Services Merged successfully');
                                                    DeleteClientProfile(ClientProfileIds);
                                                    alert('Duplicate client profile deleted successfully');
                                                    $modalInstance.close();

                                                }
                                            });

                                        };
                                    }],
                    scope: modalScope,
                    backdrop: 'static',
                    keyboard: true, // restricts esc key usage
                    windowClass: 'large-Modal',
                    resolve: {
                        DProwCollection: function () {
                            return response;
                        }
                    }

                    //    scope: modalScope,
                    //    backdrop: 'static',
                    //    keyboard: true, // restricts esc key usage
                    //    size: 'lg',
                    //    resolve: {
                    //        //selectedPlacement: function () {
                    //        //    return placement;
                    //        //}
                    //    }
                    //});
                    //modalScope.modalInstance.result.then(function () {
                    //    RefreshPlacements();
                    //}, function () {
                    //    //alert('Dialog closing with Dismiss');
                });
            });
        };
        $scope.UpdateAllUniqueIDs = function (person) {
            var records = CRUDService('Person').GetAll(function (response) {
                var output = response;
                // $scope.Person=output;
                var reqArray = [];
                //var uniqueid;
                //$scope.Person.UniqueID = uniqueid;
                var i = 0;
                var isretured = true;
                for (var i = 0; i < output.length; i++) {
                    // isretured =false;

                    var LC = soundex(output[i].LastName == null ? "" : output[i].LastName);
                    var FC = EncodeFirstName(output[i].FirstName == null ? "" : output[i].FirstName);
                    if (output[i].MiddleName != undefined && output[i].MiddleName != "") {
                        var MC = EncodeInitial(output[i].MiddleName);
                        var b = parseInt(MC);
                    }


                    var day = moment(output[i].DOB);

                    //var DC = new Date(day.format("MMM Do YY"));

                    var Gend = output[i].GenderID;

                    var DayCode = ((day.get('month') + 1) * 40) + day.date() + ((Gend == 1) ? 500 : 0);
                    var a = parseInt(FC);
                    var c = 0;
                    if (output[i].MiddleName == undefined || output[i].MiddleName == "") {
                        c = a;
                    } else {
                        c = a + b;
                    }
                    c = replacespacewithgzero(c);
                    DayCode = replacespacewithgzero(DayCode);
                    var uniqueid = LC + '-' + c + '-' + (day.get('year') % 100) + '-' + DayCode;
                    //var x = uniqueid;

                    reqArray[i] = {
                        PersonId: output[i].ID,
                        UniqueId: uniqueid.toString()
                    };
                }
                var req = {
                    "list": reqArray
                };

                var url = servicesURL + "Person/UpdateAlluniqueIds";
                var config = {
                    responsetype: 'json',
                    headers: {
                        'Accept': 'application/json', 'Content-Type': 'application/json'
                    }
                }
                return $http.post(url, req, config).then(function (res) {
                    return res;
                });


            });


        }
        //updateallSSNs

        $scope.UpdateAllSSNs = function (person) {
            var records = CRUDService('Person').GetAll(function (response) {
                var output = response;

                // $scope.Person=output;
                var reqArray = [];
                //var uniqueid;
                //$scope.Person.UniqueID = uniqueid;
                var i = 0;
                var isretured = true;
                for (var i = 0; i < output.length; i++) {
                    // isretured =false;


                    //var DC = new Date(day.format("MMM Do YY"));

                    if (output[i].SSN != null) {
                        var ssns = output[i].SSN;
                    }
                    //var x = uniqueid;

                    reqArray[i] = {
                        PersonId: output[i].ID,
                        SSNs: ssns.toString()
                    };
                }
                var req = {
                    "list": reqArray
                };

                var url = servicesURL + "Person/UpdateAllSsns";
                var config = {
                    responsetype: 'json',
                    headers: {
                        'Accept': 'application/json', 'Content-Type': 'application/json'
                    }
                }
                return $http.post(url, req, config).then(function (res) {
                    return res;
                });


            });


        }



        //end of operation

        $scope.Search = function (obj) {
            $rootScope.SystemID
            //if ($rootScope.CurrentUserole == "AdultAdmin")
            if ($rootScope.SystemID =="2")
            {
                $scope.CanShowTitle = false;
                //ISR 1019
                $scope.CanShowTitleAdult = true;

            }
            if($rootScope.SystemID =="1") {
                $scope.CanShowTitle = true;
                //ISR 1019
                $scope.CanShowTitleAdult = false;
                //ISR 1019

            }
            if ($rootScope.SystemID == "3") {
                $scope.CanShowTitle = false;
                //ISR 1019
                $scope.CanShowTitleAdult = true;

            }

            $scope.isLoading = true;
            $scope.CanShowNew = false;
            if (obj != null) {
                $timeout(
                    function () {
                        CaseMgtService('ClientProfile/Search').SearchClientProfile(obj, function (response) {
                            $scope.rowCollection = response;
                        }).$promise.then(function () {
                            $scope.CanShowNew = true;
                            $scope.rowCount = $scope.rowCollection.length;
                        });
                        $scope.isLoading = false;
                    }, 2000);
            }
            $scope.hasData = true;
        };

        $scope.notifiation = function () {
            alert('test for the notification');


        }
        //for 21plus
        $scope.Search21plus = function () {
            if($rootScope.SystemID == "2")
            //if($rootScope.CurrentUserole == "AdultAdmin")
            {
                $scope.CanShowTitle = false;
                //ISR 1019
                $scope.CanShowTitleAdult = true;
           
            }
            if ($rootScope.SystemID == "1")
            {
                $scope.CanShowTitle = true;
                //ISR 1019
                $scope.CanShowTitleAdult = false;
                //ISR 1019

            }
            if ($rootScope.SystemID == "3")
                //if($rootScope.CurrentUserole == "AdultAdmin")
            {
                $scope.CanShowTitle = false;
                //ISR 1019
                $scope.CanShowTitleAdult = true;

            }



            $scope.isLoading = true;
            $scope.CanShowNew = false;

            $timeout(
                function () {
                    CaseMgtService('ClientProfile/SearchPlus').SearchClientProfile1(function (response) {
                        $scope.rowCollection = response;
                    }).$promise.then(function () {
                        $scope.CanShowNew = true;
                        $scope.rowCount = $scope.rowCollection.length;
                        $scope.checkAll = function () {
                            if ($scope.selectedAll) {
                                $scope.selectedAll = true;
                            } else {
                                $scope.selectedAll = false;
                            }
                            angular.forEach($scope.displayed, function (row) {
                                row.selected = $scope.selectedAll;
                            });
                        };
                        $scope.Deleteall = function (row) {
                            var deleteids = [];
                            angular.forEach($scope.displayed, function (row) {
                                if (row.selected == true) {
                                    // DeleteClientProfile(row.ID);
                                    deleteids.push(row.ID);
                                }
                                else {
                                    return null;
                                }
                            });
                            if (deleteids.length > 0)
                                DeleteaMultipleClients(deleteids);
                        }
                    });
                    $scope.isLoading = false;
                }, 2000);

            $scope.hasData = true;
        };

        //Pending Delete Profiles
        $scope.SearchToDeleteByAdmin = function () {
            if($rootScope.SystemID == "2")
            //if ($rootScope.CurrentUserole == "AdultAdmin")
            {
                $scope.CanShowTitle = false;
                //ISR 1019
                $scope.CanShowTitleAdult = true;

            }
            if ($rootScope.SystemID == "1")
            {
                $scope.CanShowTitle = true;
                //ISR 1019
                $scope.CanShowTitleAdult = false;
                //ISR 1019

            }
            if ($rootScope.SystemID == "3")
                //if ($rootScope.CurrentUserole == "AdultAdmin")
            {
                $scope.CanShowTitle = false;
                //ISR 1019
                $scope.CanShowTitleAdult = true;

            }

            $scope.isLoading = true;
            $scope.CanShowNew = false;
            $scope.showprofiles = true;
            $timeout(
                function () {
                    CaseMgtService('ClientProfile/InActiveClients').GetClientProfileToDelete(function (response) {
                        $scope.rowCollection = response;
                    }).$promise.then(function () {
                        $scope.CanShowNew = true;
                        $scope.rowCount = $scope.rowCollection.length;
                        $scope.checkAll = function () {
                            if ($scope.selectedAll) {
                                $scope.selectedAll = true;
                            } else {
                                $scope.selectedAll = false;
                            }
                            angular.forEach($scope.displayed, function (row) {
                                row.selected = $scope.selectedAll;
                            });
                        };
                        $scope.DeleteallByAdmin = function (row) {
                            var deleteids = [];
                            angular.forEach($scope.displayed, function (row) {
                                if (row.selected == true) {
                                    // DeleteClientProfile(row.ID);
                                    deleteids.push(row.ID);
                                }
                                else {
                                    return null;
                                }
                            });
                            if (deleteids.length > 0) {
                                var reply = confirm("Are you sure you want to delete the client(s)?");
                                if (reply)
                                    DeleteaMultipleClientsByAdmin(deleteids);
                                else
                                    return false;
                            }

                        }
                    });
                    $scope.isLoading = false;
                }, 2000);

            $scope.hasData = true;
        };
        $rootScope.CountInactiveClients = function () {
            angular.copy($scope.SearchToDeleteByAdmin);
        }

        //End of Pending delete profiles

        // Clear Search
        $scope.ClearSearch = function (entity) {
            entity.lastName = '';
            entity.firstName = '';
            $scope.rowCollection = [];
            $scope.CanShowNew = false;
            $scope.CanShowTitle = false;
            if($rootScope.SystemID == "2")
            //if ($rootScope.CurrentUserole == "AdultAdmin")
            {
                $scope.CanShowTitle = false;
                //ISR 1019
                $scope.CanShowTitleAdult = true;

            }
            if ($rootScope.SystemID == "1")
            {
                $scope.CanShowTitle = true;
                //ISR 1019
                $scope.CanShowTitleAdult = false;
                //ISR 1019

            }
            if ($rootScope.SystemID == "3")
                //if ($rootScope.CurrentUserole == "AdultAdmin")
            {
                $scope.CanShowTitle = false;
                //ISR 1019
                $scope.CanShowTitleAdult = true;

            }

            $rootScope.currentClientName = '';
            $rootScope.$broadcast('UpdateTabs', 'Clear');
            $rootScope.$broadcast('UpdateClientInfo', 'NewClient');
            $rootScope.$broadcast('UpdateReferral', 'NewReferral');
            $rootScope.$broadcast('UpdateFamilyInfo', 'NewFamilyInfo');
        };
        ////check all
        //$scope.checkAll = function () {
        //    if ($scope.selectedAll) {
        //        $scope.selectedAll = true;
        //    } else {
        //        $scope.selectedAll = false;
        //    }
        //    angular.forEach($scope.displayed, function (row) {
        //        row.selected = $scope.selectedAll;
        //    });
        //};


        // New Client Profile 
        $scope.CreateNew = function () {

            $rootScope.Person = '';
            $rootScope.$broadcast('UpdateTabs', 'New');
            $rootScope.$broadcast('UpdateClientInfo', 'NewClient');
            $rootScope.$broadcast('UpdateReferral', 'NewReferral');
            $rootScope.$broadcast('UpdateFamilyInfo', 'NewFamilyInfo');
            //$scope.xjts = "true";
            //$rootScope.xjts = angular.copy($scope.xjts);
        };

        // Edit Client Profile
        $scope.LoadClientProfile = function (selectedEntity) {

            GetandUpdateClientProfile(selectedEntity.ID);
            $rootScope.currentClientName = selectedEntity.FirstName + ' ' + selectedEntity.LastName;
            $rootScope.ReqClient = selectedEntity;
            $rootScope.printage = function () {
                if ($rootScope.ReqClient.DOB != null) {
                    var DOB = $rootScope.ReqClient.DOB;
                    var currentYear = new Date();
                    var d = new Date(DOB);

                    // var diff = (currentYear - new Date(DOB).getTime());
                    var diff = (currentYear - d);
                    $scope.CurrentAge = (currentYear.getFullYear() - d.getFullYear());


                    if (currentYear.getMonth() < d.getMonth() ||
                   currentYear.getMonth() == d.getMonth() && currentYear.getDate() < d.getDate()) {
                        $scope.Person.CurrentAge--;
                    }
                    return $scope.CurrentAge;



                }
                //$scope.Person.CurrentAge = years;
            };





        };


        // Delete Client Profile
        $scope.deleteClientProfile = function (selectedEntity) {
            var decition = confirm("are you sure you want to delete the client");
            if (decition) {
                DeleteClientProfile(selectedEntity.ID);
            }

        };

        //ReActivate Client Profile
        $scope.RevertInactiveClientProfile = function (selectedEntity) {
            var response = confirm("are you sure you want to make the client active again.");
            if (response)
                ActivateClient(selectedEntity.ID);
        }

        var ActivateClient = function (clientProfileID) {
            $rootScope.CurrentClientProfileID = clientProfileID;
            CaseMgtService('ClientProfile/Activateclient').ActivateClient({ ID: clientProfileID }, function (response) {
                //$scope.ClientProfile = response;


            }).$promise.then(function (response) {
                if (response[0] == "S") {
                    BaseService.openSmallDialog('Person', 'activated');
                    $scope.SearchToDeleteByAdmin($scope.entity);
                }
            });
        };
        //End ReActivate Client Profile 

        // Helper functions to handle all other tabs
        $scope.$on('UpdateClientProfile', function (event, clientProfileID) {
            $timeout(
                function () {
                    $scope.$apply(function () {
                        GetandUpdateClientProfile(clientProfileID);
                    });
                });
        });
        //
        var DeleteClientProfile = function (clientProfileID) {
            $rootScope.CurrentClientProfileID = clientProfileID;
            CaseMgtService('ClientProfile/Deleteclient').DeleteClientProfile({ ID: clientProfileID }, function (response) {
                //$scope.ClientProfile = response;


            }).$promise.then(function (response) {
                if (response[0] == "S") {
                    BaseService.openSmallDialog('Person', 'deleted');
                    $scope.Search($scope.entity);
                }
            });
        };

        var DeleteaMultipleClients = function (DeletedIDs) {
            CaseMgtService('ClientProfile/DeleteMultipleClients').DeleteMultipleClients(DeletedIDs, function (response) {
                //$scope.ClientProfile = response;
                if (response[0] == "s")
                    BaseService.openSmallDialog('Client Profiles', 'Deleted');
            }).$promise.then(function (response) {
                $scope.Search21plus();
            });
        };
        //To Delete by admin multiple clients
        var DeleteaMultipleClientsByAdmin = function (DeletedIDs) {
            CaseMgtService('ClientProfile/AdminDeleteClientProfile').DeleteMultipleClients(DeletedIDs, function (response) {
                //$scope.ClientProfile = response;
                if (response[0] == "s")
                    BaseService.openSmallDialog('Client Profiles', 'Deleted');
            }).$promise.then(function (response) {
                $scope.SearchToDeleteByAdmin($scope.entity);
            });
        };


        // Get complete ClientProfile info and load tabs
        var GetandUpdateClientProfile = function (clientProfileID) {
            $rootScope.CurrentClientProfileID = clientProfileID;
            CRUDService('ClientProfile').Find({ ID: clientProfileID }, function (response) {
                $scope.ClientProfile = response;

                ClientInfo(); // Update ClientInfo Tab
                Supplemental(); // Update Supplemental Tab
                Address(); // Update Address Tab            
                FamilyInfo(); // Update FamilyInfo Tab
                Referral(); // Update Referral Tab
                Assessment(); // Update Assessment Tab            

            }).$promise.then(function () {
                $rootScope.$broadcast('UpdateTabs', 'Edit');
            });
        };

        // Loads Client Info Tab
        var ClientInfo = function () {
            $rootScope.Person = $scope.ClientProfile.Person;
            $rootScope.ClientProfile = $scope.ClientProfile.ClientProfile;
            $rootScope.CurrentClientProfilePersonId = $scope.ClientProfile.Person.Person.ID;
            //$rootScope.Person.CurrentAge = (new Date().getFullYear() -new Date($rootScope.Person.Person.DOB).getFullYear());
            $rootScope.$broadcast('UpdateClientInfo', 'EditClient');
        };

        // Loads Supplemental Tab
        var Supplemental = function () {
            $rootScope.$broadcast('UpdateSupplemental', 'EditSupplemental');
        };

        // Loads Address Tab
        var Address = function () {
            $rootScope.$broadcast('UpdateAddress', 'EditAddress');
        };

        // Loads Family Info Tab
        var FamilyInfo = function () {
            $rootScope.Person = $scope.ClientProfile.Person;
            $rootScope.ClientProfile = $scope.ClientProfile.ClientProfile;
            // $rootScope.CurrentClientProfilePersonId = $scope.ClientProfile.ClientProfile.ID;
            $rootScope.FamilyProfiles = $scope.Person.FamilyProfile;

            $rootScope.$broadcast('UpdateFamilyInfo', 'EditFamilyInfo');
        };

        // Loads Referral Tab
        var Referral = function () {
            $rootScope.Placements = $scope.ClientProfile.Placement;
            $rootScope.$broadcast('UpdateReferral', 'EditReferral');
        };

        // Loads Assessment Tab
        var Assessment = function () {
            $rootScope.Assessments = $scope.ClientProfile.Assessment;
            $rootScope.$broadcast('UpdateAssessment', 'EditAssessment');
        };

      

}]);

// Case Plan Tab Controller
app.controller('CasePlanController', ['$scope', '$timeout', '$filter', '$rootScope', '$modal', 'CRUDService', 'CaseMgtService', 'BaseService', function ($scope, $timeout, $filter, $rootScope, $modal, CRUDService, CaseMgtService, BaseService)
{

    var modalScope = $rootScope.$new();
    //to open the accordion groups
    $scope.ClientProfile = '';
    $rootScope.Person = '';
    $rootScope.Person = $scope.ClientProfile.Person;
    $scope.isOpen = true;

    // Don't show the footer message intiallly
    $scope.CanShowBCPPlanMessage = false;

    // Function to generate Referral Title
    $scope.GenerateBCPPlanTitle = function (bcpplan) {

        var title = bcpplan;

        //for (var i = 0; i <= placement.PlacementOffense.length - 1; i++)
        //{
        //    title = title + " || " + placement.PlacementOffense[i].Offense.VCCCode;
        //}

        return title;
    };
    
    // Function to raise as Create New Placement button is clicked
    $scope.AddOrEditBCPPlan = function (bcpplan) {
        modalScope.modalInstance = $modal.open({
            templateUrl: 'views/casemanagement/addoreditBCPPlan.html',
            controller: 'AddorUpdateBCPController',
            scope: modalScope,
            backdrop: 'static',
            keyboard: false, // restricts esc key usage
            size: 'lg',
            resolve: {
                selectedBCP: function () {

                    return bcpplan;
                }
            }
        });
        modalScope.modalInstance.result.then(function () {
            RefreshBCPPlans();
        }, function () {
            alert('Dialog closing with Dismiss');
        });
    };


    //print friendly version
    //$scope.PrintPlacement = function (placement, placementEnrollment, $event, enrollmentType) {
    //    modalScope.modalInstance = $modal.open({
    //        templateUrl: 'views/casemanagement/PrintReferral.html',
    //        controller: 'AddorUpdateEnrollmentController',
    //        scope: modalScope,
    //        backdrop: 'static',
    //        keyboard: true,// restricts esc key usage
    //        size: 'lg',
    //        resolve:
    //        {


    //            selectedPlacement: function () {

    //                return placement;
    //            },


    //            selectedEnrollment: function () {
    //                if (enrollmentType == "New") {
    //                    $rootScope.CurrentPlacementID = placement.Placement.ID;
    //                }
    //                else if (enrollmentType == "Edit") {
    //                    $rootScope.CurrentPlacementID = placement.Enrollment.PlacementID;
    //                    $rootScope.CurrentEnrollmentId = placement.Enrollment.ID;
    //                }
    //                return placementEnrollment;
    //            }
    //        }
    //    });

    //    modalScope.modalInstance.result.then(function () {

    //        RefreshPlacements();
    //    }, function () {
    //        //alert('Dialog closing with Dismiss');
    //    });
    //};




    //Delete placement functionality
    //$scope.deleteBCPPlan = function (row) {
    //    var decition = confirm("Are youu sure , you want to delete the BCP Plan");
    //    if (decition)
    //        deleteplacement(row.Placement);

    //};


    //var deleteBCP = function (selectedBCP) {
    //    CaseMgtService('Placement/DeleteBCP').DeleteBCPbyid({ ID: selectedBCP.ID }, function (response) {
    //        //$scope.ClientProfile = response;
    //        if (response == "Success")

    //            RefreshPlacements();



    //    }).$promise.then(function (response) {
    //        BaseService.openSmallDialog('placement', 'deleted');
    //        RefreshPlacements();

    //    });
    //};


    // Function to raise as Create New Enrollment button is clicked
    //$scope.AddOrEditEnrollment = function (placement, placementEnrollment, $event, enrollmentType) {
    //    modalScope.modalInstance = $modal.open({
    //        templateUrl: 'views/casemanagement/addoreditEnrollment.html',
    //        controller: 'AddorUpdateEnrollmentController',
    //        scope: modalScope,
    //        backdrop: 'static',
    //        keyboard: false, // restricts esc key usage
    //        size: 'lg',
    //        resolve:
    //        {
    //            selectedEnrollment: function () {
    //                if (enrollmentType == "New") {
    //                    $rootScope.CurrentPlacementID = placement.Placement.ID;
    //                }
    //                else if (enrollmentType == "Edit") {
    //                    $rootScope.CurrentPlacementID = placement.Enrollment.PlacementID;
    //                    $rootScope.CurrentEnrollmentId = placement.Enrollment.ID;
    //                }
    //                return placementEnrollment;
    //            }
    //        }
    //    });

    //    modalScope.modalInstance.result.then(function () {
    //        RefreshPlacements();
    //    }, function () {
    //        //alert('Dialog closing with Dismiss');
    //    });
    //};

    //var RefreshEnrollments = function () {
    //    CaseMgtService('ClientProfile/Enrollment').GetEnrollmentsByPlacements({ ID: $rootScope.CurrentPlacementID }).$promise.then(function (response) {

    //        for (var i = 0; i < $rootScope.Placements.length; i++) {
    //            if ($rootScope.Placements[i].Placement.ID === $rootScope.CurrentPlacementID) {
    //                $rootScope.Placements[i].Enrollment = response;

    //                return;
    //            }
    //        }
    //    });
    //};

    // Function to raise as Edit Placement button is clicked
    //$scope.EditPlacement = function (row, $event) {
    //    $event.preventDefault();
    //    $event.stopPropagation();

    //    $scope.AddOrEditPlacement(row);
    //};

    //print placement

    //$scope.Printplace = function (row, $event) {
    //    $event.preventDefault();
    //    $event.stopPropagation();

    //    $scope.PrintPlacement(row);
    //};


    var RefreshPlacements = function () {
        CaseMgtService('ClientProfile/BehaviorChangePlan').GetBehaviorChangePlanByClientProfile({ ID: $rootScope.CurrentClientProfileID }, function (response) {
            $rootScope.Placements = response;
            $scope.Placements = $rootScope.Placements;
            $scope.CanShowPlacementMessage = ($scope.Placements.length == 0) ? true : false;
        });
    };
    //function to Delete the enrollments by Placements


    //$scope.DeleteEnrollment = function (row) {
    //    var decition = confirm("Are u sure you want to delete the Enrollment?");
    //    if (decition)
    //        DeleteEnrollment(row.Enrollment);

    //};


    //var DeleteEnrollment = function (selectedenrollment) {

    //    CaseMgtService('Enrollment/DeleteEnrollment').DeleteEnrollmentsByPlacements({ ID: selectedenrollment.ID }, function (response) {
    //        //$scope.ClientProfile = response;
    //        if (response == "Success")

    //            Refreshplacements();



    //    }).$promise.then(function (response) {
    //        BaseService.openSmallDialog('Enrollment', 'deleted');
    //        RefreshPlacements();

    //    });
    //};

    //$scope.CloseModal = function () {
    //    $modalInstance.close();
    //};


    // Listen to the event whenever there is a change in rootscope person
    //$scope.$on('UpdateReferral', function (event, data) {
    //    $timeout(
    //        function () {
    //            $scope.$apply(function () {
    //                if (data == 'NewReferral') {
    //                    $scope.Placements = '';
    //                }
    //                else if (data == 'EditReferral') {
    //                    $scope.Placements = $rootScope.Placements;
    //                    $scope.CanShowPlacementMessage = ($scope.Placements.length == 0) ? true : false;
    //                }
    //            });
    //        });
    //});


    // Create the scope for all the controllers

}]);



// End Case Plan Tab Conroller 

// Case Plan Tab : Create new or Update existing BCP Controller.
app.controller('AddorUpdateBCPController', ['$scope', '$rootScope', '$timeout', '$modalInstance', '$filter', 'CRUDService', 'BaseService', '$q', 'CustomCRUDService', function ($scope, $rootScope, $timeout, $modalInstance, $filter, CRUDService, BaseService, $q, CustomCRUDService)
{
    // Initialize all required variables
    ////  var SetDefaultVariables = function () {
    ////        // Assign selectedPlacement to CurrentPlacement
    ////        $scope.CurrentPlacement = (selectedPlacement != null ? selectedPlacement : null);
    ////        $scope.OrgCurrentPlacement = (selectedPlacement != null ? angular.copy(selectedPlacement) : null);
    ////        $scope.AllPlacementLevels = [];
    ////        $scope.AllJudges = [];
    ////        //$scope.GetAllCourt
    ////        $scope.AllOffenses = [];
    ////        $scope.SelectedOffenses = [];
    ////        $scope.Offenses = [];
    ////      //ISR 101
    ////        $scope.AllCourtName = [];
    ////      //ISR 1019
    ////    };

    ////    // Define Submit button Text
    ////    var SetButtonText = function () {
    ////        $scope.SubmitButtonText = (selectedPlacement != null ? 'Update' : 'Save');

    ////    };

        var p =
            // Begin: DatePicker Functionality
            $scope.datePicker = (function () {
                var method = {};
                method.instances = [];

                method.open = function ($event, instance) {
                    $event.preventDefault();
                    $event.stopPropagation();

                    method.instances[instance] = true;
                };

                $scope.dateOptions = {
                    startingDay: 1,
                    showWeeks: 'false'
                };

                return method;
            }());
        // End: DatePicker Functionality

    ////    // Start: Factory and Service Calls  
    ////    // Factory call to get all Placement Levels
    ////    var GetAllPlacementLevels = function getData() {
    ////        CustomCRUDService('PlacementLevel', 'GetAll').GetAll(function (response) {

    ////            $scope.AllPlacementLevels = response;
    ////        });
    ////    };

    ////    // Factory call to get all Judges 
    ////    var GetAllJudges = function getData() {
    ////        CustomCRUDService('Judge', 'GetAll').GetAll(function (response) {

    ////            $scope.AllJudges = response;
    ////        });
    ////    };

    ////    // Factory call to get all Placement Charges
    ////    var GetAllOffenses = function getData() {
    ////        CustomCRUDService('Offense', 'GetAll').GetAll(function (response) {

    ////            $scope.AllOffenses = response;
    ////        });
    ////    };

    ////    // ngInputsTag for Placement Charges Code
    ////    $scope.GetPlacementCharges = function (query) {
    ////        var defer = $q.defer();
    ////        var test = $filter('filterByName')($scope.AllOffenses, query);

    ////        defer.resolve(test);
    ////        return defer.promise;
    ////    };

    //////Factory call to get the Court Name
    ////    var GetAllCourt = function getData() {
    ////        CustomCRUDService('CourtName', 'GetAll').GetAll(function (response) {

    ////            $scope.AllCourtName = response;
    ////        });
    ////    };

    ////    // End: Factory and Service Calls  

    ////    // Start: Page Events  
    ////    // Cancel button event
    ////    $scope.CloseModal = function () {
    ////        $modalInstance.close();
    ////    };

    ////    // Reset button event
    ////    $scope.Reset = function () {
    ////        // $scope.currentPlacement = $scope.placement.placement;
    ////        $scope.CurrentPlacement = angular.copy($scope.OrgCurrentPlacement);
    ////    };




    ////    // Save / Update button Click Event
    ////    $scope.CreateOrUpdate = function (isValid, placement) {
    ////        $scope.submitted = true;
    ////        if (isValid == true) {
    ////            // Update FK Id's using selection on view
    ////            placement.Placement.PlacementLevelID = placement.Placement.PlacementLevel.ID;
    ////            placement.Placement.JudgeID = placement.Placement.Judge.ID;
    ////            //ISR 1019
    ////             if($rootScope.SystemID == "2")
    ////            //if ($rootScope.CurrentUserole == "AdultAdmin") 
    ////            {
    ////                placement.Placement.CourtNameID = placement.Placement.CourtName.ID;
    ////            }
    ////            else
    ////            {
    ////                placement.Placement.CourtNameID = null;
    ////            }
    ////            //ISR 1019

    ////            if (placement.Placement.ID != null) {
    ////                if (placement.PlacementOffense == undefined)
    ////                { alert('please pick the charge code'); }
    ////                for (var i = 0; i < placement.PlacementOffense.length; i++) {
    ////                    if (placement.PlacementOffense[i].ID != 0) {
    ////                        BaseService.SetAuditingDetails(placement.PlacementOffense[i], true);

    ////                    }
    ////                }
    ////                placement.Placement.UpdatedBy = $rootScope.CurrentUser;
    ////                CRUDService('Placement').Update({ ID: placement.Placement.ID }, placement).$promise.then(function () {
    ////                    BaseService.openSmallDialog('Placement', 'Updated');
    ////                    $modalInstance.close();
    ////                });
    ////            }
    ////            else {
    ////                // Set Auditing Data to the Newly Crating Entity
    ////                BaseService.SetAuditingDetails(placement.Placement, true);
    ////                if (placement.PlacementOffense == undefined)
    ////                { alert('please pick the charge code'); }
    ////                for (var i = 0; i < placement.PlacementOffense.length; i++) {
    ////                    BaseService.SetAuditingDetails(placement.PlacementOffense[i], true);
    ////                }
    ////                placement.Placement.CreatedBy = $rootScope.CurrentUser;
    ////                // update placement's ClietProfileID with CurrentClientProfileID
    ////                placement.Placement.ClientProfileID = $rootScope.CurrentClientProfileID;
    ////                //to avoid virtuials in dropdown
    ////                placement.Placement.Judge = null;
    ////                placement.Placement.PlacementLevel = null;


    ////                CRUDService('Placement').Create(placement).$promise.then(function (response) {
    ////                    BaseService.openSmallDialog('Placement', 'Created');
    ////                    $modalInstance.close();
    ////                });
    ////            }
    ////        };
    ////        $scope.submitted = false;
    ////        LoadDefaults();
    ////    };
    ////    // End: Page Events  

    ////    // Adding Offense to the existing colleciton
    ////    $scope.OnOffenseSelect = function ($item) {

    ////        // CREATE NEW PLACEMENTOFFENSE AND LOAD SELECTED OFFENSE TO IT
    ////        var placementOffense = {
    ////            PlacementID: $scope.CurrentPlacement.ID,
    ////            OffenseID: $item.ID,
    ////            Active: true,
    ////            Placement: null,
    ////            Offense: $item
    ////        };
    ////        if ($scope.CurrentPlacement.PlacementOffense == null)
    ////            $scope.CurrentPlacement.PlacementOffense = [];

    ////        // Add that to the scope variable to bind it to UI
    ////        $scope.CurrentPlacement.PlacementOffense.push(placementOffense);
    ////        $scope.SelectedOffense = '';
    ////    };

    ////    // Remove Offense from the existing colleciton
    ////    $scope.RemoveOffense = function (offense) {
    ////        for (var i = 0; $scope.CurrentPlacement.PlacementOffense.length; i++) {
    ////            if (JSON.stringify($scope.CurrentPlacement.PlacementOffense[i].Offense) === JSON.stringify(offense.Offense)) {
    ////                $scope.CurrentPlacement.PlacementOffense.splice(i, 1);
    ////                $scope.frmPlacement.$dirty = true;
    ////                break;
    ////            }
    ////        };
    ////    };

    ////    // Default Settings
    ////    var LoadDefaults = function () {
    ////        //ISR 1019
    ////         if($rootScope.SystemID == "2")
    ////        //if ($rootScope.CurrentUserole == "AdultAdmin")
    ////        {
    ////            $scope.IsVisibleForAdult = true;
    ////            GetAllCourt();

    ////        }
    ////        else
    ////        {
    ////            $scope.IsVisibleForAdult = false;
    ////        }
    ////        //ISR 1019
    ////        SetDefaultVariables();
    ////        SetButtonText();
    ////        GetAllPlacementLevels();
    ////        GetAllJudges();
    ////        GetAllOffenses();
                      
    ////    };

    ////    // Start view with default values
    ////    LoadDefaults();
    
}]);

//End of BCPPlanController

// Referral Tab Controller
app.controller('ReferralController', ['$scope', '$timeout', '$filter', '$rootScope', '$modal', 'CRUDService',  'CaseMgtService', 'BaseService', function ($scope, $timeout, $filter, $rootScope, $modal, CRUDService, CaseMgtService,BaseService) {

    //to differentiate the juvenile and adult as per the user role-kishors-11/17/2016
        var modalScope = $rootScope.$new();
        //to open the accordion groups
        //$scope.status = {
        //    isFirstOpen: true,
        //    oneAtATime: false,
        //    isItemOpen: [true]
        //};
        $scope.ClientProfile = '';
        $rootScope.Person = '';
        $rootScope.Person = $scope.ClientProfile.Person;
        if ($rootScope.SystemID == 1)
        {
            $scope.lblAddCaseInfo = "Add Case Info";
            $scope.lblReferral = "Referral";
            $scope.ShowforAdult = false;
            $scope.ShowforJuvenile = true;
            $scope.ShowforCwb = false;
            $scope.btnAddEnrollment = "Add Enrollment";
            
        }
        if ($rootScope.SystemID == 2)
        {
            $scope.lblAddCaseInfo = "Add Case Info";
            $scope.lblReferral = "Referral";
            $scope.ShowforAdult = true;
            $scope.ShowforJuvenile = false;
            $scope.ShowforCwb = false;
            $scope.btnAddEnrollment = "Add Enrollment";
        }

        if ($rootScope.SystemID == 3)
        {
            $scope.lblAddCaseInfo = "Add Enrollment";
            $scope.lblReferral = "Program";
            $scope.ShowforAdult = false;
            $scope.ShowforJuvenile = false;
            $scope.ShowforCwb = true;
            $scope.btnAddEnrollment = "Add Referral";
        }

        $scope.isOpen = true;

        // Don't show the footer message intiallly
        $scope.CanShowPlacementMessage = false;

        // Function to generate Referral Title
        $scope.GeneratePlacementTitle = function (placement) {
            if ($rootScope.SystemID == "3")
            {
                //var title ="Participating in SNAP-ET :" +  placement.Placement.PlacementLevel.Name;
                //title = title + " || Participating in VIEW/TANF :" + placement.Placement.Judge.Name;
                var title = "Assistance Type: " + placement.Placement.AssistanceType.Name
                //title = title + " || Participating in VIEW/TANF :" + placement.Placement.Judge.Name
                
            }
            if ($rootScope.SystemID == "2" || $rootScope.SystemID == "1")
            {
                var title = placement.Placement.PlacementLevel.Name;

                for (var i = 0; i <= placement.PlacementOffense.length - 1; i++)
                {
                    title = title + " || " + placement.PlacementOffense[i].Offense.VCCCode;
                }

                
            }
            return title;
        };

        // Function to raise as Create New Placement button is clicked
        $scope.AddOrEditPlacement = function (placement) {
            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/addoreditPlacement.html',
                controller: 'AddorUpdatePlacementController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: false, // restricts esc key usage
                size: 'lg',
                resolve: {
                    selectedPlacement: function () {

                        return placement;
                    }
                }
            });
            modalScope.modalInstance.result.then(function () {
                RefreshPlacements();
            }, function () {
                alert('Dialog closing with Dismiss');
            });
        };


        //print friendly version
        $scope.PrintPlacement = function (placement, placementEnrollment, $event, enrollmentType) {
            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/PrintReferral.html',
                controller: 'AddorUpdateEnrollmentController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: true,// restricts esc key usage
                size: 'lg',
                resolve:
                {


                    selectedPlacement: function () {

                        return placement;
                    },


                    selectedEnrollment: function () {
                        if (enrollmentType == "New") {
                            $rootScope.CurrentPlacementID = placement.Placement.ID;
                        }
                        else if (enrollmentType == "Edit") {
                            $rootScope.CurrentPlacementID = placement.Enrollment.PlacementID;
                            $rootScope.CurrentEnrollmentId = placement.Enrollment.ID;
                        }
                        return placementEnrollment;
                    }
                }
            });

            modalScope.modalInstance.result.then(function () {

                RefreshPlacements();
            }, function () {
                //alert('Dialog closing with Dismiss');
            });
        };
    //print freindly version for adult
        $scope.PrintPlacementAdult = function (placement, placementEnrollment, $event, enrollmentType) {
            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/PrintReferralAdult.html',
                controller: 'AddorUpdateEnrollmentController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: true,// restricts esc key usage
                size: 'lg',
                resolve:
                {


                    selectedPlacement: function () {

                        return placement;
                    },


                    selectedEnrollment: function () {
                        if (enrollmentType == "New") {
                            $rootScope.CurrentPlacementID = placement.Placement.ID;
                        }
                        else if (enrollmentType == "Edit") {
                            $rootScope.CurrentPlacementID = placement.Enrollment.PlacementID;
                            $rootScope.CurrentEnrollmentId = placement.Enrollment.ID;
                        }
                        return placementEnrollment;
                    }
                }
            });

            modalScope.modalInstance.result.then(function () {

                RefreshPlacements();
            }, function () {
                //alert('Dialog closing with Dismiss');
            });
        };
    //print friendly version for adult
    //print friendly version for cwb
        $scope.PrintPlacementCwb = function (placement, placementEnrollment, $event, enrollmentType) {
            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/PrintReferralCwb.html',
                controller: 'AddorUpdateEnrollmentController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: true,// restricts esc key usage
                size: 'lg',
                resolve:
                {


                    selectedPlacement: function () {

                        return placement;
                    },


                    selectedEnrollment: function () {
                        if (enrollmentType == "New") {
                            $rootScope.CurrentPlacementID = placement.Placement.ID;
                        }
                        else if (enrollmentType == "Edit") {
                            $rootScope.CurrentPlacementID = placement.Enrollment.PlacementID;
                            $rootScope.CurrentEnrollmentId = placement.Enrollment.ID;
                        }
                        return placementEnrollment;
                    }
                }
            });

            modalScope.modalInstance.result.then(function () {

                RefreshPlacements();
            }, function () {
                //alert('Dialog closing with Dismiss');
            });
        };
    //print friendly version for cwb




        //Delete placement functionality
        $scope.deleteplacement = function (row) {
            var decition = confirm("Are youu sure , you want to delete the placement");
            if (decition)
                deleteplacement(row.Placement);

        };


        var deleteplacement = function (selectedplacement) {
            CaseMgtService('Placement/Deleteplacement').Deleteplacementbyid({ ID: selectedplacement.ID }, function (response) {
                //$scope.ClientProfile = response;
                if (response == "Success")

                    RefreshPlacements();



            }).$promise.then(function (response) {
                BaseService.openSmallDialog('placement', 'deleted');
                RefreshPlacements();

            });
        };


        // Function to raise as Create New Enrollment button is clicked
        $scope.AddOrEditEnrollment = function (placement, placementEnrollment, $event, enrollmentType) {
            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/addoreditEnrollment.html',
                controller: 'AddorUpdateEnrollmentController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: false, // restricts esc key usage
                size: 'lg',
                resolve:
                {
                    selectedEnrollment: function () {
                        if (enrollmentType == "New") {
                            $rootScope.CurrentPlacementID = placement.Placement.ID;
                        }
                        else if (enrollmentType == "Edit") {
                            $rootScope.CurrentPlacementID = placement.Enrollment.PlacementID;
                            $rootScope.CurrentEnrollmentId = placement.Enrollment.ID;
                        }
                        return placementEnrollment;
                    }
                }
            });

            modalScope.modalInstance.result.then(function () {
                RefreshPlacements();
            }, function () {
                //alert('Dialog closing with Dismiss');
            });
        };

        var RefreshEnrollments = function () {
            CaseMgtService('ClientProfile/Enrollment').GetEnrollmentsByPlacements({ ID: $rootScope.CurrentPlacementID }).$promise.then(function (response) {

                for (var i = 0; i < $rootScope.Placements.length; i++) {
                    if ($rootScope.Placements[i].Placement.ID === $rootScope.CurrentPlacementID) {
                        $rootScope.Placements[i].Enrollment = response;

                        return;
                    }
                }
            });
        };

        // Function to raise as Edit Placement button is clicked
        $scope.EditPlacement = function (row, $event) {
            $event.preventDefault();
            $event.stopPropagation();

            $scope.AddOrEditPlacement(row);
        };

        //print placement

        //$scope.Printplace = function (row, $event) {
        //    $event.preventDefault();
        //    $event.stopPropagation();

        //    $scope.PrintPlacement(row);
        //};


        var RefreshPlacements = function () {
            CaseMgtService('ClientProfile/Placement').GetPlacementsByClientProfile({ ID: $rootScope.CurrentClientProfileID }, function (response) {
                $rootScope.Placements = response;
                $scope.Placements = $rootScope.Placements;
                $scope.CanShowPlacementMessage = ($scope.Placements.length == 0) ? true : false;
            });
        };
        //function to Delete the enrollments by Placements


        $scope.DeleteEnrollment = function (row) {
            var decition = confirm("Are u sure you want to delete the Enrollment?");
            if (decition)
                DeleteEnrollment(row.Enrollment);

        };


        var DeleteEnrollment = function (selectedenrollment) {

            CaseMgtService('Enrollment/DeleteEnrollment').DeleteEnrollmentsByPlacements({ ID: selectedenrollment.ID }, function (response) {
                //$scope.ClientProfile = response;
                if (response == "Success")

                    Refreshplacements();



            }).$promise.then(function (response) {
                BaseService.openSmallDialog('Enrollment', 'deleted');
                RefreshPlacements();

            });
        };

        $scope.CloseModal = function () {
            $modalInstance.close();
        };

    //Employment changes
        var DeleteEmploymentPlan = function (employmentPlan) {

            CaseMgtService('EmploymentPlan/DeleteEmploymentPlan').DeleteEmploymentPlan({ ID: employmentPlan.ID }, function (response) {
                if (response == "Success")
                    console.log('EmploymentPlan Deleted');
            }).$promise.then(function (response) {
                BaseService.openSmallDialog('Employment Plan', 'deleted');
                RefreshPlacements();

            });
        }

    //Employment
    // Function to raise as Create New Employment button is clicked 
        $scope.AddOrEditEmployment = function (enrollment, enrollmentEmployment, $event, hasEmploymentPlan) {
            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/addoreditEmployment.html',
                controller: 'AddorUpdateEmploymentController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: false, // restricts esc key usage
                size: 'lg',
                resolve:
                {
                    selectedEnrollment: function () {
                        if (hasEmploymentPlan != 0) {
                            $rootScope.CurrentEnrollmentID = enrollment.Enrollment.ID;
                            $rootScope.CurrentEmploymentID = enrollment.EmploymentPlan[0].ID;
                        }
                        else {
                            $rootScope.CurrentEmploymentID = null;
                            $rootScope.CurrentEnrollmentID = enrollment.Enrollment.ID;

                        }
                        return enrollmentEmployment;
                    }
                }
            });

            modalScope.modalInstance.result.then(function () {
                RefreshPlacements();
            }, function () {
                //alert('Dialog closing with Dismiss');
            });
        };
    //End of employment changes


        // Listen to the event whenever there is a change in rootscope person
        $scope.$on('UpdateReferral', function (event, data) {
            $timeout(
                function () {
                    $scope.$apply(function () {
                        if (data == 'NewReferral') {
                            $scope.Placements = '';
                        }
                        else if (data == 'EditReferral') {
                            $scope.Placements = $rootScope.Placements;
                            $scope.CanShowPlacementMessage = ($scope.Placements.length == 0) ? true : false;
                        }
                    });
                });
        });

    

      
    // Create the scope for all the controllers
   
}]);

// Referral Tab : Create new or Update existing Placement Controller
app.controller('AddorUpdatePlacementController', ['$scope', '$rootScope', '$timeout', '$modalInstance', '$filter', 'CRUDService', 'BaseService', '$q', 'selectedPlacement', 'CustomCRUDService', function ($scope, $rootScope, $timeout, $modalInstance, $filter, CRUDService, BaseService, $q, selectedPlacement, CustomCRUDService) {
    // Initialize all required variables
      var SetDefaultVariables = function () {
            // Assign selectedPlacement to CurrentPlacement
            $scope.CurrentPlacement = (selectedPlacement != null ? selectedPlacement : null);
            $scope.OrgCurrentPlacement = (selectedPlacement != null ? angular.copy(selectedPlacement) : null);
            $scope.AllPlacementLevels = [];
            $scope.AllJudges = [];
            //$scope.GetAllCourt
            $scope.AllOffenses = [];
            $scope.SelectedOffenses = [];
            $scope.Offenses = [];
          //ISR 1019
            $scope.AllCourtName = [];
          //ISR 1019
           
        };

        // Define Submit button Text
        var SetButtonText = function () {
            $scope.SubmitButtonText = (selectedPlacement != null ? 'Update' : 'Save');

        };

        var p =
            // Begin: DatePicker Functionality
            $scope.datePicker = (function () {
                var method = {};
                method.instances = [];

                method.open = function ($event, instance) {
                    $event.preventDefault();
                    $event.stopPropagation();

                    method.instances[instance] = true;
                };

                $scope.dateOptions = {
                    startingDay: 1,
                    showWeeks: 'false'
                };

                return method;
            }());
        // End: DatePicker Functionality

        // Start: Factory and Service Calls  
        // Factory call to get all Placement Levels
        var GetAllPlacementLevels = function getData() {
            CustomCRUDService('PlacementLevel', 'GetAll').GetAll(function (response) {

                $scope.AllPlacementLevels = response;
            });
        };

        // Factory call to get all Judges 
        var GetAllJudges = function getData() {
            CustomCRUDService('Judge', 'GetAll').GetAll(function (response) {

                $scope.AllJudges = response;
            });
        };

        // Factory call to get all Placement Charges
        var GetAllOffenses = function getData() {
            CustomCRUDService('Offense', 'GetAll').GetAll(function (response) {

                $scope.AllOffenses = response;
            });
        };

        // ngInputsTag for Placement Charges Code
        $scope.GetPlacementCharges = function (query) {
            var defer = $q.defer();
            var test = $filter('filterByKeyword')($scope.AllOffenses, query);

            defer.resolve(test);
            return defer.promise;
        };

    //Factory call to get the Court Name
        var GetAllCourt = function getData() {
            CustomCRUDService('CourtName', 'GetAll').GetAll(function (response) {

                $scope.AllCourtName = response;
            });
        };

    //Factory call to get the AssistanceType Name
        var GetAllAssistanceType = function getData() {
            CustomCRUDService('AssistanceType', 'GetAll').GetAll(function (response) {

                $scope.AllAssistanceType = response;
            });
        };

    //Factory call to get the CareerPathway options
        var GetAllCareerPathway = function getData() {
            CustomCRUDService('CareerPathway', 'GetAll').GetAll(function (response) {

                $scope.AllCareerPathway = response;
            });
        };

        // End: Factory and Service Calls  

        // Start: Page Events  
        // Cancel button event
        $scope.CloseModal = function () {
            $modalInstance.close();
        };

        // Reset button event
        $scope.Reset = function () {
            // $scope.currentPlacement = $scope.placement.placement;
            $scope.CurrentPlacement = angular.copy($scope.OrgCurrentPlacement);
        };




        // Save / Update button Click Event
        $scope.CreateOrUpdate = function (isValid, placement) {
            $scope.submitted = true;
            if (isValid == true) {
                // Update FK Id's using selection on view
                placement.Placement.PlacementLevelID = placement.Placement.PlacementLevel.ID;
                placement.Placement.JudgeID = placement.Placement.Judge.ID;
                //ISR 1019
                 if($rootScope.SystemID == "2")
                //if ($rootScope.CurrentUserole == "AdultAdmin") 
                {
                    placement.Placement.CourtNameID = placement.Placement.CourtName.ID;
                }
                else
                {
                    placement.Placement.CourtNameID = null;
                }
                //ISR 1019
                //ISR 1171
                 if ($rootScope.SystemID == "3")
                     //if ($rootScope.CurrentUserole == "AdultAdmin") 
                 {
                     placement.Placement.AssistanceTypeID = placement.Placement.AssistanceType? placement.Placement.AssistanceType.ID : null;
                     placement.Placement.CareerPathwayID = placement.Placement.CareerPathway? placement.Placement.CareerPathway.ID: null;
                 }
                 else
                 {
                     placement.Placement.AssistanceTypeID = null;
                     placement.Placement.CareerPathwayID = null;
                 }
                //ISR 1171

                 if (placement.Placement.ID != null) {
                     if ($rootScope.SystemID == "2" || $rootScope.SystemID == "1")
                     {
                         if (placement.PlacementOffense == undefined)
                         {
                             alert('please pick the charge code');
                         }
                         for (var i = 0; i < placement.PlacementOffense.length; i++) {
                             if (placement.PlacementOffense[i].ID != 0) {
                                 BaseService.SetAuditingDetails(placement.PlacementOffense[i], true);

                             }
                         }
                     }//end of system id condition
                 
                     placement.Placement.UpdatedBy = $rootScope.CurrentUser;
                     placement.Placement.UpdatedDate = new Date().toISOString().slice(0, 19).replace('T', ' '); //add UpdatedDate
                    CRUDService('Placement').Update({ ID: placement.Placement.ID }, placement).$promise.then(function () {
                        BaseService.openSmallDialog('Placement', 'Updated');
                        $modalInstance.close();
                    });
                }
                else {
                    // Set Auditing Data to the Newly Crating Entity
                     BaseService.SetAuditingDetails(placement.Placement, true);
                     if ($rootScope.SystemID == "2" || $rootScope.SystemID == "1")
                     {
                         if (placement.PlacementOffense == undefined) {
                             alert('please pick the charge code');
                         }
                     
                    for (var i = 0; i < placement.PlacementOffense.length; i++) {
                        BaseService.SetAuditingDetails(placement.PlacementOffense[i], true);
                    }
                    }//end of system id condition
                    placement.Placement.CreatedBy = $rootScope.CurrentUser;
                    // update placement's ClietProfileID with CurrentClientProfileID
                    placement.Placement.ClientProfileID = $rootScope.CurrentClientProfileID;
                    //to avoid virtuials in dropdown
                    placement.Placement.Judge = null;
                    placement.Placement.PlacementLevel = null;
                    //Newly added to remove the virtuials in dropdown in courtName
                    if ($rootScope.SystemID == "2")
                    {
                        placement.Placement.CourtName = null;
                    }
                    if ($rootScope.SystemID == "3")
                    {
                        placement.Placement.AssistanceType = null;
                        placement.Placement.CareerPathway = null;
                    }

                    CRUDService('Placement').Create(placement).$promise.then(function (response) {
                        BaseService.openSmallDialog('Placement', 'Created');
                        $modalInstance.close();
                    });
                }
            };
            $scope.submitted = false;
            LoadDefaults();
        };
        // End: Page Events  

        // Adding Offense to the existing colleciton
        $scope.OnOffenseSelect = function ($item) {

            // CREATE NEW PLACEMENTOFFENSE AND LOAD SELECTED OFFENSE TO IT
            var placementOffense = {
                PlacementID: $scope.CurrentPlacement.ID,
                OffenseID: $item.ID,
                Active: true,
                Placement: null,
                Offense: $item
            };
            if ($scope.CurrentPlacement.PlacementOffense == null)
                $scope.CurrentPlacement.PlacementOffense = [];

            // Add that to the scope variable to bind it to UI
            $scope.CurrentPlacement.PlacementOffense.push(placementOffense);
            $scope.SelectedOffense = '';
        };

        // Remove Offense from the existing colleciton
        $scope.RemoveOffense = function (offense) {
            for (var i = 0; $scope.CurrentPlacement.PlacementOffense.length; i++) {
                if (JSON.stringify($scope.CurrentPlacement.PlacementOffense[i].Offense) === JSON.stringify(offense.Offense)) {
                    $scope.CurrentPlacement.PlacementOffense.splice(i, 1);
                    $scope.frmPlacement.$dirty = true;
                    break;
                }
            };
        };

        // Default Settings
        var LoadDefaults = function () {
            //ISR 1019
             if($rootScope.SystemID == "2")
            //if ($rootScope.CurrentUserole == "AdultAdmin")
             {
               $scope.lblCourtOrderDate = "Court Order Date";
               $scope.lblNextCourtDate = "Next Court Date";
               $scope.lblrisk = "Overall Risk at Time of Placement *";
               $scope.lblriskPlaceholder = "Select Risk Level";
               $scope.lblJudge = "Judge *";
               $scope.lblJudgePlaceholder = "Select Judge";
               $scope.lblCourtOrderNarrative = "Court Order Narrative";
               $scope.IsVisibleForAdult = true;
               $scope.IsVisibleCWB = true;
               $scope.VisibleOnlyCWB = false;
               $scope.modalPlacementTitle = "Case";
                GetAllCourt();

            }
            if($rootScope.SystemID == "1")
            {
                $scope.lblCourtOrderDate = "Court Order Date";
                $scope.lblNextCourtDate = "Next Court Date";
                $scope.lblrisk = "Overall Risk at Time of Placement *";
                $scope.lblriskPlaceholder = "Select Risk Level";
                $scope.lblJudge = "Judge *";
                $scope.lblJudgePlaceholder = "Select Judge";
                $scope.lblCourtOrderNarrative = "Court Order Narrative";
                $scope.IsVisibleForAdult = false;
                $scope.IsVisibleCWB = true;
                $scope.VisibleOnlyCWB = false;
                $scope.modalPlacementTitle = "Case";
            }
            if ($rootScope.SystemID == "3")
            {
                $scope.lblCourtOrderDate = "Enrollment Date";
                $scope.lblNextCourtDate = "Next Appt. Date";
                $scope.lblrisk = "Participating in SNAP-ET *";
                $scope.lblriskPlaceholder = "Select SNAP-ET";
                $scope.lblJudge = "Participating in VIEW/TANF *";
                $scope.lblJudgePlaceholder = "Select VIEW/TANF";
                $scope.lblCourtOrderNarrative = "Comments";
                $scope.IsVisibleForAdult = false;
                $scope.IsVisibleCWB = false;
                $scope.VisibleOnlyCWB = true;
                GetAllAssistanceType();
                GetAllCareerPathway();
                $scope.optEmployerFullPartTime = [{ value: 'FullTime', label: 'Full-Time' }, { value: 'PartTime', label: 'Part-Time' }];
                $scope.optEmployerBenefits = [{ value: 'Yes', label: 'Yes' }, { value: 'No', label: 'No' }];
                $scope.modalPlacementTitle = "Enrollment";

                //GetAllCourt();

            }
            //ISR 1019
            SetDefaultVariables();
            SetButtonText();
            GetAllPlacementLevels();
            GetAllJudges();
            GetAllOffenses();
                      
        };

        // Start view with default values
        LoadDefaults();
    
}]);

// Referral Tab : Create new or Update existing Enrollment Controller
app.controller('AddorUpdateEnrollmentController', ['$scope', '$timeout', '$modal', '$modalInstance', '$rootScope', 'CRUDService', 'BaseService', 'CaseMgtService', '$q', 'selectedEnrollment', 'CustomCRUDService', function ($scope, $timeout, $modal, $modalInstance, $rootScope, CRUDService, BaseService, CaseMgtService, $q, selectedEnrollment, CustomCRUDService) {


           var SetDefaultValues = function () {
            $scope.CurrentPlacementEnrollment = (selectedEnrollment != null) ? selectedEnrollment.Enrollment : EmptyEnrollment();
            $scope._CurrentPlacementEnrollment = (selectedEnrollment != null) ? angular.copy(selectedEnrollment.Enrollment) : angular.copy(EmptyEnrollment());
            $scope.CurrentProgressNotes = (selectedEnrollment != null) ? selectedEnrollment.ProgressNote : null;
            $scope._CurrentProgressNotes = (selectedEnrollment != null) ? angular.copy(selectedEnrollment.ProgressNote) : null;
            $scope.CurrentServiceUnits = (selectedEnrollment != null) ? selectedEnrollment.ServiceUnit : null;
            $scope._CurrentServiceUnits = (selectedEnrollment != null) ? angular.copy(selectedEnrollment.ServiceUnit) : null;
            $scope.SubmitButtonText = ($scope.CurrentPlacementEnrollment.ID != 0) ? 'Update' : 'Save';

            if ($scope.SubmitButtonText == 'Save') {
                $scope.x = "true";
            }
            else {
                $scope.x = "false";
            }
            if ($scope.CurrentPlacementEnrollment.ID == 0)
                $scope.CurrentPlacementEnrollment.ReferralDate = new Date();
            $scope.CanShowRDJJS = (selectedEnrollment != null) ? true : false;

            if (selectedEnrollment != null) {
                $scope.GenerateToolTip($scope.CurrentPlacementEnrollment.Source, 'Referral');
                $scope.GenerateToolTip($scope.CurrentPlacementEnrollment.Counselor, 'Counselor');
            }

            $scope.CanShowFormButtons = true;
            $scope.FormattedReferralName = '';
            $scope.CurrentReferralService = '';
            $scope.FormattedCounselorName = '';
            $scope.AllReferrals = [];
            $scope.ServiceProgramCategories = [];
            $scope.AllCounselors = [];
            $scope.AllServiceReleases = [];
            $scope.AllServiceOutcomes = [];
        };
        //to print



        //refer to this service
        if (selectedEnrollment != null) {
            $scope.rts = selectedEnrollment.Enrollment.ServiceProgramCategory.ServiceProgram.Name + ' | ' + selectedEnrollment.Enrollment.ServiceProgramCategory.ServiceCategory.Name;
            if (selectedEnrollment.Enrollment.Counselor != null) {
                $scope.counselorprintname = (selectedEnrollment.Enrollment.Counselor.FirstName + ' ' + selectedEnrollment.Enrollment.Counselor.LastName);
            }
            $scope.refsourcename = selectedEnrollment.Enrollment.Source.FirstName + ' ' + selectedEnrollment.Enrollment.Source.LastName;
        }



        //to get the placement by placement id

        CaseMgtService('ClientProfile/Placement').GetPlacementsByClientProfile({
            ID: $rootScope.CurrentClientProfileID
        }, function (response) {

            $rootScope.Placements = response;
            $scope.Placements = $rootScope.Placements;
            // var options = new Array($scope.Placements);
            var len = $scope.Placements.length;
            for (var i = 0; i < len; i++) {
                for (var j = 0; j < $scope.Placements[i].Enrollment.length; j++) {
                    //alert($scope.Placements[i].Enrollment[j].Enrollment.ID);
                    if (selectedEnrollment != null) {
                        if ($scope.Placements[i].Enrollment[j].Enrollment.ID == selectedEnrollment.Enrollment.ID) {
                            $scope.currentprintplacement = $scope.Placements[i];


                        }
                    }

                }
            }

        });

        //calculate the age of juvenile at the age of referral

        $scope.var = function () {
            if (selectedEnrollment.Enrollment.ReferralDate != null) {
                var DOr = selectedEnrollment.Enrollment.ReferralDate;
                var currentYear = new Date();
                var d = new Date(DOr);

                // var diff = (currentYear - new Date(DOB).getTime());
                var diff = (currentYear - d);
                $scope.DR = (currentYear.getFullYear() - d.getFullYear());


                if (currentYear.getMonth() < d.getMonth() ||
               currentYear.getMonth() == d.getMonth() && currentYear.getDate() < d.getDate()) {
                    $scope.DR--;
                }
                return $scope.DR;
                alert($scope.DR);



            };
        };
        //$scope.Person.CurrentAge = years;




        // Create Empty Enrollment to assign in creating new scenario
        var EmptyEnrollment = function () {
            return {
                ID: 0,
                PlacementID: $rootScope.CurrentPlacementID,
                SourceID: '',
                ServiceProgramCategoryID: '',
                BasisofReferral: '',
                SourceNotes: '',

            };
        };
        //delete service units
        $scope.DeleteserviceUnit = function (selectedserviceUnit) {
            var decition = confirm("Are u sure you want to delete the Serviceunit?");
            if (decition)
                DeleteserviceUnit(selectedserviceUnit.ID);

        };


        var DeleteserviceUnit = function (id) {

            CaseMgtService('ClientProfile/DeleteServiceUnit').DeleteServiceUnitforEnrollment({
                ID: id
            }, function (response) {
                //$scope.ClientProfile = response;
                if (response == "Success")

                    RefreshServiceUnits();



            }).$promise.then(function (response) {
                BaseService.openSmallDialog('Serviceunit', 'deleted');
                RefreshServiceUnits();

            });
        };
        //Delete ProgressNotes

        $scope.DeleteProgressNote = function (selectedProgressNote) {
            var decition = confirm("Are u sure you want to delete the ProgressNote?");
            if (decition)
                DeleteProgressNote(selectedProgressNote.ID);

        };


        var DeleteProgressNote = function (id) {

            CaseMgtService('ClientProfile/DeleteProgressNote').DeleteProgressNotesForEnrollment({
                ID: id
            }, function (response) {
                //$scope.ClientProfile = response;
                if (response == "Success")

                    RefreshProgressNotes();



            }).$promise.then(function (response) {
                BaseService.openSmallDialog('ProgressNote', 'deleted');
                RefreshProgressNotes();

            });
        };
        //print the progressnotes particular division

        printDiv = function (divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }


        // Begin: DatePicker Functionality
        $scope.datePicker = (function () {
            var method = {
            };
            method.instances = [];

            method.open = function ($event, instance) {
                $event.preventDefault();
                $event.stopPropagation();

                method.instances[instance] = true;
            };

            $scope.dateOptions = {
                startingDay: 1,
                showWeeks: 'false'
            };

            return method;
        }());
        // End: DatePicker Functionality

        /** Start: Factory and Service Calls  **/
        // Factory call to get all Referrals
        var GetAllReferrals = function () {
            CustomCRUDService('Staff', 'GetAll').GetAll(function (response) {
                $scope.AllReferrals = response;
            });
        };

    //Factory call to get all Judges for referals.
        var GetAllJudge = function () {
            CustomCRUDService('Judge', 'GetAll').GetAll(function (response) {
                $scope.AllReferrals = response;
            });
        };
    //

        // Factory call to get all Service Program Categories
        var GetAllServiceProgramCategorys = function () {
            CustomCRUDService('ServiceProgramCategory', 'GetAll').GetAll(function (response) {
                $scope.ServiceProgramCategories = response;
            });
        };

        // Factory call to get all Counselors
        var GetAllCounselors = function () {
            CustomCRUDService('Staff', 'GetAll').GetAll(function (response) {
                $scope.AllCounselors = response;
            });
        };

        // Factory call to get all Service Releases
        var GetServiceReleases = function () {
            CustomCRUDService('ServiceRelease', 'GetAll').GetAll(function (response) {
                $scope.AllServiceReleases = response;
                // $scope.AllServiceReleases = response;
            });
        };


        // Factory call to get all Service Outcomes
        var GetAllServiceOutcomes = function () {
            CustomCRUDService('ServiceOutcome', 'GetAll').GetAll(function (response) {
                $scope.AllServiceOutcomes = response;
            });
        };

        /** End: Factory and Service Calls  **/

        // Default Settings
        var LoadDefaults = function () {
            SetDefaultValues();
            //if ($rootScope.CurrentUserole == "AdultAdmin")
            //{
                //$rootScope.IsDropDownVisible = false;
                //$rootScope.IsDropDownVisibleAdults = true;
                //GetAllJudge();
            //}
            //else
            //{
                //$rootScope.IsDropDownVisible = true ;
                //$rootScope.IsDropDownVisibleAdults = false;
               
            //}
            GetAllReferrals();
            GetAllServiceProgramCategorys();
            GetAllCounselors();
            GetServiceReleases();
            GetAllServiceOutcomes();
            //ISR 1019
             if($rootScope.SystemID == "2")
             //if ($rootScope.CurrentUserole == "AdultAdmin")
            {
                $scope.IsVisibleForAdult = false;
                $scope.CurrentPlacementEnrollment.ICN = 0;
                 // $scope.ReferralSource = true;
                $scope.IsVisibleForDJS = true;
                $scope.xreferral = true;
                $scope.lblReferralSource = "Referral Source *";
                $scope.lblReferralDropDown = "Select Referral";
                $scope.lblReason = "Reason";
                $scope.lblReasonDropDown = "Select Service Outcome";
                $scope.YouthConselorName = "Case Manager/Officer";
                $scope.lblDateCaseAssigned = "Date Case Assigned";
                $scope.title = ' ';
                $scope.CaseManagerNotes = "Notes";
                $scope.truefalse = false;
                $scope.ShowDateCaseAssigned = true;
                $scope.modalEnrollmentTitle = "Enrollment";
            }
             else if ($rootScope.SystemID == "1")
            {
                $scope.title = 'ICN* Number';
                 //$scope.ReferralSource = true;
                $scope.IsVisibleForDJS = true;
                $scope.xreferral = true;
                $scope.lblReferralSource = "Referral Source *";
                $scope.lblReferralDropDown = "Select Referral";
                $scope.lblReason = "Reason";
                $scope.lblReasonDropDown = "Select Service Outcome";
                $scope.YouthConselorName = "Youth Counselor Name";
                $scope.CaseManagerNotes = "Case Manager / Service Provider Dialog Notes";
                $scope.lblDateCaseAssigned = " ";
                $scope.IsVisibleForAdult = true;
                $scope.truefalse = true;
                $scope.ShowDateCaseAssigned = false;
                $scope.modalEnrollmentTitle = "Enrollment";

             }
             else if($rootScope.SystemID == "3")
                 //if ($rootScope.CurrentUserole == "AdultAdmin")
             {
                 $scope.IsVisibleForAdult = false;
                 $scope.CurrentPlacementEnrollment.ICN = 0;
                 $scope.lblReferralSource = "Career Advisor Name *";
                 $scope.lblReferralDropDown = "Select Career Advisor";
                 $scope.lblReason = "Referral Source";
                 $scope.lblReasonDropDown = "Select Referral Source";
                 //$scope.ReferralSource = false;
                 $scope.xreferral = false;
                 $scope.IsVisibleForDJS = false;
                 $scope.YouthConselorName = "";
                 $scope.lblDateCaseAssigned = "Date Case Assigned";
                 $scope.title = ' ';
                 $scope.CaseManagerNotes = "Notes";
                 $scope.truefalse = false;
                 $scope.ShowDateCaseAssigned = true;
                 $scope.modalEnrollmentTitle = "Referral";
                 $scope.lblReferralDropDown
             }

            //ISR 1019
            
        };

        /** Start : Page Events  **/
        // Close button event
        $scope.CloseModal = function () {
            $modalInstance.close();
        };

        // Reset button event
        $scope.Reset = function () {
            $scope.CurrentPlacementEnrollment = angular.copy($scope._CurrentPlacementEnrollment);
            $scope.CurrentProgressNotes = angular.copy($scope._CurrentProgressNotes);
            $scope.CurrentServiceUnits = angular.copy($scope._CurrentServiceUnits);

        };

        // Generate ToolTip on Referral and Counselor Select
        $scope.GenerateToolTip = function (selectedReferral, entity) {
            //alert(selectedReferral.Source);
            // Generate ToolTip
            var toolTip = '';
            if (selectedReferral == null || selectedReferral.Login == null) {
                return;
            }

            if (selectedReferral.Login.JobTitle != null) {
                toolTip = selectedReferral.Login.JobTitle.Name + '<br>'
            };

            if (selectedReferral.Login.Email != null) {
                toolTip = toolTip + selectedReferral.Login.Email + '<br>'
            };

            if (selectedReferral.Login.PhoneNumber != null) {
                toolTip = toolTip + '(P): ' + selectedReferral.Login.PhoneNumber + '<br>'
            };

            if (selectedReferral.Login.FaxNumber != null) {
                toolTip = toolTip + '(F): ' + selectedReferral.Login.FaxNumber + '<br>'
            };

            // Assign tool tip based on entity
            // use currently selected referral object properties and format them as needed
            switch (entity) {
                case "Referral":
                    $scope.FormattedReferralName = toolTip;
                    break;
                case "Counselor":
                    $scope.FormattedCounselorName = toolTip;
                    break;
            }
        };

        // Save / Update button Click Event
        $scope.CreateOrUpdate = function (isValid, enrollment) {
            $scope.submitted = true;
            if (isValid == true) {
                enrollment.SourceID = (enrollment.Source != null) ? enrollment.Source.ID : null;
                enrollment.CounselorID = (enrollment.Counselor != null) ? enrollment.Counselor.ID : null;
                enrollment.ServiceProgramCategoryID = (enrollment.ServiceProgramCategory != null) ? enrollment.ServiceProgramCategory.ID : null;
                enrollment.ServiceReleaseID = (enrollment.ServiceRelease != null) ? enrollment.ServiceRelease.ID : null;
                enrollment.ServiceOutcomeID = (enrollment.ServiceOutcome != null) ? enrollment.ServiceOutcome.ID : null;

                if (enrollment.ID != 0) {
                    enrollment.UpdatedBy = $rootScope.CurrentUser;
                    CaseMgtService('Enrollment/UpdateEnrollment').UpdateEnrollment({ ID: enrollment.ID }, enrollment).$promise.then(function (response) {
                        BaseService.openSmallDialog('Enrollment', 'Updated');
                        $modalInstance.close();
                    });
                }
                else {

                    // Set Auditing Data to the Newly Crating Entity
                    BaseService.SetAuditingDetails(enrollment, true);
                    //to avoid duplicates in dropdown
                    enrollment.Source = null;
                    enrollment.Counselor = null;
                    enrollment.ServiceProgramCategory = null;
                    enrollment.ServiceRelease = null;
                    enrollment.ServiceOutcome = null;
                    enrollment.CreatedBy = $rootScope.CurrentUser;

                    CRUDService('Enrollment').Create(enrollment).$promise.then(function (response) {
                        BaseService.openSmallDialog('Enrollment', 'Created');
                        $modalInstance.close();
                    });
                };
                $scope.submitted = false;
                LoadDefaults();
            };
        };

        // Create a new rootscope
        var modalScope = $rootScope.$new();

        // To Open Progress Notes dialog
        $scope.AddorEditProgressNotes = function (progressNote) {
            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/addoreditProgressNote.html',
                controller: 'AddorUpdateProgressNoteController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: false, // restricts esc key usage
                size: 'md',
                resolve: {
                    selectedProgressNote: function () {

                        return progressNote;
                    }
                }
            });
            modalScope.modalInstance.result.then(function () {
                RefreshProgressNotes();
            }, function () {
                //alert('Dialog closing with Dismiss');
            });
        };

        // To Open Service Units view
        $scope.AddorEditServiceUnits = function (serviceUnit) {
            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/addoreditServiceUnit.html',
                controller: 'AddorUpdateServiceUnitController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: false, // restricts esc key usage
                size: 'sm',
                resolve: {
                    selectedServiceUnit: function () {

                        return serviceUnit;
                    }
                }
            });
            modalScope.modalInstance.result.then(function () {
                RefreshServiceUnits();
            }, function () {
                //alert('Dialog closing with Dismiss');
            });
        };

        // Refresh Service Units data with database
        var RefreshServiceUnits = function () {
            CaseMgtService('ClientProfile/ServiceUnit').GetServiceUnitsForEnrollment({
                ID: $rootScope.CurrentEnrollmentId
            }, function (response) {
                $scope.CurrentServiceUnits = response;
            });
        };

        // Refresh ProgressNotes data with database
        var RefreshProgressNotes = function () {
            CaseMgtService('ClientProfile/ProgressNote').GetProgressNotesForEnrollment({
                ID: $rootScope.CurrentEnrollmentId
            }, function (response) {
                //$scope.CurrentPlacementEnrollment.ProgressNote = response;
                $scope.CurrentProgressNotes = response;
            });
        };

        //end of juvenile block
    

    /** Start : Page Events  **/
    // Initialize all required variablesf
    

    /** End : Page Events  **/

    // Start view with default values
    LoadDefaults();

}]);

// Referral - Enrollment - RDJJS Internal Use Only Tab : Create new or Update existing Progress Note Controller
app.controller('AddorUpdateProgressNoteController', ['$scope', '$rootScope', '$timeout', '$modal', '$modalInstance', 'CRUDService', 'CustomCRUDService', 'CaseMgtService', 'BaseService', '$q', 'selectedProgressNote', function ($scope, $rootScope, $timeout, $modal, $modalInstance, CRUDService, CustomCRUDService, CaseMgtService, BaseService, $q, selectedProgressNote) {
    // Initialize all required variables
  
          var SetDefaultValues = function () {
            $scope.ProgressNote = (selectedProgressNote != null) ? selectedProgressNote : null;
            $scope._ProgressNote = (selectedProgressNote != null) ? angular.copy(selectedProgressNote) : null;
            SetButtonText();
            //Time picker Handles
            //var d = new Date();
            //d.setHours(0);
            //d.setMinutes(15);
            //$scope.ProgressNote.Duration = d;


        };

        // Set BUtton Text either as Save or Update
        var SetButtonText = function () {
            $scope.SubmitButtonText = (selectedProgressNote != null) ? 'Update' : 'Save';

            if ($scope.SubmitButtonText == "Save") {

                $scope.ProgressNote = {
                    Duration: ''
                };
                $scope.ProgressNote.Duration = '1900-01-01 00:15:00.000';
            }
        };

        // Begin: DatePicker Functionality
        $scope.datePicker = (function () {
            var method = {};
            method.instances = [];

            method.open = function ($event, instance) {
                $event.preventDefault();
                $event.stopPropagation();

                method.instances[instance] = true;
            };

            $scope.dateOptions = {
                startingDay: 1,
                showWeeks: 'false'
            };

            return method;
        }());
        // End: DatePicker Functionality

        // Factory call to get all ContactTypes
        var GetAllContactTypes = function () {
            CustomCRUDService('ContactType', 'GetAll').GetAll(function (response) {

                $scope.AllContactTypes = response;
            });
        };

    // Factory call to get all SubContactTypes(This is for Adult)
        var GetAllSubContactTypes = function () {
            CustomCRUDService('SubContactType', 'GetAll').GetAll(function (response) {

                $scope.AllSubContactTypes = response;
             });
         };

        /** Start : Page Events  **/
        // Close button event
        $scope.CloseProgressNote = function () {
            $modalInstance.close();
        };

        // Reset button event
        $scope.Reset = function () {
            $scope.ProgressNote = angular.copy($scope._ProgressNote);
            $scope.mytime = angular.copy($scope._mytime);
            //Time picker Handles
            //var d = new Date();
            //d.setHours(0);
            //d.setMinutes(15);
            //$scope.mytime = d;
        };

        // Save / Update button Click Event
        $scope.CreateOrUpdate = function (isValid, progressNote) {

            $scope.submitted = true;
            if (isValid == true) {
                progressNote.ContactTypeID = (progressNote.ContactType != null) ? progressNote.ContactType.ID : null;
                //if ($rootScope.SystemID == "2")
                //{
                    progressNote.SubContactTypeID = (progressNote.SubContactType != null) ? progressNote.SubContactType.ID: null;
                //}
                    if (progressNote.ID != null) {
                    progressNote.UpdatedBy = $rootScope.CurrentUser;
                    CaseMgtService('ProgressNote/UpdateProgresnote').UpdateProgressNote({ ID: progressNote.ID }, progressNote).$promise.then(function (response) {
                        // CRUDService('ProgressNote').Update({ ID: progressNote.ID }, progressNote).$promise.then(function (response) {
                        BaseService.openSmallDialog('Progress Note', 'Updated');
                        $modalInstance.close();
                    });
                }
                else {
                    // Set Auditing Data to the Newly Crating Entity
                    BaseService.SetAuditingDetails(progressNote, true);
                    //to avoid duplicates


                    progressNote.ContactType = null;
                    progressNote.SubContactType = null;
                    progressNote.CreatedBy = $rootScope.CurrentUser;
                    progressNote.EnrollmentID = $rootScope.CurrentEnrollmentId;
                    CRUDService('ProgressNote').Create(progressNote).$promise.then(function (response) {
                        BaseService.openSmallDialog('Progress Note', 'Created');
                        $modalInstance.close();
                    });
                }
            };
            $scope.submitted = false;
            LoadDefaults();
        };
        /** End : Page Events  **/

        // Load Defaults of the dialog
        var LoadDefaults = function () {
            SetDefaultValues();
            GetAllContactTypes();
            //ISR 1090
            //if ($rootScope.SystemID == "2")
            //{
             //WO156256
                //$scope.AdultSubContactType = true;
                GetAllSubContactTypes();
            //}
            //else
            //{
              //  $scope.AdultSubContactType = false;

            //}

            
        };

        LoadDefaults();
    
}]);

// Referral - Enrollment - RDJJS Internal Use Only Tab : Create new or Update existing Service Unit Controller
app.controller('AddorUpdateServiceUnitController', ['$scope', '$rootScope', '$timeout', '$modal', '$modalInstance', 'CRUDService', 'CaseMgtService', 'BaseService', '$q', 'selectedServiceUnit', function ($scope, $rootScope, $timeout, $modal, $modalInstance, CRUDService, CaseMgtService, BaseService, $q, selectedServiceUnit) {

  
       // Initialize all required variables
        var SetDefaultValues = function () {
            $scope.ServiceUnit = (selectedServiceUnit != null) ? selectedServiceUnit : null;
            $scope._ServiceUnit = (selectedServiceUnit != null) ? angular.copy(selectedServiceUnit) : null;

            UpdateServiceUnit();
            SetButtonText();
        };

        // Update service unit entity with helper properties
        var UpdateServiceUnit = function () {
            if (selectedServiceUnit != null) {
                $scope.ServiceUnit.SelectedMonth = { 'Month': $scope.ServiceUnit.Month };
                $scope._ServiceUnit.SelectedMonth = { 'Month': angular.copy($scope.ServiceUnit.Month) };
                $scope.ServiceUnit.SelectedYear = { 'Year': $scope.ServiceUnit.Year };
                $scope._ServiceUnit.SelectedYear = { 'Year': angular.copy($scope.ServiceUnit.Year) };
            }
        };

        var LoadMonths = function () {
            $scope.Months = BaseService.GetCalendarMonths();
        };

        var LoadYears = function () {
            $scope.Years = BaseService.GetCalendarYears();
        };

        // Set BUtton Text either as Save or Update
        var SetButtonText = function () {
            $scope.SubmitButtonText = (selectedServiceUnit != null) ? 'Update' : 'Save';
        };

        /** Start : Page Events  **/
        // Close button event
        $scope.CloseServiceUnit = function () {
            $modalInstance.close();
        };

        // Reset button event
        $scope.Reset = function () {
            $scope.ServiceUnit = angular.copy($scope._ServiceUnit);
            $scope.ServiceUnit.SelectedMonth = angular.copy($scope._ServiceUnit.SelectedMonth);
            $scope.ServiceUnit.SelectedYear = angular.copy($scope._ServiceUnit.SelectedYear);

        };

        // Save / Update button Click Event
        $scope.CreateOrUpdate = function (isValid, serviceUnit) {
            $scope.submitted = true;
            if (isValid == true) {
                $scope.ServiceUnit.Month = $scope.ServiceUnit.SelectedMonth.Month;
                $scope.ServiceUnit.Year = $scope.ServiceUnit.SelectedYear.Year;
                serviceUnit.SystemID = 1;

                if (serviceUnit.ID != null) {
                    serviceUnit.UpdatedBy = $rootScope.CurrentUser;
                    CaseMgtService('ServiceUnit/UpdateServiceUnit').UpdateServiceUnit({ ID: serviceUnit.ID }, serviceUnit).$promise.then(function (response) {
                        BaseService.openSmallDialog('Service Unit', 'Updated');
                        $modalInstance.close();
                    });
                }
                else {
                    // Set Auditing Data to the Newly Crating Entity
                    BaseService.SetAuditingDetails(serviceUnit, true);
                    serviceUnit.CreatedBy = $rootScope.CurrentUser;

                    serviceUnit.EnrollmentID = $rootScope.CurrentEnrollmentId;
                    CRUDService('ServiceUnit').Create(serviceUnit).$promise.then(function (response) {
                        BaseService.openSmallDialog('Service Unit', 'Created');
                        $modalInstance.close();
                    });
                }
            };
            $scope.submitted = false;
            LoadDefaults();
        };
        /** End : Page Events  **/

        // Load Defaults of the dialog
        var LoadDefaults = function () {
            SetDefaultValues();
            LoadMonths();
            LoadYears();
        };

        LoadDefaults();
    
}]);

// Family Info Tab Controller
app.controller('FamilyInfoController', ['$scope', '$timeout', '$modal', '$rootScope', 'CRUDService', 'BaseService', 'CaseMgtService', '$q', '$controller', 'GISService', 'BingService', function ($scope, $timeout, $modal, $rootScope, CRUDService, BaseService, CaseMgtService, $q, $controller, GISService, BingService) {


    //to differentiate the juvenile and adult as per the user role-kishors-11/17/2016
  
        var modalScope = $rootScope.$new();

        // Don't show the footer message intiallly
        $scope.CanShowMessage = false;

        // Function to raise as Create New Placement button is clicked
        $scope.AddOrEditFamilyMember = function (familyMember) {

            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/addoreditFamilyMember.html',
                controller: 'AddorUpdateFamilyMemberController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: false, // restricts esc key usage
                size: 'lg',
                resolve: {
                    selectedFamilyMember: function () {

                        return familyMember;
                    }
                }
            });
            modalScope.modalInstance.result.then(function () {

                RefreshFamilyMembers();
            }, function () {
                //alert('Dialog closing with Dismiss');
            });
        };
        $scope.Addresses = function (term) {

            return $.getJSON("https://gis.richmondgov.com/ArcGIS/rest/services/Geocode/RichmondAddress/GeocodeServer/findAddressCandidates?callback=?", {
                f: "pjson", Street: term, outFields: "*"
            }, function (data) {
                return data.candidates;
            }).then(function (resp) {
                return resp.candidates;
            });
        };
        //add address for the family profile
        $scope.AddOrEditFamilyMemberAddress = function (familymember, matchingAddresses, addressType, addressId) {


            modalScope.FamilyProfile = familymember;
            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/AddressPopup.html',
                controller: 'FamilyAddressController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: true, // restricts esc key usage
                size: 'lg',
                resolve: {
                    selectedFamilyMember: function () {

                        //  kishore();
                        return familymember;



                    }

                }

            });


            modalScope.modalInstance.result.then(function () {

                RefreshFamilyMembers();
            }, function () {
                //alert('Dialog closing with Dismiss');
            });

        };



        // Refresh Family Members data with database
        var RefreshFamilyMembers = function () {
            CaseMgtService('ClientProfile/FamilyProfile').GetFamilyProfilesForPerson({ ID: $rootScope.CurrentClientProfilePersonId }, function (response) {
                $rootScope.FamilyProfiles = response;
                $rootScope.$broadcast('UpdateFamilyInfo', 'EditFamilyInfo');
            });
        };


        $scope.Deletefamilymember = function (selectedfamilymember) {
            var decition = confirm("are you sure, want to delete the familymember");
            if (decition)
                Deletefamilymember(selectedfamilymember.FamilyProfile.FamilyMemberID);

        };
        var Deletefamilymember = function (FamilyMemberID) {

            CaseMgtService('FamilyProfile/DeleteMember').DeleteFamilyProfilesForPerson({ ID: FamilyMemberID }, function (response) {
                //$scope.ClientProfile = response;
                if (response == "Success")
                    RefreshFamilyMembers();
            }).$promise.then(function (response) {
                BaseService.openSmallDialog('familymember', 'deleted');
                RefreshFamilyMembers();
            });
        };

        // Listen to the event whenever there is a change in rootscope person
        $scope.$on('UpdateFamilyInfo', function (event, data) {
            $timeout(
                function () {
                    $scope.$apply(function () {
                        if (data == 'NewFamilyInfo') {
                            $scope.FamilyProfiles = '';
                        }
                        else if (data == 'EditFamilyInfo') {
                            $scope.FamilyProfiles = $rootScope.FamilyProfiles;
                            $scope.CanShowMessage = ($scope.FamilyProfiles == 0) ? true : false;
                        }
                    });
                });
        });

        //end of juvenile block
    
    // Create the scope for all the controllers
    
}]);

// Family Info Tab - Family Member Controller
app.controller('AddorUpdateFamilyMemberController', ['$scope', '$timeout', '$modal', '$modalInstance', '$rootScope', 'CRUDService', 'CustomCRUDService','BaseService', '$q', 'selectedFamilyMember', function ($scope, $timeout, $modal, $modalInstance, $rootScope, CRUDService, CustomCRUDService, BaseService, $q, selectedFamilyMember) {

    // Set default values of the view
    
   
    var SetDefaultValues = function () {
        //ISR 1019
        //if ($rootScope.CurrentUserole == "AdultAdmin")
        if ($rootScope.SystemID == "2")
        {
            $scope.IsVisibleAdult = false;
            $scope.IsVisibleCwb = false;
            $scope.IsVisibleOnlyCWB = false;
            $scope.lblIncome = " ";
        }
        else if ($rootScope.SystemID == "1") {
            $scope.IsVisibleAdult = true;
            $scope.IsVisibleIncome = true;
            $scope.IsVisibleOnlyCWB = false;
            $scope.lblIncome ="Income";
            
        }
        else if ($rootScope.SystemID == "3")
        {
            $scope.IsVisibleAdult = false;
            $scope.IsVisibleIncome = true;
            $scope.lblIncome = "Monthly Income($)";
            $scope.IsVisibleOnlyCWB = true;
            
        }
            //ISR 1019
            $scope.AllRelationships = [];
            $scope.AllMaritalStatus = [];
            $scope.AllEducationLevels = [];
            $scope.AllJobStatuses = [];
            $scope.FamilyProfile = (selectedFamilyMember != null) ? selectedFamilyMember : EmptyFamilyMember();
            $scope.DefaultamilyProfile = (selectedFamilyMember != null) ? angular.copy(selectedFamilyMember) : angular.copy(EmptyFamilyMember());
            SetButtonText();
        };
        //date spalsh

        var EmptyFamilyMember = function () {
            return {
                PersonID: '',
                Person: '',
                RelationshipID: '',
                Relationship: '',
                SourceNotes: ''
            };
        };

        // Set BUtton Text either as Save or Update
        var SetButtonText = function () {
            $scope.SubmitButtonText = (selectedFamilyMember != null) ? 'Update' : 'Save';
        };

        // Begin: DatePicker Functionality
        $scope.datePicker = (function () {
            var method = {};
            method.instances = [];

            method.open = function ($event, instance) {
                $event.preventDefault();
                $event.stopPropagation();

                method.instances[instance] = true;
            };

            $scope.dateOptions = {
                startingDay: 1,
                showWeeks: 'false'
            };

            return method;
        }());
        // End: DatePicker Functionality

        /** Start: Factory and Service Calls  **/
        // Factory call to get all Relationships
        var GetAllRelationships = function () {
            CustomCRUDService('Relationship', 'GetAll').GetAll(function (response) {
                $scope.AllRelationships = response;
            });
        };

        // Factory call to get all MaritalStatus
        var GetAllMaritalStatuses = function () {
            CustomCRUDService('MaritalStatus', 'GetAll').GetAll(function (response) {
                $scope.AllMaritalStatus = response;
            });
        };

        // Factory call to get all Education Level
        var GetAllEducationLevels = function () {
            CustomCRUDService('EducationLevel', 'GetAll').GetAll(function (response) {
                $scope.AllEducationLevels = response;
            });
        };

        // Factory call to get all Job Status
        var GetAllJobStatuses = function () {
            CustomCRUDService('JobStatus', 'GetAll').GetAll(function (response) {
                $scope.AllJobStatuses = response;
            });
        };

        /** End: Factory and Service Calls  **/

        /** Start : Page Events  **/
        // Close button event
        $scope.CloseFamilyMember = function () {
            $modalInstance.close();
        };

        // Reset button event
        $scope.Reset = function () {
            $scope.FamilyProfile = angular.copy($scope.DefaultamilyProfile);


        };

        //$scope.$on('UpdateFamilymember', function (event, data) {
        //    $timeout(
        //        function () {
        //            $scope.$apply(function () {
        //                if (data == 'NewFamilyMember') {
        //                    $scope.originalFamilymember = '';

        //                }
        //                else if (data == 'EditFamilymember') {                        
        //                    // Update Supplemental object of scope
        //                     $scope.FamilyProfile = (selectedFamilyMember != null) ? selectedFamilyMember : EmptyFamilyMember();
        //                    $scope.originalFamilyMember = angular.copy($rootScope.selectedFamilyMember);
        //                    LoadDefaults();
        //                }

        // Save / Update button Click Event
        $scope.CreateOrUpdate = function (isValid, familyProfile) {
            $scope.submitted = true;
            if (isValid == true) {
                // Update Family Profile related data
                familyProfile.FamilyProfile.RelationshipID = familyProfile.FamilyProfile.Relationship.ID;

                // Update Person related data
                familyProfile.FamilyProfile.Person.SuffixID = (familyProfile.FamilyProfile.Person.Suffix != null) ? familyProfile.FamilyProfile.Person.Suffix.ID : null;
                // Update PersonSupplemental related data
                familyProfile.PersonSupplemental.MaritalStatusID = (familyProfile.PersonSupplemental.MaritalStatus != null) ? familyProfile.PersonSupplemental.MaritalStatus.ID : null;
                familyProfile.PersonSupplemental.JobStatusID = (familyProfile.PersonSupplemental.JobStatus != null) ? familyProfile.PersonSupplemental.JobStatus.ID : null;
                familyProfile.PersonSupplemental.EducationLevelID = (familyProfile.PersonSupplemental.EducationLevel != null) ? familyProfile.PersonSupplemental.EducationLevel.ID : null;

                if (familyProfile.FamilyProfile.ID != null) {
                    familyProfile.FamilyProfile.UpdatedBy = $rootScope.CurrentUser;
                    CRUDService('FamilyProfile').Update({ ID: familyProfile.FamilyProfile.ID }, familyProfile).$promise.then(function () {
                        BaseService.openSmallDialog('Family Profile', 'Updated');
                        $modalInstance.close();
                    });
                }
                else {
                    // Set Auditing Data to the Newly Crating Entity
                    BaseService.SetAuditingDetails(familyProfile.FamilyProfile, false);
                    BaseService.SetAuditingDetails(familyProfile.FamilyProfile.Person, true);
                    BaseService.SetAuditingDetails(familyProfile.PersonSupplemental, false);

                    //Need to update below field before creating new family member
                    //Changed person id as client profile id based on requirement
                    // familyProfile.FamilyProfile.ClientProfilePersonID = $rootScope.CurrentClientProfilePersonId;
                    familyProfile.FamilyProfile.CreatedBy = $rootScope.CurrentUser;
                    familyProfile.FamilyProfile.ClientProfilePersonID = $rootScope.ClientProfile.ID;
                    familyProfile.FamilyProfile.Relationship = null;
                    familyProfile.PersonSupplemental.MaritalStatus = null;
                    familyProfile.PersonSupplemental.EducationLevel = null;
                    familyProfile.PersonSupplemental.JobStatus = null;
                    familyProfile.FamilyProfile.Person.Suffix = null;

                    CRUDService('FamilyProfile').Create(familyProfile).$promise.then(function (response) {
                        BaseService.openSmallDialog('Family Profile', 'Created');
                        $modalInstance.close();
                    });
                }


            };

            $scope.submitted = false;
            LoadDefaults();
        };
        /** End : Page Events  **/

        // Load Defaults of the dialog
        var LoadDefaults = function () {
            SetDefaultValues();
            GetAllRelationships();
            GetAllMaritalStatuses();
            GetAllEducationLevels();
            GetAllJobStatuses();

        };

        LoadDefaults();
    
}]);

// Assessment Tab Controller
app.controller('AssessmentController', ['$scope', '$timeout', '$modal', '$rootScope', 'CRUDService','BaseService', 'CaseMgtService', function ($scope, $timeout, $modal, $rootScope, CRUDService, BaseService, CaseMgtService) {

       //start of juvenile block


        var modalScope = $rootScope.$new();

        // Factory call to get the results according to the selected Entity
        var RefreshAssessments = function getData() {
            CaseMgtService('ClientProfile/Assessment').GetAssessmentsForClientProfile({ ID: $rootScope.CurrentClientProfileID }, function (response) {
                $rootScope.Assessments = response;
                $rootScope.$broadcast('UpdateAssessment', 'EditAssessment');
            });
        };

        // Function to raise as Create New Assessment button is clicked
    
        $scope.AddOrEditAssessment = function (assessment) {
            modalScope.modalInstance = $modal.open({
                templateUrl: 'views/casemanagement/addoreditAssessment.html',
                controller: 'AddorUpdateAssessmentController',
                scope: modalScope,
                backdrop: 'static',
                keyboard: false, // restricts esc key usageselectedassessment
                size: 'lg',
                resolve: {
                    selectedAssessment: function () {
                        return assessment;
                    }
                }
            });
            modalScope.modalInstance.result.then(function () {
                RefreshAssessments();

            }, function () {
                //alert('Dialog closing with Dismiss');
            });
        };
        ////delete assessment

        $scope.DeleteAssessment = function (selectedassessment) {
            var decition = confirm("are you sure, want to delete the assessement");
            if (decition)
                DeleteAssessment(selectedassessment.ID);

        };
        var DeleteAssessment = function (id) {
            CaseMgtService('Assessment/Deleteassessment').DeleteAssessmentbyid({ ID: id }, function (response) {
                //$scope.ClientProfile = response;
                if (response == "Success")
                    RefreshAssessments();
            }).$promise.then(function (response) {
                BaseService.openSmallDialog('Assessment', 'deleted');
                RefreshAssessments();
            });
        };


        // Listen to the event whenever there is a change in rootscope person
        $scope.$on('UpdateAssessment', function (event, data) {
            $timeout(
                function () {
                    $scope.$apply(function () {
                        if (data == 'NewAssessment') {
                            $scope.Assessments = '';
                        }
                        else if (data == 'EditAssessment') {
                            $scope.Assessments = $rootScope.Assessments;
                            $scope.CanShowMessage = ($scope.Assessments == 0) ? true : false;
                        }
                    });
                });
        });
     // Create the scope for all the controllers
    
}]);

// Assessment Tab - Assessment Controller
app.controller('AddorUpdateAssessmentController', ['$scope', '$timeout', '$modal', '$modalInstance', '$rootScope', 'CRUDService', 'CustomCRUDService', 'BaseService', '$q', 'selectedAssessment', function ($scope, $timeout, $modal, $modalInstance, $rootScope, CRUDService,CustomCRUDService, BaseService, $q, selectedAssessment) {
   
        // Set default values of the view
        var SetDefaultValues = function () {
            $scope.AllAssessmentTypes = [];
            $scope.AllAssessmentSubTypes = [];
            $scope.AllPersons = [];

            $scope.Assessment = (selectedAssessment != null) ? selectedAssessment : null;
            $scope._Assessment = (selectedAssessment != null) ? angular.copy(selectedAssessment) : null;
            SetButtonText();
        };

        // Set BUtton Text either as Save or Update
        var SetButtonText = function () {
            $scope.SubmitButtonText = (selectedAssessment != null) ? 'Update' : 'Save';

        };

        // Begin: DatePicker Functionality
        $scope.datePicker = (function () {
            var method = {};
            method.instances = [];

            method.open = function ($event, instance) {
                $event.preventDefault();
                $event.stopPropagation();

                method.instances[instance] = true;
            };

            $scope.dateOptions = {
                startingDay: 1,
                showWeeks: 'false'
            };

            return method;
        }());
        // End: DatePicker Functionality

        /** Start : Page Events  **/
        // Close button event
        $scope.CloseAssessment = function () {
            $modalInstance.close();
        };

        // Reset button event
        $scope.Reset = function () {

            $scope.Assessment = angular.copy($scope._Assessment);

        };

        /** End : Page Events  **/

        /** Start: Factory and Service Calls  **/
        // Factory call to get all Relationships
        var GetAllAssessmentTypes = function () {
            CustomCRUDService('AssessmentType', 'GetAll').GetAll(function (response) {

                $scope.AllAssessmentTypes = response;
            });
        };

        var GetAllAssessmentSubTypes = function () {
            CustomCRUDService('AssessmentSubType', 'GetAll').GetAll(function (response) {

                $scope.AllAssessmentSubTypes = response;
            });
        };

        var GetAllPersons = function () {
            CustomCRUDService('Staff', 'GetAll').GetAll(function (response) {
                $scope.AllPersons = response;
            });
        };

        /** End: Factory and Service Calls  **/

        // Load Defaults of the dialog
        var LoadDefaults = function () {
            SetDefaultValues();
            GetAllAssessmentTypes();
            GetAllAssessmentSubTypes();
            GetAllPersons();
            if ($rootScope.SystemID == "3")
            {
                $scope.AssessmentScoreLength = "150";
            }
            else {
                $scope.AssessmentScoreLength = "15";
            }
        };

        // Save / Update button Click Event
        $scope.CreateOrUpdate = function (isValid, assessment) {
            $scope.submitted = true;

            if (isValid == true) {
                assessment.AssessmentTypeID = (assessment.AssessmentType != null) ? assessment.AssessmentType.ID : null;
                assessment.AssessmentSubtypeID = (assessment.AssessmentSubtype != null) ? assessment.AssessmentSubtype.ID : null;
                assessment.StaffID = (assessment.Staff != null) ? assessment.Staff.ID : null;

                if (assessment.ID != null) {
                    assessment.UpdatedBy = $rootScope.CurrentUser;
                    CRUDService('Assessment').Update({ ID: assessment.ID }, assessment).$promise.then(function (response) {
                        BaseService.openSmallDialog('Assessment', 'Updated');
                        $modalInstance.close();
                    });
                }
                else {
                    assessment.ClientProfileID = $rootScope.CurrentClientProfileID;

                    // Set Auditing Data to the Newly Crating Entity
                    BaseService.SetAuditingDetails(assessment, true);
                    // to avoid duplicates in dropdown
                    assessment.AssessmentType = null;
                    assessment.AssessmentSubtype = null;
                    assessment.Staff = null;
                    assessment.CreatedBy = $rootScope.CurrentUser;
                    //Need to update below field before creating new Assessment        
                    CRUDService('Assessment').Create(assessment).$promise.then(function (response) {
                        BaseService.openSmallDialog('Assessment', 'Created');
                        $modalInstance.close();
                    });
                }
            };
            $scope.submitted = false;
            //LoadDefaults();
        };

        LoadDefaults();
    

    /** End : Page Events  **/
}]);

// Supplemental Tab Controller
app.controller('SupplementalController', ['$scope', '$timeout', '$modal', '$rootScope', 'CRUDService', 'CustomCRUDService', 'BaseService', function ($scope, $timeout, $modal, $rootScope, CRUDService, CustomCRUDService, BaseService) {

    // Set default settings to Client Info Tab
    var SetDefaults = function () {
        $scope.AllSchools = [];
        $scope.AllEducationLevels = [];
        $scope.MedicaidValues = [];
        $scope.InsuranceValues = [];
        $scope.LicenseValues = [];
        $scope.IDType = [];
        $scope.LivingSituation = [];
        $scope.HighestEducation = [];
        $scope.SubmitButtonText = ($scope.Supplemental == '') ? "Save" : "Update";

        //For CWB new fields
        $scope.AllFundingSource = [];
        $scope.AllCareerStation = [];
        //End of new fields for CWB
    };

    /** Start: Factory and Service Calls  **/
    // Factory call to get the results according to the selected Entity
    var GetAllEducationLevels = function getData() {
        CustomCRUDService('EducationLevel', 'GetAll').GetAll(function (response) {

            $scope.AllEducationLevels = response;

        });
    };
    //Factory call to get the results according to the selected Entity
    var GetAllSchools = function getData() {
        CustomCRUDService('School', 'GetAll').GetAll(function (response) {
            $scope.AllSchools = response;

        });
    };

    var GetAllMaritalStatuses = function () {
        CustomCRUDService('MaritalStatus', 'GetAll').GetAll(function (response) {
            $scope.AllMaritalStatus = response;
        });
    };

    var GetAllJobStatuses = function () {
        CustomCRUDService('JobStatus', 'GetAll').GetAll(function (response) {
            $scope.AllJobStatuses = response;
        });
    };
    var GetAllFundingSource = function () {
        CustomCRUDService('FundingSource', 'GetAll').GetAll(function (response) {
            $scope.AllFundingSource = response;
        });
    }
    
    //var GetAllCarrerStation = function () {
    //        CustomCRUDService('CarrerStation', 'GetAll').GetAll(function (response) {
    //            $scope.AllCareerStation = response;
    //        });
    //    }

        /** End: Factory and Service Calls  **/

        // Default Settings
        var LoadDefaults = function () {
            SetDefaults();
            //if ($rootScope.CurrentUserole == "AdultAdmin")
            if ($rootScope.SystemID == "2") {
                $scope.AssignSupplimentText = "Primary Language";
                $scope.IsVisibleJuvenile = false;
                $scope.lblPhysicalHealth = "";
                $scope.IsVisible = false;
                $scope.IsVisibleAdult = true;
                $scope.IsVisibleCwb = true;
                $scope.IsVisibleCwbFields = false;
                $scope.lblHairColor = "Hair color";
                //GetAllSchools();

                GetAllMaritalStatuses();
                GetAllJobStatuses();
            }
            if ($rootScope.SystemID == "1") {
                $scope.AssignSupplimentText = "School Attended";
                $scope.lblPhysicalHealth = "Physical Health";
                $scope.IsVisibleJuvenile = true;
                $scope.IsVisible = true;
                $scope.IsVisibleAdult = false;
                $scope.IsVisibleCwb = true;
                $scope.IsVisibleJuvenileCWB = true;
                $scope.lblExceptionalEducation = "Exceptional Education"
                $scope.lblCurrentGrade = "Current Grade";
                $scope.IsVisibleCwbFields = false;
                $scope.lblHairColor = "Hair color";
                GetAllSchools();
                GetAllEducationLevels();

                GetAllMaritalStatuses();
                GetAllJobStatuses();
            }
            if ($rootScope.SystemID == "3") {
                $scope.AssignSupplimentText = "Primary Language";
                $scope.IsVisibleJuvenile = false;
                $scope.lblPhysicalHealth = "";
                $scope.IsVisible = false;
                $scope.IsVisibleAdult = true;
                $scope.IsVisibleCwb = false;
                $scope.IsVisibleJuvenileCWB = true;
                $scope.lblExceptionalEducation = "IEP ";
                $scope.lblCurrentGrade = "Highest Grade Completed";
                $scope.IsVisibleCwbFields = true;
                $scope.lblHairColor = "Shoe size(inches)";
                //GetAllSchools();
                GetAllEducationLevels();
                GetAllMaritalStatuses();
                GetAllJobStatuses();
                GetAllFundingSource();
               // GetAllCarrerStation();
            }
            //create and apply phone mask if not Internet Explorer [IR914983]
            document.documentMode ? $scope.PhoneMask = "" : $scope.PhoneMask = "999-999-9999";
        };

        // Save or Update Client Info
        $scope.CreateOrUpdateSupplemental = function (isValid, supplemental) {
            $scope.submitted = true;
            if (isValid == true) {
                // Update FK Id's using selection on view
                supplemental.SchoolID = (supplemental.School != null) ? supplemental.School.ID : null;
                supplemental.EducationLevelID = (supplemental.EducationLevel != null) ? supplemental.EducationLevel.ID : null;

                supplemental.MaritalStatusID = (supplemental.MaritalStatus != null) ? supplemental.MaritalStatus.ID : null;
                supplemental.JobStatusID = (supplemental.JobStatus != null) ? supplemental.JobStatus.ID : null;
                if ($rootScope.SystemID == "3") {
                    supplemental.FundingSourceID = (supplemental.FundingSource != null) ? supplemental.FundingSource.ID : null;
                    //supplemental.CarrerStationID = (supplemental.CareerStation != null) ? supplemental.CareerStation.ID : null;
                }

                if (supplemental.IssueDate != null || supplemental.ExpirationDate != null) {
                    var issuedate = new Date(supplemental.IssueDate);
                    var expiredate = new Date(supplemental.ExpirationDate);
                    if (issuedate >= expiredate) {
                        $scope.lblMsg = "The Expiration date should be greater Issue date.";
                        return false;
                    }
                }


                if (supplemental.ID != null) {
                    supplemental.UpdatedBy = $rootScope.CurrentUser;
                    supplemental.UpdatedDate = new Date().toISOString().slice(0, 19).replace('T', ' '); //add UpdatedDate
                    CRUDService('PersonSupplemental').Update({ ID: supplemental.ID }, supplemental).$promise.then(function () {
                        BaseService.openMediumDialog('Person Supplemental', 'Updated');
                        // Cancel();
                    });
                }
                else {
                    // Set Auditing Data to the Newly Crating Entity
                    BaseService.SetAuditingDetails(supplemental, true);

                    supplemental.PersonID = $rootScope.CurrentClientProfilePersonId;
                    CRUDService('PersonSupplemental').Create(supplemental).$promise.then(function (response) {
                        $rootScope.$broadcast('UpdateClientProfile', $rootScope.CurrentClientProfileID);
                        BaseService.openMediumDialog('Person Supplemental', 'Created');
                    });
                }
            };
            $scope.submitted = false;
        };

        // Cancel Client Info
        $scope.Cancel = function () {
            //$rootScope.$broadcast('UpdateTabs', 'Clear');
        };
        //number input
        $scope.onlyNumbers = /^\d+$/;

        // Reset Client Info
        $scope.Reset = function () {
            $scope.Supplemental = angular.copy($scope.originalpersonsupplemental);
            LoadDefaults();
        };


        // Begin: DatePicker Functionality
        $scope.datePicker = (function () {
            var method = {
            };
            method.instances = [];

            method.open = function ($event, instance) {
                $event.preventDefault();
                $event.stopPropagation();

                method.instances[instance] = true;
            };

            $scope.dateOptions = {
                startingDay: 1,
                showWeeks: 'false'
            };

            return method;
        }());
        // End: DatePicker Functionality

        // Listen to the event whenever there is a change in rootscope person
        $scope.$on('UpdateSupplemental', function (event, data) {
            $timeout(
                function () {
                    $scope.$apply(function () {
                        if (data == 'NewSupplemental') {
                            $scope.originalpersonsupplemental = '';

                        }
                        else if (data == 'EditSupplemental') {
                            // Update Supplemental object of scope

                            $scope.Supplemental = ($rootScope.Person.PersonSupplemental.ID != 0) ? $rootScope.Person.PersonSupplemental : '';
                            $scope.originalpersonsupplemental = angular.copy($rootScope.Person.PersonSupplemental);
                            LoadDefaults();
                        }
                    });
                });
        });

    //}
}]);

// Address Tab Controller
app.controller('AddressController', ['$scope', '$timeout', '$http', '$resource', '$modal', '$rootScope', 'CRUDService', 'CustomCRUDService', 'BaseService', 'GISService', 'BingService', function ($scope, $timeout, $http, $resource, $modal, $rootScope, CRUDService, CustomCRUDService, BaseService, GISService, BingService) {
    
  
    var GetAllPropertyType = function () {
        CustomCRUDService('PropertyType', 'GetAll').GetAll(function (response) {
            $scope.AllPropertyType = response;
        });
    }
        // Create the scope for all the controllers
        var modalScope = $rootScope.$new();
        // Set default settings to Client Info Tab
        var SetDefaults = function () {
            $scope.SelectedDJSAddress = null;
            //ISR 1019
                //if ($rootScope.CurrentUserole == "AdultAdmin")
             if($rootScope.SystemID == "2")
            {
                $scope.IsVisibleAdult = false;
                $scope.IsAdultVisibleTrue = true;
                $scope.IsCwbVisibleTrue = false;
                $scope.lblAddress = "Client Address";
                $scope.placeholdertext="Start typing Client Address Line";
                
            }
             if ($rootScope.SystemID == "1")
             {
                $scope.IsVisibleAdult = true;
                $scope.IsAdultVisibleTrue = false;
                $scope.IsCwbVisibleTrue =false;
                $scope.placeholdertext="Start typing DJU Address Line";
                $scope.lblAddress = "DJS Address";
             }
             if ($rootScope.SystemID == "3") {
                 $scope.IsVisibleAdult = false;
                 $scope.IsAdultVisibleTrue = false;
                 $scope.IsCwbVisibleTrue = true;
                 $scope.lblAddress = "Client Address";
                 $scope.placeholdertext = "Start typing Client Address Line";
                 GetAllPropertyType();

             }
            //ISR 1019
            SetSubmitButtonText();
        };
        // Default Settings
        var LoadDefaults = function () {
            SetDefaults();
        };

        var SetSubmitButtonText = function () {
            if ($rootScope.Person.PersonAddress != '' || $rootScope.Person.PersonAddress != null) {
                if ($rootScope.Person.PersonAddress.length > 0)
                    $scope.SubmitButtonText = "Update";
                else if ($rootScope.Person.PersonAddress.length == 0)
                    $scope.SubmitButtonText = "Save";
            }
        };

        /** Start: Factory and Service Calls  **/
        // Retrieve all address as user start typeing considering as city address
        // $scope.Addresses = angular.copy($rootScope.Addresses);
        $scope.Addresslist = {};
        // var address = {};

        $scope.Addresses = function (term) {
            //return  $.getJSON("https://gis.richmondgov.com/ArcGIS/rest/services/Geocode/RichmondAddress/GeocodeServer/findAddressCandidates?callback=?", {
            //      f: "pjson", Street: , outFields: "*"
            //  }, function (data) {
            //     return data.candidates;
            //  });
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
                     if ($rootScope.SystemID == "3")
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

        /** End: Factory and Service Calls  **/
        //  save or update family profile address
        $scope.CreateOrUpdateFamilyAddress = function (isValid, djsAddress, csuAddress) {
            $scope.submitted = true;

            if (isValid == true) {

                if (djsAddress != null) {
                    djsAddress.PersonID = $rootScope.CurrentClientProfilePersonId;

                    // Save / Update DJSAddress            
                    if (djsAddress.ID != null) {

                        djsAddress.UpdatedBy = $rootScope.CurrentUser;
                        CRUDService('PersonAddress').Update({ ID: djsAddress.ID }, djsAddress).$promise.then(function () {
                            BaseService.openMediumDialog('Person DJS Address', 'Updated');
                        });
                    }
                    else {
                        // Set Auditing Data to the Newly Crating Entity
                        BaseService.SetAuditingDetails(djsAddress, true);
                        djsAddress.ID = 0;
                        djsAddress.CreatedBy = $rootScope.CurrentUser;

                        CRUDService('PersonAddress').Create(djsAddress).$promise.then(function (response) {
                            //$rootScope.$broadcast('UpdateClientProfile', $rootScope.CurrentClientProfileID);
                            BaseService.openMediumDialog('Person DJS Address', 'Created');
                        });
                    }
                }

                // Save / Update CSUAddress
                if (csuAddress != '') {
                    csuAddress.PersonID = $rootScope.CurrentClientProfilePersonId;

                    if (csuAddress.ID != null) {
                        csuAddress.UpdatedBy = $rootScope.CurrentUser;
                        CRUDService('PersonAddress').Update({ ID: csuAddress.ID }, csuAddress).$promise.then(function () {
                            BaseService.openMediumDialog('Person CSU Address', 'Updated');
                        });
                    }
                    else {
                        // Set Auditing Data to the Newly Crating Entity
                        BaseService.SetAuditingDetails(csuAddress, true);
                        csuAddress.ID = 0;
                        csuAddress.CreatedBy = $rootScope.CurrentUser;


                        CRUDService('PersonAddress').Create(csuAddress).$promise.then(function (response) {
                            //$rootScope.$broadcast('UpdateClientProfile', $rootScope.CurrentClientProfileID);
                            BaseService.openMediumDialog('Person CSU Address', 'Created');
                        });
                    }
                }
            };
            $scope.submitted = false;
        };


        // Save or Update Address
        $scope.CreateOrUpdateAddress = function (isValid, djsAddress, csuAddress) {
            $scope.submitted = true;

            if (isValid == true) {

                if ($rootScope.SystemID == 3)
                {
                    djsAddress.PropertyTypeID = (djsAddress.PropertyType != null) ? djsAddress.PropertyType.ID : null;
                }

                if (djsAddress != null || djsAddress == "") {
                    djsAddress.UpdatedBy = $rootScope.CurrentUser;
                    djsAddress.PersonID = $rootScope.CurrentClientProfilePersonId;

                    // Save / Update DJSAddress            
                    if (djsAddress.ID != null) {
                        djsAddress.UpdatedBy = $rootScope.CurrentUser
                        CRUDService('PersonAddress').Update({ ID: djsAddress.PersonID }, djsAddress).$promise.then(function () {
                            if ($rootScope.SystemID == 3)
                                BaseService.openSmallDialog('Address', 'Updated');
                            else
                                BaseService.openSmallDialog('Person DJS Address', 'Updated');
                        });
                    }
                    else {
                        // Set Auditing Data to the Newly Crating Entity
                        BaseService.SetAuditingDetails(djsAddress, true);
                        djsAddress.ID = 0;
                        djsAddress.CreatedBy = $rootScope.CurrentUser;

                        CRUDService('PersonAddress').Create(djsAddress).$promise.then(function (response) {
                            //$rootScope.$broadcast('UpdateClientProfile', $rootScope.CurrentClientProfileID);
                            if ($rootScope.SystemID == 3)
                                BaseService.openSmallDialog('Address', 'Created');
                            else
                                BaseService.openSmallDialog('Person DJS Address', 'Created');

                        });
                    }
                }

                // Save / Update CSUAddress
                if (csuAddress != '') {
                    csuAddress.PersonID = $rootScope.CurrentClientProfilePersonId;

                    if (csuAddress.ID != null) {
                        csuAddress.UpdatedBy = $rootScope.CurrentUser;
                        CRUDService('PersonAddress').Update({ ID: csuAddress.PersonID }, csuAddress).$promise.then(function () {
                            BaseService.openSmallDialog('Person CSU Address', 'Updated');
                        });
                    }
                    else {
                        // Set Auditing Data to the Newly Crating Entity
                        BaseService.SetAuditingDetails(csuAddress, true);
                        csuAddress.ID = 0;
                        csuAddress.CreatedBy = $rootScope.CurrentUser;
                        CRUDService('PersonAddress').Create(csuAddress).$promise.then(function (response) {
                            //$rootScope.$broadcast('UpdateClientProfile', $rootScope.CurrentClientProfileID);
                            BaseService.openSmallDialog('Person CSU Address', 'Created');
                        });
                    }
                }
            };
            $scope.submitted = false;
        };

        // Reset Address
        $scope.Reset = function () {

            if ($scope.DJSAddress.AddressLineOne == undefined) {
                $scope.DJSAddress = '';
            } else {
                $scope.DJSAddress = angular.copy($scope.DJSAddressOrg);
            }
            if ($scope.CSUAddress.AddressLineOne == undefined) {
                $scope.CSUAddress = '';
            }
            else {
                $scope.CSUAddress = angular.copy($scope.CSUAddressOrg);
            }

        };

        // Listen to the event whenever there is a change in rootscope person
        $scope.$on('UpdateAddress', function (event, data) {
            $timeout(
                function () {
                    $scope.$apply(function () {
                        if (data == 'NewAddress') {


                        }
                        else if (data == 'EditAddress') {
                            // PersonAddress
                            // Create one scope for DJS address and one for CSU address
                            var personAddress = $rootScope.Person.PersonAddress;

                            $scope.DJSAddress = '';
                            $scope.DJSAddressType = '';
                            $scope.CSUAddress = '';
                            $scope.CSUAddressType = '';
                            $scope.DJSAddressOrg = '';
                            $scope.CSUAddressOrg = '';

                            for (var i = 0; i <= personAddress.length - 1; i++) {

                                switch (personAddress[i].AddressTypeID) {
                                    // If AddressType of PersonAddress is 1 or 2 then it is DJS Address
                                    case 1:
                                    case 2:
                                        $scope.DJSAddress = personAddress[i];
                                        $scope.DJSAddressOrg = "";
                                        $scope.DJSAddressOrg = angular.copy(personAddress[i]);
                                        $scope.DJSAddressID = $scope.DJSAddress.ID;
                                        $scope.DJSAddressType = personAddress[i].AddressTypeID;
                                        if ($rootScope.SystemID == "2")
                                        //if ($rootScope.CurrentUserole == "AdultAdmin")
                                            FormatAddressMessageForAdults(personAddress[i].AddressTypeID);
                                        if ($rootScope.SystemID == "3")
                                            FormatAddressMessageForAdults(personAddress[i].AddressTypeID);
                                        else
                                            FormatAddressMessage(personAddress[i].AddressTypeID);
                                            
                                        break;
                                        // If AddressType of PersonAddress is 3 or 4 then it is CSU Address
                                    case 3:
                                    case 4:
                                        $scope.CSUAddress = personAddress[i];
                                        $scope.CSUAddressOrg = "";
                                        $scope.CSUAddressOrg = angular.copy(personAddress[i]);
                                        $scope.CSUAddressID = $scope.CSUAddress.ID;
                                        $scope.CSUAddressType = personAddress[i].AddressTypeID;
                                        FormatAddressMessage(personAddress[i].AddressTypeID);
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

                        else { // New address
                            $scope.DJSAddress = FormatAddress($item, 1);
                            getCouncilDistrict($item.location.x, $item.location.y);
                        }

                        // assign ID to the formatted address
                        $scope.DJSAddress.ID = djsAddressID;
                        if ($scope.DJSAddress.AddressType != undefined) {
                            $scope.DJSAddress.AddressType.Description = "DJS City Address";
                            $scope.DJSAddress.AddressType.ID = 1;
                            $scope.DJSAddress.AddressType.Name = "DJS-City";
                        }
                        if ($rootScope.SystemID == "2")
                        //if ($rootScope.CurrentUserole == "AdultAdmin") 
                        {
                            FormatAddressMessageForAdults(1);
                            
                        }
                        if ($rootScope.SystemID == "3")
                            //if ($rootScope.CurrentUserole == "AdultAdmin") 
                        {
                            FormatAddressMessageForAdults(1);

                        }
                        else {
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
                                if (result) {
                                    //Commented out to fix the defect PL 399388

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
                        if ($scope.DJSAddress.AddressType != undefined) {
                            $scope.CSUAddress.AddressType.Description = "CSU City Address";
                            $scope.CSUAddress.AddressType.ID = 3;
                            $scope.CSUAddress.AddressType.Name = "CSU-City";
                        }
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

                                    //if (result.estimatedTotal == 1) {
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

    // Show / Hide message as per Formated address for Adult Case 
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
    //

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
                        Latitude: item.attributes.X,
                        Longitude: item.attributes.Y,
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
            //Make the second call to get the council district only for CWB 
            if ($rootScope.SystemID == 3 && addressType == 1)
            {
                $timeout(callAtTimeout, 1000);
            }
            else
            {
                $scope.DJSAddress.CouncilDistrict = "";
            }
            //function callAtTimeout() {
            //    if (address.Latitude != "" || address.Longitude != "") {

            //        var buildurl = "https://starapp2.richva.ci.richmond.va.us/services/gis/geodata/locationsummary/" + address.Latitude + "," + address.Longitude + "?f=json&v=1";
            //        $http({
            //            method: "GET",
            //            url: buildurl
            //        }).then(function mySuccess(response) {
            //            var obj = response.data;
            //            if (obj.InCity == true) {

            //                for (var i = 0; i <= obj.CommonBoundaries.Results.length - 1 ; i++) {
            //                    if (obj.CommonBoundaries.Results[i].LayerName === "Council Districts") {
            //                        var Index = i;
            //                        break;
            //                    }

            //                }
            //                $scope.DJSAddress.CouncilDistrict = obj.CommonBoundaries.Results[Index].Value;
            //            }



            //        }, function myError(response) {
            //            var objerror = response.statusText;
            //        });
            //    }
            //}
            // }

            function callAtTimeout() {
                getCouncilDistrict(address.Latitude, address.Longitude);
            }
            //End of Make the second call to get the council district .
           
            switch (addressType) {
                case 1:
                case 2:
                    //$scope.DJSAddress.AddressType = {
                    //    Description:'',
                    //    ID: '',
                    //    Name:''
                    //}
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
                    //$scope.CSUAddress.AddressType = {
                    //    Description: '',
                    //    ID: '',
                    //    Name: ''
                    //}
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

    //updated gis call 20190201
        function getCouncilDistrict(x, y) {
            if (x != "" || y != "") {
                var location = x + "," + y;
                $.getJSON("https://gis.richmondgov.com/ArcGIS/rest/services/StatePlane4502/CommonBoundaries/MapServer/identify?callback=?", {
                    geometryType: "esriGeometryPoint",
                    f: "pjson",
                    geometry: location,
                    sr: "2284",
                    layers: "all:7",
                    tolerance: "1",
                    mapExtent: "11743500,3687943,11806063,3744740",
                    imageDisplay: "600,550,96",
                    returnGeometry: "false"
                }, function (data) {
                    $scope.DJSAddress.CouncilDistrict = '';
                    if (data.results.length)
                        $scope.DJSAddress.CouncilDistrict = data.results[0].value;
                });
            }
        }

}]);

// Pick Address Controller
app.controller('PickAddressController', ['$scope', '$modal', '$modalInstance', 'GISService', 'BingService', 'Addresses', function ($scope, $modal, $modalInstance, GISService, BingService, Addresses) {

    // Assigned addresses to scope variable
    $scope.Addresses = Addresses.Address;
    $scope.PassedAddressType = Addresses.AddressType;
    $scope.AddressID = Addresses.AddressID;

    /** Start : Page Events  **/
    // Close button event
    $scope.ClosePickAddress = function () {
        $modalInstance.close();
    };

    $scope.SelectAddress = function (finalAddress, finalAddressType) {
        var selectedAddress = {
            SelectedAddress: finalAddress,
            SelectedAddressType: finalAddressType,
            AddressID: $scope.AddressID
        };

        $modalInstance.close(selectedAddress);
    };

    /** End : Page Events  **/
}]);

// Referral Tab : Create new or Update existing Employment Controller
app.controller('AddorUpdateEmploymentController', ['$scope', '$timeout', '$modal', '$modalStack', '$modalInstance', '$rootScope', 'CRUDService', 'BaseService', 'CaseMgtService', '$q', 'selectedEnrollment', 'CustomCRUDService', function ($scope, $timeout, $modal, $modalStack, $modalInstance, $rootScope, CRUDService, BaseService, CaseMgtService, $q, selectedEnrollment, CustomCRUDService) {
    //[Placement]>[Enrollment]>[ActionPlan]+[EmploymentPlan]+[Enrollment]+[ProgressNote]+[ServiceUnit]
    var SetDefaultValues = function () {

        $scope.CurrentPlacementEmployment = (selectedEnrollment.EmploymentPlan[0] != null) ? selectedEnrollment.EmploymentPlan[0] : EmptyEmployment();
        $scope._CurrentPlacementEmployment = (selectedEnrollment.EmploymentPlan[0] != null) ? angular.copy(selectedEnrollment.EmploymentPlan[0]) : angular.copy(EmptyEmployment());
        $scope.CurrentActionPlans = (selectedEnrollment != null) ? selectedEnrollment.ActionPlan : null;
        $scope._CurrentActionPlans = (selectedEnrollment != null) ? angular.copy(selectedEnrollment.ActionPlan) : null;
        $scope.SubmitButtonText = ($scope.CurrentPlacementEmployment.ID != 0) ? 'Update' : 'Save';

        if ($scope.SubmitButtonText == 'Save') {
            $scope.x = "true";
        }
        else {
            $scope.x = "false";
        }
        $scope.CanShowAP = (selectedEnrollment.EmploymentPlan[0] != null) ? true : false;
        if ($scope.CanShowAP) {
            RefreshActionPlans();
        }
        $scope.CanShowFormButtons = true;
        $scope.FormattedReferralName = '';
        $scope.CurrentReferralService = '';
        $scope.FormattedCounselorName = '';
        $scope.AllReferrals = [];
        $scope.ServiceProgramCategories = [];
        $scope.AllCounselors = [];
        $scope.AllServiceReleases = [];
        $scope.AllServiceOutcomes = [];
    };
    // Create Empty Employment to assign in creating new scenario
    var EmptyEmployment = function () {
        return {
            ID: 0,
            EnrollmentID: $rootScope.CurrentEnrollmentID,
            EmploymentGoal: '',
            EduTrainGoal: '',
            WorkExperience: '',
            Strengths: '',
            HighestEd: '',
            AddtlTraining: '',
            Credentials: '',
            Barriers: '',
        };
    };
    //Delete ActionPlans

    $scope.DeleteActionPlan = function (selectedActionPlan) {
        var decision = confirm("Are you sure you want to delete the Action Plan?");
        if (decision)
            DeleteActionPlan(selectedActionPlan.ID);

    };


    var DeleteActionPlan = function (id) {

        CaseMgtService('ClientProfile/DeleteActionPlan').DeleteActionPlansForEmploymentPlan({
            ID: id
        }, function (response) {
            //$scope.ClientProfile = response;
            if (response == "Success")

                RefreshActionPlans();



        }).$promise.then(function (response) {
            BaseService.openSmallDialog('ActionPlan', 'deleted');
            RefreshActionPlans();

        });
    };

    // Begin: DatePicker Functionality
    $scope.datePicker = (function () {
        var method = {
        };
        method.instances = [];

        method.open = function ($event, instance) {
            $event.preventDefault();
            $event.stopPropagation();

            method.instances[instance] = true;
        };

        $scope.dateOptions = {
            startingDay: 1,
            showWeeks: 'false'
        };

        return method;
    }());

    // Default Settings
    var LoadDefaults = function () {
        SetDefaultValues();
        //RefreshActionPlans();
    };

    /** Start : Page Events  **/
    // Close button event
    $scope.CloseModal = function () {
        $modalInstance.close();
    };
    $scope.ClosePrintModal = function () {
        $modalStack.dismissAll('dismissAll');
    };
    $scope.date = new Date();

    // Reset button event
    $scope.Reset = function () {
        $scope.CurrentPlacementEmployment = angular.copy($scope._CurrentPlacementEmployment);
        $scope.CurrentActionPlans = angular.copy($scope._CurrentActionPlans);

    };

    // Save / Update button Click Event
    $scope.CreateOrUpdate = function (isValid, employment) {
        $scope.submitted = true;
        if (isValid == true) {

            if (employment.ID != 0) {
                employment.UpdatedBy = $rootScope.CurrentUser;
                CaseMgtService('EmploymentPlan/UpdateEmploymentPlan').UpdateEmploymentPlan({ ID: employment.ID }, employment).$promise.then(function (response) {
                    BaseService.openSmallDialog('Employment', 'Updated');
                    $modalInstance.close();
                });
            }
            else {

                // Set Auditing Data to the Newly Crating Entity
                BaseService.SetAuditingDetails(employment, true);
                employment.CreatedBy = $rootScope.CurrentUser;

                CRUDService('EmploymentPlan').Create(employment).$promise.then(function (response) {
                    BaseService.openSmallDialog('Employment', 'Created');
                    $modalInstance.close();
                });
            };
            $scope.submitted = false;
            LoadDefaults();
        };
    };

    // Create a new rootscope
    var modalScope = $rootScope.$new();

    // To Open Action Plan dialog
    $scope.AddorEditActionPlan = function (actionPlan) {
        modalScope.modalInstance = $modal.open({
            templateUrl: 'views/casemanagement/addoreditActionPlan.html',
            controller: 'AddorUpdateActionPlanController',
            scope: modalScope,
            backdrop: 'static',
            keyboard: false, // restricts esc key usage
            size: 'md',
            resolve: {
                selectedActionPlan: function () {

                    return actionPlan;
                }
            }
        });
        modalScope.modalInstance.result.then(function () {
            RefreshActionPlans();
        }, function () {
            //alert('Dialog closing with Dismiss');
        });
    };
    $scope.PrintEmploymentPlan = function () {
        modalScope.modalInstance = $modal.open({
            templateUrl: 'views/casemanagement/PrintEmploymentPlan.html',
            scope: $scope,
            backdrop: 'static',
            keyboard: true,// restricts esc key usage
            size: 'lg',
            resolve:
            {
            }
        });
    };

    // Refresh ActionPlans data with database
    var RefreshActionPlans = function () {
        CaseMgtService('ClientProfile/ActionPlan').GetActionPlansForEmploymentPlan({
            ID: $rootScope.CurrentEmploymentID
        }, function (response) {
            //$scope.CurrentPlacementEmployment.ActionPlan = response;
            $scope.CurrentActionPlans = response;
        });
    };

    LoadDefaults();

}]);

// Action Plan controller 
app.controller('AddorUpdateActionPlanController', ['$scope', '$rootScope', '$timeout', '$modal', '$modalInstance', 'CRUDService', 'CustomCRUDService', 'CaseMgtService', 'BaseService', '$q', 'selectedActionPlan', function ($scope, $rootScope, $timeout, $modal, $modalInstance, CRUDService, CustomCRUDService, CaseMgtService, BaseService, $q, selectedActionPlan) {
    // Initialize all required variables

    var SetDefaultValues = function () {
        $scope.ActionPlan = (selectedActionPlan != null) ? selectedActionPlan : null;
        $scope._ActionPlan = (selectedActionPlan != null) ? angular.copy(selectedActionPlan) : null;
        SetButtonText();
    };

    // Set Button Text either as Save or Update
    var SetButtonText = function () {
        $scope.SubmitButtonText = (selectedActionPlan != null) ? 'Update' : 'Save';
    };

    // Begin: DatePicker Functionality
    $scope.datePicker = (function () {
        var method = {};
        method.instances = [];

        method.open = function ($event, instance) {
            $event.preventDefault();
            $event.stopPropagation();

            method.instances[instance] = true;
        };

        $scope.dateOptions = {
            startingDay: 1,
            showWeeks: 'false'
        };

        return method;
    }
        ());
    // End: DatePicker Functionality

    /** Start : Page Events  **/
    // Close button event
    $scope.CloseActionPlan = function () {
        $modalInstance.close();
    };

    // Reset button event
    $scope.Reset = function () {
        $scope.ActionPlan = angular.copy($scope._ActionPlan);
    };

    // Save / Update button Click Event
    $scope.CreateOrUpdate = function (isValid, actionPlan) {

        $scope.submitted = true;
        if (isValid == true) {
            if (actionPlan.ID != null) {
                actionPlan.UpdatedBy = $rootScope.CurrentUser;
                CaseMgtService('ActionPlan/UpdateActionPlan').UpdateActionPlan({
                    ID: actionPlan.ID
                }, actionPlan).$promise.then(function (response) {
                    BaseService.openSmallDialog('Action Plan', 'Updated');
                    $modalInstance.close();
                });
            } else {
                // Set Auditing Data to the Newly Crating Entity
                BaseService.SetAuditingDetails(actionPlan, true);
                //to avoid duplicates
                actionPlan.CreatedBy = $rootScope.CurrentUser;
                actionPlan.EmploymentPlanID = $rootScope.CurrentEmploymentID;
                CRUDService('ActionPlan').Create(actionPlan).$promise.then(function (response) {
                    BaseService.openSmallDialog('Action Plan', 'Created');
                    $modalInstance.close();
                });
            }
        };
        $scope.submitted = false;
        LoadDefaults();
    };
    /** End : Page Events  **/

    // Load Defaults of the dialog
    var LoadDefaults = function () {
        SetDefaultValues();
    };

    LoadDefaults();
}
]);

