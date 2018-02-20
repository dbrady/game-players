#!/usr/bin/env ruby
# This is the board class for a set of puzzles in "Abandoned Arsonal II", a
# puzzle maze found on a sky island from the airship.
#
# The puzzle works as follows: there are enemy robots on the map, which is
# labeled like battleship with A down to F and 1 through 5. On the grid are
# Loading Robots and regular robots. Loading robots will drop a bomb when
# killed. Regular robots are labeled with letters, where "a" means it takes one
# hit to kill this robot, "c" means it takes three hits, etc. Loading robots are
# labeled with numbers 1 through 9 and mean the same thing.
#
# At the start of each puzzle, you are given some number of bombs. You win if
# you can destroy all the robots. (Actually, you win if you kill the robot that
# holds the key, which is usually the toughest robot on the board, but starting
# with level 2 it turns out you can get the key without killing all the
# robots. However, there is loot on the floor of the map that you cannot pick up
# while any robots still live to guard it.)
#
# So, the rules:
# 1. A bomb can only be placed ON a robot.
# 2. A bomb does 1 point of damage to the robot it was placed on, plus any
# robots in the adjacent 8 squares.
# 3. If all the robots are dead, you win.
# 4. If you have not won but you are out of bombs, you lose.

class Arsenal
  attr_reader :board, :shots, :robots
  ROWS = 6
  COLS = 5
  EMPTY_TILE = "."

  def initialize board:, shots: 2
    @board, @shots = board, shots
  end

  def to_s
    puts " |12345"
    puts "-+-----"
    1.upto(ROWS).each do |row|
      print "#{row_name(row)}|"
      1.upto(COLS).each do |col|
        print robot_at("#{row_name(row)}#{col_name(col)}")
      end
    end
  end

  def out_of_ammo?
    shots <= 0
  end

  def win?
    robots.all?(&:dead?)
  end

  def fire location
    raise ArgumentError, "location must be a position" unless location =~ /[A-F][1-5]/
  end

  private

  def robot_at(location)
    robots.detect {|robot| robot.location == location } || EMPTY_TILE
  end

  def col_name col
    col
  end

  def row_name row
    ("A".."F")[row-1]
  end
end


board1 = <<BOARD
.....
.a.a.
2.2.2
.a.a.
..3..
.....
BOARD



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
