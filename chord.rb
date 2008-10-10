#!/usr/bin/ruby
require 'optparse'

class ChordConverter

  def parse(input, output)
    input.each do |line|
      line.strip!
      regex = /(\[[A-G][#|b]?[m|maj]?1?[0-9]?\])/
      l1, l2, prev = "", "", ""
      line.split(regex).each do |token|
        if token =~ regex
          l1 << token
          prev = token
        else
          i = [0,(token.length - prev.length)].max
          l1 << ' ' * i
          l2 << token
          prev = ""
        end
        l1.strip!
        l2.strip!
      end
      output << l1 << "\n"
      output << l2 << "\n"
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
