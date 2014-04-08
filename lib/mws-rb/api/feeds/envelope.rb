class MWS::API::Feeds::Envelope
  def initialize(params={})
    unless params[:type] == 'text'
      @type = :xml
      @envelope = build_envelope(params)
    else
      @type = :text
      @envelope = params[:message]
    end
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
    if @type == :text
      result = @envelope 
    else
      result = @envelope.target!
      result.gsub!('<Items type="array">', "")
      result.gsub!('</Items>', "")
      result.gsub!('<Inventories type="array">', "")
      result.gsub!('</Inventories>', "")
    end
    result
  end

  def xsd
    Nokogiri::XML::Schema(File.open(File.join(File.dirname(__FILE__),"xsd/amzn-envelope.xsd")))
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

      xml << params[:message].to_xml(skip_instruct: true, root: "Message") if params[:message]
      xml << {"Messages" => params[:messages]}.to_xml(skip_instruct: true) if params[:messages]
    end
    xml
  end
end
