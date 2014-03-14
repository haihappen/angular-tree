element = scope = $compile = null

beforeEach module 'angularTree'
beforeEach inject ($injector, $rootScope) ->
  scope = $rootScope.$new()
  $compile = $injector.get('$compile')

@compileElement = (html) ->
  element = angular.element(html)
  $compile(element)(scope)
  element
