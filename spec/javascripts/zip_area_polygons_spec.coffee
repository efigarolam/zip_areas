//= require zip_area_polygons

describe 'zip_area_polygons', ->

  it 'expects to define ZipAreasMap', ->
    expect(ZipAreasMap).toBeDefined()
  it 'returns and empty zipCodes array', ->
    expect(ZipAreasMap.zipCodes).toEqual([])
  it 'gets a random color', ->
    color = RandomColor.generate()
    expect(color).toBeDefined()

  describe 'ZipAreasMap.getCoordinates()', ->

    it 'returns an array with coordinates', ->
      zipcode = {
        name: 'name'
        coordinates: [ { longitude: 1, latitude: 1 },
        { longitude: 1, latitude: 1 } ] }
      coordinates = ZipAreasMap.getCoordinates(zipcode)
      expect(coordinates.length).toEqual(2)
    it 'contains coordinates inside of the Array', ->
      zipcode = {
        name: 'name'
        coordinates: [ { longitude: 1, latitude: 1 },
        { longitude: 1, latitude: 1 } ] }
      coordinates = ZipAreasMap.getCoordinates(zipcode)
      expect(coordinates).toContain({ k: 1, A: 1 })

  describe 'ZipAreasMap.createZipCode()', ->

    it

  describe 'ajax request', ->

    it 'executes the initialize method', ->
      spyOn($, 'ajax').andCallFake (response) ->
        response.success ->
          ZipAreasMap.initialize()
      expect(ZipAreasMap.initialize()).toHaveBeenCalled()
