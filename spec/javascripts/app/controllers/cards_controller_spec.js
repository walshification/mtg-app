describe("cardsCtrl", function() {

  describe("initialization", function() {

    var scope = null,
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
});
