describe 'directive', ->
  scope = element = null


  beforeEach module 'angularTree'
  beforeEach inject ($rootScope, $compile) ->
    scope = $rootScope.$new()
    element = $compile('<ul angular-tree><li ng-repeat="child in children" draggable="true">{{child.text}}</li></ul>')(scope)


  it 'compiles to ul', ->
    scope.$apply ->
      scope.children = [{ text: 2 }, { text: 3 }]
    expect(element.text()).toMatch '23'

    scope.$apply ->
      scope.children.push text: 4
    expect(element.text()).toMatch '234'

    scope.$apply ->
      scope.children.unshift text: 1
    expect(element.text()).toMatch '1234'


  it 'compiles to nested ul', ->
    scope.$apply ->
      scope.children = [{ text: 2, children: [ { text: 21 }, { text: 22 }] }, { text: 3 }]
    expect(element.text()).toMatch '221223'

    scope.$apply ->
      scope.children.push text: 4, children: [text: 41]
    expect(element.text()).toMatch '221223441'

    scope.$apply ->
      scope.children.unshift text: 1, children: [text: 11]
    expect(element.text()).toEqual '111221223441'

