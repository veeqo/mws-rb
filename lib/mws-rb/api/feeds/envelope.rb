class MWS::API::Feeds::Envelope
  def initialize(params={})
    @envelope = build_envelope(params)
    validate! unless params[:skip_schema_validation] == true
  end

  def valid?
    self.errors.count == 0
  end

  def validate!
    unless valid?
      raise "Invalid XML:\n" + self.errors.join("\n")
    end
  end

  def md5
    Digest::MD5.base64digest(self)
  end

  def to_str
    to_s
  end

  def to_s
    result = @envelope.target!
    result.gsub!('<Items type="array">', "")
    result.gsub!('</Items>', "")
    result.gsub!('<Inventories type="array">', "")
    result.gsub!('</Inventories>', "")
    result
  end

  def xsd
    Nokogiri::XML::Schema(File.open(File.join(MWS::API::Feeds::XSD_PATH, "amzn-envelope.xsd")))
  end

  def errors
    @errors ||= xsd.validate(Nokogiri::XML(self))
  end

  private
  def build_envelope(params={})
    xml = Builder::XmlMarkup.new
    xml.instruct!

    xml.AmazonEnvelope do
      xml.Header do
        xml.DocumentVersion "1.01"
        xml.MerchantIdentifier params[:merchant_id]
      end

      xml.MessageType params[:message_type].to_s.camelize
      xml.PurgeAndReplace params[:purge_and_replace] || false

      messages_array(params).map do |message|
        xml << message_xml(message)
      end
    end
    xml
  end

  def messages_array params
    # TODO: Questinable solution. Maybe better to take into account
    # only one of these parameters

    get_array(params[:message]) + get_array(params[:messages])
  end

  def get_array parameter
    [ parameter ].flatten.compact
  end

  def message_xml message
    message.to_xml(skip_instruct: true, root: "Message")
  end
end
