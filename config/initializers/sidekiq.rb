Sidekiq.configure_server do |config|
  config.redis = { :url => ENV['REDIS_URL'], :namespace => 'pdf2text' }
  environment = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
end

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV['REDIS_URL'], :namespace => 'pdf2text' }
end
