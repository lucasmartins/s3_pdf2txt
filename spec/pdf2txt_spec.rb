require_relative "spec_helper"
require_relative "../pdf2txt.rb"

def app
  Pdf2txt
end

describe Pdf2txt do
  context 'with good params' do
    it 'schedules the job' do
      post '/convert', {'file_url'=>'http://s3.amazon.com/foo/bar.pdf', 'callback_url'=>'http://0.0.0.0/txt/callback'}
      expect(last_response.status).to eq(200)
    end
  end
  context 'with bad params' do
    it "raises params error" do
      post '/convert'
      expect(JSON.parse(last_response.body)).to eq({"message"=>"invalid params"})
      expect(last_response.status).to eq(400)
    end
  end  
end
