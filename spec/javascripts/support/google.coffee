window.google ||= {
  maps: {
    event: {
      addListener: (polygon, event, addFunction) ->
    }
  }
}

class window.google.maps.Polygon
  constructor: (object) ->
    @options = object
  setMap: (map) ->
    @map = map
  setOptions: (options) ->
    @options.fillColor = options.fillColor
    @options.strokeColor = options.strokeColor

class window.google.maps.Map
  constructor: (@canvas, @mapOptions) ->

class window.google.maps.LatLng
  constructor: (@k, @a) ->
