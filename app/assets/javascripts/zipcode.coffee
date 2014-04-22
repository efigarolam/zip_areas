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
    )

