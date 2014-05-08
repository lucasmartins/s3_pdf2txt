require 'net/http'

class ConverterWorker
  include Sidekiq::Worker
  def perform(file_url,callback_url)
    storage_path = Invoice.storage_path(invoice_id)
    File.delete(storage_path) if File.exists?(storage_path)
    PdfConverter.retrieve_file(file_url,storage_path) do |txt_file|
      puts "txt_file.size=#{txt_file.size}"
      puts 'callback_url here!'
    end
  end
end