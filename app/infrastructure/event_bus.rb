class EventBus
  def initialize(handlers)
    @handlers = handlers
  end

  def dispatch(event)
    event_class = event.class

    matching_handlers = @handlers.select{|handler| handler.listen_to == event_class}

    matching_handlers.each do |handler|
      handler.handle(event)
    end
  end
end