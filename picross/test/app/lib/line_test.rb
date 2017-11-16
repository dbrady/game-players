require_relative '../../test_helper'
require 'app/lib/line'

class LineTest < MiniTest::Test
  def subject
    Line.new ['?', '?']
  end

  def test_size
    assert_equal 2, subject.size
  end

  def test_to_s_delegates_to_cells_to_s
    cell1 = MiniTest::Mock.new
    cell2 = MiniTest::Mock.new
    cell1.expect :to_s, '.'
    cell2.expect :to_s, '#'
    assert_equal '.#', Line.new([cell1, cell2]).to_s
  end
end
