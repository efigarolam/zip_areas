## Interactive Zip Areas Map with Google Maps & Polygons

What's up? In this time I'm going to show you how to build an interactive Zip Areas map, using the Google Maps API and a simple Rails application. I want to highlight that Rails is not a requirement. I'm just using Rails to automatically generate Javascript objects, from a YAML file. So, in summary, you should be able to do it using any framework or web language.

You can check what I'm talking about on [this demo](http://zipareas.herokuapp.com).

### Setting up the project

I'm assuming that you have already a Rails application. So I won't explain from the beginning. If you have any troubles, please put a comment, I'll be happy to help you.

The first step to start working with the Google Maps API is to add the following line on your layout `app/views/layouts/application.html.haml`:

    = javascript_include_tag "https://maps.googleapis.com/maps/api/js?key=[YOUR_KEY]8&sensor=true"

It is important to add that line above the following line:

    = javascript_include_tag "application", "data-turbolinks-track" => true

If you are using ERB templates, you should change the syntax. Not a big deal.

### Getting the Zip areas boundaries

The next step is to generate a YAML file which will contains all the boundaries of each Zip Code Area. As you may notice, I'm using New York's Zip codes as example. The format I'm using on the YAML file is the following:

    -
      name: '10001'
      boundaries:
        -
          longitude: '-73.987733'
          latitude: '40.744149'
        -
          longitude: '-73.983973'
          latitude: '40.748934'
        -
          longitude: '-74.006533'
          latitude: '40.756112'
        -
          longitude: '-74.008242'
          latitude: '40.752352'
        -
          longitude: '-73.992177'
          latitude: '40.743465'
    -
      name: '10002'
      boundaries:
        -
          longitude: '-73.997519'
          latitude: '40.714021'
        -
          longitude: '-73.996017'
          latitude: '40.708849'
        -
          longitude: '-73.976104'
          latitude: '40.712915'
        -
          longitude: '-73.97516'
          latitude: '40.719681'
        -
          longitude: '-73.992583'
          latitude: '40.724137'

I got the data from [this document](https://www.google.com/fusiontables/DataSource?docid=1Lae-86jeUDLmA6-8APDDqazlTOy1GsTXh28DAkw). The precision increases with the number of boundaries.

### Generating Polygon objects from the YAML file

In order to show the Zip Areas on the Map, we will be using Polygons, which are an object from the Google Maps API used to draw areas. Here is the code where I'm generating an array of ZipCodes and its Polygons, then in other place I will draw those Polygons on the map. I called this file `zip_area_polygons.js.coffee.erb`:

    window.ZipAreasMap ||= {}

    # Array of ZipCodes
    ZipAreasMap.zipCodes = []

    # Opening the YAML file.
    <% zip_codes = YAML.load_file('config/ny_zip_areas.yml') %>

    # Iterating over each Zip Code.
    <% zip_codes.each do |zp| %>

    # Defining the color of the Polygon
    color = RandomColor.generate()

    ZipAreasMap.zipCodes.push(
      # The boundaries for a Polygon
      boundaries: [
    <% zp['boundaries'].each do |b| %>
        new google.maps.LatLng(<%= b['latitude'] %>, <%= b['longitude'] %>),
    <% end %>
      ]

      # This is the Polygon correspoding to each ZipCode.
      polygon: ->
        new google.maps.Polygon(
          paths: @boundaries
          strokeColor: color
          strokeOpacity: 0.8
          strokeWeight: 2
          fillColor: color
          fillOpacity: @isCurrent('<%= zp["name"] %>', 'opacity')
          zipCode: '<%= zp["name"] %>'
          active: @isCurrent('<%= zp["name"] %>', 'active')
        )

      # This is for handling the status of the Polygon
      # Filled if is active
      # Empty if is not active
      isCurrent: (zipCode, property) ->
        isCurrent = ZipAreasMap.selectedZipCodes.filter (zip) ->
          zip is zipCode

        return 0.5 if isCurrent.length and property is 'opacity'
        return 0 if property is 'opacity'
        return true if isCurrent.length and property is 'active'
        return false
    )
    <% end %>

### Random Color generator

Looking a little bit on Internet, I have found [this method](http://www.paulirish.com/2009/random-hex-color-code-snippets/) to generate Random Colors, check it out, I put that on `random_color.js.coffee` file:

    window.RandomColor ||= {}

    RandomColor.generate = ->
      '#' + ('000000' + Math.floor(Math.random()*16777215).toString(16)).slice(-6)

### The markup

Working with Google Maps is very easy, for HTML markup we just need the following:

    .col-lg-8
      #zip-area-map-canvas
      %input#zip-codes{type: 'hidden', value: "#{@zip_codes}"}
    .col-lg-4
      %p You have selected the following zip codes:
      %p#selected-zip-codes

I have a Demo controller with an index action, so this markup is inside of `app/views/demo/index.html.haml`

Add that markup wherever you want the map to display, the important element is the empty div with id `#zip-area-map-canvas`.

One last important thing is to add the following CSS:

    #zip-area-map-canvas {
      height: 500px;
    }

We need to specify the height and width of our Map. I have already specified the width of the Map with the `.col-lg-8` class from Twitter's Bootstrap.

### The Map initializer

Here is the code which will initialize the Map with all the Zip Area Polygons. The file is called `map.js.coffee`

    ZipAreasMap.initialize = ->
      canvas = $('#zip-area-map-canvas').get(0)

      if canvas
        mapOptions =
          center: new google.maps.LatLng(40.75532,-73.983677)
          zoom: 12

        map = new google.maps.Map(canvas, mapOptions)

        ZipAreasMap.polygons = []

        ZipAreasMap.zipCodes.forEach (zipArea) ->
          ZipAreasMap.polygons.push zipArea.polygon()

        ZipAreasMap.setActiveZipCodes = ->
          activePolygons = ZipAreasMap.polygons.filter (polygon) ->
            polygon.active is true

          ZipAreasMap.selectedZipCodes = activePolygons.map (polygon) -> polygon.zipCode

          $('#selected-zip-codes').text(ZipAreasMap.selectedZipCodes.join(', '))

        ZipAreasMap.polygons.forEach (polygon) ->
          polygon.setMap map

          google.maps.event.addListener polygon, "click", ->
            fillOpacity = (if @fillOpacity is 0 then 0.5 else 0)
            @setOptions
              fillOpacity: fillOpacity
            this.active = !this.active
            ZipAreasMap.setActiveZipCodes()

### Pre-selecting Zip Areas

We can pre-select zip areas from our Map, I made it work just adding the following code in the controller that renders the Map's view:

    class DemoController < ApplicationController
      def index
        @zip_codes = params[:zip_codes]
      end
    end

Remember that I used that instance variable on the `#zip-codes` hidden input.

### Finishing up

We are ready to see it working, you just need add this code, I called the file as `demo.js.coffee`:

    window.ZipAreasMap ||= {}

    $ ->
      # Splitting the zip codes from the hidden input.
      ZipAreasMap.selectedZipCodes = $('#zip-codes').val().split(',')
      
      # Initializing the Map.
      ZipAreasMap.initialize()
      
      $('#selected-zip-codes').text(ZipAreasMap.selectedZipCodes)
      
      # Change color button
      $('#change-color').click ->
        color = RandomColor.generate()
        ZipAreasMap.polygons.forEach (polygon) ->
          polygon.setOptions
            fillColor: color
            strokeColor: color

As you could notice, I am initializing the map when the document is ready!

I hope you could find this useful! Thanks for reading and see you next time!
