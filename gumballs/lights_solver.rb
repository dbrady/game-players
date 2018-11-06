#!/usr/bin/env ruby
require_relative 'general_solver'
require_relative 'lights'

# Level 1
# board = LightsOnBoard.new 10, [
#   [0, 0, 0],
#   [0, 0, 0]
# ]

# Level 2
# board = LightsOnBoard.new 15, [
#                             [0, 0, 0],
#                             [0, 0, 0],
#                             [0, 0, 0],
#                           ]

# Level 3
board = LightsOnBoard.new 20, [
                            [0, 1, 1, 0],
                            [1, 0, 0, 1],
                            [1, 0, 0, 1],
                            [0, 1, 1, 0],
                          ]
# Level 4
board = LightsOnBoard.new 30, [
                            [0, 0, 0, 0, 0],
                            [0, 1, 0, 1, 0],
                            [0, 1, 0, 1, 0],
                            [0, 0, 0, 0, 0],
                          ]
solver = GeneralSolver.new.solve board
