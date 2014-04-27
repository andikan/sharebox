source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'

# Use PostgreSQL as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '>= 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# facebook login
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'

# A lightweight, flexible library for Facebook
gem "koala", "~> 1.9.0"

# app settings
gem 'settingslogic'

#for uploading files
gem "paperclip", "~> 4.1"

#for Paperclip to use Amazon S3  
gem "aws-sdk"

#for nested folders
gem "acts_as_tree"

# for pagination
gem 'kaminari'


group :development do 
  # app server
  gem 'puma'
  
  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-rails', '~> 1.1', require: false
  gem 'capistrano-rbenv', '~> 2.0', require: false
  gem 'capistrano3-puma', require: false

  # https://github.com/dejan/rails_panel/tree/master/meta_request
  # http://blog.chh.tw/posts/better-way-to-watch-rails-log-rails-panel/
  gem 'meta_request'
  gem "annotate"
  gem "migration_comments"
  gem "better_errors"
  # for layout and helpers generations
  gem "nifty-generators"
end

group :test do
  gem "mocha"
end
