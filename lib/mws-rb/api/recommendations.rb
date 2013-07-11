module MWS
  module API
    class Recommendations < Base
      def initialize(connection)
        @uri = "/Recommendations/2013-04-01"
        @version = "2013-04-01"
        super
      end
    end
  end
end
