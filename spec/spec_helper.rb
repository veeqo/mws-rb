require 'rubygems'
require 'bundler/setup'

require 'mws'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock # or :fakeweb
  config.configure_rspec_metadata!
  config.default_cassette_options = { match_requests_on: [:method, :host, :content_type] }
  config.filter_sensitive_data('DUMMY_AWS_ACCESS_KEY') { ENV['AWS_ACCESS_KEY'] }
  config.filter_sensitive_data('DUMMY_AWS_SECRET_KEY') { ENV['AWS_SECRET_KEY'] }
  config.filter_sensitive_data('DUMMY_AWS_SELLER_ID')  { ENV['AWS_SELLER_ID']  }
  config.register_request_matcher(:content_type) do |request1, request2|
    request1.headers['Content-Type'] == request2.headers['Content-Type']
  end
end

RSpec.configure(&:raise_errors_for_deprecations!)
