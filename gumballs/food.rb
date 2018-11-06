#!/usr/bin/env ruby

# Pharaoh

cream_berry = 300

goblins_chocolate = 10 * cream_berry + 45


# Output: to fully feed Pharaoh, you need up to 1,659,000 gold.

# 1. Make Twilight Whisky (45,000 gold x 1 = 45,000)
#   1.1 Make 10 Bone of Moonlight (9,000 gold x 10 = 90,000)
#     1.1.1 Make 20 Tower Flower (900 gold x 20 = 18,000)
#       1.1.1.1 Make 40 Blue Crystal Gel (360 gold x 40 = 14,400)
#         1.1.1.1.1 Make 80 Lizard Spawn (750 gold x 80 = 60,000)
#         1.1.1.1.1 Make 80 Vanilla Flour (750 gold x 80 = 60,000)
#       1.1.1.2 Make 40 Fairy Spring (360 gold x 40 = 14,400)
#         1.1.1.2.1 Make 80 Cream Berry (750 gold x 80 = 60,000)
#         1.1.1.2.2 Make 80 Magic Bean Pod (750 gold x 80 = 60,000)
#     1.1.2 Make 20 Evil Pumpkin (900 gold x 20 = 18,000)
#       1.1.2.1 Make 40 Fantasy Fruit (360 gold x 40 = 14,400)
#         1.1.2.1.1 Make 80 Cream Berry (750 gold x 80 = 60,000)
#         1.1.2.1.2 Make 80 Lizard Spawn (750 gold x 80 = 60,000)
#       1.1.2.2 Make 40 Fairy Spring (360 gold x 40 = 14,400)
#         1.1.2.2.1 Make 80 Cream Berry (750 gold x 80 = 60,000)
#         1.1.2.2.2 Make 80 Magic Bean Pod (750 gold x 80 = 60,000)
#   1.2 Make 10 Heart of Ancient Tree (9,000 gold x 10 = 90,000)
#     1.2.1 Make 20 Tower Flower (900 gold x 20 = 18,000)
#       1.2.1.1 Make 40 Blue Crystal Gel (360 gold x 40 = 14,400)
#         1.2.1.1.1 Make 80 Lizard Spawn (750 gold x 80 = 60,000)
#         1.2.1.1.1 Make 80 Vanilla Flour (750 gold x 80 = 60,000)
#       1.2.1.2 Make 40 Fairy Spring (360 gold x 40 = 14,400)
#         1.2.1.2.1 Make 80 Cream Berry (750 gold x 80 = 60,000)
#         1.2.1.2.2 Make 80 Magic Bean Pod (750 gold x 80 = 60,000)
#     1.2.2 Make 20 Elf's Dust (900 gold x 20 = 18,000)
#       1.2.2.1 Make 40 Fantasy Fruit (360 gold x 40 = 14,400)
#         1.2.2.1.1 Make 80 Cream Berry (750 gold x 80 = 60,000)
#         1.2.2.1.2 Make 80 Lizard Spawn (750 gold x 80 = 60,000)
#       1.2.2.2 Make 40 Star Mint (360 gold x 40 = 14,400)
#           1.2.2.2.1 Make 80 Vanilla Flour (750 gold x 80 = 60,000)
#           1.2.2.2.2 Make 80 Magic Bean Pod (750 gold x 80 = 60,000)
#   1.3 Make 20 Elf's Dust (900 gold x 20 = 18,000)
#     1.3.1 Make 40 Fantasy Fruit (360 gold x 40 = 14,400)
#       1.3.1.1 Make 80 Cream Berry (750 gold x 80 = 60,000)
#       1.3.1.2 Make 80 Lizard Spawn (750 gold x 80 = 60,000)
#     1.3.2 Make 40 Star Mint (360 gold x 40 = 14,400)
#         1.3.2.1 Make 80 Vanilla Flour (750 gold x 80 = 60,000)
#         1.3.2.2 Make 80 Magic Bean Pod (750 gold x 80 = 60,000)
#
#
# Totals:
# Twilight Whisky: 1
# Bone of Moonlight: 10
# Tower Flower: 40
# Blue Crystal Gel: 80
# Lizard Spawn: 400
# Vanilla Flour: 320
# Fairy Spring: 120
# Cream Berry: 480
# Magic Bean Pod: 400
# Evil Pumpkin: 20
# Fantasy Fruit: 120
# Heart Of Ancient Tree: 10
# Elf's Dust: 40
# Star Mint: 80

# Steps:
# 1. Tap Twilight Whisky
# 2. Tap Bone of Moonlight
# 3. Tap Tower Flower
# 4. Tap Blue Crystal Gel
# 5. Buy 400 Lizard Spawn
# 6. Buy 320 Vanilla Flour
# 7. Combine 80 Blue Crystal Gel
# 8. Back out to Tower Flower
# 9. Tap on Fairy Spring
# 10. Buy 480 Cream Berry
# 11. Buy 400 Magic Bean Pod
# 12. Combine 120 Fairy Spring
# 13. Back out to Tower Flower
# 14. Tap on Evil Pumpkin
# 15. Tap on Fantasy Fruit
# 16. Combine 120 Fantasy Fruit
# 17. Back out to Evil Pumpkin
# 18. Combine 20 Evil Pumpkin
# 19. Back out to Tower Flower
# 20. Combine 40 Tower Flower
# 21. Back out to Bone of Moonlight
# 22. Combine 10 Bone of Moonlight
# 23. Back out to Twilight Whisky
# 24. Tap on Heart of Ancient Tree
# 25. Tap on Elf's Dust
# 26. Tap on Star Mint
# 27. Combine 80 Star Mint
# 28. Back out to Elf's Dust
# 29. Combine 40 Elf's Dust
# 30. Back out to Heart of Ancient Tree
# 31. Combine 10 Heart of Ancient Tree
# 32. Back out to Twilight Whisky
# 33. Combine and Feed

# So, here's the thing: this would JUST be the shopping list to create Twilight
# Whisky, which is a big "just" since it's the last and hardest food item in the
# list, but the idea is I want to be able to say "Let's see, I am nearly done
# feeding Pharaoh, all I have left are Twilight Whisky and Goblin's
# Chocolate. What do I do?" The game would know all of the above PLUS the fact
# that Goblin's Chocolate is 10 cream berry + 45 gold = 7545 gold, so it would
# emit the same recipe list as above but:
# - add 7545 to the price tag
# - in step 6, add 10 cream berries to the purchase
# - add step 34 Tap Goblin's Chocolate
# - add step 35 Combine and Feed

# So ultimately you give this thing a list of all the foods you need to feed a
# gumball, it tells you how much gold you would need to feed with nothing in the
# larder, and then tell you how much of everything to buy in one go. Then
# feeding Twilight Whisky is a painful 33 steps, and you're buying like 1800
# Vanilla Flour, etc, but when you come to the next food item, Mermaid Jam, you
# already have all of the essential supplies and even some of the combined
# items. E.g. Mermaid Jam is 20 Evil Pumpkins, 10 Star Scrap, and 10 Rainbow
# Shell, but the instructions for Twilight Whisky would already have made you
# buy and combine the extra Evil Pumpkins. Star Scrap needs Elf's Dust (which
# you'd already have) and Crystal Eggs. Similarly, Rainbow Shell needs Tower
# Flower (which you already have) and Crystal Eggs, but you'll have made all the
# crystal eggs you need putting together the star scrap.
#
# And so on. By the time you've reached the fifth ingredient, it should pretty
# much be Combine and Feed all the way down the line.
#
# So you just list the foods you need, and it builds the shopping/build list. I
# can't believe how hard I work to be this lazy.

cream_berry = {
  gold: 750
}

twilight_whisky = {
  bone_of_moonlight: 10,
  heart_of_ancient_tree: 10,
  elfs_dust: 20,
  gold: 45000
}


pharaoh = %i[
  twilight_whisky
  mermaid_jam
  medusa_brandy
  emperors_chocolate
  owl_red_wine
  miracle_jelly
  vodka_of_fate
  angels_puff
  demons_chocolate
  dwarfs_bitter
  sapphire_jelly
  starlight_pie
  bishops_chocolate
  dryads_ice_cream
  cavemans_gingerbread
  gumball_jelly
  witchs_chocolate
  hobbit_omelet
  soul_cake
  goblins_chocolate
]

# class FoodItem
#   attr_reader :name, :cost, :ingredients
#   def initialize(name, cost, ingredients={})
#   end
# end


class SimpleFoodItem
  attr_reader :cost
  def initialize(name, cost)
    @cost = cost
  end
end

class ComplexFoodItem
  attr_reader :name, :cost, :ingredients
  def initialize(name, cost, ingredients)
    @name, @cost, @ingredients = name, cost, ingredients
  end

  def cost
    total_cost = @cost
    ingredients.each do |ingredient, count|
      total_cost += ingredient.cost * count
    end
    total_cost
  end
end

class Feeder
  attr_reader :items
  def initialize(item_names)
    @items = []
    Array(item_names).each do |name|
      @items << @@foods.fetch(name)
    end
  end

  def cost
    items.map {|item| item.cost }.reduce(&:+)
  end

  @@foods = {
    cream_berry: SimpleFoodItem.new(:cream_berry, 750),
    goblins_chocolate: ComplexFoodItem.new(:goblins_chocolate, 45,
                                           [
                                             [SimpleFoodItem.new(:cream_berry, 750), 10]
                                           ]),
    bishops_chocolate: ComplexFoodItem.new(:bishops_chocolate, 450,
                                           [
                                             [ComplexFoodItem.new(:blue_crystal_gel, 360,
                                                                  [
                                                                    [SimpleFoodItem.new(:lizard_spawn, 750), 10],
                                                                    [SimpleFoodItem.new(:vanilla_flour, 750), 10]
                                                                  ]
                                                                 ), 10],
                                             [ComplexFoodItem.new(:star_mint, 360,
                                                                  [
                                                                    [SimpleFoodItem.new(:vanilla_flour, 750), 2],
                                                                    [SimpleFoodItem.new(:magic_bean_pod, 750), 2]
                                                                  ]
                                                                 ), 10],
                                             [SimpleFoodItem.new(:cream_berry, 750), 20]
                                           ])
  }

  @@food_data = {
    cream_berry: { gold: 750 },
    lizards_spawn: { gold: 750 },
    vanilla_flour: { gold: 750 },
    magic_bean_pod: { gold: 750 },

    goblins_chocolate: { gold: 45, ingredients: { cream_berry: 10 }},
    blue_crystal_gel: { gold: 360, ingredients: { lizards_spawn: 2, vanilla_flour: 2 }},
    star_mint: { gold: 360, ingredients: { vanilla_flour: 2, magic_bean_pod: 2 }},
    fairy_spring: { gold: 360, ingredients: { cream_berry: 2, magic_bean_pod: 2 }},
    fantasy_fruit: { gold: 360, ingredients: { cream_berry: 2, lizards_spawn: 2 }},

    bishops_chocolate: {
      gold: 450,
      ingredients: {
        blue_crystal_gel: 10,
        star_mint: 10,
        cream_berry: 20
      }
    },

    crystal_egg: {
      gold: 900,
      ingredients: {
        blue_crystal_gel: 2,
        star_mint: 2
      }
    },

    elfs_dust: {
      gold: 900,
      ingredients: {
        fantasy_fruit: 2,
        star_mint: 2
      }
    },

    evil_pumpkin: {
      gold: 900,
      ingredients: {
        fantasy_fruit: 2,
        fairy_spring: 2
      }
    },

    tower_flower: {
      gold: 900,
      ingredients: {
        blue_crystal_gel: 2,
        fairy_spring: 2
      }
    },

    miracle_jelly: {
      gold: 4500,
      ingredients: {
        tower_flower: 10,
        elfs_dust: 10,
        blue_crystal_gel: 20
      }
    },

    unicorns_cheese: {
      gold: 4500,
      ingredients: {
        elfs_dust: 10,
        crystal_egg: 10,
        fantasy_fruit: 20
      }
    },

    bone_of_moonlight: {
      gold: 9000,
      ingredients: {
        tower_flower: 2,
        evil_pumpkin: 2
      }
    },

    dragons_rib: {
      gold: 9000,
      ingredients: {
        crystal_egg: 2,
        evil_pumpkin: 2
      }
    },

    heart_of_ancient_tree: {
      gold: 9000,
      ingredients: {
        tower_flower: 2,
        elfs_dust: 2
      }
    },

    rainbow_shell: {
      gold: 9000,
      ingredients: {
        tower_flower: 2,
        crystal_egg: 2
      }
    },

    star_scrap: {
      gold: 9000,
      ingredients: {
        elfs_dust: 2,
        crystal_egg: 2
      }
    },

    emperors_chocolate: {
      gold: 45000,
      ingredients: {
        dragons_rib: 10,
        heart_of_ancient_tree: 10,
        tower_flower: 20
      }
    },

    medusa_brandy: {
      gold: 45000,
      ingredients: {
        bone_of_moonlight: 10,
        rainbow_shell: 10,
        tower_flower: 20
      }
    },

    mermaid_jam: {
      gold: 45000,
      ingredients: {
        rainbow_shell: 10,
        star_scrap: 10,
        evil_pumpkin: 20
      }
    },

    starmoon_vodka: {
      gold: 45000,
      ingredients: {
        bone_of_moonlight: 10,
        star_scrap: 10,
        elfs_dust: 20
      }
    }
  }

  def self.cost_of(name, running_tab=Hash.new(0))
    item = @@food_data.fetch name
    # running_tab[:gold] += item.fetch :gold
    # item.fetch(:ingredients).each do |ingredient, count|
    #   running_tab[ingredient] += count
    # end
    total_cost = item.fetch(:gold) + item.fetch(:ingredients, {})
                                     .each_pair
                                     .map {|item_name, quantity| cost_of(item_name) * quantity }
                                     .reduce(0, &:+)
  end
end

# Brenda 20221188036

# Reagan in claims

puts Feeder.cost_of :starmoon_vodka
puts "-" * 20
puts Feeder.cost_of :mermaid_jam
puts "-" * 20
puts Feeder.cost_of :medusa_brandy
puts "-" * 20
puts Feeder.cost_of :emperors_chocolate
puts "-" * 20
puts Feeder.cost_of :unicorns_cheese
puts "-" * 20
puts Feeder.cost_of :miracle_jelly
puts "-" * 20
