#= require custom_methods

describe 'custom_methods', ->
  array = []

  beforeEach ->
    array = ["ola", 2]

  describe 'when the array does not includes the given value', ->

    it 'returns false if value does not match', ->
      expect(array.include("2")).toBeFalsy

  describe 'when the array includes the given value', ->

    it 'returns true when value and type match', ->
      expect(array.include(2)).toBeThuthy

