source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '4.0.2'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.0.5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test, :development do
  gem "rspec-rails", '~> 3.3.3'
  gem "capybara", '~> 2.5.0'
  gem "selenium-webdriver", '~> 2.48.1'
  gem "better_errors", '~> 2.1.1'
  gem "sprockets_better_errors", '~> 0.0.4'
  gem "binding_of_caller", '~> 0.7.2'
  gem "factory_girl_rails", '~> 4.5.0'
  gem "simplecov", '~> 0.10.0'
  gem "database_cleaner", '~> 1.5.1'
  gem "sqlite3", '~> 1.3.11'
  gem "pry", '~> 0.10.3'
  gem "guard-rspec", require: false
  gem "thin", '~> 1.6.4'
  gem 'launchy', '~> 2.4.3'
end

group :production do
  gem "google-analytics-rails"
  gem "rails_12factor"
end

gem "bootstrap-sass", "~> 3.1.1"
gem "rake", '< 11.0'
