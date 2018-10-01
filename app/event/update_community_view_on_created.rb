# frozen_string_literal: true

class UpdateCommunityViewOnCreated
  def initialize
    @write_repository = Repository.for(:community)
    @community_read_repository = Repository.for(:community_read)
    @team_read_repository = Repository.for(:team)
  end

  # CommunityCreated event
  def handle(event)
    community = @write_repository.get(event.community_id)

    @community_read_repository.save(
      uuid: community.uuid,
      name: community.name,
      address: community.address,
      size: community.size
    )

    community.teams.values.each do |t|
      @team_read_repository.save(
        name: t.name,
        status: t.status,
        messages: t.messages
      )
    end
  end

  def listen_to
    CommunityCreated
  end
end
