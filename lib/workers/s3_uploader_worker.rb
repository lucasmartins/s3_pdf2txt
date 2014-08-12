require 'aws/s3'

class S3UploaderWorker
  include Sidekiq::Worker
  @mutex = Mutex.new

  def perform(file_origin,file_destination)
    @mutex.synchronize do
      S3Uploader.upload(file_origin, file_destination)
    end
  end
end