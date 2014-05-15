# encoding: UTF-8

require 'bundler'

Bundler.setup
Bundler.require

ENV["RACK_ENV"] = "test"
ENV["AWS_S3_BUCKET"] ||= "test-bucket"

require 'rspec'
require 'rack/test'
require 'pry'
require 'pry-nav'
require 'find'
require 'sidekiq/testing'
require 'vcr'
require 'webmock/rspec'

%w{./config/initializers ./lib}.each do |load_path|
  Find.find(load_path) { |f| require f if f.match(/\.rb$/) }
end

def app
  raise 'define the f#king app!'
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

VCR.configure do |c|
  # record modes: :once, :new_episodes, :none, :all
  c.allow_http_connections_when_no_cassette = true # necessary for non-vcr wrapped tests
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock # or :fakeweb
end