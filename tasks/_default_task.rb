#!/usr/bin/env rake
# vim: filetype=ruby, fileencoding=UTF-8, tabsize=2, shiftwidth=2

require 'rake'

taskdir = File.expand_path(File.dirname __FILE__).gsub(/(.*tasks).*?/, '\1')
$LOAD_PATH.unshift taskdir unless $LOAD_PATH.include? taskdir

task :default => :test
