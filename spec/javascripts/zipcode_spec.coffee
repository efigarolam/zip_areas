#= require zipcode

describe 'zipcode', ->
  zipcode = null
  map = null

  beforeEach ->
    fixture.load 'zipcodes'
    coordinates = [
      { k: 1, a: 1 },
      { k: 2, a: 2 },
      { k: 2, a: 1 },
      { k: 1, a: 2 }
    ]
    map = new App.Map($('#zip-areas-map-canvas'))
    zipcode = new App.Zipcode('name', coordinates)

  it 'expect zipcode to be defined', ->
    expect(zipcode).toBeDefined()

  describe '#name', ->
    it 'expect to be defined', ->
      expect(zipcode.name).toBeDefined()

    it 'is equal to \"name\"', ->
      expect(zipcode.name).toEqual('name')

  describe '#boundaries', ->

    it 'expect to be defined', ->
      expect(zipcode.boundaries).toBeDefined()

    it 'has 4 boundaries', ->
      expect(zipcode.boundaries.length).toEqual(4)

  describe '#setPolygon', ->

    it 'expect to be defined', ->
      expect(zipcode.setPolygon).toBeDefined()

  describe '#polygon', ->

    it 'is null in the begining', ->
      expect(zipcode.polygon).toBeNull()

  describe '#createPolygon', ->

    it 'is defined', ->
      canvas = $('#zip-area-map-canvas')
      mapOptions =
        center: new google.maps.LatLng(40.75532, -73.983677)
        zoom: 12
      map = new google.maps.Map(canvas.get(0), mapOptions)
      zipcode.createPolygon(App.color(), map)
      expect(zipcode.polygon).toBeDefined()

  describe '#changeColor', ->

    it 'changes the color of the polygon', ->
      canvas = $('#zip-area-map-canvas')
      mapOptions =
        center: new google.maps.LatLng(40.75532, -73.983677)
        zoom: 12
      map = new google.maps.Map(canvas.get(0), mapOptions)
      zipcode.createPolygon(App.color(), map)
      newColor = App.color()
      zipcode.changeColor(newColor)
      expect(zipcode.polygon.options.fillColor).toEqual(newColor)

  describe '#addListenerToPolygon', ->

    it 'should be defined', ->
      expect(zipcode.addListenerToPolygon).toBeDefined()

