class ConverterWorker
  include Sidekiq::Worker
  def perform(file_url,callback_url)
    puts "Converting #{file_url} for #{callback_url}"
    storage_path = PdfConverter.storage_path(file_url.split('/').last)
    File.delete(storage_path) if File.exists?(storage_path)
    PdfConverter.retrieve_and_convert!(file_url,storage_path) do |new_file|
      new_url = file_url.sub('.pdf','.txt')
      if S3Uploader.new.upload(new_file, file_url.split("#{ENV['AWS_S3_BUCKET']}/").last.sub('.pdf','.txt'))
        CallbackWorker.perform_async(callback_url, nil, {file_url: new_url})
      else
        raise "Unable to upload file, will retry later."
      end
    end
  end
end