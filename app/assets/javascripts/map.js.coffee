window.ZipAreasMap ||= {}

ZipAreasMap.initialize = ->
  canvas = $('#zip-area-map-canvas').get(0)

  if canvas
    mapOptions =
      center: new google.maps.LatLng(40.75532,-73.983677)
      zoom: 12

    map = new google.maps.Map(canvas, mapOptions)

    ZipAreasMap.polygons = []

    ZipAreasMap.zipCodes.forEach (zipArea) ->
      ZipAreasMap.polygons.push zipArea.polygon()

    ZipAreasMap.setActiveZipCodes = ->
      activePolygons = ZipAreasMap.polygons.filter (polygon) ->
        polygon.active is true

      ZipAreasMap.selectedZipCodes = activePolygons.map (polygon) -> polygon.zipCode

      $('#selected-zip-codes').text(ZipAreasMap.selectedZipCodes.join(', '))

    ZipAreasMap.polygons.forEach (polygon) ->
      polygon.setMap map

      google.maps.event.addListener polygon, "click", ->
        fillOpacity = (if @fillOpacity is 0 then 0.5 else 0)
        @setOptions
          fillOpacity: fillOpacity
        this.active = !this.active
        ZipAreasMap.setActiveZipCodes()

