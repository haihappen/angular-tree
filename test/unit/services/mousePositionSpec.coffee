describe 'mousePosition service', ->
  mousePosition = $window = div = null

  beforeEach inject ($injector) ->
    mousePosition = $injector.get('mousePosition')
    $window = $injector.get('$window')

    $window.document.body.outerHTML = '''
      <body style="padding: 100px; margin: 0;">
        <div style="height: 200px; width: 200px;"></div>
      </body>
    '''

  beforeEach ->
    div = document.getElementsByTagName('div')[0]
    simulate $window.document.body, 'mousemove', pointerX: 200, pointerY: 250


  describe 'getRelativeLeft', ->
    it 'returns relative left to the body if no argument is passed in', ->
      expect(mousePosition.getRelativeLeft()).toEqual 200


    it 'returns undefined if out of bounds of passed element', ->
      simulate $window.document.body, 'mousemove', pointerX: 450, pointerY: 500

      expect(mousePosition.getRelativeLeft(div)).toBeUndefined()


    it 'returns relative left to passed element', ->
      expect(mousePosition.getRelativeLeft(div)).toEqual 100


  describe 'getRelativeTop', ->
    it 'returns relative top to the body if no argument is passed in', ->
      expect(mousePosition.getRelativeTop()).toEqual 250


    it 'returns undefined if out of bounds of passed element', ->
      simulate $window.document.body, 'mousemove', pointerX: 450, pointerY: 500

      expect(mousePosition.getRelativeTop(div)).toBeUndefined()


    it 'returns relative top to passed element', ->
      expect(mousePosition.getRelativeTop(div)).toEqual 150


  describe 'getRelativeLeftPercent', ->
    it 'returns relative left in percent to the body if no argument is passed in', ->
      expect(mousePosition.getRelativeLeftPercent()).toEqual 50


    it 'returns undefined if out of bounds of passed element', ->
      simulate $window.document.body, 'mousemove', pointerX: 450, pointerY: 500

      expect(mousePosition.getRelativeLeftPercent(div)).toBeUndefined()


    it 'returns relative left in percent to passed element', ->
      expect(mousePosition.getRelativeLeftPercent(div)).toEqual 50


  describe 'getRelativeTopPercent', ->
    it 'returns relative top in percent to the body if no argument is passed in', ->
      expect(mousePosition.getRelativeTopPercent()).toEqual 63


    it 'returns undefined if out of bounds of passed element', ->
      simulate $window.document.body, 'mousemove', pointerX: 450, pointerY: 500

      expect(mousePosition.getRelativeTopPercent(div)).toBeUndefined()


    it 'returns relative top in percent to passed element', ->
      expect(mousePosition.getRelativeTopPercent(div)).toEqual 75

