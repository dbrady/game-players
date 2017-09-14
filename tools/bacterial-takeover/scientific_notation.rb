#!/usr/bin/env ruby
# scientific_notation.rb - Patch String, Integer to go between Scientific and Engineering notations
class String
  def scientific?
    self =~ /^\d+(\.\d+)?e\+\d/
  end

  # Given a string containing a number in scientific notation, return the number
  # as a Float
  #
  # TODO: Since this game is always about very very large numbers (where the
  # floating-point error is in quadrillions or more) do the math manually and
  # return an Integer
  def to_sci
    return 0.0 unless scientific?
    num, exp = self.split /e\+/

    num = num.to_f
    exp = exp.to_i

    num * 10 ** exp
  end

  # Given a string like "1.233 Mil" or "1.233 million", return
  # 1233000. Understands notation up to vig or vigintillion (10**63)
  #
  # Important: uses "short scale" notation, like the U.S. does, rather than
  # "long scale" notation like the U.K. does. Over there a vigintillion is
  # 10**120 which is absolutely preposterous. (As opposed to 10**63 which is
  # merely ludicrous)
  def to_eng
    raise "NotYetImplemented: String#to_eng"
    scale = [
      [  6, "Mil", "million" ],
      [  9, "Bil", "billion" ],
      [ 12, "Tri", "trillion" ],
      [ 15, "Qa", "quadrillion" ],
      [ 18, "Qi", "quintillion" ],
      [ 21, "Sx", "sextillion" ],
      [ 24, "Sp", "septillion" ],
      [ 27, "Oct", "octillion" ],
      [ 30, "No", "nonillion" ],
      [ 33, "Dc", "decillion" ],
      [ 36, "Udc", "Undecillion" ],
      [ 39, "Ddc", "Duodecillion" ],
      [ 42, "Tdc", "Tredecillion" ],
      [ 45, "Qadc", "Quattuordecillion" ], # Yes really, isn't that pretty?
      [ 48, "Qidc", "Quintdecillion" ],
      [ 51, "Sxdc", "Sexdecillion" ],
      [ 54, "Spdc", "Septendecillion"],
      [ 57, "Ocdc", "Octodecillion" ],
      [ 60, "Nodc", "Novemdecillion" ], # Also pretty
      [ 63, "Vig", "Vigintillion" ]
    ]
  end
end
