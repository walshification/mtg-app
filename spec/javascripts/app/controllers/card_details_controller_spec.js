describe("CardDetailsController", function() {

  describe("Initialization", function() {

    var scope = null,
    controller = null,
    id = 42,
    httpBackend = null,
    card = {
      id: id,
      name: "Counterspell",
      multiverse_id: "102"
    };

    beforeEach(module("app"));

    beforeEach(inject(function ($controller,
                                $rootScope,
                                $routeParams,
                                $httpBackend) {
      scope           = $rootScope.$new();
      httpBackend     = $httpBackend;
      $routeParams.id = id;

      httpBackend.when('GET','/api/v1/cards/' + id + '.json').
                  respond(card);
      controller = $controller("CardDetailsController", {
        $scope: scope
      });
    }));

    it("fetches the card from the back-end", function() {
      httpBackend.flush();
      expect(scope.card).toEqual(card);
    });
  });
});
