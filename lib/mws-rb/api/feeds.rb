module MWS
  module API
    class Feeds < Base
      Actions = [:get_feed_submission_list, :get_feed_submission_list_by_next_token,
                 :get_feed_submission_count, :cancel_feed_submissions, :get_feed_submission_result ]

      def initialize(connection)
        @uri = "/"
        @version = "2009-01-01"
        @verb = :post
        super
      end

      def submit_feed(params={})
        xml_envelope = Envelope.new(params)
        params = params.except(:merchant_id, :message_type, :message)
        call(:submit_feed, params.merge!(
          request_params: {
            format: "xml",
            headers: {
              "Content-MD5" => xml_envelope.md5
            },
            body: xml_envelope.to_s
          }
        ))
      end
    end
  end
end
