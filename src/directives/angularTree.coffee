angular.module('angularTree').directive 'angularTree', ->
  restrict: 'A'

  controller: ($scope) ->
    $scope.$on 'dragstart', (_, children, index) ->
      $scope.from = children: children, index: index

    $scope.$on 'dragover', (_, children, index) ->
      $scope.to = children: children, index: index

    $scope.$on 'dragleave', ->
      $scope.to = undefined

    $scope.$on 'drop', (_, direction) ->
      $scope.to.children.splice $scope.to.index, 0, $scope.from.children.splice($scope.from.index, 1)[0]

  compile: (element) ->
    (scope) ->
      scope.template = element.clone().outerHTML
