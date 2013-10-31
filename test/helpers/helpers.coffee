element = scope = $compile = null

beforeEach module 'angularTree'
beforeEach inject ($injector, $rootScope) ->
  scope = $rootScope.$new()
  $compile = $injector.get('$compile')

beforeEach ->
  @addMatchers
    toHaveClass: (klass) ->
      angular.element(@actual).hasClass(klass)

    toInclude: (text) ->
      @actual.indexOf(text) > 0


@compileElement = (html) ->
  element = angular.element(html)
  $compile(element)(scope)
  element


@triggerEvent = (type, element = @element, eventOptions = {}, elementOptions = {}) ->
  event = document.createEvent('HTMLEvents')
  event.initEvent type

  element = angular.element(element)

  for key, value of eventOptions
    event[key] = value
  for key, value of elementOptions
    element[0][key] = value

  element[0].dispatchEvent event
