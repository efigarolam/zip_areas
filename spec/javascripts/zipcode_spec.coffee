//= require zipcode

describe 'zipcode', ->
  zipcode = null

  beforeEach ->
    fixture.load 'zipcodes'
    coordinates = [
      { k: 1, a: 1 }, { k: 2, a: 2 }, { k: 2, a: 1 }, { k: 1, a: 2 }
    ]
    zipcode = new App.Zipcode('name', coordinates)

  describe 'properties', ->
    it 'expects zipcode to be defined', ->
      expect(zipcode).toBeDefined()
    it 'expects zipcode #name to be defined', ->
      expect(zipcode.name).toBeDefined()
    it 'expects zipcode #boundaries to be defined', ->
      expect(zipcode.boundaries).toBeDefined()
    it 'expects zipcode #setPolygon to be defined', ->
      expect(zipcode.setPolygon).toBeDefined()
    it 'expects zipcode #polygon to be null', ->
      expect(zipcode.polygon).toBeNull()
    it 'expects zipcode #changeColor to be defined', ->
      expect(zipcode.changeColor).toBeDefined()
    it 'expects zipcode #createPolygon to be defined', ->
      expect(zipcode.createPolygon).toBeDefined()

  describe '#create Polygon', ->
    it 'creates a polygon', ->
      canvas = $('#zip-area-map-canvas')
      mapOptions =
        center: new google.maps.LatLng(40.75532, -73.983677)
        zoom: 12
      map = new google.maps.Map(canvas, mapOptions)
      zipcode.createPolygon("#FFF", map)
      expect(zipcode.polygon).toBeDefined()

