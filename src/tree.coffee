angular.module 'angularTree', []

angular.module('angularTree').directive 'angularTree', ->
  restrict: 'A'

  controller: ($scope) ->
    $scope.$watch 'to', (to) ->
      return unless to?
      return if $scope.position != 'to' and to == $scope.from

      child = $scope.children.splice($scope.from, 1)[0]
      switch $scope.position
        when 'above'
          $scope.children.splice to, 0, child
        when 'below'
          $scope.children.splice to + 1, 0, child
        when 'to'
          ($scope.children[to].children ||= []).push child

  compile: (element) ->
    template = element.clone()
    template.removeAttr 'ng-init'

    (scope) ->
      scope.template = template[0].outerHTML

angular.module('angularTree').directive 'draggable', ($compile) ->
    restrict: 'A'

    controller: ($scope) ->
      $scope.$watch 'y', ->
        $scope.$parent.position = switch
          when $scope.y < $scope.top + $scope.height * 0.25 then 'above'
          when $scope.y < $scope.top + $scope.height * 0.75 then 'to'
          when $scope.y < $scope.top + $scope.height then 'below'

    link: (scope, element) ->
      scope.$watch 'children', (children) ->
        return unless children?

        template = angular.element(scope.template)
        $compile(template)(scope)
        element.append template

      scope.children = scope.child.children

      element.bind 'dragstart', ->
        scope.$apply ->
          scope.$parent.from = scope.$index
          scope.$parent.to = null

      element.bind 'drop', ->
        scope.$apply ->
          scope.$parent.current = null
          scope.$parent.to = scope.$index

      element.bind 'dragover', (e) ->
        scope.$apply ->
          scope.$parent.current = scope.$index

          scope.top    = element[0].offsetTop
          scope.height = element[0].offsetHeight
          scope.y      = e.clientY

        # Required to get the drop event to work. Otherwise the browser will ignore it.
        e.preventDefault()
        e.stopPropagation()

      element.bind 'dragleave', ->
        scope.$apply ->
          scope.$parent.current = null


