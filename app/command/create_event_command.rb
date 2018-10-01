class CreateEventCommand
  attr_reader :title, :description, :start_date, :end_date

  def initialize(title, description, start_date, end_date)
    @title = title
    @start_date = start_date
    @end_date = end_date
    @description = description
  end
end