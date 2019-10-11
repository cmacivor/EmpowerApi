app.directive('datepickerPopup', ['datepickerPopupConfig', 'dateParser', 'dateFilter', function (datepickerPopupConfig, dateParser, dateFilter) {
    return {
        'restrict': 'A',
        'require': '^ngModel',
        'link': function ($scope, element, attrs, ngModel) {
            var dateFormat;

            //*** Temp fix for Angular 1.3 support [#2659](https://github.com/angular-ui/bootstrap/issues/2659)
            attrs.$observe('datepickerPopup', function (value) {
                dateFormat = value || datepickerPopupConfig.datepickerPopup;
                ngModel.$render();
            });

            ngModel.$formatters.push(function (value) {
                return ngModel.$isEmpty(value) ? value : dateFilter(value, dateFormat);
            });
        }
    };
}]);
//for pure numeric values 
app.directive('numbersOnly', function () {
    return {
        require: 'ngModel',
        link: function (scope, element, attrs, modelCtrl) {
            modelCtrl.$parsers.push(function (inputValue) {
                // this next if is necessary for when using ng-required on your input. 
                // In such cases, when a letter is typed first, this parser will be called
                // again, and the 2nd time, the value will be undefined
                if (inputValue == undefined) return ''
                var transformedInput = inputValue.replace(/[^0-9]/g, '');
                if (transformedInput != inputValue) {
                    modelCtrl.$setViewValue(transformedInput);
                    modelCtrl.$render();
                }

                return transformedInput;
            });
        }
    };
});
//for decimal values input field
app.directive('dnumbersOnly', function () {
    return {
        require: 'ngModel',
        link: function (scope, element, attrs, modelCtrl) {
            modelCtrl.$parsers.push(function (inputValue) {
                // this next if is necessary for when using ng-required on your input. 
                // In such cases, when a letter is typed first, this parser will be called
                // again, and the 2nd time, the value will be undefined
                if (inputValue == undefined) return ''
                var transformedInput = inputValue.replace(/[^0-9.]/g, '');
                if (transformedInput != inputValue) {
                    modelCtrl.$setViewValue(transformedInput);
                    modelCtrl.$render();
                }

                return transformedInput;
            });
        }
    };
});

//for phone numbers to use +,_ and numbers
app.directive('mnumbersOnly', function () {
    return {
        require: 'ngModel',
        link: function (scope, element, attrs, modelCtrl) {
            modelCtrl.$parsers.push(function (inputValue) {
                // this next if is necessary for when using ng-required on your input. 
                // In such cases, when a letter is typed first, this parser will be called
                // again, and the 2nd time, the value will be undefined
                if (inputValue == undefined) return ''
                var transformedInput = inputValue.replace(/[^0-9+-]/g, '');
                if (transformedInput != inputValue) {
                    modelCtrl.$setViewValue(transformedInput);
                    modelCtrl.$render();
                }

                return transformedInput;
            });
        }
    };
});

// Helps to generate custom tooltip feature
app.directive("tooltipSpecialPopup", function () {
    return {
        restrict: "EA",
        replace: true,
        html: true,
        scope: { content: "@", placement: "@", animation: "&", isOpen: "&" },
        templateUrl: "views/casemanagement/tooltipTemplate.html"
    };
})

.directive("tooltipSpecial", [ "$tooltip", function ($tooltip) {
    return $tooltip("tooltipSpecial", "tooltip", "mouseenter");
}]);


app.directive('datetimepickerNeutralTimezone', function () {
      return {
          restrict: 'A',
          priority: 1,
          require: 'ngModel',
          link: function (scope, element, attrs, ctrl) {
              ctrl.$formatters.push(function (value) {
                  var date = new Date(Date.parse(value));
                  date = new Date(date.getTime() + (60000 * date.getTimezoneOffset()));
                  return date;
              });

              ctrl.$parsers.push(function (value) {
                  var date = new Date(value.getTime() - (60000 * value.getTimezoneOffset()));
                  return date;
              });
          }
      };
});



