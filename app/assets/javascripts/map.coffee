window.App ||= {}

class App.Map
  constructor: ->
    @canvas = $('#zip-area-map-canvas').get(0)

  zipcodes: []

  selectedZipCodes: []

  getData: ->
    $get = $.get('/api/v1/zipcodes')
    $get.success (response) => @convertToZipCode(response)

  convertToZipCode: (data) ->
    data.forEach (element) =>
      boundaries = []
      boundaries.push(
        new google.maps.LatLng(coordinate.latitude, coordinate.longitude)
      ) for coordinate in element.coordinates
      @zipcodes.push(new window.App.Zipcode(element.name, boundaries))

  create_map: ->
    if @canvas
      mapOptions =
        center: new google.maps.LatLng(40.75532, -73.983677)
        zoom: 12
    map = new google.maps.Map(@canvas, mapOptions)
    randomColor = App.color()
    zipcode.createPolygon(randomColor, map) for zipcode in @zipcodes

  printSelectedZipCodes: ->
    $('#selected-zip-codes').text(map.selectedZipCodes.join(', '))

  getSelectedZipCodes: ->
    map.selectedZipCodes = []
    @zipcodes.forEach (zipcode) ->
      map.selectedZipCodes.push(zipcode.polygon.zipcode) if zipcode.polygon.active
    @printSelectedZipCodes()

