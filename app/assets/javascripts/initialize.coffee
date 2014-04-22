window.App ||= {}

$(document).ready ->
  window.map = new window.App.Map()
  map.getData()
  setTimeout(->
    map.initialize()
  250)
  $('#change-color').click ->
    color = new App.Color()
    randomColor = color.generate()
    map.zipcodes.forEach (zipcode) ->
      zipcode.changeColor(randomColor)

