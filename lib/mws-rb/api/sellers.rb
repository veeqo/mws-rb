module MWS
  module API
    class Sellers < Base
      def initialize(connection)
        @uri = "/Sellers/2011-07-01"
        @version = "2011-07-01"
        super(connection)
      end
    end
  end
end
