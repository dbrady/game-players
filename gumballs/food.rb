#!/usr/bin/env food
class FoodItem
  attr_reader :name, :cost
  def initialize(name, cost)
    @name, @cost = name, cost
  end
end

class Feeder
  FOODSTUFFS = {
    "Cream Berry" => { "Gold" => 300 },
    "Lizard Spawn" => { "Gold" => 300 },
    "Vanilla Flour" => { "Gold" => 300 },
    "Goblin's Chocolate" => { "Cream Berry" => 10, "Gold" => 45 },

}
