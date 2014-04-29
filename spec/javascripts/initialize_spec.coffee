#= require initialize

describe 'initialize', ->
  map = null
  $element = null

  beforeEach ->
    fixture.load 'zipcodes'
    $element = $('#change-color')
    map = new window.App.Map()

  it 'gets zipcodes from the DOM', ->
    map.selectedZipCodes = $('#zip-codes').val().split(',')
    expect(map.selectedZipCodes).toEqual([''])

  describe 'clicking element with id change-color', ->

    it 'is executed', ->
      spyOn($element, 'click')
      $element.click()
      expect($element.click).toHaveBeenCalled()

