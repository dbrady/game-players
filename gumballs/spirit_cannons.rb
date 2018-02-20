#!/usr/bin/env ruby
# This is a solver for a set of puzzles in "Fight! The Gold Coast", a puzzle
# maze found on a sky island from the airship.
#
# The puzzle works as follows: there are enemy targets in an NxN grid, and there
# are cannons that can shoot each row and column. Each shot does 100 damage to
# each ghost ship in the row or column faced by that cannon. If a ship is
# killed, it drops one additional spirit ammo. You start with one shot, and must
# kill all the ships.
#
# For the sake of typing brevity, I'm going to divide everything by 100, and
# just talk in terms of the number of shots you need to kill a ship.
#
# Level 1:
#
# 1 3
# 1 2
#
# If we number the cannons top-down and left-to-right, you can shoot cannon 1,
# killing the top-left ship, giving you 1 ammo, and doing 1 damage to the top
# right ship. Now the board looks like this:
#
# _ 2
# 1 2
#
# Now if you shoot cannon 2, it will kill the bottom-left ship and do 1 point of
# damage to the bottom-right ship:
#
# _ 2
# _ 1
#
# And now you can shoot cannon 4, get the ammo from the bottom-right ship, and
# shoot cannon 4 again killing the last ship to drop the key.
#
# You can also solve this by firing cannon 3 to kill both ships on the left and
# gaining 2 ammo, shooting cannon 4 twice, getting the last round from the
# bottom-right ship, and kill the top-right ship with the last shot.


# So, basically the rules are:
#
# 1. if every ship in the grid is dead, you win.
# 2. if any ships are alive and you have 0 shots left, you lose.
# 3. if you shoot cannon 1-N, it does 1 damage to every ship in row N.
# 4. if you shoot cannon N+1-2*N, it does 1 damage to every ship in column N.
# 5. if a ship dies, you get +1 ammo.
# 6. shooting a dead ship serves no purpose.
# require 'minitest'
# require 'minitest/spec'
class SpiritCannons
  attr_reader :board, :shots

  def initialize(board, shots=1)
    raise ArgumentError, "board x cols must be same size, got #{board.size} board, #{board.first.size} cols" unless board.size == board.first.size
    raise ArgumentError, "columns must all be same size" unless board.all? {|row| row.size == board.first.size }
    @board = board.map {|row| row.dup}
    @shots = shots
  end

  def to_s
    board.map {|row| row * " "} * "\n"
  end

  def to_a
    board
  end

  def size
    board.size
  end

  def fire cannon
    if cannon <= board.size
      board[cannon-1].each {|ship| @shots += 1 if ship == 1 }
      board[cannon-1] = board[cannon-1].map {|ship| ship.zero? ? 0 : ship -1 }
    elsif cannon <= board.size * 2
      col = cannon - board.size - 1
      board.each do |row|
        @shots += 1 if row[col] == 1
        row[col] -= 1 unless row[col].zero?
      end
    end
    @shots -= 1
  end

  def win?
    board.all? {|row| row.all? { |ship| ship.zero? } }
  end

  def out_of_ammo?
    shots.zero?
  end

  def possible_moves
    1.upto(2*size).to_a
  end

  def lose?
    out_of_ammo? && !win?
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
