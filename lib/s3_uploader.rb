class S3Uploader
  include AWS::S3

  def self.upload(file_origin,file_destination, bucket=ENV['AWS_S3_BUCKET'], &block)
    raise "Invalid destination: #{file_destination}" if file_destination =~ /http/
    file_destination.gsub!('%2F','/') if file_destination.include?('%2F')
    puts "Uploading #{file_origin} to bucket: #{bucket}"
    url = S3::Signer.url_for(file_key: file_destination, method: 'PUT', acl: 'public-read', s3_bucket: bucket)
    request = Typhoeus::Request.new url, method: :put, body: File.open(file_origin).read, headers: {'X-Amz-Acl' => 'public-read'}
    request.on_headers do |response|
      unless response.code==200
        raise "Couldn't upload file!\n#{response}"
      end
    end
    request.on_complete do |response|
      raise 'File not available at S3' unless S3Object.exists?(file_destination, bucket)
      block.call(response) if block_given?
    end
    request.run
  end
end