# -*- encoding: utf-8 -*-
# stub: binance-ruby 1.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "binance-ruby".freeze
  s.version = "1.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jake Peterson".freeze]
  s.bindir = "exe".freeze
  s.date = "2021-06-06"
  s.description = "Ruby wrapper for the Binance API.".freeze
  s.email = ["hello@jakenberg.io".freeze]
  s.homepage = "https://github.com/jakenberg/binance-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.15".freeze
  s.summary = "binance-ruby-1.3.1".freeze

  s.installed_by_version = "3.2.15" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<codecov>.freeze, ["~> 0.1"])
    s.add_development_dependency(%q<dotenv>.freeze, ["~> 2.2"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<timecop>.freeze, ["~> 0.9"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_development_dependency(%q<byebug>.freeze, ["~> 11.1.3"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.20.0"])
    s.add_runtime_dependency(%q<awrence>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<httparty>.freeze, ["~> 0.15"])
    s.add_runtime_dependency(%q<faye-websocket>.freeze, ["~> 0.11"])
    s.add_runtime_dependency(%q<eventmachine>.freeze, ["~> 1.2"])
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.1.0"])
  else
    s.add_dependency(%q<codecov>.freeze, ["~> 0.1"])
    s.add_dependency(%q<dotenv>.freeze, ["~> 2.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0.9"])
    s.add_dependency(%q<webmock>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<byebug>.freeze, ["~> 11.1.3"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.20.0"])
    s.add_dependency(%q<awrence>.freeze, ["~> 1.0"])
    s.add_dependency(%q<httparty>.freeze, ["~> 0.15"])
    s.add_dependency(%q<faye-websocket>.freeze, ["~> 0.11"])
    s.add_dependency(%q<eventmachine>.freeze, ["~> 1.2"])
    s.add_dependency(%q<activesupport>.freeze, [">= 5.1.0"])
  end
end
