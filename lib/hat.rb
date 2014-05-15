# Just an utilily module, this won't last much.
module Sinatra::Hat
  def self.validate_params(incoming_params,expected_params)
    incoming_params.keys.sort==expected_params.sort
  end
end