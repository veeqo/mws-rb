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

module MWS
  def self.new(options={})
    @connection = MWS::Connection.new(options)
    @api = MWS::Api.new(@connection)
  end

  def self.orders
    @orders = MWS::Orders.new(@connection, @api)
  end

  def self.reports
    @reports = MWS::Reports.new(@connection, @api)
  end

  def self.products
    @products = MWS::Products.new(@connection, @api)
  end

  def self.sellers
    @sellers = MWS::Sellers.new(@connection, @api)
  end

  def self.recommendations
    @recommendations = MWS::Recommendations.new(@connection, @api)
  end

  def self.fulfillment_inventory
    @fulfillment_inventory = MWS::FulfillmentInventory.new(@connection, @api)
  end
end
