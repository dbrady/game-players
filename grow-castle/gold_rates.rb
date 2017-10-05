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

  def gpn
    format(rate * 60 * 60 * 8)
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
orcs = Income.new "Orc Workers", 216_000, 3600
workers = Income.new "Human Workers", 1_641_600, 3600
colonies = Income.new "Colonies", 354_013, 48

broken_coin = Income.new "Autocombat with Broken Coin", 880118, 30
no_broken_coin = Income.new "Autocombat w/o Broken Coin", 1074211, 30

g0=890931
g1=1272670


# 4475000 - 4858000
# 383000
combat_mixed = Income.new "Combat + Total", g1-g0, 45.0

incomes = [ orcs, workers, colonies ]
total = Income.new "Total", incomes.map(&:rate).sum, 1

combat = Income.new "Combat", combat_mixed.rate, 1
# Obtain these numbers by replaying a wave, timing it by hand, then checking the
# Gold tab of the Battle Results page
combat_colony = Income.new "Combat Only (Colony Gold Buffs)", 79514, 45.0
combat_buffed = Income.new "Combat Only (Combat Gold Buffs)", 95306, 45.0
incomes << combat
incomes << combat_colony
incomes << broken_coin
incomes << no_broken_coin


g0=4354472
g1=4588800
combat_mixed_combat_buffed = Income.new "Combat + Total (Combat Gold Buffs)", g1-g0, 45.0
colony_combat_buffed = Income.new "Colonies (Combat Gold Buffs)", 137888, 54
incomes << combat_mixed_combat_buffed
incomes << colony_combat_buffed
incomes << combat_buffed

commercial = Income.new "Commercial", 390300, 30.0
incomes << commercial

table = Text::Table.new
table.head = ["Name", "Gold/Sec", "Gold/Min", "Gold/Hr", "Gold/8hr", "Gold/Day"]
table.foot = [total.name, total.gps, total.gpm, total.gph, total.gpn, total.gpd]

puts "Gold Income:"
incomes.each do |w|
  table.rows << [
    w.name,
    { value: w.gps, align: :right },
    { value: w.gpm, align: :right },
    { value: w.gph, align: :right },
    { value: w.gpn, align: :right },
    { value: w.gpd, align: :right },
  ]
end

puts table
