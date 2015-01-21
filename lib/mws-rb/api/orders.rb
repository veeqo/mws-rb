module MWS
  module API
    class Orders < Base
      Actions = [:list_orders, :list_orders_by_next_token, :get_order, :list_order_items,
                 :list_order_items_by_next_token, :get_service_status]

      def initialize(connection)
        @uri = "/Orders/2013-09-01"
        @version = "2013-09-01"
        @verb = :post
        super
      end
    end
  end
end
