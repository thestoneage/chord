#!/usr/bin/ruby
require 'optparse'

class ChordConverter

  def initialize(input = $stdin, output = $stdout)
    @regex = /(\[[A-G][#|b]?[m|maj]?1?[0-9]?\])/
    @input = input  
    @output = output
    @chordline, @textline, @prevchord = '', '', ''
  end

  def process(input)
    input.each do |line|
      @output << process_line(line)
    end
    return @output
  end

  def process_line(line)
    line.strip!
    @chordline, @textline, @prevchord = '', '', ''
    line.split(@regex).each do |token|
      process_token(token)
    end
    return @chordline.rstrip << "\n" << @textline.strip << "\n"
  end

  def process_token(token)
    if token =~ @regex
      @chordline << token
      @prevchord = token
    else
      length = token.length - @prevchord.length
      @chordline << ' ' * length
      @textline << token
      @prevchord = ''
    end
    return [@chordline, @textline, @prevchord]
  end

end

if __FILE__ == $0
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
end
