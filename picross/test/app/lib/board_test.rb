require_relative "../../test_helper"
require "app/lib/board"

class BoardTest < MiniTest::Test
  # rubocop: disable Layout/IndentHeredoc
  def board_1x1
    <<BOARD
  1
  -
1|#
BOARD
  end
  # rubocop: enable Layout/IndentHeredoc

  def test_board_parse
    assert_equal 1, Board.parse(board_1x1).height
    assert_equal 1, Board.parse(board_1x1).width
  end

  # def test_board_render
  #   assert_equal board_1x1, Board.parse(board_1x1).to_s
  # end
end
