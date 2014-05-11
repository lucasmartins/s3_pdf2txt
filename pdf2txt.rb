require 'json'

class Pdf2txt < Sinatra::Base
  post '/convert' do
    content_type :json
    begin
      params = JSON.parse(request.body.read)  
      unless Sinatra::Hat.validate_params(params,['file_url','callback_url'])
        invalid_params
      else
        jid = ConverterWorker.perform_async(params['file_url'],params['callback_url'])
        status [200,{jid: jid}]
      end
    rescue JSON::ParserError => e
      invalid_params
    end
  end

  if ENV['RACK_ENV']=='development'
    post '/mock_callback' do
      content_type :json
      puts request.inspect
      status 200
    end  
  end

  private
  def invalid_params
    status 400
    json({'message'=>'invalid params'})
  end
end
