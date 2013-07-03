require 'httparty'
require 'base64'
require 'openssl'

require_relative 'mws-rb/connection'
require_relative 'mws-rb/api'
require_relative 'mws-rb/api/orders'
require 'active_support/core_ext'

module MWS
  def self.new(options={})
    @connection = MWS::Connection.new(options)
    @api = MWS::Api.new(@connection)
  end

  def self.orders
    @orders = MWS::Orders.new(@connection, @api)
  end
end
