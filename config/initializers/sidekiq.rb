# rewrite for heroku sake
if ENV['REDISTOGO_URL']
  ENV['REDIS_URL']=ENV['REDISTOGO_URL']
end

Sidekiq.configure_server do |config|
  config.redis = { :url => ENV['REDIS_URL'], :namespace => 'pdf2txt' }
  environment = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
end

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV['REDIS_URL'], :namespace => 'pdf2txt' }
end
