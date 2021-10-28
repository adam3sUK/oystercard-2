require_relative './station.rb'

class Journey
  attr_reader :journey
  MINIMUM_CHARGE = 1
  def initialize
    @journey = {}
  end


  def start_journey(station)
    @journey.merge!(start: station)
  end

  def end_journey(station)
    @journey.merge!(end: station) 
  end

  def cost
    MINIMUM_CHARGE
  end

  def complete?
    (@journey[:start]) && (@journey[:end]) ? true : false
  end

end