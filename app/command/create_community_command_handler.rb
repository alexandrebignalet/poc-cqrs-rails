class CreateCommunityCommandHandler

  def initialize
    @repository = Repository.for(:community)
  end

  def handle(command)
    community = Community.new(command.name, command.address, command.size)
    @repository.add community
    CommandResponse.with_value community.uuid, [CommunityCreated.new(community.uuid)]
  end

  def listen_to
    CreateCommunityCommand
  end
end

