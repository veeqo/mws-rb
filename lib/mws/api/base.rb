module MWS
  module API
    # Base Class
    class Base
      attr_reader :connection, :uri, :version, :verb

      # TODO: Temporary solution, move to configuration
      DEFAULT_TIMEOUT = 2000
      USER_AGENT = 'User-Agent'.freeze
      STRICT_MEHTHOD_ENDING = '!'.freeze

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
          print_upcoming_functionality_warning(name) if MWS.display_warnings

          call(name, *args)
        elsif self.class::ACTIONS.include?(method_without_bang(name))
          response = call(method_without_bang(name), *args)

          return response unless response.key?(MWS::API::RESPONSE_ERROR_KEY)

          raise MWS::API::ResponseError, response.to_json
        else
          super
        end
      end

      def respond_to_missing?(name, include_private = false)
        self.class::ACTIONS.include?(name) ||
          self.class::ACTIONS.include?(method_without_bang(name)) ||
          super
      end

      def http_request_options
        @http_request_options ||= begin
          options = { timeout: DEFAULT_TIMEOUT }
          options.merge!(headers: { USER_AGENT => MWS.user_agent }) if MWS.user_agent.present?
          options
        end
      end

      private

      def method_without_bang(name)
        name.to_s.chomp(STRICT_MEHTHOD_ENDING).to_sym
      end

      def print_upcoming_functionality_warning(name)
        warn "[WARNING] `#{name}` will have the same functionality as `#{name}!` " \
              "in the next major version."
      end
    end
  end
end
