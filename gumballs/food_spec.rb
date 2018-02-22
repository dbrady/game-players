#!/usr/bin/env ruby
require_relative 'food'

RSpec.describe Feeder do
  it "exists" do
    expect(Feeder).to be
  end

  describe "cost returns item cost" do
    example "for simple items" do
      feeder = Feeder.new(:cream_berry)
      expect(feeder.cost).to eq 750
    end

    example "for complex items" do
      feeder = Feeder.new(:goblins_chocolate)
      expect(feeder.cost).to eq 7545
    end
  end

  # def test_cream_berry
  #   feeder = Feeder.new :cream_berry
  #   assert_equal 750, feeder.cost
  # end

  # def test_goblins_chocolate_costs_7545_gold
  #   feeder = Feeder.new :goblins_chocolate
  #   assert_equal 7545, feeder.cost
  # end
end
