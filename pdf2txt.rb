require 'sinatra/json'
require 'json'

class Pdf2txt < Sinatra::Base
  post '/convert' do
    content_type :json
    begin
      params = JSON.parse(request.body.read)  
      unless Sinatra::Hat.validate_params(params,['file_url','callback_url']) && params['callback_url'] =~ /https?:\/\/(\w.*):?\//
        invalid_params
      else
        puts "Conversion request accepted with params: #{params}"
        jid = ConverterWorker.perform_async(params['file_url'],params['callback_url'])
        status 200
        body({'jid'=>jid}.to_json)
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
