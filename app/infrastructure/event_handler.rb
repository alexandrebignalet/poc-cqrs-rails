class EventHandler
  def self.register(event_handler)
    handlers << event_handler
  end

  def self.handlers
    @handlers ||= []
  end
end