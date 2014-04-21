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

    it 'creates a zipcode object', ->
      array = [{ A: 1, k: 1 }, { A: 2, k: 1 }, { A: 2, k: 2 }]
      zipcode = { name: 'dummy' }
      zipCodeObject = ZipAreasMap.createZipCode(array, zipcode)
      expect(zipCodeObject).toBeDefined()
    it 'has a boundaries array with 3 elements', ->
      array = [{ A: 1, k: 1 }, { A: 2, k: 1 }, { A: 2, k: 2 }]
      zipcode = { name: 'dummy' }
      zipCodeObject = ZipAreasMap.createZipCode(array, zipcode)
      expect(zipCodeObject.boundaries.length).toEqual(3)
    it 'calls the polygon function', ->
      array = [{ A: 1, k: 1 }, { A: 2, k: 1 }, { A: 2, k: 2 }]
      zipcode = { name: 'dummy' }
      zipCodeObject = ZipAreasMap.createZipCode(array, zipcode)
      expect(zipCodeObject.polygon).toHaveBeenCalled
    it 'calls the isCurrent function', ->
      array = [{ A: 1, k: 1 }, { A: 2, k: 1 }, { A: 2, k: 2 }]
      zipcode = { name: 'dummy' }
      zipCodeObject = ZipAreasMap.createZipCode(array, zipcode)
      expect(zipCodeObject.isCurrent).toHaveBeenCalled

    describe 'isCurrent()', ->

      array = []
      zipcode = null
      ZipAreasMap.selectedZipCodes = []
      zipCodeObject = null

      describe 'active zipcodes', ->

        beforeEach ->
          array = [{ A: 1, k: 1 }, { A: 2, k: 1 }, { A: 2, k: 2 }]
          zipcode = { name: 'dummy' }
          ZipAreasMap.selectedZipCodes = ['dummy']
          zipCodeObject = ZipAreasMap.createZipCode(array, zipcode)
        it 'returns an opacity of 0.5', ->
          expect(zipCodeObject.isCurrent(zipcode.name, 'opacity')).toEqual(0.5)
        it 'returns true', ->
          expect(zipCodeObject.isCurrent(zipcode.name, 'active')).toEqual(true)

      describe 'inactive zipcodes', ->
        beforeEach ->
          array = [{ A: 1, k: 1 }, { A: 2, k: 1 }, { A: 2, k: 2 }]
          zipcode = { name: 'dummy' }
          ZipAreasMap.selectedZipCodes = ['']
          zipCodeObject = ZipAreasMap.createZipCode(array, zipcode)
        it 'returns an opacity of 0.5', ->
          expect(zipCodeObject.isCurrent(zipcode.name, 'opacity')).toEqual(0)
        it 'returns true', ->
          expect(zipCodeObject.isCurrent(zipcode.name, 'active')).toEqual(false)

  describe 'ajax request', ->

    it 'executes the initialize method', ->
      spyOn($, 'ajax').andCallFake (response) ->
        response.success ->
          ZipAreasMap.initialize()
      expect(ZipAreasMap.initialize()).toHaveBeenCalled()
