module MWS
  module FulfillmentInboundShipment

    Actions = %w(CreateInboundShipmentPlan CreateInboundShipment UpdateInboundShipment ListInboundShipments
                 ListInboundShipmentsByNextToken ListInboundShipmentItems ListInboundShipmentItemsByNextToken
                 GetServiceStatus)

    #CreateInboundShipmentPlan - Returns the information required to create an inbound shipment.
    #CreateInboundShipment - Creates an inbound shipment.
    #UpdateInboundShipment - Updates an existing inbound shipment.
    #ListInboundShipments - Returns a list of inbound shipments based on criteria that you specify.
    #ListInboundShipmentsByNextToken - Returns the next page of inbound shipments using the NextToken parameter.
    #ListInboundShipmentItems - Returns a list of items in a specified inbound shipment, or a list of items that were updated within a specified time frame.
    #ListInboundShipmentItemsByNextToken - Returns the next page of inbound shipment items using the NextToken parameter.
    #GetServiceStatus - Returns the operational status of the Fulfillment Inbound Shipment API section.
    #
    # More info here http://docs.developer.amazonservices.com/en_US/fba_inbound/FBAInbound_Overview.html

    def self.call_api(api, action, params={})
      api.get(
        uri: "/FulfillmentInboundShipment/2010-10-01",
        action: action.to_s.camelize,
        version: "2010-10-01",
        parameters: params
      )
    end
  end
end
