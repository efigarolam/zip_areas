ZipAreasMap.initialize = ->
  canvas = $("#zip-area-map-canvas").get(0)
  if canvas
    mapOptions =
      center: new google.maps.LatLng(40.75532, -73.983677)
      zoom: 12
    map = new google.maps.Map(canvas, mapOptions)
    ZipAreasMap.polygons = []

