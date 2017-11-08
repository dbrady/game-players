require_relative "../../test_helper"
require "app/lib/board"

class SolverTest < MiniTest::Test
  def test_tiny_full_board_solution
    assert_equal " 1\n1#", Board.new(rows: [1], cols: [1]).solution
  end

  def test_4x4_full_board_solution
    board = Board.new rows: [4, 4, 4, 4],
                      cols: [4, 4, 4, 4]
    expected = " 4444\n4####\n4####\n4####\n4####"
    assert_equal expected, board.solution
  end
end
