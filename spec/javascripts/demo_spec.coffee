# require demo

describe "demo", ->
  it "creates a zipAreasMap object", ->
    expect(ZipAreasMap).toBeDefined
  xit "creates a empty Array", ->
    expect(ZipAreasMap.selectedZipCodes).toEqual([""])
