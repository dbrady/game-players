#!/usr/bin/env ruby
target = ARGV.first&.to_i || 642

metallurgical = 37
electrical = 23
aviation = 59
ancient = 271

solutions = []
(target / metallurgical).times do |m|
  (target / electrical).times do |e|
    (target / aviation).times do |v|
      (target / ancient).times do |n|
        if target == (
             m*metallurgical +
             e*electrical +
             v*aviation +
             n*ancient
           )
          solutions << [m, e, v, n]
        end
      end
    end
  end
end

solutions.each do |m, e, v, n|
  puts "#{m} metal + #{e} electric + #{v} aviation + #{n} ancient == #{target}"
end
