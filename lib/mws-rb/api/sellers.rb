module MWS
  class Sellers
    def initialize(connection, api)
      @connection = connection
      @api = api
    end

    def list_marketplace_participations
      @api.post(
        uri: "/Sellers/2011-07-01",
        action: "ListMarketplaceParticipations",
        version: "2011-07-01"
      )
    end

    def list_marketplace_participations_by_next_token(next_token)
      @api.post(
        uri: "/Sellers/2011-07-01",
        action: "ListMarketplaceParticipationsByNextToken",
        version: "2011-07-01",
        parameters: {:next_token => next_token}
      )
    end

    def get_service_status
      @api.post(
        uri: "/Sellers/2011-07-01",
        action: "GetServiceStatus",
        version: "2011-07-01"
      )
    end
  end
end
