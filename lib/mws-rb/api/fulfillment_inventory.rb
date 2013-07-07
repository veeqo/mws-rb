module MWS
  module API
    module FulfillmentInventory

      Actions = %w(ListInventorySupply ListInventorySupplyByNextToken GetServiceStatus)

      #ListInventorySupply - Returns information about the availability of a seller's inventory.
      #ListInventorySupplyByNextToken -Returns the next page of information about the availability of a seller's inventory using the NextToken parameter.
      #GetServiceStatus - Returns the operational status of the Fulfillment Inventory API section.
      #
      # More info here http://docs.developer.amazonservices.com/en_US/fba_inventory/index.html

      def self.call_api(api, action, params={})
        api.get(
          uri: "/FulfillmentInventory/2010-10-01",
          action: action.to_s.camelize,
          version: "2010-10-01",
          parameters: params
        )
      end
    end
  end
end
