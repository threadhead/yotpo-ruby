require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task test: :spec
task default: :spec

require 'yard'
YARD::Rake::YardocTask.new
