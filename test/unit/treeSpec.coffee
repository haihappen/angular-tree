describe 'angular-tree directive', ->
  beforeEach ->
    scope.$apply ->
      scope.children = (value: i, children: [] for i in [0..4])
    compileElement('<ul angular-tree><li ng-repeat="child in children" draggable="true"></li></ul>')


  describe 'dragging an element', ->
    it 'sets from on scope', ->
      scope.$broadcast 'dragstart', scope.children, 4
      expect(scope.from).toEqual children: scope.children, index: 4
      expect(scope.to).toBeUndefined


    describe 'over another element', ->
      it 'sets to on scope', ->
        scope.$broadcast 'dragover', scope.children, 3
        expect(scope.to).toEqual children: scope.children, index: 3

        scope.$broadcast 'dragleave', scope.children, 3
        expect(scope.to).toBeUndefined


  describe 'dropping on another element', ->
    it 'does not move the element to itself', ->
      scope.$broadcast 'dragstart', scope.children, 2
      scope.$broadcast 'dragover', scope.children, 2
      scope.$broadcast 'drop'

      expect(scope.children).toEqual jsyaml.load '''
        - value: 0
          children: []
        - value: 1
          children: []
        - value: 2
          children: []
        - value: 3
          children: []
        - value: 4
          children: []
      '''


    it 'moves the element above the element', ->
      scope.$broadcast 'dragstart', scope.children, 2
      scope.$broadcast 'dragover', scope.children, 1
      scope.$broadcast 'drop'

      expect(scope.children).toEqual jsyaml.load '''
        - value: 0
          children: []
        - value: 2
          children: []
        - value: 1
          children: []
        - value: 3
          children: []
        - value: 4
          children: []
      '''


    it 'moves the last element above the first', ->
      scope.$broadcast 'dragstart', scope.children, 4
      scope.$broadcast 'dragover', scope.children, 0
      scope.$broadcast 'drop'

      expect(scope.children).toEqual jsyaml.load '''
        - value: 4
          children: []
        - value: 0
          children: []
        - value: 1
          children: []
        - value: 2
          children: []
        - value: 3
          children: []
      '''


    it 'moves the element below the element', ->
      scope.$broadcast 'dragstart', scope.children, 2
      scope.$broadcast 'dragover', scope.children, 3
      scope.$broadcast 'drop'

      expect(scope.children).toEqual jsyaml.load '''
        - value: 0
          children: []
        - value: 1
          children: []
        - value: 3
          children: []
        - value: 2
          children: []
        - value: 4
          children: []
      '''


    it 'moves the element inside another element', ->
      scope.$broadcast 'dragstart', scope.children, 2
      scope.$broadcast 'dragover', scope.children[3].children, 0
      scope.$broadcast 'drop'

      expect(scope.children).toEqual jsyaml.load '''
        - value: 0
          children: []
        - value: 1
          children: []
        - value: 3
          children:
            - value: 2
              children: []
        - value: 4
          children: []
      '''

      # It moves element out again
      scope.$broadcast 'dragstart', scope.children[2].children, 0
      scope.$broadcast 'dragover', scope.children, 2
      scope.$broadcast 'drop'

      expect(scope.children).toEqual jsyaml.load '''
        - value: 0
          children: []
        - value: 1
          children: []
        - value: 2
          children: []
        - value: 3
          children: []
        - value: 4
          children: []
      '''
