module MWS
  class Recommendations
    def initialize(connection, api)
      @connection = connection
      @api = api
    end

    def get_last_updated_time_for_recommendations(marketplace_id)
      @api.post(
        uri: "/Recommendations/2013-04-01",
        action: "GetLastUpdatedTimeForRecommendations",
        version: "2013-04-01",
        parameters: {:marketplace_id => marketplace_id }
      )
    end

    def list_recommendations(params={})
      @api.post(
        uri: "/Recommendations/2013-04-01",
        action: "ListRecommendations",
        version: "2013-04-01",
        parameters: params
      )
    end

    def list_recommendations_by_next_token(next_token)
      @api.post(
        uri: "/Recommendations/2013-04-01",
        action: "ListRecommendationsByNextToken",
        version: "2013-04-01",
        parameters: {:next_token => next_token}
      )
    end
  end
end
