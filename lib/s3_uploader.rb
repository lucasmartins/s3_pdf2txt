class S3Uploader
  include AWS::S3
  
  @mutex = Mutex.new
  @connection = AWS::S3::Base.establish_connection!(access_key_id: ENV['AWS_S3_KEY'], secret_access_key: ENV['AWS_S3_SECRET'])

  def self.upload(file_origin,file_destination, bucket=ENV['AWS_S3_BUCKET'], &block)
    @mutex.synchronize do
      raise "Invalid destination: #{file_destination}" if file_destination =~ /http/
      file_destination.gsub!('%2F','/') if file_destination.include?('%2F')
      puts "Uploading #{file_origin} to bucket: #{bucket}"
      response = S3Object.store(file_destination, open(file_origin), bucket, :access => :public_read)  
      raise "Couldn't upload file!" unless response.code==200
      raise 'File not available at S3' unless S3Object.exists?(file_destination, bucket)
      if block_given?
        block.call(response)
      else
        true
      end
    end
  end
end