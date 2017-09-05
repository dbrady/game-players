#!/usr/bin/env ruby
require 'colorize'
require 'text-table'

class Array
  def sum
    self.inject {|a,b| a+b}
  end
end


class Income
  attr_reader :name, :gold, :seconds

  def initialize(name, gold=0, seconds=0.0)
    @name, @gold, @seconds = name, gold, seconds.to_f
  end

  def rate
    gold / seconds
  end

  def gps
    format(rate)
  end

  def gpm
    format(rate * 60)
  end

  def gph
    format(rate * 60 * 60)
  end

  def gpd
    format(rate * 24 * 60 * 60)
  end

  def format(number)
    num = "%.02f" % number
    num, dec = *num.split('.', 2)
    num = num.reverse.chars.each_slice(3).map(&:join).join(',').reverse
    "#{num}.#{dec}"
  end
end

# Input rates from the game here:



# Town Mine yields stuff per hour. Equipment is already factored in here; if you
# equip the gold pick let's not try to calculate that; just go to the mine and
# re-read the gold per hour rate.
orcs = Income.new "Orc Workers", 93_600, 3600
workers = Income.new "Human Workers", 1_551_600, 3600
colonies = Income.new "Colonies", 147_890, 47
combat_mixed = Income.new "Combat + Total", 230_696, 44.0

incomes = [ orcs, workers, colonies ]
total = Income.new "Total", incomes.map(&:rate).sum, 1

combat = Income.new "Combat", combat_mixed.rate - total.rate, 1
incomes << combat

table = Text::Table.new
table.head = ["Name", "Gold/Sec", "Gold/Min", "Gold/Hr", "Gold/Day"]
table.foot = [total.name, total.gps, total.gpm, total.gph, total.gpd]

puts "Gold Income:"
incomes.each do |w|
  table.rows << [
    w.name,
    { value: w.gps, align: :right },
    { value: w.gpm, align: :right },
    { value: w.gph, align: :right },
    { value: w.gpd, align: :right },
  ]
end

puts table
