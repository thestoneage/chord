#!/usr/bin/env ruby
# vim: filetype=ruby, fileencoding=UTF-8, tabsize=2, shiftwidth=2

require 'rake'

taskdir = File.expand_path File.join(File.dirname(__FILE__), 'tasks')
$LOAD_PATH.unshift taskdir unless $LOAD_PATH.include? taskdir

FileList[File.join taskdir, '**', '*_task.rb'].each { |raketask| load raketask }
