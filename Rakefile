require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "jitterbug"
    gem.summary = %Q{Jitterbug: A just-in-time image creator for pretty text headers}
    gem.description = %Q{Jitterbug provides on-demand text header images using the font of your choice. On its first request, Jitterbug creates the requested header graphic. Then, and on subsequent requests, it returns an html image tag pointing to the header graphic file.}
    gem.email = "contact@flying-saucer.net"
    gem.homepage = "http://github.com/flyingsaucer/jitterbug"
    gem.authors = ["Chris Sessions", "Seth Engelhard"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "jitterbug #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
