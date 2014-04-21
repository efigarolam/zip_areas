//= require color

describe 'Color', ->
  it "returns hexagesimal color code", ->
    color = new App.Color()
    expect(color.generate()).toMatch(/^#[A-Fa-f0-9]{6}|[A-Fa-f0-9]{3}^/)
