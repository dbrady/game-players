#!/usr/bin/env ruby
require 'colorize'
require 'text-table'

# Chart/track castle
def usage
  puts <<USAGE
ruby castle.rb <chart|budget> <start_level> <goal>

Commands:
    chart starting_level max_level - display castle build progression chart
    budget starting_level budget - show how much castle you can build on a budget

Note:
    budget can be written with underscores, commas, and/or k, m, b or g suffix (b == g == Billion)
    E.g. 98.5M == 98_500_000 == 98,500,000 == 98500000
USAGE
end

class Numeric
  def sign
    self > 0 ? '+' : '-'
  end
end

def barf! error
  puts error
  puts usage
  exit 1
end

barf! "Expected 3 arguments, got #{ARGV.size}" unless ARGV.size == 3

COMMANDS = ['chart', 'budget']

command, level, goal = *ARGV
level = level.to_i

barf! "Command must be one of #{COMMANDS.inspect}" unless COMMANDS.include? command

barf! "Castle level must be > 0" unless level > 0

def parse_goal goal
  puts goal
  goal = goal.gsub(/[_,]/, '')
  puts goal

  return goal.to_i if goal =~ /^\d+$/
  return goal.to_f if goal =~ /^\d+\.\d+$/

  goal = goal.to_s.downcase
  convert = goal =~ /\./ ? :to_f : :to_i
  goal = goal.send(convert) * case goal.chars.last
                              when 'k'
                                1000
                              when 'm'
                                1_000_000
                              when 'g', 'b'
                                1_000_000_000
                              else
                                barf! "Unknown conversion factor, must be one of k, m, or g/b"
                              end
end

goal = parse_goal(goal)

barf! "goal must be > 0" unless goal > 0

# WHY ISN'T THERE A WAY TO DO THIS IN RUBY
def commaize(num)
  num.to_s.reverse.chars.each_slice(3).map(&:join).join(",").reverse
end


# Upgrading the castle costs 3500*(L-59)
# MP equals 10*L+50 or 10*(L+5)
# HP 50*L+100 or 50*(L+2)

# SO! cost_for_level = (level-44)*1000

# Upgrading the castle costs 3500*(L-59)
def cost_for_level level
  (level-59)*3500
end

# MP equals 10*L+50 or 10*(L+5)
# HP 50*L+100 or 50*(L+2)

def mp_for_level level
  10*(level+5)
end

def hp_for_level level
  50*(level+2)
end

# cost to reach any level from level 44 is a simple n(n-1)/2
def cost_to_reach level
  n = level-59
  (n*(n-1)/2)*3500
end

# there is certainly a clean formula to calculate just start to finish but I'm
# lazy, let's borrow from calculus and subtract the beginning of the integral
# from the end
def cost_from(start_level, end_level)
  cost_to_reach(end_level) - cost_to_reach(start_level)
end

def level_info(level, from_level=0)
  "Level: %5d HP: %7d MP: %5d Cost: %10s Total Cost: %12s" % level_data(level, from_level)
end

def level_data(level, from_level=0)
  [level, hp_for_level(level), mp_for_level(level), commaize(cost_for_level(level)), commaize(cost_from(from_level, level))]
end

def castle_chart(from_level:, to_level:)
  from_level.step(to_level).each do |level|
    puts level_info(level, from_level)
  end
  size = level_info(to_level,from_level).size
  puts '-' * size
  show_improvement from_level: from_level, to_level: to_level
end

def castle_table(from_level:, to_level:)
  ray = [['Level', 'HP', 'MP', 'Cost', 'Total Cost']]
  from_level.step(to_level).each do |level|
    ray << level_data(level, from_level).map {|value| { value: value, align: :right }}
  end
  puts ray.to_table first_row_is_head: true
  puts improvement_text(from_level: from_level, to_level: to_level)
end

def how_much_upgrade_can_i_afford(from_level:, with_budget:)
  level = from_level
  total_cost = 0
  while total_cost <= with_budget
    puts level_info(level, from_level)
    total_cost += cost_for_level(level)
    level += 1
  end
  size = level_info(level,from_level).size
  puts '-' * size
  puts improvement_text(from_level: from_level, to_level: level)
end

def improvement(from:, to:)
  [from, to, (to-from).sign, 100.0 * to / from - 100]
end

def hp_improvement(from_level:, to_level:)
  improvement from: hp_for_level(from_level), to: hp_for_level(to_level)
end

def mp_improvement(from_level:, to_level:)
  improvement from: mp_for_level(from_level), to: mp_for_level(to_level)
end

def improvement_text(from_level:, to_level:)
  str = <<STR
Improvement:
HP: %6d -> %6d (%s%.1f%%)
MP: %6d -> %6d (%s%.1f%%)
STR
  str % [hp_improvement(from_level: from_level, to_level: to_level),
         mp_improvement(from_level: from_level, to_level: to_level)].flatten
end

# Okay so the questions I have most about archers are:
# 1. I'm at level x, how far can I get with y gold?
# 2. I'm at level x, how much will it cost to reach level y?
# 3. I'm at level x, how much will it cost to reach damage y?

# For now, just print the chart of costs from 800 to 1000
# how_much_upgrade_can_i_afford from_level: 391, with_budget: 218_614_449
# castle_chart 391, 550

puts "WARNING: Castle costs will be weird below level 60".bold.white.on_yellow if level < 60

case command
when 'chart'
  castle_table from_level: level, to_level: goal
when 'budget'
  how_much_upgrade_can_i_afford from_level: level, with_budget: goal
end
