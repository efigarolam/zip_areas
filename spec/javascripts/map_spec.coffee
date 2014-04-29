#= require map

describe 'map', ->
  window.map = null

  beforeEach ->
    fixture.load 'zipcodes'
    map = new App.Map($('#zip-areas-map-canvas'))

  it 'expect map to be defined' , ->
    expect(map).toBeDefined()

  describe '#canvas', ->

    it 'is defined', ->
      expect(map).toBeDefined()

  describe '#zipcodes', ->

    it 'is empty at the beginning', ->
      expect(map.zipcodes).toEqual([])

  describe '#selectedZipCodes', ->

    it 'is empty at the beginning', ->
      expect(map.selectedZipCodes).toEqual([])

  describe '#printSelectedZipCodes', ->

    it 'prints selected zipcodes', ->
      map.selectedZipCodes = [1, 2, 3]
      map.printSelectedZipCodes()
      result = $('#selected-zip-codes').text()
      expect(result).toEqual('1, 2, 3')

  describe '#getSelectedZipCodes', ->

    it 'retuns an array with selected zipcodes', ->
      map.getSelectedZipCodes()
      expect(map.selectedZipCodes.length).toEqual(0)

  describe '#convertToZipCode', ->

    it 'fills the zipcodes array', ->
      data = [
        { name: '1', coordinates: [ longitude: '1', latitude: '1' ] },
        { name: '2', coordinates: [ longitude: '1', latitude: '1' ] },
        { name: '3', coordinates: [ longitude: '1', latitude: '1' ] }
      ]
      map.convertToZipCode(data)
      expect(map.zipcodes.length).toEqual(3)

