(function() {
  "use strict";

  angular.module("app").controller("cardsCtrl", function($scope, $http){

    $scope.init = function(user_id, deck_id) {
      $scope.userId = user_id;
      $scope.error = null;
    };

    $scope.cards = [];

    var page = 0;

    $scope.search = function(searchTerm) {
      if (searchTerm.length < 3) {
        return;
      }
      $scope.error = null;  // reset error message
      var params = {};
      var searchKey = searchTerm.match(/^\d*$/) ? "multiverse_id" : "name";
      params[searchKey] = searchTerm;
      params["page"] = page;
      $http.get("/api/v1/cards.json", { "params": params }
        ).then(function (response) {
          $scope.cards = Array.prototype.concat(response.data);
        }, function (error) {
          $scope.error = error.statusText;
        });

      $scope.searchTerm = null;
    }

    $scope.previousPage = function() {
      if (page > 0) {
        page--;
        $scope.search($scope.keywords);
      }
    }

    $scope.nextPage = function() {
      page++;
      $scope.search($scope.keywords);
    }

    window.scope = $scope;
  });
}());
