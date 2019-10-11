// Service to handle all common functionality throught the application
app.service('BaseService', ['$modal', function ($modal) {

    // Open true modal window, user has to close this before continuing
    this.openSmallModal = function (currentEntity, requestType) {
        var modalInstance = $modal.open({
            templateUrl: 'views/common/messageBox.html',
            controller: 'ConfirmationController',
            backdrop: 'static',
            size: 'sm',
            resolve: {
                message: function () {
                    return currentEntity + ' ' + requestType + ' Successfully';
                }
            }
        });
    }

    // Open true modal window, user has to close this before continuing
    this.openMediumModal = function (currentEntity, requestType) {
        var modalInstance = $modal.open({
            templateUrl: 'views/common/messageBox.html',
            controller: 'ConfirmationController',
            backdrop: 'static',
            size: 'md',
            resolve: {
                message: function () {
                    return currentEntity + ' ' + requestType + ' Successfully';
                }
            }
        });
    }

    // Open true modal window, user has to close this before continuing
    this.openLargeModal = function (currentEntity, requestType) {
        var modalInstance = $modal.open({
            templateUrl: 'views/common/messageBox.html',
            controller: 'ConfirmationController',
            backdrop: 'static',
            size: 'lg',
            resolve: {
                message: function () {
                    return currentEntity + ' ' + requestType + ' Successfully';
                }
            }
        });
    }

    // Open dialog window as non-static, clickikng anywhere on the form will close the pop up 
    this.openSmallDialog = function (currentEntity, requestType) {
        var modalInstance = $modal.open({
            templateUrl: 'views/common/messageBox.html',
            controller: 'ConfirmationController',
            backdrop: true,
            backdropClass: 'modal-nobackdrop', // with transparent background
            size: 'sm',
            resolve: {
                message: function () {
                    return currentEntity + ' ' + requestType + ' Successfully';
                }
            }
        });
    }

    // Open dialog window as non-static, clickikng anywhere on the form will close the pop up 
    this.openMediumDialog = function (currentEntity, requestType) {
        var modalInstance = $modal.open({
            templateUrl: 'views/common/messageBox.html',
            controller: 'ConfirmationController',
            backdrop: true,
            backdropClass: 'modal-nobackdrop', // with transparent background
            size: 'md',
            resolve: {
                message: function () {
                    return currentEntity + ' ' + requestType + ' Successfully';
                }
            }
        });
    }

    // Open dialog window as non-static, clickikng anywhere on the form will close the pop up 
    this.openLargeDialog = function (currentEntity, requestType) {
        var modalInstance = $modal.open({
            templateUrl: 'views/common/messageBox.html',
            controller: 'ConfirmationController',
            backdrop: true,
            backdropClass : 'modal-nobackdrop', // with transparent background
            size: 'lg',
            resolve: {
                message: function () {
                    return currentEntity + ' ' + requestType + ' Successfully';
                }
            }
        });
    }

    // Gets Formatted Date
    this.getFormattedDate = function (input) {
        var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

        return ("0" + input.getDate()).slice(-2) + "-" + months[input.getMonth()] + "-" + input.getFullYear();
    }

    // Returns calendar months
    this.GetCalendarMonths = function () {
        return [            
            { "Month": 1, "MonthName": "JAN" },
            { "Month": 2, "MonthName": "FEB" },
            { "Month": 3, "MonthName": "MAR" },
            { "Month": 4, "MonthName": "APR" },

            { "Month": 5, "MonthName": "MAY" },
            { "Month": 6, "MonthName": "JUN" },
            { "Month": 7, "MonthName": "JUL" },
            { "Month": 8, "MonthName": "AUG" },

            { "Month": 9, "MonthName": "SEP" },
            { "Month": 10, "MonthName": "OCT" },
            { "Month": 11, "MonthName": "NOV" },
            { "Month": 12, "MonthName": "DEC" },
        ];
    };

    // Returns calendar years between 20 years
    this.GetCalendarYears = function () {
        var calendarYears = [];
        for (var i = 2000; i <= 2020; i++) {
            calendarYears.push({
                Year: i,
                YearValue: i
            });
        }
        return calendarYears;
    };

    this.GetYesOrNoValues = function () {
        return [
            { "ID": 1, "Name": "Yes" },
            { "ID": 0, "Name": "No" }
        ];
    };

    // Load Auditing Fields for New Entities
    this.SetAuditingDetails = function(currentEntity, isActive)
    {
        currentEntity.CreatedDate = new Date();
        currentEntity.CreatedBy = 0; // Change this to session's userid, after implementing authentication 
        currentEntity.UpdatedDate = new Date();
        currentEntity.UpdatedBy = 0; // Change this to session's userid, after implementing authentication
        currentEntity.Active = isActive;

        return currentEntity;
    }

 

}]);
