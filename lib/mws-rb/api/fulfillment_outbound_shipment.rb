module MWS
  module API
    class FulfillmentOutboundShipment < Base
      Actions = [
        :cancel_fulfillment_order,
        :create_fulfillment_order,
        :get_fulfillment_order,
        :get_fulfillment_preview,
        :get_package_tracking_details,
        :get_service_status,
        :list_all_fulfillment_orders,
        :list_all_fulfillment_orders_by_next_token,
      ]

      def initialize(connection)
        @uri = "/FulfillmentOutboundShipment/2010-10-01"
        @version = "2010-10-01"
        super
      end
    end
  end
end
