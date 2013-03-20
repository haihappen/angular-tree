describe 'Tree', ->
  describe 'treeCtrl', ->
    ctrl = null

    beforeEach ->
      ctrl = new angular.module('Tree').controller('treeCtrl')

    it '1 == 1', ->
      expect(1).toBe(1)
      