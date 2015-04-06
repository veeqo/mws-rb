module MWS
  module API
    class Base
      attr_reader :connection, :uri, :version, :verb

      # TODO: Temporary solution, move to configuration
      DEFAULT_TIMEOUT = 2000

      def initialize(connection)
        @verb ||= :get
        @connection = connection
      end

      def call(action, params={})
        @verb = params.delete(:verb) || @verb

        # extract request_params for feeds api requests
        request_params = params[:request_params] || {}
        params = params.except(:request_params)

        # asin needs to be capitalized in requests
        if action.to_s.include?("ASIN")
          action = action.to_s.camelize
          action.sub! "Asin", "ASIN"
        else
          action = action.to_s.camelize
        end

        query = Query.new({
          verb: @verb,
          uri: @uri,
          host: @connection.host,

          aws_access_key_id: @connection.aws_access_key_id,
          aws_secret_access_key: @connection.aws_secret_access_key,
          seller_id: @connection.seller_id,
          action: action,
          version: @version,
          params: params
        })

        case @verb.to_s.upcase
        when "GET"
          HTTParty.get(query.request_uri, http_request_options)
        when "POST"
          HTTParty.post(query.request_uri, request_params.merge(http_request_options))
        end
      end

      def method_missing(name, *args)
        if self.class::Actions.include?(name)
          self.call(name, *args)
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
