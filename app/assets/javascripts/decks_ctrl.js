(function() {
  "use strict";

  angular.module("app").controller("decksCtrl", function($scope, $http){

  Pusher.log = function(message) {
    if (window.console && window.console.log) {
      window.console.log(message);
    }
  };

  var pusher = new Pusher('2187084e7089c4797e05');
  var channel = pusher.subscribe('test_channel');
  channel.bind('my_event', function(data) {
    alert(data.message);
  });

    $scope.setUser = function(id) {
      $scope.userId = id;
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

    $scope.hand = [];
    $scope.permanents = [];
    $scope.lands = [];
    $scope.stackSpells = [];
    $scope.graveyard = [];

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

    $scope.shuffle = function() {
      var currentIndex = $scope.deck.cards.length;
      var temp;
      var randomIndex;

      // While there remain elements to shuffle…
      while (currentIndex) {

        // Pick a remaining element…
        randomIndex = Math.floor(Math.random() * currentIndex--);

        // And swap it with the current element.
        temp = $scope.deck.cards[currentIndex];
        $scope.deck.cards[currentIndex] = $scope.deck.cards[randomIndex];
        $scope.deck.cards[randomIndex] = temp;
      }

      return $scope.deck;
    }

    $scope.card_groups = {
      "Artifacts" => [],
      "Creatures" => [],
      "Enchantments" => [],
      "Instants" => [],
      "Basic Lands" => [],
      "Planeswalkers" => [],
      "Sorceries" => []
    }

    window.scope = $scope;

  });
}());