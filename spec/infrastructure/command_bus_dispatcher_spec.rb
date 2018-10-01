require 'rails_helper'

RSpec.describe 'CommandBus Dispatcher Test' do
  it 'should handle a handled command' do
    handlers = [CreateCommunityCommandHandler.new]
    dispatcher = CommandBus::CommandBusDispatcher.new handlers

    response = dispatcher.dispatch(CreateCommunityCommand.new('name', 'address', 100))

    community_created = Repository.for(:community).get(response.value)
    expect(community_created.name).to eq 'name'
  end

  it 'should throw if no handler is registered for a given command' do
    dispatcher = CommandBus::CommandBusDispatcher.new []

    expect { dispatcher.dispatch({}) }.to raise_error CommandBus::CommandBusDispatcher::HandlerNotFoundError
  end

  it 'should execute the right handler' do
    handlers = [CreateCommunityCommandHandler.new, CreateEventCommandHandler.new]
    dispatcher = CommandBus::CommandBusDispatcher.new handlers

    response = dispatcher.dispatch(CreateCommunityCommand.new('name', 'address', 100))

    community_created = Repository.for(:community).get(response.value)
    expect(community_created.name).to eq 'name'
  end

  it 'should execute logger middleware' do
    dispatcher = CommandBus.build

    dispatcher.dispatch(CreateCommunityCommand.new('name', 'address', 100))
  end
end