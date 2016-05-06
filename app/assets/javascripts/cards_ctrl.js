(function() {
  "use strict";

  angular.module("app").controller("cardsCtrl", function($scope, $http){

    $scope.init = function(user_id, deck_id) {
      $scope.userId = user_id;
      $scope.cards = [];
      $scope.error = null;
    };

    $scope.search = function(searchTerm) {
      $scope.error = null;  // reset error message
      var params = {};
      var searchKey = searchTerm.match(/^\d*$/) ? "multiverse_id" : "name";
      params[searchKey] = searchTerm;
      $http.get("/api/v1/cards.json", { "params": params }
        ).then(function (response) {
          $scope.cards = Array.prototype.concat(response.data);
        }, function (error) {
          $scope.error = error.statusText;
        });

      $scope.searchTerm = null;
    }

    window.scope = $scope;
  });
}());
