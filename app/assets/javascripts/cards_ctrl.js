(function() {
  "use strict";

  angular.module("app").controller("cardsCtrl", function($scope, $http){

    $scope.init = function(user_id, deck_id) {
      $scope.userId = user_id;
      $scope.cards = [];
      $scope.error = null;
    };

    $scope.search = function(searchTerm) {
      $http.get("/api/v1/cards.json", { "params": {"card_name": searchTerm } }
        ).then(function (response) {
          $scope.cards.push(response.data);
        }, function (error) {
          $scope.error = error.statusText;
        });

      $scope.searchTerm = "";
    }

    window.scope = $scope;
  });
}());
