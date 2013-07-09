module MWS
  module API
    class FulfillmentOutboundShipment < Base
      def initialize(connection)
        @uri = "/FulfillmentOutboundShipment/2010-10-01"
        @version = "2010-10-01"
        super(connection)
      end
    end
  end
end
