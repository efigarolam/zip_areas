window.App ||= {}

$ ->
  window.map = new window.App.Map()
  map.selectedZipCodes = $('#zip-codes').val().split(',')
  map.getData()

  setTimeout(->
    map.create_map()
  250)
  map.printSelectedZipCodes()

  $('#change-color').click ->
    randomColor = App.color()
    zipcode.changeColor(randomColor) for zipcode in map.zipcodes

