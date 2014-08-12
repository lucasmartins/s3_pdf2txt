require "spec_helper"

describe S3UploaderWorker do

  let(:file_origin) { 'spec/fixtures/fixture_one.txt' }
  let(:file_destination) { 'fixture_one.txt' } # on S3
  
  describe '#perform' do
    it 'uploads successfully' do
      Sidekiq::Testing.inline! do
        expect{ S3UploaderWorker.perform_async(file_origin,file_destination) }.not_to raise_error
      end
    end
  end
end