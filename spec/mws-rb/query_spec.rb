require 'spec_helper'

describe MWS::Query do
  let(:query_params) {{
    verb: "GET",
    uri: "/",
    host: "mws-eu.amazonservices.com",
    aws_access_key_id: "key",
    aws_secret_access_key: "secret",
    action: "ListOrders",
    seller_id: "Seller ID",
    mws_auth_token: 'auth_token',
    version: "2010-01-01",
    timestamp: "2013-01-01T00:00:00-02:00"
  }}

  let(:query) {MWS::Query.new(query_params)}

  describe "Initialization" do
    it "should create a MWS::Query object" do
      expect(subject.class).to eq(MWS::Query)
    end

    it "should have some default params" do
      expect(subject.uri).to eq("/")
      expect(subject.verb).to eq("GET")
      expect(subject.signature_method).to eq("HmacSHA256")
      expect(subject.signature_version).to eq(2)
      expect(subject.timestamp.class).to eq(Time)
    end
  end

  describe "Build query" do
    let(:query_params) { super().merge(mws_auth_token: 'auth_token') }
    let(:generated_query) { "AWSAccessKeyId=key&Action=ListOrders&MWSAuthToken=auth_token&SellerId=Seller%20ID&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2013-01-01T00%3A00%3A00-02%3A00&Version=2010-01-01" }

    it "should build a simple query with MWSAuthToken" do
      expect(query.build_query).to eq(generated_query)
    end

    it "should build a query with a signature" do
      expect(query.build_query("signature").include?("Signature=signature")).to eq true
    end

    it "should be a query with custom params" do
      builded_query = MWS::Query.new(query_params.merge(params: {custom_param: "custom"})).build_query
      expect(builded_query).to include("CustomParam=custom")
    end

    it "capitalize sku and asin on action name" do
      asin_query_params = query_params.merge(action: "TestAsin")
      query =  MWS::Query.new(asin_query_params)
      expect(query.action).to eq("TestASIN")

      asin_query_params = query_params.merge(action: "TestSku")
      query =  MWS::Query.new(asin_query_params)
      expect(query.action).to eq("TestSKU")
    end
  end

  describe "canonical string" do
    let(:canonical) { "GET\nmws-eu.amazonservices.com\n/\nAWSAccessKeyId=key&Action=ListOrders&MWSAuthToken=auth_token&SellerId=Seller%20ID&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2013-01-01T00%3A00%3A00-02%3A00&Version=2010-01-01" }

    it "should generate a canonical string with MWSAuthToken" do
      expect(query.canonical).to eq(canonical)
    end
  end

  describe "signature" do
    let(:query_params) { super().merge(mws_auth_token: 'auth_token') }

    it "should generate a valid signature taking into account MWSAuthToken" do
      expect(query.signature).to eq("1+bIWdZtiUwNNObu9fSYkQPVkSzRf4/lX5/FFgwx+4U=")
    end
  end

  describe "request_uri" do
    let(:query_params) { super().merge(mws_auth_token: 'auth_token') }
    let(:request_uri) { "https://mws-eu.amazonservices.com/?AWSAccessKeyId=key&Action=ListOrders&MWSAuthToken=auth_token&SellerId=Seller%20ID&Signature=1%2BbIWdZtiUwNNObu9fSYkQPVkSzRf4%2FlX5%2FFFgwx%2B4U%3D&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2013-01-01T00%3A00%3A00-02%3A00&Version=2010-01-01" }

    it "should generate a valid request uri with MWSAuthToken" do
      expect(query.request_uri).to eq(request_uri)
    end
  end

  describe MWS::Query::Helpers do
    subject {MWS::Query::Helpers}

    describe "escape_date_time_params(params={})" do
      let(:time) {Time.new(2013, 01, 01)}

      it "should escape a simple hash" do
        expect(subject.escape_date_time_params(time: time)).to eq({time: time.iso8601})
      end

      it "should escape a nested hash" do
        expect(subject.escape_date_time_params(time: {time: time})).to eq({time: {time: time.iso8601}})
      end
    end

    describe "camelize_keys(parmas={})" do
      it "should camelize a simple hash" do
        expect(subject.camelize_keys(new_key: "value")).to eq("NewKey" => "value")
      end

      it "should camelize a nested hash" do
        expect(subject.camelize_keys(key: {key: "value"})).to eq("Key" => {"Key" => "value"})
      end
    end

    describe "make_structured_lists" do
      it "should return a new structured list" do
        structured_list = subject.make_structured_lists(ids_list: {label: "Id.id", values: [1,2]})
        expect(structured_list).to eq("Id.id.1" => 1, "Id.id.2" => 2)
      end

      it "should return the same hash if there's no list params" do
        structured_list = subject.make_structured_lists(test: "test")
        expect(structured_list).to eq(test: "test")
      end

      it "should return a hash with structured lists and normal values" do
        structured_list = subject.make_structured_lists(test: "test", id_list: {label: "Id.id", values: [1]})
        expect(structured_list).to eq(test: "test", "Id.id.1" => 1)
      end
    end
  end
end
