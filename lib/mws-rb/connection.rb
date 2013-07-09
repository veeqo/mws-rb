module MWS
  class Connection
    attr_reader :host, :aws_access_key_id, :aws_secret_access_key, :seller_id

    def initialize(options={})
      @host = options[:host] ||"mws.amazonservices.com"
      @aws_access_key_id = options[:aws_access_key_id]
      @aws_secret_access_key = options[:aws_secret_access_key]
      @seller_id = options[:seller_id]
    end

    # Map APIS
    def feeds
      MWS::API::Feeds.new(self)
    end

    def fulfillment_inbound_shipment
      MWS::API::FulfillmentInboundShipment.new(self)
    end

    def fulfillment_inventory
      MWS::API::FulfillmentInventory.new(self)
    end

    def fulfillment_outbound_shipment
      MWS::API::FulfillmentOutboundShipment.new(self)
    end

    def orders
      MWS::API::Orders.new(self)
    end

    def products
      MWS::API::Products.new(self)
    end

    def recommendations
      MWS::API::Recommendations.new(self)
    end

    def reports
      MWS::API::Reports.new(self)
    end

    def sellers
      MWS::API::Sellers.new(self)
    end
  end
end
