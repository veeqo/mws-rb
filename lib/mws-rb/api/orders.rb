module MWS
  module API
    class Orders < Base
      def initialize(connection)
        @uri = "/Orders/2011-01-01"
        @version = "2011-01-01"
        super(connection)
      end
    end
  end
end
