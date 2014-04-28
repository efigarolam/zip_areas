# Improvement of code part #1 - Model Creations

Hello guys! This is my first post and today I'm going to write about how to
improve old code. This is a rails technical post, so you should have a
knowledge of some Rails functionalities such as Assets Pipeline, MVC,
testing and API's.

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

## Start to configure the app!

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
with `rails generate rspec:install`. Now we need to configure rspec in the
file `rspec/spec_helper.rb`:

```ruby
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
```

Also if now we are using rspec for unit testing, now we can delete all the
content of `test` folder.

For Javascript testing we use teaspoon, with the jasmine framework for testing
using coffeescript syntax, so install it is very easy, only you
need to run `rails generate teaspoon:install --framework=jasmine --coffee`. You
can get more information about teaspoon [here](https://github.com/modeset/teaspoon).

The last step is install cucumber for integration tests, also very easy to install
`rails generate cucumber:install`.

Nice! now we got a test environment working! But we dont have a database yet...
Well, we need to update our config/database.yml with the information of the
database and run `rake db:create`.

## Lets start to create the models!

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

With this migrations run `rake db:migrate`.

Its time to add tests to our models, the first model to test is coordinate, so
in `spec/models/coordinate_spec.rb` we going to write the specs.

```ruby
require 'spec_helper'

describe Coordinate do
  let(:coordinate) { create(:coordinate) }

  it { expect(coordinate).to respond_to(:longitude) }
  it { expect(coordinate).to respond_to(:latitude) }
  it { expect(coordinate).to respond_to(:zipcode_id) }
  it { expect(coordinate).to belong_to(:zipcode) }
  it { expect(coordinate).to be_valid }

  describe "#longitude validation" do
    it "fails with nil value" do
      coordinate.longitude = nil
      expect(coordinate).to_not be_valid
    end
    it "fails with text" do
      coordinate.longitude = "ola k ace"
      expect(coordinate).to_not be_valid
    end
  end

  describe "#latitude validation" do
    it "fails with nil value" do
      coordinate.latitude = nil
      expect(coordinate).to_not be_valid
    end
    it "fails with text" do
      coordinate.latitude = "ola k ace"
      expect(coordinate).to_not be_valid
    end
  end

  describe "#zipcode validations" do
    it "fails with nil value" do
      coordinate.zipcode_id = nil
      expect(coordinate).to_not be_valid
    end
  end
end
```

We use factories for test this model, so let's create the factory for this
model in the file `spec/factories/coordinates.rb`. Also you can get more info about
factories [here](https://github.com/thoughtbot/factory_girl_rails).

```ruby
FactoryGirl.define do
  factory :coordinate do
    longitude  -73.987733
    latitude   40.744149
    zipcode_id 1
  end
end
```

Now when you run the tests with `rspec` in the terminal, some tests are passing
and some are failing. We need to make all to pass, to lets write some code in
`app/models/coordinate.rb` file:

```ruby
class Coordinate < ActiveRecord::Base
  belongs_to :zipcode

  validates :longitude, presence: true, numericality: true
  validates :latitude, presence: true, numericality: true
  validates :zipcode_id, presence: true
end
```

And now all the tests are passing. How sweet!

Its Time to do the same with zipcode model. Let's write some specs in `spec/models/zipcode_spec.rb`.

```ruby
require "spec_helper"

describe Zipcode do
  let(:zipcode) { create(:zipcode) }

  it { expect(zipcode).to respond_to(:name) }
  it { expect(zipcode).to have_many(:coordinates) }
  it { expect(zipcode).to have_many(:coordinates).dependent(:destroy) }
  it { expect(zipcode).to be_valid }

  describe "#name validation" do
    it "fails with nil value" do
      zipcode.name = nil
      expect(zipcode).to_not be_valid
    end
  end
end
```

Don't forget to create the factory for zipcode in `spec/factories/zipcode.rb`:

```ruby
FactoryGirl.define do
  factory :zipcode do
    name "area"
  end
end
```

Again when we run the tests with `rspec spec/models/zipcode.rb` in the terminal,
some tests are passing and some are failing. We need to make all to pass, again
to lets write some that make them pass in `app/models/zipcode.rb` file:

```ruby
class Zipcode < ActiveRecord::Base
  has_many :coordinates, dependent: :destroy

  validates :name, presence: true
end
```

And now if we run our tests again, all tests are passing!

## Conclutions

Yes, is a lot of things! But finally we got a working environment and create
some tests, also we defined the models. This is not over yet, but we got a
solid base to start to work. In the next post we start with the API and more
tests.

See you in the next post!

