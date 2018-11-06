#!/usr/bin/env ruby
require_relative 'food'

RSpec.describe Feeder do
  it "exists" do
    expect(Feeder).to be
  end

  xdescribe "#cost returns item cost as hash" do
    example "for simple items just includes gold" do
      feeder = Feeder.new(:cream_berry)
      expect(feeder.cost.keys).to eq [:gold]
      expect(feeder.cost[:gold]).to eq 750
    end

    example "for complex items includes number of items" do
      feeder = Feeder.new(:goblins_chocolate)
      expect(feeder.cost[:gold]).to eq 7545
    end
  end

  describe ".cost_of returns item cost" do
    example "of cream berry" do
      expect(Feeder.cost_of(:cream_berry)).to eq {gold: 750}
    end

    example "of goblin's chocolate" do
      expect(Feeder.cost_of(:goblins_chocolate)[:gold]).to eq 7545
    end

    example "of star mint" do
      expect(Feeder.cost_of(:star_mint)[:gold]).to eq 3360
    end

    example "of green gel" do
      expect(Feeder.cost_of(:blue_crystal_gel)[:gold]).to eq 3360
    end

    example "of bishop's chocolate" do
      expect(Feeder.cost_of(:bishops_chocolate)[:gold]).to eq 82650
    end
  end
end
