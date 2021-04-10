
const app = angular.module('demoApp', [])
app.directive('appHeader', function() {
  return {
    templateUrl: '/app/templates/header.html?' + new Date().getTime(),
    replace: true
  };
})
app.directive('appBody', function() {
  return {
    templateUrl: '/app/templates/body/bodyRoot.html?' + new Date().getTime(),
    controller: function AppBodyController($scope, $http) {
      $scope.switchModule = function(v) {
        $scope.bodyModule = v;
      };
    },
    replace: true
  };
})
app.directive('appBodyApi', function() {
  return {
    templateUrl: '/app/templates/body/bodyApi.html?' + new Date().getTime(),
    controller: function AppBodyApiController($scope, $http) {
      $http.get("api/angularCode")
      .then(function(response) {
        $scope.angularCode = response.data;
      });
      $http.get("api/csCode")
      .then(function(response) {
        $scope.csCode = response.data;
      });
    },
    replace: true
  };
})
app.directive('appBodyDocument', function() {
  return {
    templateUrl: '/app/templates/body/bodyDocument.html?' + new Date().getTime(),
    replace: true
  };
})
app.controller('loadData', function($scope, $http) {
  $scope.bodyModule = 'api';
  $http.get("api/getContent")
  .then(function(response) {
    $scope.data = response.data;
  });
});