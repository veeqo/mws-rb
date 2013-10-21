module MWS
  class Connection
    attr_reader :host, :aws_access_key_id, :aws_secret_access_key, :seller_id

    def initialize(options={})
      @host = options[:host] ||"mws.amazonservices.com"
      @aws_access_key_id = options[:aws_access_key_id] || MWS.aws_access_key_id
      @aws_secret_access_key = options[:aws_secret_access_key] || MWS.aws_secret_access_key
      @seller_id = options[:seller_id]

      if @aws_access_key_id.to_s.empty? || @aws_secret_access_key.to_s.empty? || @seller_id.to_s.empty?
        raise(ArgumentError, "You must provide :aws_access_key_id, :aws_secret_access_key and :seller_id")
      end
    end

    # Map APIS
    def feeds
      @fees ||= MWS::API::Feeds.new(self)
    end

    def fulfillment_inbound_shipment
      @fis ||= MWS::API::FulfillmentInboundShipment.new(self)
    end

    def fulfillment_inventory
      @fi ||= MWS::API::FulfillmentInventory.new(self)
    end

    def fulfillment_outbound_shipment
      @fos ||= MWS::API::FulfillmentOutboundShipment.new(self)
    end

    def orders
      @orders ||= MWS::API::Orders.new(self)
    end

    def products
      @products ||= MWS::API::Products.new(self)
    end

    def recommendations
      @recommendations ||= MWS::API::Recommendations.new(self)
    end

    def reports
      @reports ||= MWS::API::Reports.new(self)
    end

    def sellers
      @sellers ||= MWS::API::Sellers.new(self)
    end
  end
end
