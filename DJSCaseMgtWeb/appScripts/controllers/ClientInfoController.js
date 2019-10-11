
// Client Info Tab Controller
app.controller('ClientInfoController', ['$scope', '$timeout', '$filter', '$rootScope', '$modal', 'CRUDService', 'CustomCRUDService', 'BaseService', 'CaseMgtService', '$http', 'servicesURL', '$controller', function ($scope, $timeout, $filter, $rootScope, $modal, CRUDService, CustomCRUDService, BaseService, CaseMgtService, $http, servicesURL, $controller) {
    var modalScope = $rootScope.$new();

    //if ($rootScope.CurrentUserole == "AdultAdmin")
    if ($rootScope.SystemID == "2")
    {
        $scope.title = 'Adult Info';
        $scope.AssignNumber = 'FBI/NCIC Number';
        $scope.placeholdertext = " ";
        $scope.CanShowtxtJTS = false;
        $scope.CanShowStateVCIN = true;
        $scope.CanShowAlias = true;
        $scope.lblMsg = "*are mandatory";
        $scope.italicsmsg = "";
        $scope.ShowOnlyCWB = false;
        
        
    }
    if ($rootScope.SystemID == "1")
    {
        $scope.title = 'Juvenile Info';
        $scope.CanShowtxtJTS = true;
        $scope.placeholdertext = "JTS Number";
        $scope.AssignNumber = 'JTS Number *';
        $scope.CanShowStateVCIN = false;
        $scope.CanShowAlias = false;
        $scope.italicsmsg = "(Exception: If this is a new client being referred to prevention/diversion services who does not have a JTS number assigned, leave that field blank but record a valid social security number.)";
        $scope.lblMsg = "*Mandatory fields";
        $scope.ShowOnlyCWB = false;
        
        
    }
    if ($rootScope.SystemID == "3")
    {
        $scope.title = 'Participant Info';
        $scope.AssignNumber = 'FBI/NCIC Number';
        $scope.placeholdertext = " ";
        $scope.CanShowtxtJTS = false;
        $scope.CanShowStateVCIN = true;
        $scope.CanShowAlias = true;
        $scope.lblMsg = "*are mandatory";
        $scope.italicsmsg = "";
        $scope.ShowOnlyCWB = true;


    }


        //$scope.ClientProfile = '';


        //$rootScope.Person = '';
        //$rootScope.Person.PersonAddress = '';
        //$rootScope.Placements = '';
        //$rootScope.FamilyProfiles = '';
        //$rootScope.Assessments = '';
        // CustomCRUDService('Staff', 'GetAll').GetAll(function (response) {
        //    $scope.AllReferrals = response;



        // Loads Supplemental Tab
        var Supplemental = function () {
            $scope.Person = $rootScope.Person;
            // $rootScope.Person.PersonSupplemental = $scope.ClientProfile.Person.PersonSupplemental;
            $rootScope.$broadcast('UpdateSupplemental', 'EditSupplemental');
        };

        // Loads Address Tab
        var Address = function () {
            $rootScope.$broadcast('UpdateAddress', 'EditAddress');
        };

        // Loads Family Info Tab
        var FamilyInfo = function () {
            $rootScope.FamilyProfiles = $scope.ClientProfile.Person.FamilyProfile;
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


        // Set default settings to Client Info Tab
        var SetDefaults = function () {
            $scope.Suffixes = [];
            $scope.AllRaces = [];
            $scope.Genders = [];
            $scope.Persons = [];
            $scope.rowCollection = [];
            $scope.displayed = [].concat($scope.rowCollection);

            //  $scope.SubmitButtonText = ($scope.Person == '' ?  'Save' : 'Update');
            $scope.CanShowReset = true;

        };


        // Factory call to get the results according to the selected Entity
        var GetAllRaces = function getData(tableState) {
            CustomCRUDService('Race', 'GetAll').GetAll(function (response) {

                $scope.AllRaces = response;
            });
        };

        // Factory call to get the Genders 
        //var GetAllGenders = function getData(tableState) {

        //    CustomCRUDService('Gender', 'GetAll').GetAll(function (response) {
        //        //ISR 1019
        //        var res = response.splice(-1, 1);
        //        //ISR 1019
        //        $scope.Genders = response;
        //    });
        //};

        var GetAllGenders = function getData(tableState) {

            CustomCRUDService('Gender', 'GetAll').GetAll(function (response) {
                $scope.Genders = response;
            });
        };



        // Factory call to get the Suffixes 
        var GetAllSuffixes = function () {
            CustomCRUDService('Suffix', 'GetAll').GetAll(function (response) {

                $scope.Suffixes = response;
            });
        };

        // Factory call to get the Persons
        var GetAllPersons = function () {
            CaseMgtService('ClientProfile/Person').GetAllPersonsWithNoClientProfile(function (response) {
                $scope.Persons = response;
                //alert($scope.Persons.length);
                //$scope.Persons = [{ 'FirstName': 'TB', 'LastName': 'abc' }, { 'FirstName': 'TB', 'LastName': 'acd' }, { 'FirstName': 'TB', 'LastName': 'xyz' }, { 'FirstName': 'TB', 'LastName': 'pqr' }];
            });
        };

        // Callback on LastName Person selection
        $scope.setPcode = function (selectedPerson) {
            $scope.Person = selectedPerson;
        };
        //




        // Calculate Age using DOBb
        var CalculateAge = function () {
            if ($scope.Person.DOB != null) {
                var DOB = $scope.Person.DOB;
                var currentYear = new Date();
                var d = new Date(DOB);

                // var diff = (currentYear - new Date(DOB).getTime());
                var diff = (currentYear - d);
                $scope.Person.CurrentAge = (currentYear.getFullYear() - d.getFullYear());


                if (currentYear.getMonth() < d.getMonth() ||
               currentYear.getMonth() == d.getMonth() && currentYear.getDate() < d.getDate()) {
                    $scope.Person.CurrentAge--;
                }
                return $scope.Person.CurrentAge;



            }
            //$scope.Person.CurrentAge = years;
        };


        //Navigate to home page when click on Search button

        // Close button event

        // Default Settings
        var LoadDefaults = function () {
            SetDefaults();
            GetAllRaces();
            GetAllGenders();
            GetAllSuffixes();
            GetAllPersons();
        };

        // Begin: DatePicker Functionality
        $scope.open = function () {
            $timeout(function () {
                $scope.opened = true;
            });
        };

        $scope.dateOptions = {
            startingDay: 1,
            showWeeks: 'false'
        };
        // End: DatePicker Functionality

        // BEGIN: Client Info Events

        // Save or Update Client Info
        $scope.CreateOrUpdateClientInfo = function (isValid, person) {
            $scope.Person = person;
            var uniqueid;
            $scope.Person.UniqueID = uniqueid;
            //$scope.uniqueId = person.UniqueID;
            $scope.submitted = true;
            if (isValid == true) {
                // Update FK Id's using selection on view
                person.SuffixID = (person.Suffix != null) ? person.Suffix.ID : null;
                person.RaceID = (person.Race != null) ? person.Race.ID : null;
                person.GenderID = (person.Gender != null) ? person.Gender.ID : null;

                $rootScope.NewPerson = angular.copy(person);
                if (person.ID != null) {
                    var person = $rootScope.NewPerson;
                    var uniqueid = $rootScope.NewUniqueID;
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

                    alert('The Unique License Number Is : ' + LC + '-' + c + '-' + (day.get('year') % 100) + '-' + DayCode);
                    uniqueid = LC + '-' + c + '-' + (day.get('year') % 100) + '-' + DayCode;
                    $rootScope.NewUniqueID = angular.copy(uniqueid);

                    CRUDService('Person').Update({
                        ID: person.ID
                    }, person).$promise.then(function (response) {
                        if (response[0] == "J") {

                            alert("This JTS number is already EXISTS, please give different one");

                        }
                        if (response[0] == "S") {

                            alert("This SSN number is already EXISTS, please give different one");

                        }
                        if (response[0] != "J" && response[0] != "S") {
                            BaseService.openSmallDialog('Person', 'Updated');
                        }

                        ////Update Unique Id for the newly added person
                        var reqArray = [];
                        reqArray[0] = {
                            PersonId: person.ID,
                            UniqueId: uniqueid.toString()
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
                        //send request to update unique id
                        $http.post(url, req, config).then(function (res) {
                            console.log(res.data);
                        });
                    });
                } else {

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

                    alert('The Unique License Number Is : ' + LC + '-' + c + '-' + (day.get('year') % 100) + '-' + DayCode);
                    uniqueid = LC + '-' + c + '-' + (day.get('year') % 100) + '-' + DayCode;
                    $rootScope.NewUniqueID = angular.copy(uniqueid);

                    if (uniqueid != null && uniqueid != "") {
                        CaseMgtService('person/GetduplicatePersons').GetduplicatePersons({
                            ID: uniqueid
                        }, function (response) {
                            // $scope.Clientprofile =$rootscope.Clientprofile;

                            if (response.length != 0) {
                                modalScope.DProwCollection = response;
                                //Need to take the person id of the originial
                                $rootScope.OriginalClientprofileID = response[0].ID;
                                //end of //Need to take the person id of the originial
                                //Show duplicate persons data on modal
                                modalScope.modalInstance = $modal.open({
                                    templateUrl: 'views/casemanagement/DuplicatePersons.html',
                                    controller: [
                                '$scope', '$modalInstance', '$window', '$http', '$rootScope', 'servicesURL', 'BaseService', 'CRUDService', function ($scope, $modalInstance, $window, $http, $rootScope, servicesURL, BaseService, CRUDService) {
                                    $scope.ClosePopup = function () {
                                        $modalInstance.close();
                                    };
                                    $scope.SearchClient = function () {
                                        $window.location.href = ' #/';
                                        $modalInstance.close();

                                    };
                                    //Create person even it is duplicate
                                    $scope.CreateNewClient = function () {
                                        var person = $rootScope.NewPerson;
                                        var uniqueid = $rootScope.NewUniqueID;
                                        //Sets auditing details
                                        BaseService.SetAuditingDetails(person, true);
                                        //Avoiding adding of new virtuals
                                        person.Gender = null;
                                        person.Race = null;
                                        person.Suffix = null;
                                        //Add new person 
                                        CRUDService('Person').Create(person).$promise.then(function (response) {
                                            $rootScope.$broadcast('UpdateClientProfile', response.ID);
                                            BaseService.openSmallDialog('Person', 'Created');
                                            //Update Unique Id for the newly added person
                                            var reqArray = [];
                                            reqArray[0] = {
                                                PersonId: response.PersonID,
                                                UniqueId: uniqueid.toString()
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
                                            //send request to update unique id
                                            $http.post(url, req, config).then(function (res) {
                                                $modalInstance.close();
                                                //console.log(res.data);
                                            });
                                        });
                                    };

                                    // Edit Client Profile
                                    $scope.LoadClientProfile = function (selectedEntity) {

                                        $rootScope.Person = angular.copy(selectedEntity);
                                        $rootScope.cpid = selectedEntity.ClientProfileID;
                                        GetandUpdateClientProfile(selectedEntity.ClientProfileID);
                                        LoadDefaults();
                                        $modalInstance.close();


                                    };

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


                                    var ClientInfo = function () {
                                        $rootScope.Person = $scope.ClientProfile.Person;
                                        $rootScope.CurrentClientProfilePersonId = $scope.ClientProfile.Person.Person.ID;
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
                                        $rootScope.FamilyProfiles = $scope.ClientProfile.Person.FamilyProfile;
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

                                });
                                //**************************End of modal ************

                            }
                            else {

                                var person = $rootScope.NewPerson;
                                var uniqueid = $rootScope.NewUniqueID;
                                //Sets auditing details
                                BaseService.SetAuditingDetails(person, true);
                                //Avoiding adding of new virtuals
                                person.Gender = null;
                                person.Race = null;
                                person.Suffix = null;
                                //Add new person 
                                CRUDService('Person').Create(person).$promise.then(function (response) {
                                    $rootScope.$broadcast('UpdateClientProfile', response.ID);
                                    // BaseService.openSmallDialog('Person', 'Created');
                                    if (response[0] == "J") {

                                        alert("This JTS number is already EXISTS, please give different one");

                                    }
                                    if (response[0] == "S") {

                                        alert("This SSN number is already EXISTS, please give different one");

                                    }
                                    if (response[0] != "J" && response[0] != "S") {
                                        BaseService.openSmallDialog('Person', 'Created');

                                    }

                                    //Update Unique Id for the newly added person
                                    var reqArray = [];
                                    reqArray[0] = {
                                        PersonId: response.PersonID,
                                        UniqueId: uniqueid.toString()
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
                                    //send request to update unique id
                                    $http.post(url, req, config).then(function (res) {
                                        console.log(res.data);
                                    });

                                });
                            }
                        });
                    }

                }
            }
        };

        $scope.CreateNewClient = function () {

            var person = $rootScope.NewPerson;
            var uniqueid = $rootScope.NewUniqueID;
            //Sets auditing details
            BaseService.SetAuditingDetails(person, true);
            //Avoiding adding of new virtuals
            person.Gender = null;
            person.Race = null;
            person.Suffix = null;
            //Add new person 
            CRUDService('Person').Create(person).$promise.then(function (response) {

                $rootScope.$broadcast('UpdateClientProfile', response.ID);
                BaseService.openSmallDialog('Person', 'Created');

                //Update Unique Id for the newly added person
                var reqArray = [];
                reqArray[0] = {
                    PersonId: response.PersonID,
                    UniqueId: uniqueid.toString()
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
                //send request to update unique id
                $http.post(url, req, config).then(function (res) {
                    console.log(res.data);
                });
            });
        };
        // Cancel Client Info
        $scope.Cancel = function () {
            $rootScope.$broadcast('UpdateTabs', 'Clear');
        };

        // Reset Client Info
        $scope.Reset = function () {
            $scope.Person = angular.copy($scope.OriginalPerson);
        };

        // Get Age on DOB Change
        $scope.GetAge = function () {
            CalculateAge();
        };

    //Only for CWB for duplicate clients
        $scope.CreateNewClientProfile = function () {

            var person = $rootScope.NewPerson;
            //var uniqueid = $rootScope.NewUniqueID;
            //Sets auditing details
            //BaseService.SetAuditingDetails(person, true);
            //Avoiding adding of new virtuals
            //person.Gender = null;
            //person.Race = null;
            //person.Suffix = null;
            //Add new Clientprofile 
            var url = servicesURL + "Person/CreateNewClientProfile/";
            $http.post(url + "/" + $rootScope.OriginalClientprofileID).success(function (response) {
                if (response[0] == 's') {

                    BaseService.openSmallDialog('Client Profile', 'Created');
                }
                if (response[0] == 'e') {

                    BaseService.openSmallDialog('Client Profile', 'Failed');
                }


            })
           .error(function () { alert('Unexpected Error occured.'); });


        };

    //End of CWB for duplicate clients

        //$rootScope.Agep=angular.copy($scope.GetAge);

        // END: Client Info Events

        // Listen to the event whenever there is a change in rootscope person
        $scope.$on('UpdateClientInfo', function (event, data) {
            $timeout(
                function () {
                    $scope.$apply(function () {
                        if (data == 'NewClient') {
                            // $rootScope.Person.Person = '';
                            $scope.Person = '';
                            $scope.OriginalPerson = '';
                            if ($rootScope.SystemID == "1") {
                                $scope.xjts = false;
                            }
                            else
                            {
                                $scope.xjts = false;
                            }
                            $scope.SubmitButtonText = "Save";
                            $rootScope.Person.Person.CurrentAge =



                            function () {
                                if ($rootScope.Person.Person.DOB != null) {
                                    var DOB = $rootScope.Person.Person.DOB;
                                    var currentYear = new Date();
                                    var d = new Date(DOB);

                                    // var diff = (currentYear - new Date(DOB).getTime());
                                    var diff = (currentYear - d);
                                    $scope.Person.CurrentAge = (currentYear.getFullYear() - d.getFullYear());


                                    if (currentYear.getMonth() < d.getMonth() ||
                                   currentYear.getMonth() == d.getMonth() && currentYear.getDate() < d.getDate()) {
                                        $scope.Person.CurrentAge--;
                                    }
                                    return $scope.Person.CurrentAge;



                                }
                                //$scope.Person.CurrentAge = years;
                            };



                        }
                        else if (data == 'EditClient') {
                            // Update calculated field
                            //$rootScope.Person.Person.CurrentAge = function () {
                            //    if ($rootScope.Person.Person.DOB != null) {
                            var DOB = $rootScope.Person.Person.DOB;
                            $scope.SubmitButtonText = "Update";
                            $scope.xjts = false;
                            var currentYear = new Date();
                            var d = new Date(DOB);

                            //        // var diff = (currentYear - new Date(DOB).getTime());
                            //        var diff = (currentYear - d);
                            $rootScope.Person.Person.CurrentAge = (new Date().getFullYear() - d.getFullYear());


                            if (currentYear.getMonth() < d.getMonth() ||
                           currentYear.getMonth() == d.getMonth() && currentYear.getDate() < d.getDate()) {
                                $rootScope.Person.Person.CurrentAge--;
                            }
                            //return $rootScope.Person.Person.CurrentAge;



                            //    }
                            //    //$scope.Person.CurrentAge = years;
                            //};

                            // Get the current Person to current scope
                            $scope.OriginalPerson = angular.copy($rootScope.Person.Person);

                            $scope.Person = $rootScope.Person.Person;
                            LoadDefaults();

                        }



                    });
                });
        });

        // Start view with default values
        LoadDefaults();


        //end of juvenile block
        //$controller('ClientSearchController', { $scope: $scope });

    // Create the scope for all the controllers
    

}]);

