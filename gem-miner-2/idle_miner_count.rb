#!/usr/bin/env ruby
# Gem Miner 2 - Easy - Level ? - Idle Miner

# Start with $0 in wallet
# Start with level 1 Pickaxe
# Start with 1 worker (yourself)

# Actions:
# Tap: increment tap count, add (pickaxe level x workers) to wallet
# Upgrade: subtract $20 from wallet, increment pickaxe level by 1
# Hire: subtract $500 from wallet, increment workers by 1

# Exit: Reach $1M, print tap count

class IdleMiner
  attr_accessor :wallet, :pickaxe, :workers, :tap_count

  def initialize
    @wallet = 0
    @pickaxe = 1
    @workers = 1
    @tap_count = 0
  end

  def run
    while wallet < 1_000_000
      if wallet >= 500
        hire!
      elsif wallet >= 20
        upgrade!
      else
        tap!
      end
    end
    win!
  end

  def win!
    puts "**********************************"
    puts "WIN! Wallet has reached #{wallet_money}!"
    puts "Taps: #{tap_count}"
    puts "**********************************"
  end

  def tap!
    self.tap_count += 1
    self.wallet += tap_value
    puts "TAP! Wallet now has #{wallet_money}"
  end

  def upgrade!
    self.pickaxe += 1
    self.wallet -= 20
    puts "UPGRADE: Pickaxe is now level #{pickaxe}"
  end

  def hire!
    self.workers += 1
    self.wallet -= 500
    puts "HIRE! New number of workers is #{workers}"
  end

  def tap_value
    pickaxe * workers
  end

  def wallet_money
    if @wallet == 0
      "$0"
    else
      "$" + number = wallet.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end
  end
end

if __FILE__==$0
  IdleMiner.new.run
end
