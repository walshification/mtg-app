(function() {
  "use strict";

  var app = angular.module("app", [
    "ngAnimate",
    "ngRoute",
    "templates",
    ]
  );

  app.config([
    "$routeProvider",
    function($routeProvider) {
      $routeProvider.when("/", {
        controller: "cardsCtrl",
        templateUrl: "card_search.html",
      }).when("/:id", {
        controller: "CardDetailsController",
        templateUrl: "card_detail.html",
      });
    }
  ]);

}());
