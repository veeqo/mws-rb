module MWS
  module API
    class FulfillmentInventory < Base
      def initialize(connection)
        @uri = "/FulfillmentInventory/2010-10-01"
        @version = "2010-10-01"
        super
      end
    end
  end
end
