class CreateEventCommandHandler

  def initialize
    @repository = Repository.for(:event)
  end

  def handle(command)
    event = Event.new(command.title, command.start_date, command.end_date, command.description)
    @repository.add event
    CommandResponse.with_value event.uuid
  end

  def listen_to
    CreateEventCommand
  end
end