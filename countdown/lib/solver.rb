class Solver
  def initialize(numbers, goal)
    @numbers, @goal = numbers.sort.reverse, goal
  end

  def solve
    # Base 1: Winner
    winner = numbers.detect { |n| n == goal }
    return winner if winner

    # Base 2: No solution -- Loser
    return nil if numbers.size == 1

    # Base Condition 3: recurse
    solutions = []
    legal_solvers.each { |s| solution = s.solve;  solutions << solution if solution }
    solutions.empty? ? nil : solutions
  end

  def legal_solvers
    new_solvers = []
    pairs = (0...numbers.size-1).flat_map { |x| ((x+1)..numbers.size-1).map { |y| [x, y] } }

    pairs.each do |i, j|
      new_nums = numbers.dup
      b, a = new_nums.delete_at(j), new_nums.delete_at(i)
      raise "BARF BARF BARF: a: #{a}, b: #{b}, new_nums: #{new_nums * ', '}" if a.to_i.zero? || b.to_i.zero?
      new_solvers << Solver.new([a+b, *new_nums], goal)
      new_solvers << Solver.new([a-b, *new_nums], goal) if a>b
      new_solvers << Solver.new([a*b, *new_nums], goal) if b.to_i > 0
      new_solvers << Solver.new([a/b, *new_nums], goal) if b>1 && a.divisible_by?(b)
    end
    new_solvers
  end

  private

  attr_reader :numbers, :goal

end
