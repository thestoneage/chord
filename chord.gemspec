#!/usr/bin/env ruby
# vim: filetype=ruby, fileencoding=UTF-8, tabsize=2, shiftwidth=2

filelist = %w[chord.gemspec
 bin/chord
 lib/chord.rb
 Rakefile.rb
 README
 test/test_chord.rb
 tasks/test_task.rb
 tasks/gem_task.rb
 tasks/_default_task.rb]

testlist = filelist.grep /^test/

$spec = Gem::Specification.new do |s|
  s.name = 'chord'
  s.default_executable = 'chord'
  s.executable = 'chord'
  s.summary = 'Chord is a simple ruby-programm that converts text files with inline chord symbols such as [Am] into various formats.'
  s.version = Gem::Version.new '0.0.1'
  s.author = 'Marc Rummel'
  s.email = 'Marc.Rummel@GoogleMail.Com'
  s.homepage = 'https://GitHub.Com/IconOfTheStoneage/Chord/'
  s.required_ruby_version = Gem::Requirement.new '~> 1.8.6'
  s.files = filelist
  s.test_files = testlist
end
