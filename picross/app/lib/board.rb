# Board - parse, solve, render a board
class Board
  attr_reader :width, :height
  def initialize(width, height, matrix)
    # rubocop: disable Style/ParallelAssignment
    @width, @height, @matrix = width, height, matrix
    # rubocop: enabled Style/ParallelAssignment
  end

  def self.parse(_string)
    Board.new(1, 1, [['#']])
  end
end
