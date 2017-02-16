module MWS
  module API
    class MerchantFulfilllment < Base
      ACTIONS = [
        :get_eligible_shipping_services,
        :create_shipment,
        :get_shipment,
        :cancel_shipment,
        :get_service_status,
      ].freeze

      def initialize(connection)
        @uri = 'MerchantFulfillment/2015-06-01'
        @version = '2015-06-01'
        super
      end
    end
  end
end
