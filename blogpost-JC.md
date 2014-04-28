# Improvement of code part #1

Hello guys! This is my first post and today I'm going to write about how to
improve old code. This is a very rails technical post, so you should have a
knowledge of some Rails functionalities such as Assets Pipeline, MVC and API's

This post is the description of a proccess to improve a code
that print the zip codes of Manhattan in a Google map. If you want to check the
original post, you can read it
[here](http://blog.crowdint.com/2014/02/04/interactive-zip-areas-map-with-google-maps.html).
I highly recommend to read for understand
the background of this post.

Also, the base code can be viewed [here](https://github.com/efigarolam/zip_areas).

## The background

Actually the application mainly works in this way:

* The file `config/ny_zip_areas.yml` contains the zipcodes and the coordinates
of every zip code.
* The file `app/assets/javascripts/zip_area_polygons.js.coffee.erb` manage the
creation of coordinates and poligons of the zipcodes using the Rails Assets
Pipeline, also manage the logic of the selected zipcodes.
* The file `app/assets/javascripts/map.js.coffee` manage the creation of the
Google map, the render of the zip code's polygons, and the visualization of the
selected zip codes, also show dynamically the selected zipcodes in the page.
* And the file `app/assets/javascripts/demo.js.coffee` initialize an object
ZipAreasMap, in this object we append a lot of functions and objects for make
Google map works.

## The To-Do list

How that we understand how works. Now we need to improve this code adding some
new features:

* We need to create an API, for get the zipcodes and coordinates by AJAX.
* The creation of the API involves the creation of new models and controllers.
* Change the logic of the javascript and make refactor
* The application doesn't have tests, so we need to add too.

## Start to create the API!

Let's start with the API, the first thing to do is update our `Gemfile` file
with the necesary gems for testing:

```ruby
group :development, :test do
  gem 'pry'
  gem 'pry-remote'
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'teaspoon'
  gem 'phantomjs'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
end
```

After updating our `Gemfile` its time to run `bundle update`. Now install rspec
with `rails generate rspec:install` and configure rspec in the file `rspec/spec_helper`:



The API manage zipcodes and coordinates, so the
models are Zipcode and Coordinate. The zipcode has many coordinates and
coordinate belongs to zipcode. So let's create the model zipcode with
`rails generate model zipcode`, and edit the file
`db/migrate/[timestamps]_create_zipcodes.rb`:

```ruby
class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.string :name

      t.timestamps
    end
  end
end
```

Now its time to create our model coordinate with
`rails generate model coordinate` and edit the file
`db/migrate/[timestamps]_create_coordinate.rb`:

```ruby
class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.decimal :longitude
      t.decimal :latitude
      t.references :zipcode

      t.timestamps
    end
    add_index :coordinates, :zipcode_id
  end
end

```

