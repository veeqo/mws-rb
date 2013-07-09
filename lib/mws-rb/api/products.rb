module MWS
  module API
    class Products < Base
      def initialize(connection)
        @uri = "/Products/2011-10-01"
        @version = "2011-10-01"
        super(connection)
      end
    end
  end
end
