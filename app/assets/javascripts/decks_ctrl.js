(function() {
  "use strict";

  angular.module("app").controller("decksCtrl", function($scope, $http){

    $scope.setUser = function(id) {
      $scope.userId = id;
    };

    $scope.setDeck = function(id) {
      $http.get("/api/v1/decks/" + id + ".json").then(function (response) {
        $scope.currentDeck = response.data;
        $scope.sortByType($scope.currentDeck["cards"]);
      });
    };

    $http.get("/api/v1/decks.json").then(function (response) {
      $scope.decks = response.data;
      $scope.deck = $scope.decks[0];
    });

    $scope.createDeck = function (newDeckName, newDeckColors, newDeckType, newDeckFormat) {
      var newDeck = {
        name: newDeckName, 
        color: newDeckColors, 
        deck_type: newDeckType, 
        legal_format: newDeckFormat,
        user_id: $scope.userId
      };
      $http.post("/api/v1/decks.json", {deck: newDeck}).then(function (response) {

        }, function (error) {
          $scope.error = error.statusText;
        });

      $scope.decks.push(newDeck);
      $scope.newDeckName = "";
      $scope.newDeckColors = "";
      $scope.newDeckType = "";
      $scope.newDeckFormat = "";
    };

    $scope.cardGroups = {
      "Artifacts": [],
      "Creatures": [],
      "Enchantments": [],
      "Instants": [],
      "Lands": [],
      "Planeswalkers": [],
      "Sorceries": []
    }

    $scope.sortByType = function (cards) {
      for (var i = 0; i < cards.length; i++) {
        switch (cards[i].card_type) {
        case "Artifact":
          $scope.cardGroups["Artifacts"].push(cards[i]);
          break;
        case "Creature":
          $scope.cardGroups["Creatures"].push(cards[i]);
          break;
        case "Enchantment":
          $scope.cardGroups["Enchaments"].push(cards[i]);
          break;
        case "Instant":
          $scope.cardGroups["Instants"].push(cards[i]);
          break;
        case "Basic Land":
          $scope.cardGroups["Lands"].push(cards[i]);
          break;
        case "Planeswalker":
          $scope.cardGroups["Planeswalkers"].push(cards[i]);
          break;
        case "Sorcery":
          $scope.cardGroups["Sorceries"].push(cards[i]);
          break;
        }
      } 
    }

    $scope.cardImageInGallery;

    $scope.galleryCard = function(cardImage) {
      $scope.cardImageInGallery = cardImage;
    }

    window.scope = $scope;

  });
}());