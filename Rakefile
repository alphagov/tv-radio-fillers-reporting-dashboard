require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['tests/routes/*.rb', 'tests/helpers/*.rb']
  t.verbose = true
end

desc 'Default task: run all tests'
task :default => [:test]
