# require custom/zip_area_polygons

describe "zip_area_polygons", ->
  it "creates a zipAreasMap object", ->
    expect(ZipAreasMap).toBeDefined
  it "creates a empty Array for zipCodes", ->
    expect(ZipAreasMap.zipCodes).toEqual([])
  it "creates a empty Array for zip_codes", ->
    expect(ZipAreasMap.rawZipCodes).toEqual([])

