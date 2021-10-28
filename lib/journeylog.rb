class JourneyLog

  def initialize
    @journey_class = Journey.new
    @journey_history = []
  end

  def start(station)
    @journey_class.start_journey(station)
  end

  def finish(station)
    @journey_class.end_journey(station)
  end

  def journeys
    
  end

  private

  def current_journey
    
  end

end