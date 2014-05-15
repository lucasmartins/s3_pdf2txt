require "spec_helper"

describe ConverterWorker do

  URL_PREFIX="https://s3.amazonaws.com/#{ENV['AWS_S3_BUCKET']}"
  let(:pdf_file_url) { "#{URL_PREFIX}/fixture_two.pdf" }
  let(:pdf_file_url_2) { "#{URL_PREFIX}/fixture_one.pdf" }
  let(:txt_file_url) { "#{URL_PREFIX}/fixture_two.txt" }
  let(:txt_file_url_2) { "#{URL_PREFIX}/fixture_one.txt" }
  let(:storage_path) { PdfConverter.storage_path(pdf_file_url.split('/').last) }
  let(:storage_path_2) { PdfConverter.storage_path(pdf_file_url_2.split('/').last) }
  let(:callback_url) { 'https://0.0.0.0/txt/callback' }
  
  before(:all) do
    AWS::S3::Base.establish_connection!(access_key_id: ENV['AWS_S3_KEY'], secret_access_key: ENV['AWS_S3_SECRET'])
  end

  context 'fixture one' do
    before(:each) do
      AWS::S3::S3Object.delete storage_path, ENV['AWS_S3_BUCKET']
    end
    describe '#perform' do
      def run_job
        Sidekiq::Testing.inline! do
          ConverterWorker.perform_async(pdf_file_url,callback_url)
        end
      end
      it 'retrieves the file successfully' do
        run_job
        expect(File.exists?(storage_path)).to be_true
      end
      it 'uploads to S3' do
        expect(AWS::S3::S3Object.exists?('fixture_one.txt', ENV['AWS_S3_BUCKET'])).to be_true
      end
      it "calls callback" do
        ServiceCallback.should_receive(:send).with(callback_url, nil, {"file_url"=>txt_file_url}).and_return('something')
        run_job
      end
    end
  end

  context 'fixture two' do
    before(:each) do
      AWS::S3::S3Object.delete storage_path_2, ENV['AWS_S3_BUCKET']
    end
    describe '#perform' do
      def run_job
        Sidekiq::Testing.inline! do
          ConverterWorker.perform_async(pdf_file_url_2,callback_url)
        end
      end
      it 'retrieves the file successfully' do
        run_job
        expect(File.exists?(storage_path_2)).to be_true
      end
      it 'uploads to S3' do
        expect(AWS::S3::S3Object.exists?('fixture_two.txt', ENV['AWS_S3_BUCKET'])).to be_true
      end
      it "calls callback" do
        ServiceCallback.should_receive(:send).with(callback_url, nil, {'file_url'=>txt_file_url_2} ).and_return('something')
        run_job
      end
    end
  end
  
end