# Cell class - Knows if it is on, off, or undetermined
# Can render itself as a string
class Cell
  STATE_ON = '#'.freeze
  STATE_OFF = ' '.freeze
  STATE_UNKNOWN = '.'.freeze

  # STATES = [STATE_ON, STATE_OFF, STATE_UNKNOWN].freeze
  attr_reader :state

  def initialize(state)
    @state = state
  end

  def self.parse(state)
    # raise ArgumentError unless state.in? STATES
    Cell.new state
  end

  def on?
    state == STATE_ON
  end

  def off?
    state == STATE_OFF
  end

  def unknown?
    !on? && !off?
  end

  def to_s
    state
  end
end
