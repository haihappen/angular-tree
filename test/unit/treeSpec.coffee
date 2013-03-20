describe 'Tree', ->
  beforeEach module 'Tree'

  describe 'treeCtrl', ->
    scope = null

    beforeEach inject ($rootScope, $controller) ->
      scope = $rootScope.$new()
      ctrl = $controller('treeCtrl', $scope: scope)

    describe 'start', ->
      beforeEach ->
        scope.start(100, 200)

      it 'sets x and y', ->
        expect(scope._start.x).toEqual 100
        expect(scope._start.y).toEqual 200

    describe 'end', ->
      beforeEach ->
        scope.end(100, 200)

      it 'sets x and y', ->
        expect(scope._end.x).toEqual 100
        expect(scope._end.y).toEqual 200
