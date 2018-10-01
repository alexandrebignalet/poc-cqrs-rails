module MemoryRepository
  class BaseWriteRepository
    def initialize
      @records = {}
    end

    def add(entity)
      @records[entity.uuid] = entity
      entity
    end

    def get(uuid)
      @records[uuid]
    end

    def all
      @records
    end
  end

  class CommunityRepository < BaseWriteRepository; end
  class EventRepository < BaseWriteRepository; end

  class BaseReadRepository
    def initialize
      @records = {}
    end

    def save(entity)
      @records[entity[:uuid]] = entity
    end

    def get(uuid)
      @records[uuid]
    end

    def all
      @records
    end
  end

  class CommunityReadRepository < BaseReadRepository; end

  class TeamReadRepository < BaseReadRepository
    def save(team)
      @records[team[:name]] = team
    end

    def find_by_name(name)
      @records[name]
    end
  end
end