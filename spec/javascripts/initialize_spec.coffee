#= require initialize

describe 'initialize', ->

  beforeEach ->
    fixture.load 'zipcodes'

  it 'initializes map', ->
    map = new window.App.Map()
    expect(map.initialize()).toHaveBeenCalled()

