describe 'draggable directive', ->
  beforeEach ->
    compileElement '<ul angular-tree><li ng-repeat="child in children" draggable="true">{{child.value}}</li></ul>'
    scope.$apply ->
      scope.children = (value: "#{i}", children: [] for i in [0..4])


  it 'compiles to list', ->
    expect(element.find('li').length).toEqual 5


  it 'compiles to nested list', ->
    childScope = angular.element(element.find('li')[1]).scope()

    childScope.$apply ->
      childScope.children = (value: "1.#{i}", children: [] for i in [0..1])

    expect(element.find('li').length).toEqual 7
    expect(element.find('ul').find('li').length).toEqual 2


  it 'watches children', ->
    draggable = null

    # Remove last element
    scope.$apply ->
      draggable = scope.children.pop()

    expect(element.find('li').length).toEqual 4
    expect(element.find('ul').length).toEqual 0

    # Drop on first element
    scope.$apply ->
      scope.children[0].children.push draggable

    expect(element.find('li').length).toEqual 5
    expect(element.find('ul').length).toEqual 1
    expect(element.find('ul').find('li').length).toEqual 1


  it 'emits dragstart event', ->
    spyOn scope, '$emit'
    simulate element.find('li')[1], 'dragstart'

    expect(scope.$emit).toHaveBeenCalledWith 'dragstart', scope.children, 1


  it 'emits dragover event', ->
    spyOn scope, '$emit'
    simulate element.find('li')[0], 'dragover'

    expect(scope.$emit).toHaveBeenCalledWith 'dragover', scope.children, 0


  it 'emits drop event', ->
    spyOn scope, '$emit'
    simulate element.find('li')[1], 'dragstart'
    simulate element.find('li')[0], 'drop'

    expect(scope.$emit).toHaveBeenCalledWith 'drop'
