window.ZipAreasMap ||= {}

$ ->
  ZipAreasMap.selectedZipCodes = []
  ZipAreasMap.initialize()

  $('#change-color').click ->
    color = RandomColor.generate()
    ZipAreasMap.polygons.forEach (polygon) ->
      polygon.setOptions
        fillColor: color
        strokeColor: color
