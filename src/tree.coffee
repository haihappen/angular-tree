angular.module 'angularTree', []

angular.module('angularTree').directive 'angularTree', ->
  restrict: 'A'

  controller: ($scope) ->
    childOf = (from, to) ->
      while to
        return true if from.$id == to.$id
        to = to.$parent
      false

    $scope.$watch 'to', ->
      return unless $scope.to?
      return if childOf($scope.from, $scope.to)

      child = $scope.from.$parent.children.splice($scope.from.$index, 1)[0]
      switch $scope.position
        when 'above'
          $scope.to.$parent.children.splice $scope.to.$index, 0, child
        when 'below'
          $scope.to.$parent.children.splice $scope.to.$index + 1, 0, child
        when 'to'
          $scope.to.child.children.push child

      delete $scope.to
      delete $scope.from

  compile: (element) ->
    template = element.clone()
    template.removeAttr 'ng-init'

    (scope) ->
      scope.template = template[0].outerHTML


angular.module('angularTree').directive 'draggable', ($compile, $rootScope) ->
    restrict: 'A'

    controller: ($scope) ->
      $scope.$watch 'y', ->
        $rootScope.position = switch
          when $scope.y < $scope.top + $scope.height * 0.25 then 'above'
          when $scope.y < $scope.top + $scope.height * 0.75 then 'to'
          when $scope.y < $scope.top + $scope.height then 'below'

    link: (scope, element) ->
      scope.children = scope.child.children ||= []

      scope.$watch 'children', (children) ->
        return unless children?
        return if children.length == 0

        template = angular.element(scope.template)
        $compile(template)(scope)
        element.append template

      element.bind 'dragstart', (e) ->
        $rootScope.$apply ->
          $rootScope.from = scope

        element.addClass 'dragging'
        e.stopPropagation()

      element.bind 'drop', (e) ->
        $rootScope.$apply ->
          $rootScope.to = scope
          $rootScope.current = null

        element.removeClass 'dragging'
        e.stopPropagation()

      element.bind 'dragover', (e) ->
        e.dataTransfer.dropEffect = 'move'
        $rootScope.$apply ->
          $rootScope.current = scope.child

        scope.$apply ->
          scope.top    = element[0].offsetTop
          scope.height = element[0].offsetHeight
          scope.y      = e.clientY

        e.stopPropagation()

        # Required to get the drop event to work. Otherwise the browser will ignore it.
        e.preventDefault()

      element.bind 'dragleave', ->
        element.removeClass 'dragging'
        $rootScope.$apply ->
          $rootScope.current = null
