require 'httparty'
require 'base64'
require 'openssl'
require 'active_support/core_ext'

require_relative 'mws-rb/query'
require_relative 'mws-rb/connection'
require_relative 'mws-rb/api/base'
require_relative 'mws-rb/api/orders'
require_relative 'mws-rb/api/reports'
require_relative 'mws-rb/api/products'
require_relative 'mws-rb/api/sellers'
require_relative 'mws-rb/api/recommendations'
require_relative 'mws-rb/api/fulfillment_inventory'
require_relative 'mws-rb/api/fulfillment_inbound_shipment'
require_relative 'mws-rb/api/fulfillment_outbound_shipment'
require_relative 'mws-rb/api/feeds'

module MWS
  def self.new(options={})
    @connection = MWS::Connection.new(options)
  end
end
