class Number
  attr_reader :lh, :rh, :op

  def initialize(lh, op=nil, rh=nil)
    raise ArgumentError.new("Number must be created with 1 or 3 args: (int) or (Number, Number, op)") if rh && op.nil?
    @lh, @op, @rh = lh, op, rh
  end

  def simple?
    rh.nil? && op.nil?
  end

  def divisible_by?(number)
    to_i % number.to_i == 0
  end

  def composite?
    !simple?
  end

  def to_i
    if simple?
      lh
    else
      lh.to_i.send op, rh.to_i
    end
  end

  def to_s
    if simple?
      "#{lh}"
    else
      "(#{lh} #{op} #{rh})"
    end
  end

  def *(n); Number.new(self, :*, n); end
  def /(n); Number.new(self, :/, n); end
  def +(n); Number.new(self, :+, n); end
  def -(n); Number.new(self, :-, n); end

  def ==(other)
    case other
    when String
      to_s == other
    when Integer
      to_i == other
    when Number
      to_i == other.to_i
    end
  end

  def score
    lhscore = lh.to_i
    rhscore = if rh.is_a? Number
                rh.score
              else
                rh.to_i
              end
    opscore = {
      :+ => 1,
      :- => 2,
      :* => 4,
      :/ => 8
    }.fetch(op, 0)
    lhscore + opscore + rhscore
  end

  def <=>(other)
    to_i <=> other.to_i
  end
  include Comparable
end
