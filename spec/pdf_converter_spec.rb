require_relative "spec_helper"
# def self.retrieve_and_convert!(file_url, local_copy, &block)
describe PdfConverter do
  describe '.retrieve_and_convert!' do
    let(:file_url){ 'https://github.s3.amazonaws.com/media/progit.en.pdf' }
    let(:local_copy){ 'storage/progit.en.pdf' }
    let(:local_copy_txt){ 'storage/progit.en.txt' }
    before(:each) do
      File.delete(local_copy) if File.exists?(local_copy)
    end
    context 'NO block given' do
      before(:each) do
        PdfConverter.retrieve_and_convert!(file_url, local_copy)
      end
      it 'downloads the file' do      
        expect(File.exists?(local_copy)).to be_true
      end
    end
    context 'block given' do
      it 'calls the block with accessible variable scope' do
        PdfConverter.retrieve_and_convert!(file_url, local_copy) do |converted_file|
          expect(File.exists?(converted_file)).to be_true
          File.delete(converted_file)
        end
        expect(File.exists?(local_copy_txt)).to be_false
      end
    end
  end
end
