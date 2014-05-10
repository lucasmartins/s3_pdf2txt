require 'net/http'

class ConverterWorker
  include Sidekiq::Worker
  def perform(file_url,callback_url)
    storage_path = PdfConverter.storage_path(file_url.split('/').last)
    File.delete(storage_path) if File.exists?(storage_path)
    PdfConverter.retrieve_file(file_url,storage_path) do |txt_file|
      ServiceCallback.send(callback_url, txt_file, {size: txt_file.size})
    end
  end
end