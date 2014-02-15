source 'https://rubygems.org'

ruby '2.1.0'

gem 'rails', '4.0.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
  gem 'rails_layout'
  gem 'rack-mini-profiler'
end   

group :development, :test do
  gem 'sqlite3'
  
  gem 'byebug'

  gem 'rspec-rails', '~> 2.14.1'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'	
  gem 'selenium-webdriver'
  gem 'database_cleaner', '< 1.1.0'
  gem 'launchy'
  gem 'webmock'
  gem 'simplecov', require: false
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.1'
  gem 'coffee-rails', '~> 4.0.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'rails-settings-cached', '0.3.1'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

gem 'httparty'

gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'jbuilder'

gem 'bootstrap-sass'


# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
