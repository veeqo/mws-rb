module MWS
  module API
    class Reports < Base
      ACTIONS = [:request_report, :get_report_request_list, :get_report_request_list_by_next_token,
                 :get_report_request_count, :cancel_report_requests, :get_report_list, :get_report_list_by_next_token,
                 :get_report_count, :get_report, :manage_report_schedule, :get_report_schedule_list,
                 :get_report_schedule_list_by_next_token, :get_report_schedule_count, :update_report_acknowledgements]

      def initialize(connection)
        @uri = "/"
        @version = "2009-01-01"
        super
      end
    end
  end
end
