module MWS
  module Sellers

    Actions = %w(ListMarketplaceParticipations ListMarketplaceParticipationsByNextToken GetServiceStatus)

    #ListMarketplaceParticipations - Returns a list of marketplaces that the seller submitting the request can sell in, and a list of participations that include seller-specific information in that marketplace.
    #ListMarketplaceParticipationsByNextToken - Returns the next page of marketplaces and participations using the NextToken.
    #GetServiceStatus - Returns the operational status of the Sellers API section.
    #
    # More info here http://docs.developer.amazonservices.com/en_US/sellers/index.html

    def self.call_api(api, action, params={})
      api.post(
        uri: "/Sellers/2011-07-01",
        action: action.to_s.camelize,
        version: "2011-07-01",
        params: params
      )
    end
  end
end
