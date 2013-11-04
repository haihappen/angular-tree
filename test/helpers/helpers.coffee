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
