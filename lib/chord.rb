#!/usr/bin/ruby

class ChordConverter

  def initialize(input = $stdin, output = $stdout)
    @regex = /(\[[A-H][#|b]?[m|maj|min]?1?[0-9]?\])/
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
    chordline, textline = "", ""
    line.split(@regex).each do |token|
      process_token(token, chordline, textline)
    end
    return chordline.rstrip << "\n" << textline.strip << "\n"
  end

  def process_token(token, chordline, textline)
    if token =~ @regex
      chordline << token
    else
      textline << token
      chordline << " " * token.length
    end
    return [chordline, textline]
  end

end
