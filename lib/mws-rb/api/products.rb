module MWS
  class Products
    def initialize(connection, api)
      @connection = connection
      @api = api
    end

    def list_matching_products(params={})
      @api.get(
        uri: "/Products/2011-10-01",
        action: "ListMatchingProducts",
        version: "2011-10-01",
        parameters: params
      )
    end

    def list_matching_products(marketplace_id, asin_list)
      @api.get(
        uri: "/Products/2011-10-01",
        action: "GetMatchingProduct",
        version: "2011-10-01",
        parameters: {:marketplace_id => marketplace_id}.merge(MWS::Helpers.make_structured_list("ASINList.ASIN.", asin_list))
      )
    end

    def get_matching_product_for_id(marketplace_id, id_type, id_list)
      id_list = MWS::Helpers.make_structured_list("IdList.Id.", id_list)
      @api.get(
        uri: "/Products/2011-10-01",
        action: "GetMatchingProductForId",
        version: "2011-10-01",
        parameters: {:marketplace_id => marketplace_id, :id_type => id_type}.merge(id_list)
      )
    end

    def get_competitive_pricing_for_sku(marketplace_id, seller_sku_list)
      seller_sku_list = MWS::Helpers.make_structured_list("SellerSKUList.SellerSKU.", seller_sku_list)
      @api.get(
        uri: "/Products/2011-10-01",
        action: "GetCompetitivePricingForSKU",
        version: "2011-10-01",
        parameters: {:marketplace_id => marketplace_id}.merge(seller_sku_list)
      )
    end

    def get_competitive_pricing_for_asin(marketplace_id, asin_list)
      asin_list = MWS::Helpers.make_structured_list("SellerSKUList.SellerSKU.", asin_list)
      @api.get(
        uri: "/Products/2011-10-01",
        action: "GetCompetitivePricingForASIN",
        version: "2011-10-01",
        parameters: {:marketplace_id => marketplace_id}.merge(asin_list)
      )
    end

    def get_lowest_offer_listing_for_sku(params={})
      @api.get(
        uri: "/Products/2011-10-01",
        action: "GetLowestOfferListingsForSKU",
        version: "2011-10-01",
        parameters: params
      )
    end

    def get_lowest_offer_listing_for_asin(params={})
      @api.get(
        uri: "/Products/2011-10-01",
        action: "GetLowestOfferListingsForASIN",
        version: "2011-10-01",
        parameters: params
      )
    end

    def get_my_price_for_sku(params={})
      @api.get(
        uri: "/Products/2011-10-01",
        action: "GetMyPriceForSKU",
        version: "2011-10-01",
        parameters: params
      )
    end

    def get_product_categories_for_sku(marketplace_id, seller_sku)
      @api.get(
        uri: "/Products/2011-10-01",
        action: "GetProductCategoriesForSKU",
        version: "2011-10-01",
        parameters: {:marketplace_id => marketplace_id, :"SellerSKU" => seller_sku}
      )
    end

    def get_product_categories_for_asin(marketplace_id, asin)
      @api.get(
        uri: "/Products/2011-10-01",
        action: "GetProductCategoriesForASIN",
        version: "2011-10-01",
        parameters: {:marketplace_id => marketplace_id, :"ASIN" => asin}
      )
    end

    def get_service_status
      @api.get(
        uri: "/Products/2011-10-01",
        action: "GetServiceStatus",
        version: "2011-10-01"
      )
    end
  end
end
