class ServiceCallback
  def self.send(callback_url, body=nil, params)
    request = Typhoeus::Request.new(
      callback_url,
      method: :post,
      body: body,
      params: params,
      header: {:Accept => "application/json", 'Content-Type' => "application/json"}
    )
    request.on_headers do |response|
      unless response.code==200
        raise "Request failed on HTTP #{response.code}"
      end
    end
    request.run
  end
end