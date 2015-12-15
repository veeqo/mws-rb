module MWS
  module API
    # FulfillmentInboundShipment
    class FulfillmentInboundShipment < Base
      ACTIONS = [:create_inbound_shipment_plan, :create_inbound_shipment, :update_inbound_shipment,
                 :list_inbound_shipments, :list_inbound_shipments_by_next_token, :list_inbound_shipment_items,
                 :list_inbound_shipment_items_by_next_token, :get_service_status]

      def initialize(connection)
        @uri = '/FulfillmentInboundShipment/2010-10-01'
        @version = '2010-10-01'
        super
      end
    end
  end
end
