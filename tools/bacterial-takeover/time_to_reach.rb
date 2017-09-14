#!/usr/bin/env ruby
# time_to_reach.rb - given a BPS rate, how long will it take to buy a planet
# (default: Mars)

require_relative 'scientific_notation'

# The Mars Colony costs 12.225 Ddc. That's Duodecillion in short scale
# (i.e. where a billion is a thousand million, not a million million; see
# https://en.wikipedia.org/wiki/Names_of_large_numbers ) so that's times 10**39.
#
# So that's 12_225_000_000_000_000_000_000_000_000_000_000_000_000 units. Bring
# your extra-large wallet.

# Fortunately our currently is quite tiny; in fact in this game you pay with
# cells of bacteria. One cell of E. Coli weighs 0.95e-12 grams. That's 11.614
# Octillion grams. Or 11.614 Septillion kilograms if you prefer. Which is handy
# because about half of that, 5.972 Septillion kilograms, is the mass of the
# entire Earth.

# Forget the large wallet; bring a spare PLANET.

# Anyway. In Bacterial Takeover you start with a few petri dishes, then work
# your way up to your first germ flask; eventually you just start grabbing
# rotting fish (no really, that's the next unit up from flasks). Eventually you
# have entire labs then compounds then cities then space stations,
# industrialized asteroids and finally artificial planets.

# Not finally. It's just that you need a LOT of artificial planets before you
# can buy your first real one. Most of growth media units will segue nicely into
# the next one but there's a gap of about 100 million between the artificial
# planet and reaching Mars, so it becomes a game of how many production
# multipliers you can stack up across the board to reach the colony.

# Right now I have nearly 350 artificial planets, and many hundreds of most
# everything else. All my growth media combined are churning out 9.065e+36
# bacteria per second. Just doing some exponent estimation, it looks like I'm
# about a third short of a perfect 1:1000 growth ratio, so call it 1333 seconds
# or so?
# irb> 12.225e+39 / 9.065e+36
# => 1348.5934914506342
#
# Yeah, I still got it.

# Anyway, that's what this program does:
# $ time_to_mars.rb 9.065e+36
# 1348.593 seconds
# 0 days, 0:22:28

# which means by the time I finish writing this program I'll probably have
# reached Mars, heh.

# Edit: Yup. And now I know the cost to reach the next colony, Mercury.


# TODO: If you don't name a planet, but the first arg is a scientific number,
# calculate the cost to reach that number, e.g. right now I need 3.945e+46 to
# buy 10 more Mars colonies (I already have 160; don't ask me how I have 160
# Marses lying around, let alone where I'm keeping them--they sure don't fit in
# my spare planet Earth, narmean?)
planet_costs = {
  "mars" => "12.225e+39".to_sci,
  "mercury" => "1.222e+48".to_sci,
}

planet_name, rate = if ARGV.size == 2
                 ARGV
               elsif ARGV.size == 1
                 ["mars", ARGV[0]]
               else
                 raise "Expected 1 or 2 args, got #{ARGV.size}"
               end

puts '-' * 80
puts "planet: #{planet_name.inspect}"
puts "rate: #{rate.inspect}"
puts '-' * 80

planet = planet_name.downcase

raise "I don't recognize planet '#{planet_name}' (...yet?)" unless planet_costs.has_key?(planet_name)
cost = planet_costs[planet_name]

raise "'#{rate}' does not look like a number in scientific notation. Should look like '1.213e+12'" unless rate.scientific?

rate = rate.to_sci

puts "Cost to reach #{planet} is #{rate.to_i}"

seconds = cost / rate

puts "#{seconds} seconds"

days = seconds / 86400
seconds -= 86400 * days
hours = seconds / 3600
seconds -= 3600 * hours
min = seconds / 60
seconds -= 60 * min
sec = seconds

puts "%d days, %d:%02d:%02d" % [ days, hours, min, sec ]

if days > 365.25
  puts "LOL, that's over #{(days / 365.25).to_i} years!"
end
