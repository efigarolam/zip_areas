//= require random_color

describe 'random_color', ->
  it "returns hexagesimal color code", ->
    expect(window.RandomColor.generate()).toMatch(/^#[A-Fa-f0-9]{6}|[A-Fa-f0-9]{3}/)

