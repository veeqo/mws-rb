module MWS
  module API
    # Base Class
    class Base
      attr_reader :connection, :uri, :version, :verb

      # TODO: Temporary solution, move to configuration
      DEFAULT_TIMEOUT = 2000
      USER_AGENT = 'User-Agent'.freeze

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
          HTTParty.post(
            query.request_uri,
            params.fetch(:request_params, {}).deep_merge(http_request_options)
          )
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
        @http_request_options ||= begin
          options = { timeout: DEFAULT_TIMEOUT }
          options.merge!(headers: { USER_AGENT => MWS.user_agent }) if MWS.user_agent.present?
          options
        end
      end
    end
  end
end
