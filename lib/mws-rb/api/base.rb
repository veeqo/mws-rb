module MWS
  module API
    class Base
      attr_reader :connection, :uri, :version

      def initialize(connection)
        @connection = connection
      end

      def call(action, params={})
        Query.new({
          verb: @verb,
          uri: @uri,
          host: @connection.host,

          aws_access_key_id: @connection.aws_access_key_id,
          aws_secret_access_key: @connection.aws_access_key_id,
          seller_id: @connection.seller_id,
          action: action.to_s.camelize,
          version: @version,
          params: params
        })
      end
    end
  end
end
