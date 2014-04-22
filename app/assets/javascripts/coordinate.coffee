window.App ||= {}

class App.Coordinate
  create: (coordinate) ->
    new google.maps.LatLng(coordinate.latitude, coordinate.longitude)

