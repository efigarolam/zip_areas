# require zip_area_polygons

describe "zip_area_polygons", ->

  it "creates a zipAreasMap object", ->
    expect(ZipAreasMap).toBeDefined
  it "creates a empty Array for zipCodes", ->
    expect(ZipAreasMap.zipCodes).toEqual([])

  describe "success ajax request", ->
    it "initializes ZipAreasMap", ->
      expect(ZipAreasMap.initialize()).toHaveBeenCalled
    xit "gets an array with", ->
      zipcode = {name: "11111", coordinates: [{longitude: 1, latitude: 1}, {longitude: 2, latitude: 2}]}
      coordinates = ZipAreasMap.getCoordinates(zipcode)
      expect(coordinates.length).toEq(2)

