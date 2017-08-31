source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.3'
# Use postgresql as the database for Active Record
gem 'pg', '0.21.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'

# stylin'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'

# API
gem 'jbuilder', '~> 2.5'

gem 'jquery-rails'
gem 'coffee-script'

gem 'pusher'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
  gem 'awesome_print', group: :development
  gem 'seed_dump', group: :development
end

# Security
gem 'devise'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'teaspoon-jasmine'
  gem 'guard-rspec'
  gem 'rails-controller-testing'
  gem 'simplecov', '0.15.0'
end

group :test do
  gem 'phantomjs', '~> 2.1', '>= 2.1.1.0'
  gem 'database_cleaner', '~> 1.6.1'
  gem 'codeclimate-test-reporter', require: nil
  gem 'capybara', '~> 2.7'
  gem 'capybara-angular'
  gem 'poltergeist', '~> 1.7'
end

gem 'httparty', '~>0.11'
gem 'angular-rails-templates'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
