module MWS
  module API
    class Subscriptions < Base
      Actions = [:register_destination, :deregister_destination, :list_registered_destinations, :send_test_notification_to_destination, :create_subscription, :get_subscription, :delete_subscription, :list_subscriptions, :update_subscription, :get_service_status]

      def initialize(connection)
        @uri = "/Subscriptions/2013-07-01"
        @version = "2013-07-01"
        @verb = :post
        super
      end
    end
  end
end