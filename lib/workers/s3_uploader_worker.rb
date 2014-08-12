require 'aws/s3'

class S3UploaderWorker
  include Sidekiq::Worker
  def perform(file_origin,file_destination)
    S3Uploader.upload(file_origin, file_destination)
  end
end