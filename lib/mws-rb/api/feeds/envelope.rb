class MWS::API::Feeds::Envelope
  def initialize(params={})
    @envelope = build_envelope(params)
    validate! unless params[:skip_schema_validation] == true
  end

  def valid?
    true
  end

  def validate!
    raise "Invalid xml" unless valid?
  end

  def md5
    Digest::MD5.base64digest(@envelope)
  end

  def to_str
    @envelope
  end

  def to_s
    @envelope
  end

  private
  def build_envelope(params={})
    xml = Builder::XmlMarkup.new(indent: 2)
    xml.instruct!

    xml.AmazonEnvelope do
      xml.Header do
        xml.DocumentVersion "1.01"
        xml.MerchantIdentifier params[:merchant_id]
      end

      xml.MessageType params[:message_type].to_s.camelize
      xml.PurgeAndReplace = params[:purge_and_replace] || false

      xml << params[:message].to_xml(skip_instruct: true, root: "Message") 
    end
    xml.target!
  end
end
