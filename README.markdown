mws-rb
========

## What?
mws-rb is a complete wrapper for Amazon.com's Marketplace Web Service (MWS) API. It exposes the entire MWS api in a more friendly way.

## How?

#### Installation

Using with a Gemfile (mostly rails projects):

    gem 'mws-rb'
    bundle install

Using in a simple ruby file:

    gem install mws-rb
    require 'mws-rb'

#### Initialization

    mws_api = MWS.new(
      host: "mws-eu.amazonservices.com",
      aws_access_key_id: "Your access key id",
      aws_secret_access_key: "Your secret access key",
      seller_id: "Your seller/merchant id"
    )

#### Using

To access the apis you can use:

        mws_api._api_name_.call(:action_to_be_called, params={})

The :call method exposes the API receiving an action_name and a hash of params.

All MWS apis are covered in this gem:

        mws_api.feeds.call(:action_to_be_called, params={})
        mws_api.orders.call(:action_to_be_called, params={})
        mws_api.reports.call(:action_to_be_called, params={})
        mws_api.products.call(:action_to_be_called, params={})
        mws_api.sellers.call(:action_to_be_called, params={})
        mws_api.recommendations.call(:action_to_be_called, params={})
        mws_api.fulfillment_inventory.call(:action_to_be_called, params={})
        mws_api.fulfillment_inbound_shipment.call(:action_to_be_called, params={})
        mws_api.fulfillment_outbound_shipment.call(:action_to_be_called, params={})

#### API docs/actions/params

You can check on the MWS documentation section all actions and params needed:

- Feeds - http://docs.developer.amazonservices.com/en_US/feeds/index.html
- Reports - http://docs.developer.amazonservices.com/en_US/reports/index.html
- Fulfillment Inbound Shipment - http://docs.developer.amazonservices.com/en_US/fba_inbound/index.html
- Fulfillment Inventory - http://docs.developer.amazonservices.com/en_US/fba_inventory/index.html
- Fulfillment Outbound Shipment - http://docs.developer.amazonservices.com/en_US/fba_outbound/index.html
- Orders - http://docs.developer.amazonservices.com/en_US/orders/index.html
- Products - http://docs.developer.amazonservices.com/en_US/products/index.html
- Recommendations - http://docs.developer.amazonservices.com/en_US/recommendations/index.html
- Sellers - http://docs.developer.amazonservices.com/en_US/sellers/index.html

#### Example

Let's say we want to retrieve a list of orders using MWS orders api:

    mws_api.orders.call(:list_orders, "MarketplaceId.Id.1" => "marketplace id",  created_after: Time.new(2013, 1, 1))

#### Testing your keys

Some MWS sections has a "GetServiceStatus" action that can be called without params to retrieve the api status. You can use this action to test your keys.

    mws_api.products.call(:get_service_status)
    => #<HTTParty::Response:0x2e2dea0 parsed_response={"GetServiceStatusResponse"=>{"GetServiceStatusResult"=>{"Status"=>"GREEN", "Timestamp"=>"2013-07-09T10:34:06.674Z"}, "ResponseMetadata"=>{"RequestId"=>"ea5e7b61-fb6a-482d-833c-ac4062133c7b"}}}, @response=#<Net::HTTPOK 200 OK readbody=true>, @headers={"date"=>["Tue, 09 Jul 2013 10:34:06 GMT"], "server"=>["Server"], "x-mws-request-id"=>["ea5e7b61-fb6a-482d-833c-ac4062133c7b"], "x-mws-timestamp"=>["2013-07-09T10:34:06.674Z"], "x-mws-response-context"=>["ra/Ih8Fefp3woGaqQAZezx6ryFhdsVE17xnnTihojFWwrQOMn7B9y4wiQUjUc9/Sh/QjzA58hng="], "content-type"=>["text/xml"], "content-length"=>["383"], "vary"=>["Accept-Encoding,User-Agent"]}>
    1.9.3-p327 :002 >

## TODO

- Create a better way to use the feeds api, add helpers so the user can easily create the desired xml.
- Use method_missing to allow calls direct to the api action, e.g: mws_api.orders.list_orders(params).
- Parse structured list params
- Complete documentation.

## LICENSE

Copyright (c) Jhimy Fernandes Villar

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
