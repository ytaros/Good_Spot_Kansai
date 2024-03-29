source "https://rubygems.org/"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"
gem 'acts-as-taggable-on', '~> 9.0'
gem "rails", "~> 7.0.7", ">= 7.0.7.2"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem 'image_processing', '~> 1.12', require: 'image_processing/mini_magick'
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'rails-i18n'
gem 'sorcery'
gem 'carrierwave'
gem 'config'
gem 'mini_magick'
gem 'font-awesome-rails'
gem 'aws-sdk-s3', require: false
gem 'ransack'
gem 'dotenv-rails'
gem 'fog-aws'
gem 'geocoder'
gem 'kaminari'
gem 'active_storage_validations'
gem 'meta-tags'
gem 'hotwire-rails'
gem 'rubocop', require: false
gem 'rubocop-performance', require: false
gem 'rubocop-rails', require: false
gem 'rubocop-rspec', require: false

group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'pry-rails'
  gem 'letter_opener_web'

end

group :development do
  gem "web-console"
end

group :production do
  gem 'pg', '~> 1.5', '>= 1.5.4'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "rspec-rails"
  gem "factory_bot_rails"
end