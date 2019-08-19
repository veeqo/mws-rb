# frozen_string_literal: true

module MWS
  # Auth
  class Auth < Query
    def initialize(params = {})
      super
      @app_instance_id = params[:app_instance_id]
      @return_path = params[:return_path]

      raise(ArgumentError, "You must provide #{required_params}") unless valid_params?
    end
    attr_reader :app_instance_id, :return_path

    def authorization_url
      request_uri
    end

    protected

    def required_params
      %i[host aws_access_key_id aws_secret_access_key app_instance_id return_path]
    end

    def valid_params?
      required_params.all? { |parameter| send(parameter).present? }
    end

    def base_query(signature = nil)
      query = {
        'AWSAccessKeyId' => aws_access_key_id,
        'id' => app_instance_id,
        'SignatureMethod' => signature_method,
        'SignatureVersion' => signature_version,
        'returnPathAndParameters' => return_path
      }
      query['Signature'] = signature if signature
      query
    end
  end
end
