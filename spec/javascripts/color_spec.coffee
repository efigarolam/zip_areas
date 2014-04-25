#= require color

describe 'Color', ->

  it "returns hexagesimal color code", ->
    expect(App.color()).toMatch(/^#[A-Fa-f0-9]{6}|[A-Fa-f0-9]{3}^/)

