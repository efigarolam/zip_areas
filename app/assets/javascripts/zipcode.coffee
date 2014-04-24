window.App ||= {}

class App.Zipcode
  constructor: (@name, @boundaries) ->

  setPolygon: (color) ->
    new google.maps.Polygon(
      paths: @boundaries
      strokeColor: color
      strokeOpacity: 0.8
      strokeWeight: 2
      fillColor: color
      fillOpacity: 0
      zipcode: @name
      active: false
    )

  polygon: null

  changeColor: (color) ->
    @polygon.setOptions
      fillColor: color
      strokeColor: color

  createPolygon: (color, googleMap) ->
    @polygon = @setPolygon(color)
    @polygon.setMap googleMap
    google.maps.event.addListener @polygon, "click", ->
      fillOpacity = (if @fillOpacity is 0 then 0.5 else 0)
      @setOptions
        fillOpacity: fillOpacity
      @active = !@active
      map.selectedZipCodes = []
      map.zipcodes.forEach (zipcode) ->
        if zipcode.polygon.active is true
          map.selectedZipCodes.push(zipcode.polygon.zipcode)
      $('#selected-zip-codes').text(map.selectedZipCodes.join(', '))

