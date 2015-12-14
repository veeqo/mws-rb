module MWS
  module API
    class Recommendations < Base
      ACTIONS = [:get_last_updated_time_for_recommendations_checks, :list_recommendations, :list_recommendations_by_next_token]

      def initialize(connection)
        @uri = "/Recommendations/2013-04-01"
        @version = "2013-04-01"
        super
      end
    end
  end
end
