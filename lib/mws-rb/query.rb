module MWS
  class Query
    attr_reader :verb, :uri, :host, :aws_access_key_id, :aws_secret_access_key, :action, :seller_id,
                :signature_method, :signature_version, :timestamp, :version

    def initialize(params={})
      @verb = params[:verb] || "GET"
      @uri = params[:uri] || "/"
      @host = params[:host]

      @aws_access_key_id = params[:aws_access_key_id]
      @aws_secret_access_key = params[:aws_secret_access_key]
      @action = params[:action]
      @seller_id = params[:seller_id]
      @signature_method = params[:signature_method] || "HmacSHA256"
      @signature_version = params[:signature_version] || 2
      @timestamp = params[:timestamp] || Time.now
      @version = params[:version]

      @params = params[:params]
    end

    def request_uri
      "https://" << @host << @uri << '?' << build_query(signature)
    end

    def canonical
      [@verb.to_s.upcase, @host.downcase, @uri, build_query].join("\n")
    end

    def signature
      digest = OpenSSL::Digest::Digest.new('sha256')
      Base64.encode64(OpenSSL::HMAC.digest(digest, aws_secret_access_key, canonical)).chomp
    end

    def build_query(signature=nil)
      query = {
        "AWSAccessKeyId" => @aws_access_key_id,
        "Action" => @action,
        "SellerId" => @seller_id,
        "SignatureMethod" => @signature_method,
        "SignatureVersion" => @signature_version,
        "Timestamp" => @timestamp,
        "Version" => @version
      }
      query["Signature"] = signature if signature

      params = Helpers.camelize_keys(@params || {})
      query.merge!(params)
      Helpers.escape_date_time_params(query).to_query
    end

    module Helpers
      def self.escape_date_time_params(params={})
        params.map do |key, value|
          case value.class.name
          when "Time", "Date", "DateTime"
            {key => value.iso8601}
          when "Hash"
            {key => escape_date_time_params(value)}
          else
            {key => value}
          end
        end.reduce({}, :merge)
      end

      def self.camelize_keys(params={})
        params.map do |key, value|
          case value.class.name
          when "Hash"
            {key.to_s.camelize => camelize_keys(value)}
          else
            {key.to_s.camelize => value}
          end
        end.reduce({}, :merge)
      end
    end
  end
end
