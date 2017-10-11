source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'

gem 'uglifier', '>= 1.3.0'
gem 'bootstrap-sass'
gem 'turbolinks', '~> 5'
gem 'jquery-rails'
gem 'gon'

gem 'bcrypt', '~> 3.1.7'
gem 'pg'

gem 'puma'
gem 'rack-cors'

gem 'omniauth-twitter'
gem 'tweetstream'

gem 'sidekiq'

gem 'redis'
gem 'redis-rails'
gem 'redis-namespace'

gem 'parallel'
gem 'whenever'

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner'
  gem 'faker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
