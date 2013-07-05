module MWS
  class FulfillmentInventory
    def initialize(connection, api)
      @connection = connection
      @api = api
    end

    def list_inventory_supply(params={})
      @api.get(
        uri: "/FulfillmentInventory/2010-10-01",
        action: "ListInventorySupply",
        version: "2010-10-01",
        parameters: params
      )
    end

    def list_inventory_supply_by_next_token(next_token)
      @api.get(
        uri: "/FulfillmentInventory/2010-10-01",
        action: "ListInventorySupplyByNextToken",
        version: "2010-10-01",
        parameters: {:next_token => next_token}
      )
    end

    def get_service_status
      @api.get(
        uri: "/FulfillmentInventory/2010-10-01",
        action: "GetServiceStatus",
        version: "2010-10-01"
      )
    end
  end
end
