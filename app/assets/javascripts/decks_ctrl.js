(function() {
  "use strict";

  angular.module("app").controller("decksCtrl", function($scope, $http){

    $scope.hand = [];

    $http.get("/api/v1/decks.json").then(function (response) {
      $scope.decks = response.data;
      $scope.deck = $scope.decks[0];
    });

    $scope.drawCard = function() {
      $scope.hand.push($scope.deck.cards[0]);
      $scope.deck.cards.splice(0, 1);
    }

    window.scope = $scope;

  });
}());