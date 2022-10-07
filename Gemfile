source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 5.2.8', '>= 5.2.8.1'
gem 'puma', '~> 4.3', '>= 4.3.12'
gem 'jbuilder', '~> 2.8', '>= 2.8.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rest-client', '~> 2.0', '>= 2.0.2'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  gem 'rails-controller-testing', '~> 0.0.3'
  gem 'rubocop', '~> 0.66.0'
  gem 'bundler-audit', '~> 0.6.1'
  gem 'brakeman', '~> 4.7', '>= 4.7.1'
  gem 'simplecov', '~> 0.16.1'
  gem 'simplecov-console', '~> 0.4.2'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

group :test do
  gem 'capybara', '>= 3.15.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
