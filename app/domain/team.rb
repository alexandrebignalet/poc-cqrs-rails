class Team
  attr_reader :name, :status, :messages

  def initialize(name, moderated, status, theme)
    @name = name
    @moderated = moderated
    @status = status
    @theme = theme
    @messages = []
  end

  def append_message(message)
    @messages << message
  end
end