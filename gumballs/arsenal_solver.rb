require_relative 'spirit_cannons'

class Solver
  def victory(board, moves)
    puts '-' * 80
    puts "VICTORY: #{moves * ', '}"
    puts '-' * 80
  end

  def solve(board, moves=[])
    if board.win?
      victory(board, moves)
      return true
    end

    if board.out_of_ammo?
      return false
    end

    board.possible_moves.each do |move|
      new_board = SpiritCannons.new(board.to_a, board.shots)
      new_board.fire(move)
      new_moves = moves.dup.push move
      solve(new_board, new_moves)
    end
  end
end
