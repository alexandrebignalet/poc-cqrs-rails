# frozen_string_literal: true

module CommandBus
  @@instance = nil

  def self.build
    unless @@instance
      @@instance = EventDispatcherBusMiddleware.new(
          LoggerMiddleware.new(
              CommandBusDispatcher.new(CommandHandler.handlers)
          ),
          LoggerMiddleware.new(
              EventBus.new(EventHandler.handlers)
          )
      )
    end
    
    @@instance
  end

  class CommandBusDispatcher
    class HandlerNotFoundError < RuntimeError
      def initialize(command_class)
        super("Handler for command #{command_class} not found")
      end
    end

    def initialize(handlers)
      @handlers = {}
      handlers.each do |handler|
        @handlers[handler.listen_to] = handler
      end
    end

    def dispatch(command)
      command_class = command.class
      handler = @handlers[command_class]
      raise HandlerNotFoundError, command_class unless handler

      handler.handle command
    end
  end

  class EventDispatcherBusMiddleware
    def initialize(command_bus, event_bus)
      @bus = command_bus
      @event_bus = event_bus
    end

    def dispatch(command)
      command_response = @bus.dispatch(command)

      if command_response.events?
        command_response.events.each do |e|
          @event_bus.dispatch(e)
        end
      end

      command_response
    end
  end

  class LoggerMiddleware
    def initialize(next_dispatcher)
      @next = next_dispatcher
    end

    def dispatch(command)
      start_time = Time.now

      response = @next.dispatch(command)

      end_time = Time.now
      elapsed = end_time - start_time

      puts "Command #{command.class} took #{elapsed}s"

      response
    end
  end
end
