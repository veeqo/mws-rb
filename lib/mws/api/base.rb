module MWS
  module API
    # Base Class
    class Base
      attr_reader :connection, :uri, :version, :verb

      # TODO: Temporary solution, move to configuration
      DEFAULT_TIMEOUT = 2000

      def initialize(connection)
        @verb ||= :get
        @connection = connection
      end

      def call(action, params = {})
        @verb ||= params.delete(:verb)
        query = build_query_from_params(action, params)

        case @verb.to_s.upcase
        when 'GET'
          HTTParty.get(query.request_uri, http_request_options)
        when 'POST'
          HTTParty.post(query.request_uri, (params[:request_params] || {}).merge(http_request_options))
        end
      end

      def build_query_from_params(action, params)
        Query.new(verb: @verb,
                  uri: @uri,
                  host: @connection.host,
                  aws_access_key_id: @connection.aws_access_key_id,
                  aws_secret_access_key: @connection.aws_secret_access_key,
                  seller_id: @connection.seller_id,
                  mws_auth_token: @connection.mws_auth_token,
                  action: action.to_s.camelize,
                  version: @version,
                  params: params.except(:request_params))
      end

      def method_missing(name, *args)
        if self.class::ACTIONS.include?(name)
          call(name, *args)
        else
          super
        end
      end

      def http_request_options
        {
          timeout: DEFAULT_TIMEOUT
        }
      end
    end
  end
end
