require 'rubygems'
require 'bundler/setup'

require 'mws'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock # or :fakeweb
  config.configure_rspec_metadata!
  config.default_cassette_options = { match_requests_on: [:method, :host] }
  config.filter_sensitive_data('DUMMY_AWS_ACCESS_KEY') { ENV['AWS_ACCESS_KEY'] }
  config.filter_sensitive_data('DUMMY_AWS_SECRET_KEY') { ENV['AWS_SECRET_KEY'] }
  config.filter_sensitive_data('DUMMY_AWS_SELLER_ID')  { ENV['AWS_SELLER_ID']  }
end

RSpec.configure do |config|
  config.before { MWS.display_warnings = false }
  config.raise_errors_for_deprecations!
end
