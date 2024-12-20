# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!
# Optional: You can add support for custom matchers or helpers here
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Configure FactoryBot and Capybara
RSpec.configure do |config|
  # Include FactoryBot's methods to simplify syntax in tests
  config.include FactoryBot::Syntax::Methods
  
  # If using Capybara, include its DSL methods
  config.include Capybara::DSL

  # Ensure DatabaseCleaner is configured if you are using it
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # If you're using ActiveRecord fixtures, configure them here
  config.fixture_paths = [Rails.root.join('spec/fixtures')]

  # Use transactional fixtures (ensure tests are isolated)
  config.use_transactional_fixtures = true

  # Filter out Rails backtrace from the test results
  config.filter_rails_from_backtrace!
end
