source "https://rubygems.org"


# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "4.2.6"

# Use postgresql as the database for Active Record
gem "pg"

# stylin"
gem "sass-rails", "~> 4.0.3"
gem 'bootstrap-sass', '>= 3.2', group: [:assets, :development, :test]
gem "simple_form"

# API
gem "jbuilder", "~> 2.0"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "~> 4.0.0"
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem "therubyracer",  platforms: :ruby
gem "pusher"
# Use jquery as the JavaScript library
gem "jquery-rails"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0", group: :doc

# Spring speeds up development by keeping your application running in the
# background. Read more: https://github.com/rails/spring
gem "spring", group: :development
gem "pry-rails", group: :development
gem "quiet_assets", group: :development
gem "annotate", group: :development
gem 'byebug', '~> 8.2', '>= 8.2.4'
gem 'awesome_print', group: :development
gem 'seed_dump', group: :development

# Security
gem "devise"

# Use unicorn as the app server
# gem "unicorn"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

# Use debugger
# gem "debugger", group: [:development, :test]
group :development, :test do
  gem "dotenv-rails"
  gem "rspec-rails", "~> 3.0"
  gem "factory_girl_rails", "~> 4.4.1"
  gem 'teaspoon-jasmine'
end

group :test do
  gem 'phantomjs', '~> 2.1', '>= 2.1.1.0'
  gem "database_cleaner", "~> 1.3.0"
  gem "codeclimate-test-reporter", require: nil
  gem "capybara", "~> 2.7"
  gem 'capybara-angular'
  gem 'poltergeist', '~> 1.7'
end

gem 'httparty', '~>0.11'
gem 'angular-rails-templates'
gem 'sprockets', '~> 2.0'
