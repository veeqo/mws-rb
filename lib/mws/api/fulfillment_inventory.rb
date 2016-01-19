module MWS
  module API
    # FulfillmentInventory
    class FulfillmentInventory < Base
      ACTIONS = [:list_inventory_supply, :list_inventory_supply_by_next_token, :get_service_status].freeze

      def initialize(connection)
        @uri = '/FulfillmentInventory/2010-10-01'
        @version = '2010-10-01'
        super
      end
    end
  end
end
