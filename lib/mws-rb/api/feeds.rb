module MWS
  module API
    class Feeds < Base
      Actions = [:submit_feed, :get_feed_submission_list, :get_feed_submission_list_by_next_token,
                 :get_feed_submission_count, :cancel_feed_submissions, :get_feed_submission_result ]

      def initialize(connection)
        @uri = "/"
        @version = "2009-01-01"
        @verb = :post
        super
      end

      def submit_feed(params={})
        xml_envelope = build_envelope(params)
        params = params.except(:merchant_id, :message_type, :message)
        call(:submit_feed, params.merge!(
          request_params: {
            format: "xml",
            headers: {
              "Content-MD5" => Digest::MD5.base64digest(xml_envelope)
            },
            body: xml_envelope
          }
        ))
      end

      def build_envelope(params={})
        xml = Builder::XmlMarkup.new(indent: 2)
        xml.instruct!

        envelope_hash = {
          "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
          "xsi:noNamespaceSchemaLocation" => "amzn-envelope.xsd"
        }

        xml.AmazonEnvelope  envelope_hash do
          xml.Header do
            xml.DocumentVersion = "1.01"
            xml.MerchantIdentifier = params[:merchant_id]
          end

          xml.MessageType = params[:message_type].to_s.camelize
          xml.PurgeAndReplace = params[:purge_and_replace] || false

          xml << params[:message].to_xml(skip_instruct: true, root: "Message") 
        end
        xml.target!
      end
    end
  end
end
