# Bootloader
begin
  require 'dotenv'
  Dotenv.load
rescue Exception => e
  "It seems that you're not at development evironment, so I won't load Dotenv."
end

# Load path and gems/bundler
$LOAD_PATH << File.expand_path(File.dirname("../#{__FILE__}"))

require "bundler"
Bundler.require

# Local config
require "find"
require 'json'

%w{config/initializers lib}.each do |load_path|
  Find.find(load_path) { |f|
    require f unless f.match(/\/\..+$/) || File.directory?(f)
  }
end
