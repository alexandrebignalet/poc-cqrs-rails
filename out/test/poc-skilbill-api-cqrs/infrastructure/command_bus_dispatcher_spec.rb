require 'rails_helper'

RSpec.describe 'CommandBus Dispatcher Test' do
  it 'should handle a handled command' do
    repository = MemoryRepository::CommunityRepository.new
    handlers = [CreateCommunityCommandHandler.new(repository)]
    dispatcher = CommandBus::CommandBusDispatcher.new handlers

    uuid = dispatcher.dispatch(CreateCommunityCommand.new('name', 'address', 100))

    expect(repository.get(uuid).name).to eq 'name'
  end

  it 'should throw if no handler is registered for a given command' do
    dispatcher = CommandBus::CommandBusDispatcher.new []

    expect { dispatcher.dispatch(nil) }.to raise_error CommandBus::CommandBusDispatcher::HandlerNotFoundError
  end
end