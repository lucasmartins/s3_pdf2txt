require 'aws/s3'

class S3UploaderWorker
  include Sidekiq::Worker
  include AWS::S3
  def perform(file_origin,file_destination, bucket=ENV['AWS_S3_BUCKET'])
    AWS::S3::Base.establish_connection!(access_key_id: ENV['AWS_S3_KEY'], secret_access_key: ENV['AWS_S3_SECRET'])
    response = S3Object.store(file_destination, open(file_origin), bucket, :access => :public_read)
    raise "Couldn't upload file!" unless response.code==200
  end
end