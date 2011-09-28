require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Generate documentation for Rack::Plastic.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'Rack::Plastic'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Default: run unit tests.'
task :default => :test

desc 'Test Rack::Plastic'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name          = "rack-plastic"
    s.version       = "0.1.2"
    s.author        = "Wyatt Greene"
    s.email         = "techiferous@gmail.com"
    s.summary       = "Helps you write Rack middleware using Nokogiri."
    s.description   = %Q{
      If you are creating Rack middleware that changes the HTML response, use
      Rack::Plastic to get a head start.  Rack::Plastic takes care of the
      boilerplate Rack glue so that you can focus on simply changing the HTML.
    }
    # As of Jeweler 1.? (documented in 1.6.0), dependencies handled in Gemfile
    s.require_path  = "lib"
    s.files         = []
    s.files         << "README.rdoc"
    s.files         << "LICENSE"
    s.files         << "CHANGELOG"
    s.files         << "Rakefile"
    s.files         += Dir.glob("lib/**/*")
    s.files         += Dir.glob("test/**/*")
    s.homepage      = "http://github.com/techiferous/rack-plastic"
    s.requirements  << "none"
    s.has_rdoc      = true
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
