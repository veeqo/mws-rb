module MWS
  module API
    module Products

      Actions = %w(ListMatchingProducts GetMatchingProduct GetMatchingProductForId GetCompetitivePricingForSKU
                   GetCompetitivePricingForASIN GetLowestOfferListingsForSKU GetLowestOfferListingsForASIN
                   GetMyPriceForSKU GetMyPriceForASIN GetProductCategoriesForSKU GetProductCategoriesForASIN
                   GetServiceStatus)

      # ListMatchingProducts - Returns a list of products and their attributes, based on a search query.
      # GetMatchingProduct - Returns a list of products and their attributes, based on a list of ASIN values.
      # GetMatchingProductForId - Returns a list of products and their attributes, based on a list of ASIN, # GCID, SellerSKU, UPC, EAN, ISBN, and JAN values.
      # GetCompetitivePricingForSKU - Returns the current competitive price of a product, based on SellerSKU.
      # GetCompetitivePricingForASIN - Returns the current competitive price of a product, based on ASIN.
      # GetLowestOfferListingsForSKU - Returns pricing information for the lowest-price active offer listings for a product, based on SellerSKU.
      # GetLowestOfferListingsForASIN - Returns pricing information for the lowest-price active offer listings for a product, based on ASIN.
      # GetMyPriceForSKU - Returns pricing information for your own offer listings, based on SellerSKU.
      # GetMyPriceForASIN - Returns pricing information for your own offer listings, based on ASIN.
      # GetProductCategoriesForSKU -Returns the parent product categories that a product belongs to, based on SellerSKU.
      # GetProductCategoriesForASIN - Returns the parent product categories that a product belongs to, based on ASIN.
      # GetServiceStatus - Returns the operational status of the Products API section.
      #
      # More info here http://docs.developer.amazonservices.com/en_US/products/index.html

      def self.call_api(api, action, params={})
        api.get(
          uri: "/Products/2011-10-01",
          action: action.to_s.camelize,
          version: "2011-10-01",
          params: params
        )
      end
    end
  end
end
