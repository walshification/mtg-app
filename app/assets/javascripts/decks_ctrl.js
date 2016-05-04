(function() {
  "use strict";

  angular.module("app").controller("decksCtrl", function($scope, $http){

    $scope.init = function(user_id, deck_id) {
      $scope.userId = user_id;
      $http.get("/api/v1/decks/" + deck_id + ".json").then(function (response) {
        $scope.deck = response.data;
        $scope.sortByType($scope.deck["cards"]);
      });
    };

    $scope.search = function(searchTerm) {
      $scope.searchedFor = searchTerm;
    }

    $scope.createDeck = function (newDeckName, newDeckColors,
                                  newDeckType, newDeckFormat) {
      var newDeck = {
        name: newDeckName,
        color: newDeckColors,
        deck_type: newDeckType,
        legal_format: newDeckFormat,
        user_id: $scope.userId
      };
      $http.post("/api/v1/decks.json", {deck: newDeck})
        .then(function (response) {}, function (error) {
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
        case "Artifact Creature":
        case "Legendary Creature":
        case "Legendary Artifact Creature":
          $scope.cardGroups["Creatures"].push(cards[i]);
          break;
        case "Enchantment":
          $scope.cardGroups["Enchantments"].push(cards[i]);
          break;
        case "Instant":
          $scope.cardGroups["Instants"].push(cards[i]);
          break;
        case "Basic Land":
        case "Land":
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
