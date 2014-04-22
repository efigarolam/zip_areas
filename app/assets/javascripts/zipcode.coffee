window.App ||= {}

class App.Zipcode
  constructor: (@zipcode, @boundaries) ->
  isCurrent: ->
    return false
  polygon: ->
    new google.maps.Polygon(
      paths: @boundaries
      strokeColor: color
      strokeOpacity: 0.8
      strokeWeight: 2
      fillColor: color
      fillOpacity: @isCurrent(@zipcode.name, 'opacity')
      zipcode: @zipcode.name
      active: @isCurrent(@zipcode.name, 'active')
    )

