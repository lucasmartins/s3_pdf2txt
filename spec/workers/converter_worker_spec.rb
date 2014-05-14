require "spec_helper"

describe ConverterWorker do

  let(:file_url) { 'https://s3.amazonaws.com/teleforce-test/stub.pdf' }
  let(:file_url_2) { 'https://s3.amazonaws.com/teleforce-test/neogrid_gvt.pdf' }
  let(:storage_path) { PdfConverter.storage_path(file_url.split('/').last) }
  let(:callback_url) { 'https://0.0.0.0/txt/callback' }
  
  context 'vivo' do
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
        ServiceCallback.should_receive(:send).with(callback_url, nil, {"file_url"=>"https://s3.amazonaws.com/teleforce-test/stub.txt"}).and_return('something')
        run_job
      end
    end
  end

  context 'gvt' do
    describe '#perform' do
      def run_job
        Sidekiq::Testing.inline! do
          ConverterWorker.perform_async(file_url_2,callback_url)
        end
      end
      it 'retrieves the file successfully' do
        run_job
        expect(File.exists?(storage_path)).to be_true
      end
      it "calls callback" do
        ServiceCallback.should_receive(:send).with(callback_url, nil, {'file_url'=>'https://s3.amazonaws.com/teleforce-test/neogrid_gvt.txt'} ).and_return('something')
        run_job
      end
    end
  end
  
end