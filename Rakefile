require 'bundler/gem_tasks'
require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new(:test) do |tsk|
  tsk.test_files = FileList['test/*_test.rb']
end
