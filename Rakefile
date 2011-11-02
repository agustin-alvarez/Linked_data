require 'bundler/gem_tasks'

require 'yard'  #Documentation gem
require 'hpricot'

require 'rake'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/*_test.rb'
end
