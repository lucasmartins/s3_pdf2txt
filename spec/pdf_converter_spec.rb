require_relative "spec_helper"

describe PdfConverter do
  describe 'validate_params' do
    let(:params){ {'foo'=>'bar', 'baz'=>'zoo'} }
    let(:expected_params){ ['foo','baz'] }
    it 'validates the presence of hash keys' do
      expect(Sinatra::Hat.validate_params(params,expected_params)).to be_true
    end
  end
end
