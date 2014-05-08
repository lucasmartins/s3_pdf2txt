class Pdf2txt < Sinatra::Base
  post '/convert' do
    content_type :json
    unless Sinatra::Hat.validate_params(params,['file_url','callback_url'])
      status 400
      json({'message'=>'invalid params'})
    else
      status 200
    end
    # convert pdf
    # call callback telling the url of the TXT file.
  end
end
