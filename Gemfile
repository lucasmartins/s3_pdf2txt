source "https://rubygems.org/"

if ENV['TRAVIS']
  # This line is here because Travis won't install jruby-20mode, so I'm using jruby-head.
  ruby "2.1.2", :engine => "jruby", :engine_version => "9000.dev"
elsif ENV['DYNO']
  # This line should be used for stable deploys
  ruby "2.0.0", :engine => "jruby", :engine_version => "1.7.12"
else
  # rbenv adds 'SNAPSHOT' to the end
  ruby "2.1.2", :engine => "jruby", :engine_version => "9000.dev-SNAPSHOT"
end

gem 'dotenv', groups: [:development, :test]

# App Stack
gem "sinatra", "~> 1.4"
gem 'sinatra-contrib'
#gem 'bson_ext'
gem 'typhoeus'
gem 'sidekiq'
gem 'aws-s3'
gem 'puma'

group :production, :staging do
  gem 'appsignal'
end

group :development, :test do
  gem 'foreman'
  gem 'vcr'
  gem "rake", "~> 10.0"
  gem 'rspec'
  gem 'webmock'
  gem 'pry'
  gem 'pry-nav'
end

gem "codeclimate-test-reporter", group: :test, require: nil
