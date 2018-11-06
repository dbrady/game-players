# General class for solutions via recursive solver with backtracking

class ChildClassMustImplementError < StandardError; end

module RecursiveBoard
  def win?
    raise ChildClassMustImplementError
  end

  def lose?
    !win?
  end

  def possible_moves
    raise ChildClassMustImplementError
  end

  def move(position)
    raise ChildClassMustImplementError
  end

  # Used for rendering the board
  def to_s
    raise ChildClassMustImplementError
  end

  # Must return a copy of the board with nothing shared (that shouldn't
  # be). Things you should not share: move data, shots fired, game state. Things
  # you CAN share: solution caches, prohibited moves, etc.
  def dup
    raise ChildClassMustImplementError
  end
end
