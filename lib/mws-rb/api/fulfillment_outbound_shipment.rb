module MWS
  module API
    module FulfillmentOutboundShipment
      Actions = %w(GetFulfillmentPreview CreateFulfillmentOrder GetFulfillmentOrder ListAllFulfillmentOrders
                   ListAllFulfillmentOrdersByNextToken GetPackageTrackingDetails CancelFulfillmentOrder
                   GetServiceStatus)

      #GetFulfillmentPreview - Returns a list of fulfillment order previews based on items and shipping speed categories that you specify.
      #CreateFulfillmentOrder - Requests that Amazon ship items from the seller's inventory to a destination address.
      #GetFulfillmentOrder - Returns a fulfillment order based on a specified SellerFulfillmentOrderId.
      #ListAllFulfillmentOrders - Returns a list of fulfillment orders fulfilled after (or at) a specified date or by fulfillment method.
      #ListAllFulfillmentOrdersByNextToken - Returns the next page of inbound shipment items using the NextToken parameter.
      #GetPackageTrackingDetails - Returns delivery tracking information for a package in an outbound shipment for a Multi-Channel Fulfillment order.
      #CancelFulfillmentOrder - Requests that Amazon stop attempting to fulfill an existing fulfillment order.
      #GetServiceStatus - Returns the operational status of the Fulfillment Outbound Shipment API section.
      #
      # More info here http://docs.developer.amazonservices.com/en_US/fba_outbound/FBAOutbound_Overview.html

      def self.call_api(api, action, params={})
        api.get(
          uri: "/FulfillmentOutboundShipment/2010-10-01",
          action: action.to_s.camelize,
          version: "2010-10-01",
          parameters: params
        )
      end
    end
  end
end
