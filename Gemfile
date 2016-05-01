source "https://rubygems.org"


# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "4.2.6"

gem "pg"

# stylin"
gem "sass-rails", "~> 4.0.3"
gem "simple_form"
gem "annotate"

# API
gem "tolarian_registry"
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
end

group :test do
  gem "capybara", "~> 2.7"
  gem "database_cleaner", "~> 1.3.0"
end
