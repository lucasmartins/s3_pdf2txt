class ConverterWorker
  include Sidekiq::Worker

  def perform(file_url,callback_url)
    puts "Converting #{file_url} for #{callback_url}"
    storage_path = PdfConverter.storage_path(file_url.split('/').last)
    File.delete(storage_path) if File.exists?(storage_path)
    PdfConverter.retrieve_and_convert!(file_url,storage_path) do |new_file|
      new_url = file_url.sub('.pdf','.txt')
      S3Uploader.upload(new_file, file_url.split("#{ENV['AWS_S3_BUCKET']}/").last.sub('.pdf','.txt')) do
        CallbackWorker.perform_async(callback_url, nil, {file_url: new_url})
      end
    end
  end
end