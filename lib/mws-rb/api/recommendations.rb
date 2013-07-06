module MWS
  module Recommendations

    Actions = %w(GetLastUpdatedTimeForRecommendations ListRecommendations ListRecommendationsByNextToken)

    #GetLastUpdatedTimeForRecommendations - Checks whether there are active recommendations for each category for the given marketplace, and if there are, returns the time when recommendations were last updated for each category.
    #ListRecommendations = Returns your active recommendations for a specific category or for all categories for a specific marketplace.
    #ListRecommendationsByNextToken - Returns the next page of recommendations using the NextToken parameter.
    #
    # More info here http://docs.developer.amazonservices.com/en_US/recommendations/index.html

    def self.call_api(api, action, params={})
      api.post(
        uri: "/Recommendations/2013-04-01",
        action: action.to_s.camelize,
        version: "2013-04-01",
        params: params
      )
    end
  end
end
