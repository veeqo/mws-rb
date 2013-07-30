# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mws-rb/version"

Gem::Specification.new do |s|
  s.name        = "mws-rb"
  s.version     = MWS::VERSION
  s.authors     = ["Jhimy Fernandes Villar"]
  s.email       = ["stjhimy@gmail.com"]
  s.homepage    = "http://github.com/stjhimy/mws-rb"
  s.summary     = %q{Amazon MWS Gem}
  s.description = %q{A complete wrapper for Amazon.com's Marketplace Web Service (MWS) API.}

  s.rubyforge_project = "ruby-mws"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "ephemeral_response"

  s.add_runtime_dependency "httparty"
end
