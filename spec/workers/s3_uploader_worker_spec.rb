require "spec_helper"

describe S3UploaderWorker do

  let(:file_origin) { 'spec/fixtures/fixture_one.txt' }
  let(:file_destination) { 'fixture_one.txt' } # on S3
  
  describe '#perform' do
    before(:all) do
       AWS::S3::Base.establish_connection!(access_key_id: ENV['AWS_S3_KEY'], secret_access_key: ENV['AWS_S3_SECRET'])
    end
    it 'uploads successfully' do
      Sidekiq::Testing.inline! do
        expect{ S3UploaderWorker.perform_async(file_origin,file_destination) }.not_to raise_error
      end
    end
  end
end