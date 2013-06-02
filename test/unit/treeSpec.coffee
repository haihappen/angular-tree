describe 'directive', ->
  scope = element = null


  beforeEach module 'angularTree'
  beforeEach inject ($rootScope, $compile) ->
    scope = $rootScope.$new()
    element = $compile('<ul angular-tree><li ng-repeat="child in children" draggable="true">{{child.text}}</li></ul>')(scope)
    scope.children = (text: i for i in [0..4])


  describe 'moving', ->
    beforeEach ->
      scope.$apply ->
        scope.from = 4


    describe 'above', ->
      beforeEach ->
        scope.$apply ->
          scope.position = 'above'


      it 'adds child above another', ->
        scope.$apply ->
          scope.to = 0

        expect(child.text for child in scope.children).toEqual [4, 0, 1, 2, 3]


      it 'works with last element too', ->
        scope.$apply ->
          scope.from = 4
          scope.to = 4

        expect(child.text for child in scope.children).toEqual [0, 1, 2, 3, 4]


    describe 'below', ->
      beforeEach ->
        scope.$apply ->
          scope.position = 'below'


      it 'adds child below another', ->
        scope.$apply ->
          scope.to = 0

        expect(child.text for child in scope.children).toEqual [0, 4, 1, 2, 3]


      it 'works with first element too', ->
        scope.$apply ->
          scope.from = 0
          scope.to = 0

        expect(child.text for child in scope.children).toEqual [0, 1, 2, 3, 4]


    describe 'to', ->
      beforeEach ->
        scope.$apply ->
          scope.position = 'to'


      it 'adds child to another', ->
        scope.$apply ->
          scope.to = 0

        expect(child.text for child in scope.children).toEqual [0, 1, 2, 3]
        expect(child.text for child in scope.children[0].children).toEqual [4]
