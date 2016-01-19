require 'addressable/uri'

# MWS
module MWS
  # Query
  class Query
    attr_reader :verb, :uri, :host, :aws_access_key_id, :aws_secret_access_key, :mws_auth_token, :action, :seller_id,
                :signature_method, :signature_version, :timestamp, :version

    # rubocop:disable all
    def initialize(params = {})
      @verb = params[:verb] || 'GET'
      @uri = params[:uri] || '/'
      @host = params[:host]

      @aws_access_key_id = params[:aws_access_key_id]
      @aws_secret_access_key = params[:aws_secret_access_key]
      @mws_auth_token = params[:mws_auth_token]
      @action = params[:action].to_s.camelize.gsub(/(Sku|Asin)/i) { |_s| Regexp.last_match(1).upcase }
      @seller_id = params[:seller_id]
      @signature_method = params[:signature_method] || 'HmacSHA256'
      @signature_version = params[:signature_version] || 2
      @timestamp = params[:timestamp] || Time.now
      @version = params[:version]

      @params = params[:params]
    end

    def request_uri
      'https://' << @host << @uri << '?' << build_query(signature)
    end

    def canonical
      canonical = [@verb.to_s.upcase, @host.downcase, @uri, build_query].join("\n")
    end

    def signature
      digest = OpenSSL::Digest.new('sha256')
      Base64.encode64(OpenSSL::HMAC.digest(digest, aws_secret_access_key, canonical)).strip
    end

    def build_query(signature = nil)
      query = {
        'AWSAccessKeyId' => @aws_access_key_id,
        'Action' => @action,
        'SellerId' => @seller_id,
        'SignatureMethod' => @signature_method,
        'SignatureVersion' => @signature_version,
        'Timestamp' => @timestamp,
        'Version' => @version
      }
      query['MWSAuthToken'] = @mws_auth_token if @mws_auth_token
      query['Signature'] = signature if signature

      params = Helpers.camelize_keys(@params || {})
      params = Helpers.make_structured_lists(params)
      query.merge!(params)

      # Sort hash in natural-byte order
      uri = Addressable::URI.new
      uri.query_values = Hash[Helpers.escape_date_time_params(query).sort]
      uri.query
    end

    # Helpers
    module Helpers
      def self.escape_date_time_params(params = {})
        params.map do |key, value|
          case value.class.name
          when 'Time', 'Date', 'DateTime'
            { key => value.iso8601 }
          when 'Hash'
            { key => escape_date_time_params(value) }
          else
            { key => value }
          end
        end.reduce({}, :merge)
      end

      def self.camelize_keys(params = {})
        params.map do |key, value|
          case value.class.name
          when 'Hash'
            { key.to_s.camelize => camelize_keys(value) }
          else
            { key.to_s.camelize => value }
          end
        end.reduce({}, :merge)
      end

      def self.make_structured_lists(params = {})
        params.map do |key, value|
          if key.to_s.end_with?('list')
            value[:values].each_with_index.map do |item, index|
              { "#{value[:label]}.#{index + 1}" => item }
            end.reduce({}, :merge)
          else
            { key => value }
          end
        end.reduce({}, :merge)
      end
    end
  end
end
