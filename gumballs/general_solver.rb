#!/usr/bin/env ruby

# solver class using recursion and backtracking.

#
# General algorithm for a solver:
# Given:
# 1. an object that must be solved
# 2. a list of moves so far
# 3. the ability to find out what moves can be made on the object
# 4. the ability to copy the object so recursion does not mutate it
# 5. the ability to find out if we're at bad end (no moves left, game lost)
# 6. the ability to find out if we have won
# 7. the ability to apply a move to a copy of the object
# 8. (optionally) a shared list of all the lists of known victory moves
#
# Then we:
# - immediately return true if the object has won
# - immediately return false if the object has lost
# - get the list of possible moves
# - immediately return false if the object has no moves (UNUSED in this algo--if you have any ammo, you can always fire any cannon)
#
# Okay, at this point our base cases are covered. Time to do some work.
#
# - for each possible move m,
#   - make a copy of the object
#   - copy the list of moves and append m to it
#   - apply move m to object
#   - recurse.
#     - if solve(moves, copy_of_object)
#       - victory!
#         - optionally put list of moves on shared list of victories
#         - immediately return list of moves
#     - else
#       - sadness - all subtrees of this move are known to fail
#

class GeneralSolver
  def victory(board, moves)
    puts '-' * 80
    puts "VICTORY: #{moves.map(&:inspect).uniq * ', '}"
    puts '-' * 80
  end

  def solve(board, moves=[])
    if board.win?
      victory(board, moves)
      exit
      return true
    end

    if board.lose?
      return false
    end

    board.possible_moves.each do |move|
      new_board = board.dup
      new_board.move(move)
      new_moves = moves.dup.push move
      solve(new_board, new_moves)
    end
  end
end
