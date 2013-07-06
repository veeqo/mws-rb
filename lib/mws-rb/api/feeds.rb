module AWS
  module Feeds

    Actions = %w(SubmitFeed GetFeedSubmissionList GetFeedSubmissionListByNextToken GetFeedSubmissionCoun
                 CancelFeedSubmissions GetFeedSubmissionResult)

    #SubmitFeed - Uploads a feed for processing by Amazon MWS.
    #GetFeedSubmissionList - Returns a list of all feed submissions submitted in the previous 90 days.
    #GetFeedSubmissionListByNextToken - Returns a list of feed submissions using the NextToken parameter.
    #GetFeedSubmissionCount - Returns a count of the feeds submitted in the previous 90 days.
    #CancelFeedSubmissions - Cancels one or more feed submissions and returns a count of the feed submissions that were canceled.
    #GetFeedSubmissionResult - Returns the feed processing report and the Content-MD5 header.
    #
    # More info here http://docs.developer.amazonservices.com/en_US/feeds/index.html
    #
    # params: {request: {format: :xml, body:{feed_content: "JSON OR XML"}}}

    def self.call_api(api, action, params={})
      api.post(
        uri: "/",
        action: action.to_s.camelize,
        version: "2009-01-01",
        params: params
      )
    end
  end
end
