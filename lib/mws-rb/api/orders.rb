module MWS
  class Orders
    def initialize(connection, api)
      @connection = connection
      @api = api
    end

    def list_orders(params={})
      @api.get(
        uri: "/Orders/2011-01-01",
        action: "ListOrders",
        version: "2011-01-01",
        parameters: params
      )
    end

    def list_orders_by_next_token(next_token)
      @api.get(
        uri: "/Orders/2011-01-01",
        action: "ListOrdersByNextToken",
        version: "2011-01-01",
        parameters: {:next_token => next_token}
      )
    end

    def get_order(amazon_order_ids)
      @api.get(
        uri: "/Orders/2011-01-01",
        action: "GetOrder",
        version: "2011-01-01",
        parameters: MWS::Helpers.make_structured_list("AmazonOrderId.Id.", amazon_order_ids)
      )
    end

    def list_order_items(amazon_order_ids)
      @api.get(
        uri: "/Orders/2011-01-01",
        action: "ListOrderItems",
        version: "2011-01-01",
        parameters: MWS::Helpers.make_structured_list("AmazonOrderId.Id.", amazon_order_ids)
      )
    end

    def list_order_items_by_next_token(next_token)
      @api.get(
        uri: "/Orders/2011-01-01",
        action: "ListOrderItemsByNextToken",
        version: "2011-01-01",
        parameters: {:next_token => next_token}
      )
    end

    def get_service_status
      @api.get(
        uri: "/Orders/2011-01-01",
        action: "GetServiceStatus",
        version: "2011-01-01"
      )
    end
  end
end

