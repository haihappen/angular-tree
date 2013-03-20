Tree = angular.module 'Tree', []

Tree.controller 'treeCtrl', ($scope) ->
  $scope.start = (x, y) ->
    $scope._start = x: x, y: y
  
  $scope.end = (x, y) ->
    $scope._end = x: x, y: y
  
  $scope.length = ->
    [$scope._end.x - $scope._start.x, $scope._end.y - $scope._start.y]
  
  $scope.angle = (x, y) ->
    Math.atan2(y, x)
  
  $scope.inRad = (angle, point, window = 0.3) ->
    point + window > angle and point - window < angle
  
  $scope.direction = ->
    [x, y] = $scope.length()
    
    console.log $scope._direction
    
    # return $scope._direction if $scope._direction and (Math.abs(x) < 100 || Math.abs(y) < 100)
    
    console.log x, y
    
    angle = $scope.angle(x, y)
    
    console.log angle
    
    $scope._direction = switch
      when $scope.inRad(angle, Math.PI / -2) then 'up'
      when $scope.inRad(angle, 0) or $scope.inRad(angle, Math.PI * 2) then 'right'
      when $scope.inRad(angle, Math.PI / 2) then 'down'
      when $scope.inRad(angle, Math.PI) then 'left'
      else $scope._direction


Tree.directive 'draggable', ($timeout) ->
  link: (scope, element) ->
    element.bind 'dragstart', (e) ->
      scope.$apply ->
        scope.start e.clientX, e.clientY

    element.bind 'drop', (e) ->
      # element.parent().prepend scope.element.remove()

    element.bind 'dragover', (e) ->
      scope.$apply ->
        scope.end e.clientX, e.clientY
        
        element.parent().children().removeClass('up down right left')
        element.addClass scope.direction()
        
        $timeout.cancel scope.promise
        scope.promise = $timeout ->
          scope.start e.clientX, e.clientY
          , 250

      e.preventDefault()
