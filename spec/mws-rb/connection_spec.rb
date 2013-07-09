require 'spec_helper'

describe MWS::Connection do
  it "should have a default host" do
    subject.host.should eq("mws.amazonservices.com")
  end

  describe "call the right apis" do
    it "should return Feeds when calling .feeds" do
      subject.feeds.instance_of?(MWS::API::Feeds).should == true
    end

    it "should return FulfillmentInboundShipment when calling .fulfillment_inbound_shipment" do
      subject.fulfillment_inbound_shipment.instance_of?(MWS::API::FulfillmentInboundShipment).should == true
    end

    it "should return FulfillmentInventory when calling .fulfillment_inventory" do
      subject.fulfillment_inventory.instance_of?(MWS::API::FulfillmentInventory).should == true
    end

    it "should return FulfillmentOutboundShipment when calling .fulfillment_outbound_shipment" do
      subject.fulfillment_outbound_shipment.instance_of?(MWS::API::FulfillmentOutboundShipment).should == true
    end

    it "should return Orders when calling .orders" do
      subject.orders.instance_of?(MWS::API::Orders).should == true
    end

    it "should return Products when calling .products" do
      subject.products.instance_of?(MWS::API::Products).should == true
    end

    it "should return Recommendations when calling .recommendations" do
      subject.recommendations.instance_of?(MWS::API::Recommendations).should == true
    end

    it "should return Reports when calling .reports" do
      subject.reports.instance_of?(MWS::API::Reports).should == true
    end

    it "should return Sellers when calling .sellers" do
      subject.sellers.instance_of?(MWS::API::Sellers).should == true
    end
  end
end
