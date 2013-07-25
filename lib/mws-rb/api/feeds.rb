module MWS
  module API
    class Feeds < Base
      Actions = [:submit_feed, :get_feed_submission_list, :get_feed_submission_list_by_next_token,
                 :get_feed_submission_count, :cancel_feed_submissions, :get_feed_submission_result ]

      def initialize(connection)
        @uri = "/"
        @version = "2009-01-01"
        super
      end
    end
  end
end
