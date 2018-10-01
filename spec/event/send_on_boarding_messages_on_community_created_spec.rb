require 'rails_helper'

RSpec.describe 'SendOnBoardingMessagesOnCommunityCreated' do
  it 'should attach messages to the community general team' do
    command = CreateCommunityCommand.new 'name', 'address', 100
    command_bus = CommandBus.build
    response = command_bus.dispatch command

    expect(response.events?).to be true

    community = Repository.for(:community).get(response.value)
    general_team = community.teams[Community::GENERAL_TEAM_NAME.to_s]

    expect(general_team.name).to eq Community::GENERAL_TEAM_NAME.to_s
    expect(general_team.messages.size.positive?).to be true
  end
end