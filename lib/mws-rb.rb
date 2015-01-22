require 'httparty'
require 'base64'
require 'openssl'
require 'active_support/core_ext'
require 'builder'
require 'nokogiri'

require_relative 'mws-rb/query'
require_relative 'mws-rb/connection'
require_relative 'mws-rb/api/base'
require_relative 'mws-rb/api/orders'
require_relative 'mws-rb/api/reports'
require_relative 'mws-rb/api/products'
require_relative 'mws-rb/api/sellers'
require_relative 'mws-rb/api/subscriptions'
require_relative 'mws-rb/api/recommendations'
require_relative 'mws-rb/api/fulfillment_inventory'
require_relative 'mws-rb/api/fulfillment_inbound_shipment'
require_relative 'mws-rb/api/fulfillment_outbound_shipment'
require_relative 'mws-rb/api/feeds'
require_relative 'mws-rb/api/feeds/envelope'

module MWS
  @@aws_access_key_id = nil
  @@aws_secret_access_key = nil

  def self.aws_access_key_id=(key_id)
    @@aws_access_key_id = key_id
  end

  def self.aws_access_key_id
    @@aws_access_key_id
  end

  def self.aws_secret_access_key=(secret_key)
    @@aws_secret_access_key =  secret_key
  end

  def self.aws_secret_access_key
    @@aws_secret_access_key
  end

  def self.new(options={})
    @connection = MWS::Connection.new(options)
  end

  # Allow using using a global key and secret
  def self.config
    yield self
  end
end
