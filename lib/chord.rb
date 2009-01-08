#!/usr/bin/ruby

class ChordConverter

  def initialize(input = $stdin, output = $stdout)
    @regex = /(\[[a-h|A-H][#|b]?(?:m|maj|min)?1?[0-9]?\])/
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
    if chord?(token)
      chordline << token
    else
      textline << token
      chordline << " " * (textline.length - chordline.length)
    end
    return [chordline, textline]
  end
  
  def chord?(token)
    @regex.match(token) and (@regex.match(token).captures == [token])
  end

end
