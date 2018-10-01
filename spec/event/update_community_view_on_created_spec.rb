require 'rails_helper'

RSpec.describe 'Update community and team view on created' do
  it 'should provide values to community and team read repositories' do
    command = CreateCommunityCommand.new 'name', 'address', 100
    bus = CommandBus.build
    response = bus.dispatch command

    community_read_repo = Repository.for(:community_read)
    team_read_repo = Repository.for(:team)

    community_read = community_read_repo.get response.value
    team_read = team_read_repo.get Community::GENERAL_TEAM_NAME.to_s

    expect(community_read[:name]).to eq 'name'
    expect(community_read[:address]).to eq 'address'
    expect(community_read[:size]).to eq 100

    expect(team_read[:name]).to eq Community::GENERAL_TEAM_NAME.to_s
    expect(team_read[:status]).to eq 'active'
    expect(team_read[:messages].size.positive?).to be true
  end
end