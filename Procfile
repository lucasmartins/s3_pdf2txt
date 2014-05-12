web: puma -p $PORT -e $RACK_ENV
worker: bundle exec sidekiq -r config/boot.rb