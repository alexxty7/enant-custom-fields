# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'dry-schema'
gem 'dry-validation'
gem 'jsonapi-serializer'
gem 'ostruct'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.2.1', '>= 7.2.1.2'
gem 'rswag-api'
gem 'rswag-ui'
gem 'trailblazer'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development do
  gem 'annotate'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails', '~> 7.0.0'
  gem 'rswag-specs'
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false
  gem 'shoulda-matchers'
end

group :test do
  gem 'json_matchers', '0.10.0'
end
