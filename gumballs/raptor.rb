#!/usr/bin/env ruby
# ruby raptor.rb <target_number>
m=37
e=23
av=59
anc=271
goal = ARGV[0].to_i

1.upto(5) do |ms|
  1.upto(5) do |es|
    1.upto(5) do |avs|
      1.upto(5) do |ancs|
        if m*ms + e*es + av*avs + anc*ancs == goal
          puts "Metallurgy=#{ms}, Electric=#{es}, Aviation=#{avs}, Ancient=#{ancs}"
          break
        end
      end
    end
  end
end
