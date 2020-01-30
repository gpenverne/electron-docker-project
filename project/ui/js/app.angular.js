var angularApp = angular.module('angularApp', []);

angularApp.filter('unsafe', function($sce) {
    return function(val) {
        return $sce.trustAsHtml(val);
    };
});

angularApp.controller('IndexController', function StoriesController($scope, $http) {

});
