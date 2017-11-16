# Line
# - I have a collection of Cells on a Board
# - I can be vertical or horizontal; I don't know or care
# - I know my size
# - I can be asked to calculate the possible solutions for a given set of Bars
#   (YAGNI? I will probably delegate this to a smarter class than me.)
# - I can be asked to render myself as a row of text. I delegate rendering to
#   each cell
#
# - For example, if I am 5 cells long and all of them are unknown, my rendering
#   would be "?????". Or if I were 5 cells long and my 3rd cell was known to be
#   empty, my rendering would be "??.??". If I were then asked to provide
#   solutions for a single bar of length 2, I would return ["XX...", "...XX"]
#
# - Okay we're definitely getting out of Line territory and into Solver
#   territory, but I can also learn new things about myself without actually
#   arriving at a complete solution. For example if I were length 7 and I had
#   one Bar of length 5, I would know that my middle three cells would be on:
#   "??XXX??". This is because in all of my possible solutions, those cells are
#   on: ["XXXXX..", ".XXXXX.", "..XXXXX"]
#
class Line
  attr_reader :cells

  def initialize(cells)
    @cells = cells
  end

  def size
    cells.size
  end

  def to_s
    cells.map(&:to_s).join ''
  end
end
