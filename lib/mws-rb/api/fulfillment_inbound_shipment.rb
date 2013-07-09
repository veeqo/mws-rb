module MWS
  module API
    class FulfillmentInboundShipment < Base
      def initialize(connection)
        @uri = "/FulfillmentInboundShipment/2010-10-01"
        @version = "2010-10-01"
        super(connection)
      end
    end
  end
end
