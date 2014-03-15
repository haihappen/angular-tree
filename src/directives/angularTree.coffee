angular.module('angularTree').directive 'angularTree', ->
  restrict: 'A'

  controller: ($scope) ->
    $scope.$on 'dragstart', (e, children, index) ->
      $scope.from = children: children, index: index
      e.stopPropagation()

    $scope.$on 'dragover', (e, children, index) ->
      $scope.to = children: children, index: index
      e.stopPropagation()

    $scope.$on 'dragleave', (e) ->
      $scope.to = undefined
      e.stopPropagation()


    $scope.$on 'drop', (e, direction) ->
      $scope.$apply ->
        # Don't allow dragging into itself
        unless $scope.from.children[$scope.from.index].children == $scope.to.children
          draggable = $scope.from.children.splice($scope.from.index, 1)[0]
          $scope.to.children.splice $scope.to.index, 0, draggable
      e.stopPropagation()


  compile: (element) ->
    template = element.clone()[0].outerHTML

    link = (scope) ->
      scope.template = template
