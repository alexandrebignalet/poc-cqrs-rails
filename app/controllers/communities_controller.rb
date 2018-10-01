class CommunitiesController < ApplicationController
  def initialize
    @community_read_repo = Repository.for(:community_read)
    @command_bus = CommandBus.build
  end

  def show
    community = @community_read_repo.get(params[:community_id])
    render json: community, status: 200
  end

  def index
    communities = @community_read_repo.all
    render json: communities, status: 200
  end

  def create
    command = CreateCommunityCommand.new(params[:name], params[:address], params[:size])
    response = @command_bus.dispatch command
    render json: response.value, status: 201
  end
end
