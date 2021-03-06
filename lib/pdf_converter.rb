require 'java'
require 'vendor/pdfbox-1.8.4.jar'
require 'vendor/commons-logging-1.1.3.jar'
require 'vendor/fontbox-1.8.4.jar'
java_import 'org.apache.commons.logging.LogFactory'
java_import 'org.apache.pdfbox.ExtractText'

class PdfConverter
  def self.convert!(original)
    destination = change_extension(original,'txt')
    org.apache.pdfbox.ExtractText.main([original,destination])
    destination
  end

  # callback
  # {'status':0, 'sha1':'pdf file sha1', 'glue_id':'mongo hash'}
  def self.retrieve_and_convert!(file_url, local_copy, &block)
    raise 'invalid file_url' unless file_url =~ /http/
    raise 'invalid local_copy' unless  local_copy
    File.delete(local_copy) if File.exists?(local_copy)
    downloaded_file = File.open local_copy, 'wb'
    request = Typhoeus::Request.new(file_url)
    request.on_headers do |response|
      unless response.code==200
        raise "Request failed on HTTP #{response.code}"
      end
    end
    request.on_body do |chunk|
      downloaded_file.write(chunk)
    end
    request.on_complete do |response|
      downloaded_file.close
      new_file = convert!(local_copy)
      raise "File conversion went bad, not found on #{new_file}" unless File.exists?(new_file)
      block.call(new_file) if block_given?
    end
    request.run
  end

  def self.storage_path(filename)
    "storage/#{filename}"
  end

  private
  def self.change_extension(filename,new_ext)
    old_ext = filename.split('.').last
    filename.sub(".#{old_ext}",".#{new_ext}")
  end

  def self.rename_to_sha1(filename)
    FileUtils.mv(filename,generate_sha1(filename))
  end

  def self.generate_sha1(filename)
    `shasum #{filename}`.split(' ').first
  end
end