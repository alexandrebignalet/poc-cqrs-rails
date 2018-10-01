require 'rails_helper'

RSpec.describe 'CreateCommunityCommand Test' do

  it 'should create a new community' do
    repository = Repository.for(:community)

    handler = CreateCommunityCommandHandler.new
    response = handler.handle CreateCommunityCommand.new 'nom', 'address', 100

    community = repository.get(response.value)
    expect(community.name).to eq 'nom'
    expect(community.address).to eq 'address'
    expect(community.size).to eq 100
  end
end