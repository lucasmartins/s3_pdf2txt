require 'config/boot.rb'

# Load app
require 'sidekiq/web'
require "pdf2txt"
run Rack::URLMap.new('/' => Pdf2txt, '/sidekiq' => Sidekiq::Web)
