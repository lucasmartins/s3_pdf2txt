 # encoding : utf-8
require 'openssl'
require 'digest/sha1'
require 'base64'

module S3
  module Signer
    extend self
    def url_for(file_key:, method: 'GET', s3_key: ENV['AWS_S3_KEY'], s3_secret: ENV['AWS_S3_SECRET'], s3_bucket: ENV['AWS_S3_BUCKET'], acl: nil, expire_date: Time.now.to_i+900)
      digest = OpenSSL::Digest::Digest.new('sha1')
      if acl=='public-read'
        acl_string = "x-amz-acl:public-read\n"
      end
      can_string = "#{method}\n\n\n#{expire_date}\n#{acl_string}/#{s3_bucket}/#{file_key}"
      hmac = OpenSSL::HMAC.digest(digest, s3_secret, can_string)
      signature = URI.escape(Base64.encode64(hmac).strip).encode_signs
      "https://s3.amazonaws.com/#{s3_bucket}/#{file_key}?AWSAccessKeyId=#{s3_key}&Expires=#{expire_date}&Signature=#{signature}"
    end
  end
end

class String
  def encode_signs
    signs = {'+' => "%2B", '=' => "%3D", '?' => '%3F', '@' => '%40',
      '$' => '%24', '&' => '%26', ',' => '%2C', '/' => '%2F', ':' => '%3A',
      ';' => '%3B', '?' => '%3F'}
    signs.keys.each do |key|
      self.gsub!(key, signs[key])
    end
    self
  end
end