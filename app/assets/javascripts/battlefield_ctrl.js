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

      $http.get("/api/v1/decks.json").then(function (response) {
        $scope.decks = response.data;
        $scope.deck = $scope.decks[0];
      });

      channel.bind('place_land' + $scope.opponentId, function(data) {
        $scope.opponentLands.push(data.card);
        $scope.opponentHand.splice($scope.hand.indexOf({card: 1}), 1);
        $scope.$apply();
      });

      channel.bind('cast_spell' + $scope.opponentId, function(data) {
        $scope.stackSpells.push(data.card);
        $scope.opponentHand.splice($scope.hand.indexOf({card: 1}), 1);
        $scope.$apply();
      });

      channel.bind('resolve_permanent' + $scope.opponentId, function(data) {
        $scope.opponentPermanents.push(data.card);
        $scope.stackSpells.splice($scope.stackSpells.indexOf(data.card), 1);
        $scope.$apply();
      });

      channel.bind('resolve_nonpermanent' + $scope.opponentId, function(data) {
        $scope.opponentGraveyard.push(data.card);
        $scope.stackSpells.splice($scope.stackSpells.indexOf(data.card), 1);
        $scope.$apply();
      });

      channel.bind('tap_card' + $scope.opponentId, function(data) {
        var card;
        if ((data.card.card_type === "Land") || (data.card.card_type === "Basic Land")) {
          for (var i = 0; i < $scope.opponentLands.length; i++) {
            if($scope.opponentLands[i].card_name === data.card.card_name) {
              card = $scope.opponentLands[i];
            }
          }
        } else {
          for (var i = 0; i < $scope.opponentPermanents.length; i++ ) {
            if ($scope.opponentPermanents[i].card_name === data.card.card_name) {
              card = $scope.opponentPermanents[i];
            }
          }
        }
        card.tapped = !card.tapped;
        $scope.$apply();
      });

      channel.bind('opponent_draw' + $scope.opponentId, function(data) {
        $scope.opponentHand.push({card: 1});
        $scope.$apply();
      });

      channel.bind('send_land_to_graveyard' + $scope.opponentId, function(data) {
        $scope.opponentGraveyard.push(data.card);
        $scope.opponentLands.splice($scope.opponentLands.indexOf(data.card), 1);
        $scope.$apply();
      });

      channel.bind('decrease_opponent_life' + $scope.opponentId, function(data) {
        $scope.opponentLifeCount--;
        $scope.$apply();
      });

      channel.bind('send_permanent_to_graveyard' + $scope.opponentId, function(data) {
        $scope.opponentGraveyard.push(data.card);
        $scope.opponentPermanents.splice($scope.opponentPermanents.indexOf(data.card), 1);
        $scope.$apply();
      });

    };

    var pusher = new Pusher('2187084e7089c4797e05');
    var channel = pusher.subscribe('test_channel');

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
      $http.post("/api/v1/opponent_draw.json", {user_id: $scope.userId}).then(function (response) {
        }, function (error) {
          $scope.error = error.statusText;
        });
      $scope.hand.push($scope.deck.cards[0]);
      $scope.deck.cards.splice(0, 1);
    }

    $scope.cast = function(card) {
      if (card.card_type === "Basic Land" || card.card_type === "Land") {
        $http.post("/api/v1/place_land.json", {card: card, user_id: $scope.userId }).then(function (response) {
        }, function (error) {
          $scope.error = error.statusText;
        });
          $scope.lands.push(card);
      } else {
        $http.post("/api/v1/cast_spell.json", {card: card, user_id: $scope.userId }).then(function (response) {
        }, function (error) {
          $scope.error = error.statusText;
        });
          $scope.stackSpells.push(card);
      }
      $scope.hand.splice($scope.hand.indexOf(card), 1);
    }

    $scope.tap = function(card, $event) {
      if (($event.shiftKey == 1) && ((card.card_type === "Land") || (card.card_type === "Basic Land")) ){
        $http.post("/api/v1/send_land_to_graveyard.json", {card: card, user_id: $scope.userId }).then(function (response) {
        }, function (error) {
          $scope.error = error.statusText;
        });
          $scope.graveyard.push(card);
          $scope.lands.splice($scope.lands.indexOf(card), 1);
      } else if ($event.shiftKey == 1) {
        $http.post("/api/v1/send_permanent_to_graveyard.json", {card: card, user_id: $scope.userId }).then(function (response) {
        }, function (error) {
          $scope.error = error.statusText;
        });
          $scope.graveyard.push(card);
          $scope.permanents.splice($scope.permanents.indexOf(card), 1);
      } else {
        $http.post("/api/v1/tap_card.json", {card: card, user_id: $scope.userId }).then(function (response) {
        }, function (error) {
          $scope.error = error.statusText;
        });
          card.tapped = !card.tapped;
      }
    }

    $scope.opponentLife = function() {
      return $scope.opponentLifeCount;
    }

    $scope.opponentLifeCount = 20;
    $scope.playerLifeCount = 20;

    $scope.playerLife = function() {
      return $scope.playerLifeCount;
    }

    $scope.decreaseLife = function() {
      $http.post("/api/v1/decrease_opponent_life.json", {user_id: $scope.userId}).then(function (response) {
        }, function (error) {
          $scope.error = error.statusText;
        });
          $scope.playerLifeCount--;
    }

    $scope.resolve = function(card) {
      if ((card.card_type === "Creature") || (card.card_type === "Enchantment") || (card.card_type === "Legendary Creature") || (card.card_type === "Legendary Artifact Creature")) {
        $http.post("/api/v1/resolve_permanent.json", {card: card, user_id: $scope.userId }).then(function (response) {
        }, function (error) {
          $scope.error = error.statusText;
        });
          $scope.permanents.push(card);
          $scope.stackSpells.splice($scope.stackSpells.indexOf(card), 1);
      } else {
        $http.post("/api/v1/resolve_nonpermanent.json", {card: card, user_id: $scope.userId }).then(function (response) {
        }, function (error) {
          $scope.error = error.statusText;
        });
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

    $scope.activeStep = function() {

    }

    window.scope = $scope;

  });
}());