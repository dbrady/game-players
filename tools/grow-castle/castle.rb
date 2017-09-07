#!/usr/bin/env ruby

# Chart/track castle

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

cost=1162000
level=391
hp=19650
mp=3960

def level_info(level, from_level=0)
  "Level: %5d HP: %7d MP: %5d Cost: %10s Total Cost: %12s" % [level, hp_for_level(level), mp_for_level(level), commaize(cost_for_level(level)), commaize(cost_from(from_level, level))]
end

def castle_chart(start_level, end_level, increment=1)
  start_level.step(end_level, increment).each do |level|
    puts level_info(level, start_level)
  end
end

def how_much_upgrade_can_i_afford(from_level:, with_budget:)
  level = from_level
  total_cost = 0
  while total_cost <= with_budget
    puts level_info(level, from_level)
    total_cost += cost_for_level(level)
    level += 1
  end
end

# Okay so the questions I have most about archers are:
# 1. I'm at level x, how far can I get with y gold?
# 2. I'm at level x, how much will it cost to reach level y?
# 3. I'm at level x, how much will it cost to reach damage y?

# For now, just print the chart of costs from 800 to 1000
# how_much_upgrade_can_i_afford from_level: 391, with_budget: 218_614_449
# castle_chart 391, 550

how_much_upgrade_can_i_afford from_level: 550, with_budget: 221_000_000
