require "spec_helper"
require PROJECT_ROOT + '/lib/number'

describe Number do
  let(:one) { Number.new 1 }
  let(:five) { Number.new 5 }
  let(:eight) { Number.new 8 }
  let(:ten) { Number.new 10 }

  let(:fifty) { Number.new(five, :*, ten) }
  let(:four_hundred) { Number.new(fifty, :*, eight) }

  it { expect(ten).to be_divisible_by five }
  it { expect(eight).to_not be_divisible_by five }

  describe "#to_s" do
    it { expect(ten.to_s).to eq("10") }
    it { expect(fifty.to_s).to eq("(5 * 10)")}
    it { expect(four_hundred.to_s).to eq("((5 * 10) * 8)") }
  end

  context "with simple Numbers" do
    it { expect(ten.to_i).to eq(10) }
    it { expect(ten).to be_simple }
  end

  context "with composite Numbers" do
    it { expect(fifty.to_i).to eq(50) }
    it { expect(fifty).to be_composite }
  end

  describe "arithmetic dsl" do
    let(:four_hundred) { fifty * eight }
    let(:two) { ten / five }
    let(:twelve) { ten + two }
    let(:hard_ten) { twelve - two }

    it { expect(four_hundred.to_i).to eq(400) }
    it { expect(four_hundred.to_s).to eq("((5 * 10) * 8)")}

    it { expect(two.to_i).to eq(2) }
    it { expect(two.to_s).to eq("(10 / 5)") }

    it { expect(twelve.to_i).to eq(12) }
    it { expect(twelve.to_s).to eq("(10 + (10 / 5))") }

    it { expect(hard_ten.to_i).to eq(10) }
    it { expect(hard_ten.to_s).to eq("((10 + (10 / 5)) - (10 / 5))")}
  end

  describe "equality" do
    it { expect(fifty).to eq(50) }
    it { expect(50).to eq(fifty) }
    it { expect(fifty).to eq("(5 * 10)")}
    it { expect(fifty).to eq(Number.new(50))}
  end

  describe "<=>" do
    let(:one) { Number.new 1 }
    let(:five) { Number.new 5 }
    let(:eight) { Number.new 8 }
    let(:ten) { Number.new 10 }

    let(:fifty) { Number.new(five, :*, ten) }
    let(:four_hundred) { Number.new(fifty, :*, eight) }

    it { expect([eight, four_hundred, one, ten, fifty, five].sort).to eq([1, 5, 8, 10, 50, 400])}

    it "includes Comparable" do
      expect(eight).to be < ten
    end

    describe "#dump" do
      # ((100 - (10 - (9 - 5))) * (3 + 1))
      #                 \ /         \ /
      # ((100 - (10 - (  4  ))) * (  4 ))
      #            \ /
      # ((100 - (   6        )) * (  4 ))
      #      \ /
      # (     94              ) * (  4 ))
      #                        \ /
      # (                      376      )


      #                 9   5
      #                  \ /
      #                   -
      #             10   /
      #               \ /
      #                -   3   1
      #          100  /     \ /
      #              -       +
      #               \     /
      #                \   /
      #                 \ /
      #                  *


      #               100
      #                  \
      #            10     - 94
      #              \   /    \
      #         9     - 6      \
      #          \   /          \
      #           - 4      3     * 376
      #          /          \   /
      #         5            + 4
      #                     /
      #                    1

      # FORTH:
      # 100 10 9 4 - - - 3 1 + *

      let(:n100) { Number.new 100 }
      let(:n10) { Number.new 10 }
      let(:n9) { Number.new 9 }
      let(:n5) { Number.new 5 }
      let(:n3) { Number.new 3 }
      let(:n1) { Number.new 1 }

      let(:n4a) { n9 - n5 }
      let(:n4b) { n3 + n1 }
      let(:n6) { n10 - n4a }
      let(:n94) { n100 - n6 }
      let(:n376) { n94 * n4b }

      it "returns solution tree" do
      end
    end

  end

  # TODO: How much of Countdown official rules and unofficial side
  # effects do we want to enforce or care about? Examples:
  #
  # * Integers only: x / y is illegal unless x.divisible_by?(y) - A
  #   Number like "(5 / 3)" should raise an error
  #
  # * Natural Numbers Only: This isn't an official rule, but it never
  #   ever happens on the show: "(3 - 5) => -2". Should this raise an
  #   error? For now I say leave it alone, as we may want to extend
  #   this with our own version of the game that allows negative
  #   numbers (and even negative goal numbers). Adding it now would be
  #   an optimization at best (no need processing all of "-25 5 6 7
  #   8", for example), and require extra error handling at
  #   best. Besides, we can optimize and avoid in the solver by
  #   sorting the input numbers and always working left to right so
  #   that x > y at all times.
  #
  # * Legal Numbers: In the official game, there is a set of number
  #   cards to choose from. Legal numbers are limited to (1-10, 25,
  #   50, 75 and 100). Furthermore, these numbers are drawn from a
  #   deck containing exactly 1 each of the big (>=25) numbers, and 20
  #   of the little (<= 10) cards. Presumably there are 2 each of the
  #   little numbers, but there's no official rule. For now I think I
  #   won't enforce this unless I write a puzzle generator; that way
  #   if I want to write harder puzzles the solver doesn't have to be
  #   rewritten to throw away a now-unnecessary test to see if the
  #   input numbers are officially legal, while a puzzle generator (if
  #   any) could handle the specific rules of the deck.


  # 100 3 1 5 9 10 376 # 8/10cats s03e03 round 1
end
