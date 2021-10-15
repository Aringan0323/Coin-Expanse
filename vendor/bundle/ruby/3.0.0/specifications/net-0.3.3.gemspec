# -*- encoding: utf-8 -*-
# stub: net 0.3.3 ruby lib

Gem::Specification.new do |s|
  s.name = "net".freeze
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jeremy Cohen Hoffing".freeze, "Claudio Baccigalupo".freeze]
  s.date = "2015-09-03"
  s.description = "Retrieves information for Twitter users".freeze
  s.email = ["jcohenhoffing@gmail.com".freeze, "claudio@fullscreen.net".freeze]
  s.homepage = "https://github.com/Fullscreen/net".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.15".freeze
  s.summary = "An API Client for social networks".freeze

  s.installed_by_version = "3.2.15" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.3"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_development_dependency(%q<yard>.freeze, ["~> 0.8.7"])
    s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.7.1"])
    s.add_development_dependency(%q<vcr>.freeze, ["~> 2.9"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 1.19"])
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.8.7"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.7.1"])
    s.add_dependency(%q<vcr>.freeze, ["~> 2.9"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.19"])
  end
end
