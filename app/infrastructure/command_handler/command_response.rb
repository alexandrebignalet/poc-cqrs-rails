class CommandResponse
  attr_reader :value, :events

  def self.with_value(value, events = [])
    CommandResponse.new value, events
  end

  def events?
    @events.size.positive?
  end

  private
  def initialize(value, events)
    @value = value
    @events = events
  end
end