# rewrite for heroku sake
if ENV['REDISTOGO_URL']
  ENV['REDIS_URL']=ENV['REDISTOGO_URL']
end

Sidekiq.options[:concurrency]=ENV['SIDEKIQ_CONCURRENCY'].to_i if ENV['SIDEKIQ_CONCURRENCY']
puts Sidekiq.options

Sidekiq.configure_server do |config|
  config.redis = { :url => ENV['REDIS_URL'], :namespace => 'pdf2txt' }
  environment = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
end

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV['REDIS_URL'], :namespace => 'pdf2txt' }
end
