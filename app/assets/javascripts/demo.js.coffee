window.ZipAreasMap ||= {}

$ ->
  ZipAreasMap.selectedZipCodes = $('#zip-codes').val().split(',')
  ZipAreasMap.initialize()
  $('#selected-zip-codes').text(ZipAreasMap.selectedZipCodes)

  $('#change-color').click ->
    color = RandomColor.generate()
    ZipAreasMap.polygons.forEach (polygon) ->
      polygon.setOptions
        fillColor: color
        strokeColor: color
