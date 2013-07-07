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
      merchant_id: "Your merchant id"
    )

#### Using

To access the apis you can use:

        mws_api._api_name_(:action_to_be_called, params={})

All MWS apis are covered in this gem:

        mws_api.feeds(:action_to_be_called, params={})
        mws_api.orders(:action_to_be_called, params={})
        mws_api.reports(:action_to_be_called, params={})
        mws_api.products(:action_to_be_called, params={})
        mws_api.sellers(:action_to_be_called, params={})
        mws_api.recommendations(:action_to_be_called, params={})
        mws_api.fulfillment_inventory(:action_to_be_called, params={})
        mws_api.fulfillment_inbound_shipment(:action_to_be_called, params={})
        mws_api.fulfillment_outbound_shipment(:action_to_be_called, params={})

#### Example

Let's say we want to retrieve a list of orders using MWS orders api:

    mws_api.orders(:list_orders, :MarketplaceId.Id.1 => "marketplace id",  created_after: Time.new(2013, 1, 1))
