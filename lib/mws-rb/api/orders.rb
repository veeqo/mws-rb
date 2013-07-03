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
        parameters: {:"MarketplaceId.id.1" => @connection.marketplace_id}.merge(params)
      )
    end
  end
end

