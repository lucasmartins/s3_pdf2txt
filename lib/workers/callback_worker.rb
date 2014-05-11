class CallbackWorker
  include Sidekiq::Worker
  def perform(callback_url, body, params)
    ServiceCallback.send(callback_url, body, params)
  end
end
