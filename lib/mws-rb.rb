require 'httparty'
require 'base64'
require 'openssl'
require 'active_support/core_ext'

require_relative 'mws-rb/helpers'
require_relative 'mws-rb/connection'
require_relative 'mws-rb/api'
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
    @api = MWS::Api.new(@connection)
  end

  def self.orders(action, params={})
    MWS::API::Orders.call_api(@api, action, params)
  end

  def self.reports(action, params={})
    MWS::API::Reports.call_api(@api, action, params)
  end

  def self.products(action, params={})
    MWS::API::Products.call_api(@api, action, params)
  end

  def self.sellers(action, params={})
    MWS::API::Sellers.call_api(@api, action, params)
  end

  def self.recommendations(action, params={})
    MWS::API::Recommendations.call_api(@api, action, params)
  end

  def self.fulfillment_inventory(action, params={})
    MWS::API::FulfillmentInventory.call_api(@api, action, params)
  end

  def self.fulfillment_inbound_shipment(action, params={})
    MWS::API::FulfillmentInboundShipment.call_api(@api, action, params)
  end

  def self.fulfillment_outbound_shipment(action, params={})
    MWS::API::FulfillmentOutboundShipment.call_api(@api, action, params)
  end

  def self.feeds(action, params={})
    MWS::API::Feeds.call_api(@api, action, params)
  end
end
