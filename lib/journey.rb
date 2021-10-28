require_relative './station.rb'

class Journey
  attr_reader :journey
  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 5
  def initialize
    @journey = {}
  end


  def start_journey(station)
    @journey.merge!(start: station)
  end

  def end_journey(station)
    @journey.merge!(end: station) 
  end

  def fare
    complete? ? Journey::MINIMUM_CHARGE : Journey::PENALTY_CHARGE
  end

  def complete?
    (@journey[:start]) != nil && (@journey[:end]) != nil
  end



end