(function() {
  "use strict";

  angular.module("app").controller("decksCtrl", function($scope, $http){

    $scope.getDecks = function(user_id) {
      $scope.userId = user_id;
      $http.get("/api/v1/decks.json").then(function(response) {
        $scope.decks = response.data;
      });
    };

    $scope.getDeck = function(user_id, deck_id) {
      $scope.userId = user_id;
      $scope.artifacts = [];
      $scope.conspiracies = [];
      $scope.creatures = [];
      $scope.enchantments = [];
      $scope.instants = [];
      $scope.lands = [];
      $scope.phenomenons = [];
      $scope.planes = [];
      $scope.planeswalkers = [];
      $scope.schemes = [];
      $scope.sorceries = [];
      $scope.tribals = [];
      $scope.vanguards = [];
      $scope.cardGroups = {
        "Artifact": $scope.artifacts,
        "Conspiracy": $scope.conspiracies,
        "Creature": $scope.creatures,
        "Enchantment": $scope.enchantments,
        "Instant": $scope.instants,
        "Land": $scope.lands,
        "Phenomenon": $scope.phenomenons,
        "Plane": $scope.planes,
        "Planeswalker": $scope.planeswalkers,
        "Scheme": $scope.schemes,
        "Sorcery": $scope.sorceries,
        "Tribal": $scope.tribals,
        "Vanguard": $scope.vanguards,
      };

      $http.get("/api/v1/decks/" + deck_id + ".json").then(function(response) {
        $scope.deck = response.data;
        $scope.sortCardsByType($scope.deck["cards"]);
      });
    };

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
        .then(function (response) {
          console.log(response.data);
          newDeck['id'] = response.data.id;
        }, function (error) {
          console.log(error)
          $scope.error = error.statusText;
        });

      $scope.decks.push(newDeck);
      $scope.newDeckName = "";
      $scope.newDeckColors = "";
      $scope.newDeckType = "";
      $scope.newDeckFormat = "";
    };

    // $scope.addCard = function(searchTerm) {
    //   $scope.error = null;  // reset error message
    //   var params = {};
    //   var searchKey = searchTerm.match(/^\d*$/) ? "multiverse_id" : "name";
    //   params[searchKey] = searchTerm;
    //   $http.post("/api/v1/cards.json", { "params": params }
    //     ).then(function (response) {
    //       $scope.deck.cards.push(response.data[-1])
    //       $scope.sortCardsByType($scope.deck.cards);
    //     }, function (error) {
    //       $scope.error = error.statusText;
    //     });
    //
    //   $scope.searchTerm = null;
    // }

    $scope.sortCardByType = function(card) {
      $scope.cardGroups[card.card_type].push(card);
    }

    $scope.sortCardsByType = function(cards) {
      for (var i = 0; i < cards.length; i++) {
        $scope.sortCardByType(cards[i]);
      }
    }

    $scope.galleryCard = function(cardImage) {
      $scope.cardImageInGallery = cardImage;
    }

    window.scope = $scope;

  });
}());
