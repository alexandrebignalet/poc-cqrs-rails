class CreateCommunityCommand
  attr_reader :name, :address, :size

  def initialize(name, address, size)
    @name = name
    @address = address
    @size = size
  end
end