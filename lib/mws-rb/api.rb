module MWS
  class Api
    def initialize(connection)
      @connection = connection
    end

    def get(options={})
      @options = options
      @connection.get(request_uri)
    end

    def post(options={})
      @options = options
      @connection.post(request_uri)
    end

    def request_uri
      "https://" << @connection.host << @options[:uri] << '?' << query(signature)
    end

    def canonical
      [@options[:verb].to_s.upcase, @connection.host.downcase, @options[:uri], query].join("\n")
    end

    def query(signature = nil)
      query = {
        :"AWSAccessKeyId" => @connection.aws_access_key_id,
        :"Action" => @options[:action],
        :"SellerId" => @connection.merchant_id,
        :"MarketplaceId.id.1" => @connection.marketplace_id,
        :"SignatureMethod" => "HmacSHA256",
        :"SignatureVersion" => 2,
        :"Timestamp" => Time.now.iso8601,
        :"Version" => @options[:version]
      }
      query[:"Signature"] = signature if signature

      query.merge(@options[:parameters]).to_query
    end

    def signature
      digest = OpenSSL::Digest::Digest.new('sha256')
      key = @connection.aws_secret_key
      Base64.encode64(OpenSSL::HMAC.digest(digest, key, canonical)).chomp
    end
  end
end
