# frozen_string_literal: true

source 'https://rubygems.org'

gem 'chef', '~> 14'

group :lint do
  gem 'foodcritic'
  gem 'rubocop'
end

group :unit do
  gem 'berkshelf'
  gem 'chefspec'
  gem 'ci_reporter_rspec'
end

group :development do
  gem 'pry'
  gem 'rake'
  gem 'stove'
end

group :knife do
  gem 'knife-cookbook-doc'
  gem 'knife-supermarket'
end

# Kitchen
group :kitchen do
  gem 'kitchen-dokken'
  gem 'kitchen-inspec'
  gem 'kitchen-sync'
  gem 'kitchen-vagrant'
  gem 'test-kitchen'
end

group :guard do
  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-foodcritic', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
end
