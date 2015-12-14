module MWS
  module API
    class Sellers < Base
      ACTIONS = [:list_marketplace_participations,
                 :list_marketplace_participations_by_next_token,
                 :get_auth_token,
                 :get_service_status]

      def initialize(connection)
        @uri = "/Sellers/2011-07-01"
        @version = "2011-07-01"
        @verb = :post
        super
      end
    end
  end
end
