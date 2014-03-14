describe 'draggable directive', ->
  beforeEach ->
    compileElement '<ul angular-tree><li ng-repeat="child in children" draggable="true">{{child.value}}</li></ul>'
    scope.$apply ->
      scope.children = (value: "#{i}", children: [] for i in [0..4])


  it 'compiles to list', ->
    expect(element.find('li').length).toEqual 5


  it 'compiles to nested list', ->
    scope.$apply ->
      scope.children = (value: i, children: [] for i in [0..4])
      scope.children[1].children = (value: "1.#{i}", children: [] for i in [0..1])

    # Find nested list
    expect(element.find('ul').length).toEqual 1
    expect(element.find('ul').find('li').length).toEqual 2


  it 'watches children', ->
    movedChild = null

    # Remove last element
    scope.$apply ->
      movedChild = scope.children.pop()

    expect(element.find('li').length).toEqual 4
    expect(element.find('ul').length).toEqual 0

    # Drop on first element
    scope.$apply ->
      scope.children[0].children.push movedChild

    expect(element.find('li').length).toEqual 5
    expect(element.find('ul').length).toEqual 1
    expect(element.find('ul').find('li').length).toEqual 1
