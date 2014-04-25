#= require custom_methods

describe 'custom_methods', ->
  array = []

  beforeEach ->
    array = ["ola", 2]

  describe 'false cases', ->

    it 'returns false when does not match', ->
      expect(array.include("non")).toBeFalsy

    it 'returns false if type does not match', ->
      expect(array.include("2")).toBeFalsy

  describe 'true cases', ->

    it 'returns true when value and type match', ->
      expect(array.include(2)).toBethuthy

