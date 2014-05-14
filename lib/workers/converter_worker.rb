class ConverterWorker
  include Sidekiq::Worker
  def perform(file_url,callback_url)
    storage_path = PdfConverter.storage_path(file_url.split('/').last)
    File.delete(storage_path) if File.exists?(storage_path)
    PdfConverter.retrieve_and_convert!(file_url,storage_path) do
      CallbackWorker.perform_async(callback_url, nil, {file_url: file_url.sub('.pdf','.txt')})
    end
  end
end