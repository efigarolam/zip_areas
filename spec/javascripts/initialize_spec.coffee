#= require initialize

describe 'initialize', ->

  beforeEach ->
    fixture.load 'zipcodes'

  xit 'initializes map', ->
    map = new window.App.Map()
    expect(map.initialize()).toHaveBeenCalled()

