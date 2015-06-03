require 'spec_helper'

describe MWS do
  it "should return a connection on initializer" do
    subject.new(
      aws_access_key_id: "access key",
      aws_secret_access_key: "secret key",
      seller_id: "seller id",
      mws_auth_token: 'auth token'
    ).class.should eq(MWS::Connection)
  end
end
