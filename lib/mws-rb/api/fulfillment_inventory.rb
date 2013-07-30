module MWS
  module API
    class FulfillmentInventory < Base
      Actions = [:list_inventory_supply, :list_inventory_supply_by_next_token, :get_service_status]

      def initialize(connection)
        @uri = "/FulfillmentInventory/2010-10-01"
        @version = "2010-10-01"
        super
      end
    end
  end
end
