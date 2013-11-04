# describe 'angular-tree directive', ->
#   html = -> element[0].outerHTML

#   selector = (string) ->
#     new RegExp(string.replace(/((<\/?\w+))|</g, '$1.*').replace(/\n/g, '.*').replace(/\s/g, ''))


#   beforeEach ->
#     compileElement('<ul angular-tree><li ng-repeat="child in children" draggable="true">{{child.text}}</li></ul>')


#   it 'compiles to ul', ->
#     scope.$apply ->
#       scope.children = [{ text: 2 }, { text: 3 }]
#     expect(html()).toMatch selector """
#       <ul>
#         <li>2</li>
#         <li>3</li>
#       </ul>
#     """

#     scope.$apply ->
#       scope.children.push text: 4
#     expect(html()).toMatch selector """
#       <ul>
#         <li>2</li>
#         <li>3</li>
#         <li>4</li>
#       </ul>
#     """

#     scope.$apply ->
#       scope.children.unshift text: 1
#     expect(html()).toMatch selector """
#       <ul>
#         <li>1</li>
#         <li>2</li>
#         <li>3</li>
#         <li>4</li>
#       </ul>
#     """

#     scope.$apply ->
#       scope.children.splice(1, 2)
#     expect(html()).toMatch selector """
#       <ul>
#         <li>1</li>
#         <li>4</li>
#       </ul>
#     """


#   it 'compiles to nested ul', ->
#     scope.$apply ->
#       scope.children = [{ text: 2, children: [ { text: 21 }, { text: 22 }] }, { text: 3 }]
#     expect(html()).toMatch selector """
#       <ul>
#         <li>2
#           <ul>
#             <li>21</li>
#             <li>22</li>
#           </ul>
#         </li>
#         <li>3</li>
#       </ul>
#     """

#     scope.$apply ->
#       scope.children.push text: 4, children: [text: 41]
#     expect(html()).toMatch selector """
#       <ul>
#         <li>2
#           <ul>
#             <li>21</li>
#             <li>22</li>
#           </ul>
#         </li>
#         <li>3</li>
#         <li>4
#           <ul>
#             <li>41</li>
#           </ul>
#         </li>
#       </ul>
#     """

#     scope.$apply ->
#       scope.children.unshift text: 1, children: [text: 11]
#     expect(html()).toMatch selector """
#       <ul>
#         <li>1
#           <ul>
#             <li>11</li>
#           </ul>
#         </li>
#         <li>2
#           <ul>
#             <li>21</li>
#             <li>22</li>
#           </ul>
#         </li>
#         <li>3</li>
#         <li>4
#           <ul>
#             <li>41</li>
#           </ul>
#         </li>
#       </ul>
#     """

#     scope.$apply ->
#       scope.children.splice(1, 2)
#     expect(html()).toMatch selector """
#       <ul>
#         <li>1
#           <ul>
#             <li>11</li>
#           </ul>
#         </li>
#         <li>4
#           <ul>
#             <li>41</li>
#           </ul>
#         </li>
#       </ul>
#     """




#     # describe 'dragging events', ->
#     #   event = (type) ->
#     #     event = document.createEvent('HTMLEvents')
#     #     event.initEvent type, false, true
#     #     event


#     #   dragstart = (element) ->
#     #     element.dispatchEvent event('dragstart')


#     #   dragover = (element) ->
#     #     element.dispatchEvent event('dragover')


#     #   drop = (element) ->
#     #     element.dispatchEvent event('drop')


#     #   describe 'when starting to drag', ->
#     #     beforeEach ->
#     #       dragstart element.children()[0]


#     #     it 'sets from and to', ->
#     #       expect(scope.from).toEqual 0
#     #       expect(scope.to).toBeNull


#     #     describe 'when dragging over', ->
#     #       beforeEach ->
#     #         dragover element.children()[element.children().length - 1]


#     #       it 'sets current', ->
#     #         expect(scope.current).toEqual element.children().length - 1

