class Robot
  attr_reader :hp, :location

  def initialize location:, hp:, has_bomb: false
    @location, @hp, @has_bomb = location, hp, has_bomb
  end

  def self.create_robot(location, name)
    has_bomb = name.to_i > 0
    hp = if has_bomb
           name.to_i
         else
           ("a".."z").index(name)
         end
    self.new location, hp,
  end

  def has_bomb?
    @has_bomb
  end

  def shoot_at
    @hp =- 1
  end

  def dead?
    hp <= 0
  end

  def alive?
    !dead
  end

  def to_s
    if dead?
      "_"
    elsif has_bomb
      hp
    else
      (:a..:z)[hp-1]
    end
  end
end
