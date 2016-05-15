ENV["RAILS_ENV"] ||= 'test'

require_relative "../config/environment"
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'


ENV['PATH'] = ENV['PATH'] + ':' + './features'
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    window_size: [1920, 1080],
    js_errors: false,
    default_wait_time: 5,
    phantomjs: "#{File.dirname(__FILE__)}/../node_modules/.bin/phantomjs"
    # debug:       true
  )
end

Capybara.default_driver    = :poltergeist
Capybara.javascript_driver = :poltergeist

Capybara.default_max_wait_time = 5

ActiveRecord::Migration.check_pending!
ActiveRecord::Migration.maintain_test_schema! if ActiveRecord::Migration.respond_to?(:maintain_test_schema!)

# Requires supporting ruby files with custom matchers and macros, etc,
# in features/support/ and its subdirectories.
Dir[Rails.root.join("features/support/**/*.rb")].each { |f| require f }

# webmock_options = {
#   allow_localhost: true
# }
# WebMock.disable_net_connect!(webmock_options)

RSpec.configure do |config|
  config.include FeatureHelpers
  config.extend FeatureHelpers
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller

  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.fixture_path = "#{::Rails.root}/features/fixtures"

  config.global_fixtures = :all

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
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
