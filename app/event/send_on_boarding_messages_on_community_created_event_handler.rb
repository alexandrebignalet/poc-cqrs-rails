class SendOnBoardingMessagesOnCommunityCreatedEventHandler
  def initialize
    @repository = Repository.for(:community)
  end

  # SendOnBoardingMessagesOnCommunityCreated event
  def handle(event)
    community = @repository.get(event.community_id)
    general_team = community.teams[Community::GENERAL_TEAM_NAME.to_s]
    ["🚀 #{general_team.name}, voici le début de votre histoire !",
     "Prochaine étape, organisez vos évènements",
     "Rendez-vous dans l'onglet Calendrier en haut de cette page et créez votre premier événement"].each do |message|
      general_team.append_message message
     end
  end

  def listen_to
    CommunityCreated
  end
end