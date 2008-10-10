#!/usr/bin/ruby
require 'optparse'

class ChordConverter
  def initialize
    @regex = = /(\[[A-G][#|b]?[m|maj]?1?[0-9]?\])/
  end

  def parse(input, output)
    input.each do |line|
      #process line
      line.strip!
      chordline, textline, prevchord = "", "", ""
      line.split(@regex).each do |token|
        if token =~ @regex
          chordline << token
          prevchord = token
        else
          i = [0,(token.length - prev.length)].max
          chordline << ' ' * i
          textline << token
          prevchord = ""
        end
        chordline.strip!
        textline.strip!
      end
      output << chordline << "\n"
      output << textline << "\n"
    end
  end

end

options = {}
options[:input] = $stdin
options[:output] = $stdout
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"
  opts.on("-o", "--output FILE", "Use Filename instead of STDOUT") do |file|
    options[:output] = open(file, 'w')
  end
  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

if ARGV.length > 0
  options[:input] = open(ARGV[0])
end
p options
p ARGV

converter = ChordConverter.new
converter.parse(options[:input], options[:output])
