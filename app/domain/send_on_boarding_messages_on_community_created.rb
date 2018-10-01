class SendOnBoardingMessagesOnCommunityCreated
  attr_reader :community_id

  def initialize(community_id)
    @community_id = community_id
  end
end