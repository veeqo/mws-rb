require 'spec_helper'

describe MWS do
  it "should return a connection on initializer" do
    subject.new.class.should eq(MWS::Connection)
  end
end
