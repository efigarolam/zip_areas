require 'cucumber/rails'

ActionController::Base.allow_rescue = false

# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# Possible values are :truncation and :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation

