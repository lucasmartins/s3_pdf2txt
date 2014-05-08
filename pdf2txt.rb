class Pdf2txt < Sinatra::Base
  post '/convert' do
    content_type :json
    unless params.has_key?('file_url')
      status 400
      json({'message'=>'invalid params'})
    else
      status 200
    end
    # convert pdf
    # call callback telling the url of the TXT file.
  end

  def validate_params(incoming_params,expected_params)
    incoming_params.keys.sort==expected_params.sort
  end
end
