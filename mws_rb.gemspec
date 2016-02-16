$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'mws/version'

Gem::Specification.new do |s|
  s.name        = 'mws_rb'
  s.version     = MWS::VERSION
  s.authors     = ['Jhimy Fernandes Villar']
  s.email       = ['stjhimy@gmail.com']
  s.homepage    = 'http://github.com/veeqo/mws-rb'
  s.summary     = 'Amazon MWS Gem'
  s.description = "A complete wrapper for Amazon.com's Marketplace Web Service (MWS) API."
  s.license = 'MIT'

  s.rubyforge_project = 'ruby-mws'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec',         '~> 3.4'
  s.add_development_dependency 'guard',         '~> 2.13'
  s.add_development_dependency 'guard-rspec',   '~> 4.6'
  s.add_development_dependency 'guard-rubocop', '~> 1.2.0'
  s.add_development_dependency 'vcr',           '~> 3.0'
  s.add_development_dependency 'webmock',       '~> 1.22'

  s.add_dependency 'httparty',      '~> 0.13'
  s.add_dependency 'nokogiri',      '~> 1.6'
  s.add_dependency 'activesupport', '>= 3.0', '< 4.1'
  s.add_dependency 'addressable',   '~> 2.3'
  s.add_dependency 'builder',       '~> 3.2'
end
