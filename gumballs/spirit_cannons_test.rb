#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative 'spirit_cannons'

class SpiritCannonsTest < MiniTest::Test
  def board2x2
    SpiritCannons.new [ [1, 3], [1, 2] ]
  end

  def board3x3
    SpiritCannons.new [ [2, 3, 1], [3, 6, 2], [2, 3, 2] ]
  end

  def deadboard
    SpiritCannons.new([ [0, 0], [0, 0] ])
  end

  def test_class_even_exists
    assert_equal 42, 42
  end

  def test_board_can_render
    assert_equal "1 3\n1 2", board2x2.to_s
  end

  def test_cannons_do_damage_to_row
    board = board2x2
    board.fire 1
    assert_equal "0 2\n1 2", board.to_s
  end

  def test_cannons_do_not_overkill_ships_rows
    board = board2x2
    board.fire 1
    board.fire 1
    assert_equal "0 1\n1 2", board.to_s
  end

  def test_cannons_do_damage_to_column
    board = board2x2
    board.fire 4
    assert_equal "1 2\n1 1", board.to_s
  end

  def test_cannons_do_not_overkill_ships_cols
    board = board2x2
    board.fire 3
    board.fire 3
    assert_equal "0 3\n0 2", board.to_s
  end

  def test_board_has_size
    assert_equal board2x2.size, 2
    assert_equal board3x3.size, 3
  end

  def test_board_must_square
    assert_raises ArgumentError do
      SpiritCannons.new [ [1], [1, 2] ]
    end
  end

  def test_board_must_have_all_same_length_rows
    assert_raises ArgumentError do
      SpiritCannons.new [ [1,2,3], [1,2,3], [1,2,3,4] ]
    end
  end

  def test_shots_decrement
    board = board2x2
    assert_equal 1, board.shots
    board.fire 4
    assert_equal 0, board.shots
  end

  def test_win?
    assert_equal false, board2x2.win?
    assert_equal true, deadboard.win?
  end

  def test_lose_if_not_all_dead_and_out_of_ammo
    board = board2x2
    board.fire 4
    assert_equal true, board.lose?
  end

  def test_not_lose_if_out_of_ammo_but_won
    board = deadboard
    board.fire 1
    assert_equal 0, board.shots
    assert_equal false, deadboard.lose?
  end

  def test_killing_a_ship_increments_ammo
    board = board2x2
    assert_equal 1, board.shots
    board.fire 3
    assert_equal 2, board.shots
  end

  def test_to_a_returns_array_implementation
    assert_equal [ [1, 3], [1, 2] ], board2x2.to_a
  end
end

# LEVEL 1
# 1 3
# 1 2

# LEVEL 2
# 2 3 1
# 3 6 2
# 2 3 2

# LEVEL 3
# HARD!
