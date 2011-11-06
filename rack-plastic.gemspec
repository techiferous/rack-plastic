# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-plastic}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wyatt Greene"]
  s.date = %q{2011-02-21}
  s.description = %q{
      If you are creating Rack middleware that changes the HTML response, use
      Rack::Plastic to get a head start.  Rack::Plastic takes care of the
      boilerplate Rack glue so that you can focus on simply changing the HTML.
    }
  s.email = %q{techiferous@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "CHANGELOG",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "lib/plastic_helper.rb",
    "lib/plastic_test_helper.rb",
    "lib/rack-plastic.rb",
    "test/rack-plastic_test.rb",
    "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/techiferous/rack-plastic}
  s.require_paths = ["lib"]
  s.requirements = ["none"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Helps you write Rack middleware using Nokogiri.}
  s.test_files = [
    "examples/middlewares/initial.rb",
    "examples/middlewares/intro.rb",
    "examples/middlewares/l337.rb",
    "examples/middlewares/stylizer.rb",
    "examples/rackapp/app.rb",
    "examples/railsapp/app/controllers/application_controller.rb",
    "examples/railsapp/app/controllers/tommy_boy_controller.rb",
    "examples/railsapp/app/helpers/application_helper.rb",
    "examples/railsapp/app/helpers/tommy_boy_helper.rb",
    "examples/railsapp/config/boot.rb",
    "examples/railsapp/config/environment.rb",
    "examples/railsapp/config/environments/development.rb",
    "examples/railsapp/config/environments/production.rb",
    "examples/railsapp/config/environments/test.rb",
    "examples/railsapp/config/initializers/backtrace_silencers.rb",
    "examples/railsapp/config/initializers/inflections.rb",
    "examples/railsapp/config/initializers/mime_types.rb",
    "examples/railsapp/config/initializers/new_rails_defaults.rb",
    "examples/railsapp/config/initializers/session_store.rb",
    "examples/railsapp/config/routes.rb",
    "examples/railsapp/db/seeds.rb",
    "examples/railsapp/test/functional/tommy_boy_controller_test.rb",
    "examples/railsapp/test/performance/browsing_test.rb",
    "examples/railsapp/test/test_helper.rb",
    "examples/railsapp/test/unit/helpers/tommy_boy_helper_test.rb",
    "examples/sinatraapp/app.rb",
    "test/rack-plastic_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<rack>, [">= 1.0.0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.0"])
      s.add_development_dependency(%q<diffy>, ["= 2.0.4"])
      s.add_development_dependency(%q<colored>, [">= 0"])
    else
      s.add_dependency(%q<rack>, [">= 1.0.0"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rack>, [">= 1.0.0"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.0"])
      s.add_dependency(%q<diffy>, ["= 2.0.4"])
      s.add_dependency(%q<colored>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.0.0"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rack>, [">= 1.0.0"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.0"])
    s.add_dependency(%q<diffy>, ["= 2.0.4"])
    s.add_dependency(%q<colored>, [">= 0"])
  end
end

