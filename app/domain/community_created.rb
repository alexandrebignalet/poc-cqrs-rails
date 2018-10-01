class CommunityCreated
  attr_reader :community_id

  # UUID community_id
  def initialize(community_id)
    @community_id = community_id
  end
end