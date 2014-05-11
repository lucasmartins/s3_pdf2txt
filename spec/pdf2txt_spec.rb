require_relative "spec_helper"
require_relative "../pdf2txt.rb"

def app
  Pdf2txt
end

describe Pdf2txt do
  let(:params){ {'file_url'=>'http://s3.amazon.com/foo/bar.pdf', 'callback_url'=>'http://0.0.0.0/txt/callback'} }
  context 'with good params' do
    it 'schedules the job' do
      ConverterWorker.should_receive(:perform_async).with(params['file_url'],params['callback_url'])
      post '/convert', params.to_json, {content_type: 'application/json'}
      expect(last_response.status).to eq(200)
    end
  end
  context 'with bad params' do
    it "raises params error" do
      post '/convert', '', {content_type: 'application/json'}
      expect(JSON.parse(last_response.body)).to eq({"message"=>"invalid params"})
      expect(last_response.status).to eq(400)
    end
  end  
end
