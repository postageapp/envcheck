# encoding: utf-8

require 'rubygems'
require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "envcheck"
  gem.homepage = "http://github.com/tadman/envcheck"
  gem.license = "MIT"
  gem.summary = %Q{Ruby Server Environment Checking Tool}
  gem.description = %Q{Provides a simple way to test that your environment is configured correctly.}
  gem.email = "scott@twg.ca"
  gem.authors = [ "Scott Tadman" ]
end

Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end
