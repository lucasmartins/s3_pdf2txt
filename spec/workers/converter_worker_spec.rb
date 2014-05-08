require "spec_helper"

describe ConverterWorker do

  let(:file_url) { 'https://s3.amazonaws.com/teleforce-test/stub.pdf' }
  let(:callback_url) { 'https://0.0.0.0/txt/callback' }
  
  describe '#perform' do
    before(:each) do
      Sidekiq::Testing.inline! do
        ConverterWorker.perform_async(file_url,callback_url)
      end
    end
    it 'retrieves the file successfully' do
      expect(File.exists?(invoice.storage_path)).to be_true
    end
    it "process the invoice" do
      expect(invoice.reload.processed).to be_true
    end
  end
end