source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.2.1'
ruby '2.5.1'

gem 'dotenv-rails', require: 'dotenv/rails-now', groups: [:development, :test]

gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'slim'
gem 'slim-rails'
gem 'rails-i18n'
gem 'rollbar'
gem 'oj'
# gem 'therubyracer', platforms: :ruby

gem 'bootstrap-sass'
gem 'autoprefixer-rails'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'jbuilder'


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
  gem 'simplecov', require: false
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'better_errors'
  gem 'rack-mini-profiler', require: false
  gem 'binding_of_caller'
  gem 'railroady'

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

end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

