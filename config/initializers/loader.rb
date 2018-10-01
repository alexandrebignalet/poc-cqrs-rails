%w[/lib/*.rb
   /app/domain/**/*.rb 
   /app/infrastructure/**/*.rb
   /app/event/**/*.rb
   /app/command/**/*.rb].each do |path_pattern|
  Dir.glob("#{Rails.root}#{path_pattern}").each do |f|
    puts 'Loading: ' + f
    require f
  end
end

puts 'Registering write repositories'
Repository.register(:community, MemoryRepository::CommunityRepository.new)
Repository.register(:event, MemoryRepository::EventRepository.new)

puts 'Registering read repositories'
Repository.register(:community_read, MemoryRepository::CommunityReadRepository.new)
Repository.register(:team, MemoryRepository::TeamReadRepository.new)

puts 'Registering Command Handlers'
CommandHandler.register(CreateCommunityCommandHandler.new)
CommandHandler.register(CreateEventCommandHandler.new)

puts 'Registering Events Handlers'
EventHandler.register(SendOnBoardingMessagesOnCommunityCreatedEventHandler.new)
EventHandler.register(UpdateCommunityViewOnCreated.new)