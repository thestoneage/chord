#!/usr/bin/env rake
# vim: filetype=ruby, fileencoding=UTF-8, tabsize=2, shiftwidth=2

require 'rake'
require 'rake/testtask'

taskdir = File.expand_path(File.dirname __FILE__).gsub(/(.*tasks).*?/, '\1')
$LOAD_PATH.unshift taskdir unless $LOAD_PATH.include? taskdir

testdir = File.expand_path(File.join taskdir, '..', 'test')

desc 'Run the Tests'
task :test do
  FileList[File.join testdir, '**', 'test_*.rb'].each { |testsuite| require testsuite }
end
