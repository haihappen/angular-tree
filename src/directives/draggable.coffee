angular.module('angularTree').directive 'draggable', ($compile, mousePosition) ->
  restrict: 'A'

  # controller: ($scope) ->
  # $scope.$watch 'y', ->
  #   $rootScope.position = switch
  #     when $scope.y < $scope.top + $scope.height * 0.25 then 'above'
  #     when $scope.y < $scope.top + $scope.height * 0.75 then 'to'
  #     when $scope.y < $scope.top + $scope.height then 'below'

  link: (scope, element) ->
    scope.children = scope.child.children

    scope.$watchCollection 'children', (children) ->
      return unless children?.length

      template = angular.element(scope.template)
      $compile(template)(scope)
      element.append template

    parent = scope.$parent

    element.on 'dragstart', (e) ->
      scope.$emit 'dragstart', parent.children, parent.children.indexOf(scope.child)

      element.addClass 'dragging'
      e.stopPropagation()


    element.bind 'dragover', (e) ->
      scope.$emit 'dragover', parent.children, parent.children.indexOf(scope.child)

      # e.dataTransfer.dropEffect = 'move'

      # Required to get the drop event to work. Otherwise the browser will ignore it.
      e.preventDefault()
      e.stopPropagation()


    element.on 'drop', (e) ->
      scope.$emit 'drop'

      element.removeClass 'dragging'
      e.stopPropagation()




      # element.bind 'dragover', (e) ->
      #   e.dataTransfer.dropEffect = 'move'
      #   $rootScope.$apply ->
      #     $rootScope.current = scope.child

      #   scope.$apply ->
      #     scope.top    = element[0].offsetTop
      #     scope.height = element[0].offsetHeight
      #     scope.y      = e.clientY

      #   e.stopPropagation()

      #   # Required to get the drop event to work. Otherwise the browser will ignore it.
      #   e.preventDefault()

      # element.bind 'dragleave', ->
      #   element.removeClass 'dragging'
      #   $rootScope.$apply ->
      #     $rootScope.current = null
