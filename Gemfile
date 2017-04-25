source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.0.2'
ruby '2.3.1'

gem 'dotenv-rails', require: 'dotenv/rails-now', groups: [:development, :test]

gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'slim'
gem 'slim-rails'
# gem 'therubyracer', platforms: :ruby

gem 'bootstrap-sass'
gem 'autoprefixer-rails'

gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jquery-turbolinks'

gem 'jbuilder', '~> 2.5'


gem 'devise'
gem 'cancancan'
gem 'rolify'
gem 'omniauth'
gem 'omniauth-facebook'


gem 'carrierwave'
gem 'cloudinary'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'sqlite3'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'rack-mini-profiler', require: false
  gem 'simplecov', require: false
  gem 'binding_of_caller'

end

group :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
  gem 'webmock'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'simplecov', :require => false

end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

