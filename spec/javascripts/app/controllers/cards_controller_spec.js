describe("cardsCtrl", function() {

  describe("initialization", function() {
    var scope      = null,
        controller = null;

    beforeEach(module("app"));

    beforeEach(inject(function ($controller, $rootScope) {
      scope = $rootScope.$new();
      controller = $controller("cardsCtrl", {
        $scope: scope
      });
    }));

    it("defaults to an empty card list", function() {
      expect(scope.cards).toEqualData([]);
    });

  });

  describe("Getting Search Results", function() {
    var scope       = null,
        controller  = null,
        httpBackend = null,
        serverResults = [
          {
            id: 1,
            multiverse_id: 102,
            name: "Counterspell",
          },
          {
            id: 2,
            multiverse_id: 103,
            name: "Fireball",
          },
        ];

    beforeEach(module("app"));

    beforeEach(inject(function ($controller, $rootScope, $httpBackend) {
      scope       = $rootScope.$new();
      httpBackend = $httpBackend;
      controller  = $controller("cardsCtrl", {
        $scope: scope
      });
    }));


    beforeEach(function() {
      httpBackend.when('GET',
                       '/api/v1/cards.json?name=Counterspell&page=0').
                  respond(serverResults);
    })

    it("populates the card list with the results", function() {
      scope.search("Counterspell");
      httpBackend.flush();
      expect(scope.cards).toEqualData(serverResults);
    });
  });
});
