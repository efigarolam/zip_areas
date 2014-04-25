#= require map

describe 'map', ->
  window.map = null

  beforeEach ->
    fixture.load 'zipcodes'
    coordinates1 = [
      { k: 1, a: 1 },
      { k: 2, a: 2 },
      { k: 2, a: 1 },
      { k: 1, a: 2 }
    ]
    coordinates2 = [
      { k: 3, a: 3 },
      { k: 2, a: 2 },
      { k: 2, a: 3 },
      { k: 3, a: 2 }
    ]
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

