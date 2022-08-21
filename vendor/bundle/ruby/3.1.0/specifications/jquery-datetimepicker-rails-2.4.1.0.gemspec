# -*- encoding: utf-8 -*-
# stub: jquery-datetimepicker-rails 2.4.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery-datetimepicker-rails".freeze
  s.version = "2.4.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrey Novikov".freeze]
  s.date = "2014-11-19"
  s.description = "A date and time picker for jQuery and Rails".freeze
  s.email = ["envek@envek.name".freeze]
  s.homepage = "https://github.com/Envek/jquery-datetimepicker-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "This gem packages the datetimepicker jQuery plugin for Rails 3.1+ asset pipeline".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
