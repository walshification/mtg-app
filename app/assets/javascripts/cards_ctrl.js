(function() {
  "use strict";

  var app = angular.module("app")

  app.controller("cardsCtrl", function($scope, $http, $location) {

    var page = 0;
    $scope.cards = [];

    $scope.init = function(user_id, deck_id) {
      $scope.userId = user_id;
      $scope.error = null;
    };

    $scope.viewDetails = function(card) {
      $location.path("/" + card.id);
    }

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

  app.controller("CardDetailsController",
                 function($scope , $http , $routeParams) {
    var cardId = $routeParams.id;
    $scope.card = {};
    $http.get(
      "/api/v1/cards/" + cardId + ".json"
    ).then(function(response) {
      $scope.card = response.data;
    },function(response) {
      alert("There was a problem: " + response.status);
    });
  });

}());
