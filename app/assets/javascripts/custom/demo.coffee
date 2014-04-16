window.ZipAreasMap ||= {}

$ ->
  ZipAreasMap.selectedZipCodes = $("#zip-codes").val().split(',')
  ZipAreasMap.initialize()
  $('#selected-zip-codes').text(ZipAreasMap.selectedZipCodes)
