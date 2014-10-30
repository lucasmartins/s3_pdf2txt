class CallbackWorker
  include Sidekiq::Worker
  def perform(callback_url, body, params)
    puts "Calling back to #{callback_url} with params: #{params}, and body:\n#{body}"
    ServiceCallback.send(callback_url, body, params)
  end
end
