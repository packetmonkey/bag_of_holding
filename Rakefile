require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'
RuboCop::RakeTask.new

$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'bag_of_holding'

desc 'Run a console with BagOfHolding loaded'
task :console do
  require 'pry'
  ARGV.clear
  Pry.start
end

task default: [:spec, :rubocop]
