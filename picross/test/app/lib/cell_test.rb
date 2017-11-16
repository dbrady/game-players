require_relative '../../test_helper'
require 'app/lib/cell'

class CellTest < MiniTest::Test
  def test_parse_hash_as_on
    assert Cell.parse('#').on?
    refute Cell.parse('#').off?
    refute Cell.parse('#').unknown?
  end

  def test_parse_space_as_off
    refute Cell.parse(' ').on?
    assert Cell.parse(' ').off?
    refute Cell.parse(' ').unknown?
  end

  def test_parse_dot_as_unknown
    refute Cell.parse('.').on?
    refute Cell.parse('.').off?
    assert Cell.parse('.').unknown?
  end

  # Q: Should I test all three constructors if I know that render has exactly
  #    one code path, that grabs the state?
  # Q: If I only test this one path, should I explicitly test that it's getting
  #    the state?
  def test_render
    assert_equal '#', Cell.parse('#').to_s
  end
end
