require_relative "spec_helper"

describe ServiceCallback do
  describe '.send' do
    let(:callback_url){ 'http://127.0.0.1:9292/mock_callback' }
    let(:params){ {'foo'=>'bar', 'baz'=>'zoo'} }
    let(:body) { 'this is a sample body' }

    it 'sends a request to the callback_url' do
      VCR.use_cassette('service_callback.send', :record => :once) do
        response = ServiceCallback.send(callback_url, body, params)
        expect(response.code).to eq(200)
      end
    end

    it 'raises exception unless HTTP code is 200 OK' do
      VCR.use_cassette('service_callback.send_404', :record => :once) do
        expect{ ServiceCallback.send('http://nonexisting.service', body, params) }.to raise_error
      end
    end
  end
end
