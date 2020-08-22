source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.2'
gem 'pg'
gem 'puma'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'kaminari'
gem 'octokit', '~> 4.0'
gem 'fast_jsonapi'
gem 'active_model_serializers', '~> 0.10.2'
gem 'jsonapi_errors_handler'
gem 'bcrypt'
gem 'rack-cors'
gem 'webpacker'
gem 'dotenv-rails', require: 'dotenv/rails-now'
# gem 'sass-rails'
# gem 'uglifier'
# gem 'turbolinks'
# gem 'jbuilder'

group :development, :test do
  # gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # gem 'web-console'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
