# encoding: UTF-8

require 'bundler'

Bundler.setup
Bundler.require

ENV["RACK_ENV"] = "test"

require 'rspec'
require 'rack/test'
require 'pry'
require 'pry-nav'
require "find"

%w{./config/initializers ./lib}.each do |load_path|
  Find.find(load_path) { |f| require f if f.match(/\.rb$/) }
end

def app
  raise 'define the f#king app!'
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end