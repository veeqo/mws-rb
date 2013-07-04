module MWS
  module Helpers
    def self.camelize_hash(hash)
      hash.map {|key, value| {:"#{key.to_s.camelize}" => value}}.reduce({}, :merge)
    end

    def self.escape_date_time_params(hash)
      hash.map{|key, value| {key => [Time, Date, DateTime].include?(value.class) ? value.iso8601 : value}}.reduce({}, :merge)
    end
  end
end
