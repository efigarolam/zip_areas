# require map

describe "map", ->
  describe "when canvas is undefined", ->
    it "returns undefined", ->
      expect(ZipAreasMap.initialize()).toBe(undefined)
  describe "when canvas is not undefined", ->
