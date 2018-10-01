class Community
  GENERAL_TEAM_NAME = 'Général'.freeze

  attr_reader :uuid, :name, :address, :size, :teams

  def initialize(name, address, size)
    @uuid = SecureRandom.uuid
    @name = name
    @address = address
    @size = size
    @teams = {GENERAL_TEAM_NAME.to_s => affect_general_team}
  end

  def affect_general_team
    Team.new(GENERAL_TEAM_NAME, true, 'active', 'Sport Bien Être')
  end
end