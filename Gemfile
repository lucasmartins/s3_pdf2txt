source "https://rubygems.org/"

ruby "2.0.0", :engine => "jruby", :engine_version => "1.7.12"

# App Stack
gem "sinatra", "~> 1.4"
gem 'sinatra-contrib'
#gem 'bson_ext'
gem 'typhoeus'
gem 'sidekiq'
gem 'webmock'
gem 'aws-s3'

group :development, :test do
  gem 'foreman'
  gem 'vcr'
  gem "rake", "~> 10.0"
  gem 'rspec'
  #gem "minitest", "~> 5.2"
  #gem "rack-test", "~> 0.6"
  gem 'pry'
  gem 'pry-nav'
end
