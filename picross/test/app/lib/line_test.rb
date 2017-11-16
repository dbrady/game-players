require_relative '../../test_helper'
require 'app/lib/line'

class LineTest < MiniTest::Test
  def subject
    Line.new ['?', '?']
  end

  def test_size
    assert_equal 2, subject.size
  end

  def test_to_s
    assert_equal '??', subject.to_s
  end
end
