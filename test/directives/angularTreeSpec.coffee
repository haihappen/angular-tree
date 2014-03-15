describe 'angularTree directive', ->
  outline = (children = scope.children) ->
    out = []
    for child in children
      out.push child.value
      out.push outline(child.children) if child.children.length
    out


  beforeEach ->
    compileElement '<ul angular-tree><li ng-repeat="child in children" draggable="true"></li></ul>'
    scope.$apply ->
      scope.children = (value: i, children: [] for i in [0..4])


  describe 'dragging an element', ->
    it 'sets from and to on scope', ->
      scope.$emit 'dragstart', scope.children, 1
      expect(scope.from).toEqual children: scope.children, index: 1
      expect(scope.to).toBeUndefined()

      scope.$emit 'dragover', scope.children, 0
      expect(scope.to).toEqual children: scope.children, index: 0

      scope.$emit 'dragleave', scope.children, 0
      expect(scope.to).toBeUndefined()


  describe 'dropping on another element', ->
    it 'does not move the element to itself', ->
      scope.$emit 'dragstart', scope.children, 1
      scope.$emit 'dragover', scope.children, 1
      scope.$emit 'drop'

      expect(outline()).toEqual [0..4]


    it 'moves the element above the element', ->
      scope.$emit 'dragstart', scope.children, 2
      scope.$emit 'dragover', scope.children, 1
      scope.$emit 'drop'

      expect(outline()).toEqual [0, 2, 1, 3, 4]


    it 'moves the last element above the first element', ->
      scope.$emit 'dragstart', scope.children, 1
      scope.$emit 'dragover', scope.children, 0
      scope.$emit 'drop'

      expect(outline()).toEqual [1, 0, 2, 3, 4]


    it 'moves the element below the element', ->
      scope.$emit 'dragstart', scope.children, 1
      scope.$emit 'dragover', scope.children, 2
      scope.$emit 'drop'

      expect(outline()).toEqual [0, 2, 1, 3, 4]


    it 'moves the element below the last element', ->
      scope.$emit 'dragstart', scope.children, 1
      scope.$emit 'dragover', scope.children, 4
      scope.$emit 'drop'

      expect(outline()).toEqual [0, 2, 3, 4, 1]


    it 'moves the element inside another element', ->
      scope.$emit 'dragstart', scope.children, 1
      scope.$emit 'dragover', scope.children[2].children, 0
      scope.$emit 'drop'

      expect(outline()).toEqual [0, 2, [1], 3, 4]


    it 'does not move the element into itself', ->
      scope.$apply ->
        scope.children[2] = value: 2, children: [value: 2.1, children: []]

      scope.$emit 'dragstart', scope.children, 2
      scope.$emit 'dragover', scope.children[2].children, 0
      scope.$emit 'drop'

      expect(outline()).toEqual [0, 1, 2, [2.1], 3, 4]
