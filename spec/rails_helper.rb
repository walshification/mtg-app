# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'devise'
require 'capybara/poltergeist'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.include Devise::TestHelpers, :type => :controller

  # Feature Tests

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
      app,
      window_size: [1920, 1080],
      js_errors: false,
      default_wait_time: 5,
      phantomjs: "#{File.dirname(__FILE__)}/../node_modules/.bin/phantomjs"
      #debug:       true
    )
  end

  Capybara.javascript_driver = :poltergeist
  Capybara.default_driver = :poltergeist

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :type => :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do |example|
    if example.exception
      filename = File.basename(example.metadata[:file_path])
      line_number = example.metadata[:line_number]
      screenshot_name = "screenshot-#{filename}-#{line_number}.png"
      screenshot_path = "#{Rails.root.join("tmp")}/#{screenshot_name}"
      page.save_screenshot(screenshot_path)
      puts example.metadata[:full_description] + "\n  Screenshot: #{screenshot_path}"
    end
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  config.around(:each) do |example|
    retry_count = 5
    retry_count.times do |i|
      example.run
      real_example = example.example

      if real_example.exception.nil? || (real_example.exception && i == retry_count-1)
        break # Stop the retry loop and proceed to the next spec
      end

      # If we got to this point, then a retry-able exception has been thrown by the spec
      e_line = real_example.instance_variable_get '@example_block'
      puts "Error (#{real_example.exception.class} - #{real_example.exception}) occurred while running rspec example (#{e_line}"

      if i < retry_count
        real_example.instance_variable_set('@exception', nil)
        puts "Re-running rspec example (#{e_line}. Retry count #{i+1} of #{retry_count}"
      end
    end
  end
end
