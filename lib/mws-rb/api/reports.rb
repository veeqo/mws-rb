module MWS
  class Reports
    def initialize(connection, api)
      @connection = connection
      @api = api
    end

    def request_report(params={})
      @api.get(
        uri: "/",
        action: "RequestReport",
        version: "2009-01-01",
        parameters: params
      )
    end

    def get_report_request_list(params={})
      @api.get(
        uri: "/",
        action: "GetReportRequestList",
        version: "2009-01-01",
        parameters: params
      )
    end

    def get_report_request_list_by_next_token(next_token)
      @api.get(
        uri: "/",
        action: "GetReportRequestListByNextToken",
        version: "2009-01-01",
        parameters: {:next_token => next_token}
      )
    end

    def get_report_request_count(params={})
      @api.get(
        uri: "/",
        action: "GetReportRequestCount",
        version: "2009-01-01",
        parameters: params
      )
    end

    def cancel_report_requests(params={})
      @api.get(
        uri: "/",
        action: "CancelReportRequests",
        version: "2009-01-01",
        parameters: params
      )
    end

    def get_report_list(params={})
      @api.get(
        uri: "/",
        action: "GetReportList",
        version: "2009-01-01",
        parameters: params
      )
    end

    def get_report_list_by_next_token(next_token)
      @api.get(
        uri: "/",
        action: "GetReportListByNextToken",
        version: "2009-01-01",
        parameters: {:next_token => next_token}
      )
    end

    def get_report_count(params={})
      @api.get(
        uri: "/",
        action: "GetReporCount",
        version: "2009-01-01",
        parameters: params
      )
    end

    def get_report(report_id)
      @api.get(
        uri: "/",
        action: "GetReport",
        version: "2009-01-01",
        parameters: {:report_id => report_id}
      )
    end

    def manage_report_schedule(params={})
      @api.get(
        uri: "/",
        action: "ManageReportSchedule",
        version: "2009-01-01",
        parameters: params
      )
    end

    def get_report_schedule_list(params={})
      @api.get(
        uri: "/",
        action: "GetReportScheduleList",
        version: "2009-01-01",
        parameters: params
      )
    end

    # Currently this operation can never be called because the GetReportScheduleList
    # operation cannot return more than 100 results. It is included for future compatibility.
    def get_report_schedule_list_by_next_token(next_token)
    end

    def get_report_schedule_count(params={})
      @api.get(
        uri: "/",
        action: "GetReportScheduleCount",
        version: "2009-01-01",
        parameters: params
      )
    end

    def update_report_acknowledgements(params={})
      @api.get(
        uri: "/",
        action: "UpdateReportAcknowledgements",
        version: "2009-01-01",
        parameters: params
      )
    end
  end
end
