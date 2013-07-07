module MWS
  module API
    module Orders

      Actions = %w(ListOrders ListOrdersByNextToken GetOrder ListOrderItems
                   ListOrderItemsByNextToken GetServiceStatus)

      # ListOrders - Returns orders created or updated during a time frame that you specify.
      # ListOrdersByNextToken - Returns the next page of orders using the NextToken parameter.
      # GetOrder - Returns orders based on the AmazonOrderId values that you specify.
      # ListOrderItems - Returns order items basedd on the AmazonOrderId that you specify.
      # ListOrderItemsByNextToken - Returns the next page of order items using the NextToken parameter.
      # GetServiceStatus - Returns the operational status of the Orders API
      #
      # More info here http://docs.developer.amazonservices.com/en_US/orders/index.html

      def self.call_api(api, action, params={})
        api.get(
          uri: "/Orders/2011-01-01",
          action: action.to_s.camelize,
          version: "2011-01-01",
          params: params
        )
      end
    end
  end
end
