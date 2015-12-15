module MWS
  module API
    # Products
    class Products < Base
      ACTIONS = [:list_matching_products, :get_matching_product, :get_matching_product_for_id,
                 :get_competitive_pricing_for_SKU, :get_competitive_pricing_for_ASIN,
                 :get_lowest_offer_listings_for_SKU, :get_lowest_offer_listings_for_ASIN,
                 :get_my_price_for_SKU, :get_my_price_for_ASIN,
                 :get_product_categories_for_SKU, :get_product_categories_for_ASIN,
                 :get_service_status]

      def initialize(connection)
        @uri = '/Products/2011-10-01'
        @version = '2011-10-01'
        super
      end
    end
  end
end
