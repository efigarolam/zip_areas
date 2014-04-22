window.App ||= {}

class App.Zipcode
  constructor: (@name, @boundaries) ->
  polygon: ->
    new google.maps.Polygon(
      paths: @boundaries
      strokeColor: "#000"
      strokeOpacity: 0.8
      strokeWeight: 2
      fillColor: "#000"
      fillOpacity: 0
    )
  createPolygon: ->
    polygon = @polygon()
    polygon.setMap map
    google.maps.event.addListener polygon, "click", ->
      fillOpacity = (if @fillOpacity is 0 then 0.5 else 0)
      @setOptions
        fillOpacity: fillOpacity

