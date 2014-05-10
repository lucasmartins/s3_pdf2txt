require "spec_helper"

describe ConverterWorker do

  let(:file_url) { 'https://s3.amazonaws.com/teleforce-test/stub.pdf' }
  let(:storage_path) { PdfConverter.storage_path(file_url.split('/').last) }
  let(:callback_url) { 'https://0.0.0.0/txt/callback' }
  
  describe '#perform' do
    def run_job
      Sidekiq::Testing.inline! do
        ConverterWorker.perform_async(file_url,callback_url)
      end
    end
    it 'retrieves the file successfully' do
      run_job
      expect(File.exists?(storage_path)).to be_true
    end
    it "calls callback" do
      ServiceCallback.should_receive(:send).and_return('something')
      run_job
    end
  end
end