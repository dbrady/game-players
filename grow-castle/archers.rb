#!/usr/bin/env ruby

# Chart/track archers

# WHY ISN'T THERE A WAY TO DO THIS IN RUBY
def commaize(num)
  num.to_s.reverse.chars.each_slice(3).map(&:join).join(",").reverse
end

# Set this to your starting/current upgrade cost and level


# Upgrading archers costs 1,000gp more at each step past the first.
# Upgrading archers adds 0.5 to their total damage.
# At level 844 and damage 401.1, the upgrade cost is exactly 800_000.


# The costs starting out are probably weird because your first 25-50 archers you
# are purchasing actual archers instead of upgrading them in-place. However, the
# price of archers looks like it starts out here:
#
# Level:  47 Damage:  2.6 Cost: 3,000
# Level:  46 Damage:  2.1 Cost: 2,000
# Level:  45 Damage:  1.6 Cost: 1,000
# Level:  44 Damage:  1.1 Cost: 0


# SO! cost_for_level = (level-44)*1000

def cost_for_level level
  (level-44)*1000
end

# AND! damage_for_level = (level-42)*0.5+0.1
# DANGER DANGER DANGER DANGER DANGER DANGER DANGER DANGER DANGER
# DANGER DANGER DANGER DANGER DANGER DANGER DANGER DANGER DANGER
# DANGER DANGER DANGER DANGER DANGER DANGER DANGER DANGER DANGER
#
# This is affected by the % of hell world colonies! It totally skews the linear
# relationship! I currently have (counting manually here...) a total boost of
# 29% to archer damage coming from the hell world. I *ALSO* have a 60% bonus
# coming from the fire bow. Turns out these are both automatically factored into
# the damage adjustments.

# DANGER - ALSO! Prices are sublinear. That weird L-59 thing I keep finding? It
# gets worse as the game goes on, by which I mean better, because the price
# increment breaks along the way. I started this morning with castle level 550
# and 243M gold, and calculated I should be able to reach castle level 681. I
# reached 684. Somewhere along the way the increment dropped from 3,500 to
# 3,000.


# Level   Dam+29%   Dam+59%   Dam+89%
# 1059    331.1     407.5     515.8
#
# 1059*1.29=1136.11; 331.1 / 1136.11
# 1059*1.59=1683.81; 407.5 / 1683.81
# 1059*1.89=2001.51; 515.8 / 2001.51

def damage_for_level level
  (level-42)*0.5+0.1
end

# cost to reach any level from level 44 is a simple n(n-1)/2
def cost_to_reach level
  n = level-44
  (n*(n-1)/2)*1000
end

# there is certainly a clean formula to calculate just start to finish but I'm
# lazy, let's borrow from calculus and subtract the beginning of the integral
# from the end
def cost_from(start_level, end_level)
  cost_to_reach(end_level) - cost_to_reach(start_level)
end

cost=800_000
level=844
damage=401.1


cost_increment=1_000
damage_increment=0.5

def level_info(level)
  "Level: %5d Damage: %5.1f Cost: %10s Total Cost: %12s" % [level, damage_for_level(level), commaize(cost_for_level(level)), commaize(cost_from(844, level))]
end

def archer_chart(start_level, end_level, increment=1)
  start_level.step(end_level, increment).each do |level|
    puts level_info(level)
  end
end


# Okay so the questions I have most about archers are:
# 1. I'm at level x, how far can I get with y gold?
# 2. I'm at level x, how much will it cost to reach level y?
# 3. I'm at level x, how much will it cost to reach damage y?

# For now, just print the chart of costs from 800 to 1000
archer_chart 1050, 1060
