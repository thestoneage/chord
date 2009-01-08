require 'test/unit' unless defined? $ZENTEST and $ZENTEST
require 'lib/chord'

class TestChordConverter < Test::Unit::TestCase

  def setup
    @inline1 = "[Am7]Do what I say, or I will suffer"
    @result1 = <<EOF
[Am7]
Do what I say, or I will suffer
EOF

    @inline2 = "Do what I say, [Dm]or I will suffer"
    @result2 = <<EOF
               [Dm]
Do what I say, or I will suffer
EOF

    @inline3 = "[D]Do what I say, [Em]or I will suffer"
    @result3 = <<EOF
[D]            [Em]
Do what I say, or I will suffer
EOF
  end

  def test_process
    output = ""
    chord = ChordConverter.new("", output)
    assert_equal(@result1, chord.process(@inline1))
  end

  def test_process_line
    chord = ChordConverter.new
    assert(@result1==chord.process_line(@inline1), "Was: \n#{chord.process_line(@inline1)}\nShould be:\n#{@result1}")
    assert(@result2==chord.process_line(@inline2), "Was: \n#{chord.process_line(@inline2)}\nShould be:\n#{@result2}")
    assert(@result3==chord.process_line(@inline3), "Was: \n#{chord.process_line(@inline3)}\nShould be:\n#{@result3}")
  end

  def test_process_token
    chord = ChordConverter.new
    assert_equal(["[Am]", ""], chord.process_token("[Am]","",""))
    assert_equal(["          ", "Hello you!"], chord.process_token("Hello you!","",""))
  end

  
  def encapsulate(chord_array)
    chord_array.map{ |chord| "[#{chord}]" }
  end
  
  def test_chord?
    converter = ChordConverter.new
    upcase = %w{A B C D E F G} + %w{A# B# C# D# E# F# G#} + %w{Ab Bb Cb Db Eb Fb Gb} + %w{H}
    downcase = upcase.map { |chord| chord.downcase }
    notes = upcase + downcase

    majors = notes.clone
    minors = majors.map { |chord| "#{chord}m" }
    maj_sevens = majors.map { |chord| "#{chord}7" }
    min_sevens = minors.map { |chord| "#{chord}7" }
    

    chords = [majors, minors, maj_sevens, min_sevens]
    chords.each do |chord_array|
      encapsulate(chord_array).each do |chord_string|
        assert(converter.chord?(chord_string), "Should match #{chord_string} but didn't")
      end
    end
  end
    
end
