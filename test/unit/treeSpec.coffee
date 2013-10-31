describe 'angular-tree directive', ->
  beforeEach ->
    compileElement('<ul angular-tree><li ng-repeat="child in children" draggable="true">{{child.text}}</li></ul>')
    scope.$apply ->
      scope.children = (text: i for i in [0..4])


  describe 'moving children', ->
    beforeEach ->
      scope.$apply ->
        scope.from = scope.$new()
        scope.from.$index = 4

    describe 'above', ->
      beforeEach ->
        scope.$apply ->
          scope.position = 'above'


      it 'adds child above another', ->
        scope.$apply ->
          scope.to = scope.$new()
          scope.to.$index = 0

        expect(child.text for child in scope.children).toEqual [4, 0, 1, 2, 3]


    describe 'below', ->
      beforeEach ->
        scope.$apply ->
          scope.position = 'below'


      it 'adds child below another', ->
        scope.$apply ->
          scope.to = scope.$new()
          scope.to.$index = 0

        expect(child.text for child in scope.children).toEqual [0, 4, 1, 2, 3]


    describe 'to', ->
      beforeEach ->
        scope.$apply ->
          scope.position = 'to'


      it 'adds child to another', ->
        scope.$apply ->
          scope.to = scope.children[0]
          scope.to.$index = 0
          scope.to.child = children: []

        expect(child.text for child in scope.children).toEqual [0, 1, 2, 3]
        expect(child.text for child in scope.children[0].child.children).toEqual [4]
