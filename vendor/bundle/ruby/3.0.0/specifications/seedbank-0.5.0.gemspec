# -*- encoding: utf-8 -*-
# stub: seedbank 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "seedbank".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["James McCarthy".freeze]
  s.date = "2017-02-12"
  s.description = "\n    Adds simple rake commands for seeding your database. Simple dependencies let you organise your seeds.\n    If you are using Rails, Seedbank extends Rails seeds and lets you add seeds for each environment.\n  ".freeze
  s.email = ["[james2mccarthy@gmail.com".freeze]
  s.extra_rdoc_files = ["MIT-LICENSE".freeze, "README.md".freeze]
  s.files = ["MIT-LICENSE".freeze, "README.md".freeze]
  s.homepage = "http://github.com/james2m/seedbank".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1".freeze)
  s.rubygems_version = "3.2.15".freeze
  s.summary = "Generate seeds data for your Ruby application.".freeze

  s.installed_by_version = "3.2.15" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rake>.freeze, [">= 10.0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.11"])
    s.add_development_dependency(%q<rails>.freeze, ["~> 4.2"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
  else
    s.add_dependency(%q<rake>.freeze, [">= 10.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.11"])
    s.add_dependency(%q<rails>.freeze, ["~> 4.2"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
  end
end
