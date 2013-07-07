module MWS
  module API
    module Reports

      Actions = %w(RequestReport GetReportRequestList GetReportRequestListByNextToken GetReportRequestCount
                   CancelReportRequests GetReportList GetReportListByNextToken GetReportCount GetReport
                    ManageReportSchedule GetReportScheduleList GetReportScheduleListByNextToken GetReportScheduleCount
                    UpdateReportAcknowledgements)

      # RequestReport - Creates a report request and submits the request   to Amazon MWS.
      # GetReportRequestList - Returns a list of report requests tohat you can use to get the ReportRequestId for a report.
      # GetReportRequestListByNextToken - Returns a list of report requests using the NextToken.
      # GetReportRequestCount - Returns a count of report requests that HasNextave been submitted to Amazon MWS for processing.
      # CancelReportRequests - Cancels one or more report requests.
      # GetReportList - Returns a list of reports that were created in the previous 90 days.
      # GetReportListByNextToken - Returns a list of reports using the NextToken.
      # GetReportCount - Returns a count of the reportsts, created in the previous 90 days.
      # GetReport - Returns the contents of a report and the Connectionntent-MD5 header for the returned report body.
      # ManageReportSchedule - Creates, updates, or deletes a report request schedule for a specified report type.
      # GetReportScheduleList - Returns a list of order report requests that are scheduled to be submitted.
      # GetReportScheduleListByNextToken - Currently this operation can never be called.
      # GetReportScheduleCount - Returns a count of order reportort requests that are scheduled to be submitted to Amazon MWS.
      # UpdateReportAcknowledgements - Updates the acknowledged status of one or more reports
      #
      # More info here http://docs.developer.amazonservices.com/en_US/reports/index.html

      def self.call_api(api, action, params={})
        api.get(
          uri: "/",
          action: action.to_s.camelize,
          version: "2009-01-01",
          params: params
        )
      end
    end
  end
end
