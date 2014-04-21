window.ZipAreasMap ||= {}

ZipAreasMap.getCoordinates = (zipcode) ->
  array = []
  zipcode.coordinates.forEach (coordinate) ->
    array.push(
      new google.maps.LatLng(coordinate.latitude, coordinate.longitude)
    )
  array

ZipAreasMap.createZipCode = (array, zipcode) ->
  boundaries: array
  polygon: ->
    new google.maps.Polygon(
      paths: @boundaries
      strokeColor: color
      strokeOpacity: 0.8
      strokeWeight: 2
      fillColor: color
      fillOpacity: @isCurrent(zipcode.name, 'opacity')
      zipcode: zipcode.name
      active: @isCurrent(zipcode.name, 'active')
    )
  isCurrent: (zipCode, property) ->
    isCurrent = ZipAreasMap.selectedZipCodes.filter (zip) ->
      zip is zipCode
    return 0.5 if isCurrent.length and property is 'opacity'
    return 0 if property is 'opacity'
    return true if isCurrent.length and property is 'active'
    return false

ZipAreasMap.zipCodes = []
color = RandomColor.generate()
$.ajax("/api/v1/zipcodes", {
  success: (response) ->
    response.forEach (zipcode) ->
      array = ZipAreasMap.getCoordinates(zipcode)
      ZipAreasMap.zipCodes.push(ZipAreasMap.createZipCode(array, zipcode))
    ZipAreasMap.initialize()
})

