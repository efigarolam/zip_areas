window.App ||= {}

class App.Map
  constructor: ->
    @canvas = $('#zip-area-map-canvas').get(0)
  zipcodes: []
  getData: ->
    map = this
    $.ajax('/api/v1/zipcodes', {
      success: (response) ->
        response.forEach (element) ->
          boundaries = []
          element.coordinates.forEach (coordinate) ->
            boundaries.push(new google.maps.LatLng(coordinate.latitude, coordinate.longitude))
          map.zipcodes.push(new window.App.Zipcode(element.name, boundaries))
        map.zipcodes
    })
  initialize: ->
    if @canvas
      mapOptions =
        center: new google.maps.LatLng(40.75532, -73.983677)
        zoom: 12
    map = new google.maps.Map(@canvas, mapOptions)
    @zipcodes.forEach (zipcode) ->
      polygon = zipcode.polygon()
      polygon.setMap map

