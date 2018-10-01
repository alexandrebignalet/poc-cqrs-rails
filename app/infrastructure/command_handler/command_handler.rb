class CommandHandler
  def self.register(handler)
    handlers << handler
  end

  def self.handlers
    @handlers ||= []
  end
end