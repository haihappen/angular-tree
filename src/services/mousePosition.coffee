angular.module('angularTree').service 'mousePosition', ($window) ->
  [clientX, clientY] = [0, 0]

  angular.element($window).bind 'mousemove', (e) ->
    [clientX, clientY] = [e.clientX, e.clientY]

  getRelativeLeft: (element = $window.document.body) ->
    element = angular.element(element)

    if element[0].offsetLeft < clientX < element[0].offsetLeft + element[0].offsetWidth
      clientX - element[0].offsetLeft


  getRelativeLeftPercent: (element = $window.document.body) ->
    element = angular.element(element)
    relativeLeft = @getRelativeLeft(element)

    relativeLeft && Math.round(relativeLeft / element[0].offsetWidth * 100)


  getRelativeTop: (element = $window.document.body) ->
    element = angular.element(element)

    if element[0].offsetTop < clientY < element[0].offsetTop + element[0].offsetHeight
      clientY - element[0].offsetTop


  getRelativeTopPercent: (element = $window.document.body) ->
    element = angular.element(element)
    relativeTop = @getRelativeTop(element)

    relativeTop && Math.round(relativeTop / element[0].offsetHeight * 100)
