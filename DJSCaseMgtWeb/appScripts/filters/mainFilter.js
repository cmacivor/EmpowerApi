// FIlter to retrieve Display name to use on view
app.filter('getMenuDisplayNameByTitle', function () {
    return function (input, title) {        
        var i = 0, len = input.length;
        for (; i < len; i++) {           
            if (input[i].Title == title) {                
                return input[i].DisplayName;
            }
        }
        return null;
    }
});

// Filter a list on Name property (filters matching startswith clause)
// Currently using this on Placement Charges field of Placement view
app.filter('filterByName', function () {
    return function (items, query) {
        if (query.length === 0) {
            return items;
        }
        else {
            
            var filtered = [];
            var letterMatch = new RegExp(query, 'i');
            for (i = 0; i < items.length; i++) {
                var item = items[i];
                //if (angular.lowercase(items[i].VCCCode)) {
                 if (letterMatch.test(item.VCCCode.substring(0, 20))) {
                    filtered.push(item);
                }
            }
            return filtered;
        }
    };
});
// Filter a list on Viewkey, Statue, Heading, Description 
app.filter('filterByKeyword', function () {
    return function (items, query) {
        if (query.length === 0) {
            return items;
        }
        else {
            var filtered = [];
            var letterMatch = new RegExp(query, 'i');
            for (i = 0; i < items.length; i++) {
                if (letterMatch.test(items[i].Description) || letterMatch.test(items[i].VCCCode) || letterMatch.test(items[i].Statute) || letterMatch.test(items[i].GeneralHeading)) {
                    filtered.push(items[i]);
                }
            }
            return filtered;
        }
    };
});