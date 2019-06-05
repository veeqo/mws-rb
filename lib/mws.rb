# rubocop:disable all
require 'httparty'
require 'base64'
require 'openssl'
require 'active_support'
require 'active_support/core_ext'
require 'builder'
require 'nokogiri'

require_relative 'mws/query'
require_relative 'mws/connection'
require_relative 'mws/api'
require_relative 'mws/api/base'
require_relative 'mws/api/orders'
require_relative 'mws/api/reports'
require_relative 'mws/api/products'
require_relative 'mws/api/sellers'
require_relative 'mws/api/subscriptions'
require_relative 'mws/api/recommendations'
require_relative 'mws/api/fulfillment_inventory'
require_relative 'mws/api/fulfillment_inbound_shipment'
require_relative 'mws/api/fulfillment_outbound_shipment'
require_relative 'mws/api/feeds'
require_relative 'mws/api/feeds/envelope'
require_relative 'mws/api/merchant_fulfillment'

module MWS
  class << self
    attr_accessor :aws_access_key_id,
                  :aws_secret_access_key,
                  :user_agent,
                  :display_warnings

    def config
      yield self
    end

    def new(options = {})
      MWS::Connection.new(options)
    end
  end

  self.display_warnings = true
end
