(function() {
  "use strict";

  angular.module("app").controller("battlefieldCtrl", function($scope, $http) {

    Pusher.log = function(message) {
      if (window.console && window.console.log) {
        window.console.log(message);
      }
    };

    $scope.setBattlefield = function(userId, opponentId) {
      $scope.userId = userId;
      $scope.opponentId = opponentId;

      channel.bind('place_land' + $scope.opponentId, function(data) {
        // alert("Whoa!");
      $scope.opponentLands.push(data.card)
      // console.log(data.card);
      });
    };

    var pusher = new Pusher('2187084e7089c4797e05');
    var channel = pusher.subscribe('test_channel');



    $http.get("/api/v1/decks.json").then(function (response) {
      $scope.decks = response.data;
      $scope.deck = $scope.decks[0];
    });

    $scope.hand = [];
    $scope.permanents = [];
    $scope.lands = [];
    $scope.stackSpells = [];
    $scope.graveyard = [];

    $scope.opponentLands = [];
    $scope.opponentPermanents = [];
    $scope.opponentHand = [];
    $scope.opponentGraveyard = [];

    $scope.drawCard = function() {
      $scope.hand.push($scope.deck.cards[0]);
      $scope.deck.cards.splice(0, 1);
    }

    $scope.cast = function(card) {
      if (card.card_type === "Basic Land") {
        $http.post("/api/v1/place_land.json", {card: card, user_id: $scope.userId }).then(function (response) {
        }, function (error) {
          $scope.error = error.statusText;
        });
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

    window.scope = $scope;

  });
}());