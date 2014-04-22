//= require initialize

describe 'initialize', ->
  it 'initializes map', ->
    map = new window.App.Map()
    expect(map.initialize()).toHaveBeenCalled()

