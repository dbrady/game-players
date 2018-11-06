#!/usr/bin/env ruby
# puzzle board for the "Weird Lab" elemental puzzles

# This is basically the game "lights out", or in this case, "Lights On"; you
# must toggle light and dark elementals until all of them are light.

# Elementals are arranged in an MxN grid. Tapping an elemental toggles its color
# as well as the color of the orthogonally adjacent elementals (not diagonal)

require_relative 'recursive_board'

class LightsOnBoard
  include RecursiveBoard

  attr_reader :num_moves, :tiles, :moves_made
  def initialize(num_moves, tiles, moves_made=[])
    @num_moves, @tiles, @moves_made = num_moves, tiles.map {|row| row.dup}, moves_made.map {|move| move.dup}
  end

  def height
    tiles.size
  end

  def width
    tiles.first.size
  end

  def win?
    tiles.all? {|row| row.all? {|tile| tile == 1 } }
  end

  def lose?
    !win? && num_moves <= 0
  end

  def possible_moves
    moves = (0..width).to_a.product((0..height).to_a).map {|move| move.dup }
    moves_made.each do |move|
      moves.delete_if {|possible_move| possible_move[0] == move[0] && possible_move[1] == move[1] }
    end
    moves
  end

  def move(position)
    @num_moves -= 1
    @moves_made << position
    x, y = *position
    flip x, y
    flip x-1, y
    flip x+1, y
    flip x, y-1
    flip x, y+1
  end

  def flip(x, y)
    return if x<0 || x>=width || y<0 || y>=height
    tiles[y][x] = 1 - tiles[y][x]
  end

  # Used for rendering the board
  def to_s
    tiles.map {|row| row * " "} * "\n"
  end

  # Must return a copy of the board with nothing shared (that shouldn't
  # be). Things you should not share: move data, shots fired, game state. Things
  # you CAN share: solution caches, prohibited moves, etc.
  def dup
    LightsOnBoard.new num_moves, tiles
  end
end


# board = LightsOnBoard.new 10, [
#   [0, 0, 0],
#   [0, 0, 0]
# ]

# puts board

# puts "Moving at 2,0..."

# board.move [2, 0]

# puts board

# puts "Moving at 0,1..."

# board.move [0, 1]

# puts board

# puts "Win? #{board.win?.inspect}"
