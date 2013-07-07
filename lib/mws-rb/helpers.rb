#
# Some herlpers to make easier working with MWS parameters
#
module MWS
  module Helpers
    # Returns a hash with camelized keys
    #
    # Example:
    #
    # MWS::Helpers.camelize_hash(my_first_param: "1", my_second_param: "2")
    # => {:MyFirstParam=>"1", :MySecondParam=>"2"}
    def self.camelize_hash(hash)
      hash.map {|key, value| {:"#{key.to_s.camelize}" => value}}.reduce({}, :merge)
    end

    # For each key/value pair returns the value.iso8601 if the same is a Date/Time/Datetime
    #
    # Example:
    #
    # MWS::Helpers.escape_date_time_params(date_time: Time.new(2013, 1, 1))
    # => {:date_time=>"2013-01-01T00:00:00-02:00"}
    def self.escape_date_time_params(hash)
      hash.map{|key, value| {key => [Time, Date, DateTime].include?(value.class) ? value.iso8601 : value}}.reduce({}, :merge)
    end

    # Some MWS api calls require params as 'structured lists', like the ListOrders action
    # from the orders api, it receives a structured list of MarketPlaceIds, something like this:
    #
    # MarketplaceId.Id.1 => "marketplace_id_1
    # MarketPlaceId.Id.2 => "marketplace_id_2
    #
    # This helper make it easier, example:
    #
    # MWS::Helpers.make_structured_list("MarketplaceId.Id.", ["a", "b", "c"])
    # => {:"MarketplaceId.Id.1"=>"a", :"MarketplaceId.Id.2"=>"b", :"MarketplaceId.Id.3"=>"c"
    def self.make_structured_list(name, items)
      items.map.with_index{|item, index| {:"#{name}#{index + 1}" => item}}.reduce({}, :merge)
    end
  end
end
