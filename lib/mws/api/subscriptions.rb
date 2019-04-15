module MWS
  module API
    # Subscriptions
    class Subscriptions < Base
      ACTIONS = [
        :register_destination,
        :deregister_destination,
        :list_registered_destinations,
        :send_test_notification_to_destination,
        :create_subscription,
        :get_subscription,
        :delete_subscription,
        :list_subscriptions,
        :update_subscription,
        :get_service_status
      ].freeze

      def initialize(connection)
        @uri = '/Subscriptions/2013-07-01'
        @version = '2013-07-01'
        @verb = :post
        super
      end
    end
  end
end
