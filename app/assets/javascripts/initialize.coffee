window.App ||= {}

$ ->
  window.map = new window.App.Map()
  map.selectedZipCodes = $('#zip-codes').val().split(',')
  map.getData()

  setTimeout(->
    map.initialize()
  250)

  $('#change-color').click ->
    randomColor = App.color()
    zipcode.changeColor(randomColor) for zipcode in map.zipcodes

