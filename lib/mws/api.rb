module MWS
  # API module
  module API
    ResponseError = Class.new(StandardError)

    RESPONSE_ERROR_KEY = 'ErrorResponse'.freeze
  end
end
