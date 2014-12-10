(function() {
  "use strict";

  angular.module("app").controller("decksCtrl", function($scope, $http){

    $scope.hand = [];
    $scope.permanents = [];
    $scope.lands = [];
    $scope.stackSpells = [];
    $scope.graveyard = [];

    $http.get("/api/v1/decks.json").then(function (response) {
      $scope.decks = response.data;
      $scope.deck = $scope.decks[0];
    });

    $scope.drawCard = function() {
      $scope.hand.push($scope.deck.cards[0]);
      $scope.deck.cards.splice(0, 1);
    }

    $scope.cast = function(card) {
      if (card.card_type === "Basic Land") {
        $scope.lands.push(card);
      } else {
        $scope.stackSpells.push(card);
      }
      $scope.hand.splice($scope.hand.indexOf(card), 1);
    }

    $scope.tap = function(card) {
      card.tapped = !card.tapped;
    }

    $scope.resolve = function(card) {
      if ((card.card_type === "Creature") || (card.card_type === "Enchantment") || (card.card_type === "Legendary Creature") || (card.card_type === "Legendary Artifact Creature")) {
        $scope.permanents.push(card);
        $scope.stackSpells.splice($scope.stackSpells.indexOf(card), 1);
      } else {
        $scope.graveyard.push(card);
        $scope.stackSpells.splice($scope.stackSpells.indexOf(card), 1);
      }
    }

    $scope.shuffle = function(deck) {
      var m = deck.length, t, i;

      // While there remain elements to shuffle…
      while (m) {

        // Pick a remaining element…
        i = Math.floor(Math.random() * m--);

        // And swap it with the current element.
        t = deck[m];
        deck[m] = deck[i];
        deck[i] = t;
      }

      return deck;
    }

    window.scope = $scope;

  });
}());