module MWS
  class Connection
    attr_reader :host, :aws_access_key_id, :aws_secret_key, :merchant_id, :marketplace_id

    def initialize(options={})
      @host = options[:host]
      @aws_access_key_id = options[:aws_access_key_id]
      @aws_secret_key = options[:aws_secret_key]
      @merchant_id = options[:merchant_id]
      @marketplace_id = options[:marketplace_id]
    end

    def get(uri)
      puts uri
      puts HTTParty.get(uri)
    end

    def post(uri)
    end
  end
end
