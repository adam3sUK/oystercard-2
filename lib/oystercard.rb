require_relative './journey.rb'

class OysterCard
   attr_reader :balance, :entry_station, :journeys
   
   MAXIMUM_BALANCE = 90
   MINIMUM_BALANCE = 1
   
   def initialize
    @balance = 0
    @journey_history = JourneyLog.new
    @current_journey = []
   end
   
   def top_up(money)
    fail "your balance is already #{MAXIMUM_BALANCE}" if money + @balance > MAXIMUM_BALANCE
    @balance += money
   end 


   def touch_in(station)
      minimum_amount?
      @current_journey == nil ? @current_journey = Journey.new(station) : complete_journey
   end

   def touch_out(station)
      if @current_journey != nil 
         complete_journey(station)
      else
         @current_journey = Journey.new
         complete_journey
      end
   end

   private

   def complete_journey(station=nil)
      @current_journey.end_journey(station)
      log_journey
      charge_for_journey
   end

   def charge_for_journey
     @balance -= @current_journey.fare
     @current_journey = nil
   end

   def log_journey
      journeys << @current_journey.journey
   end

   def deduct(fare)
      @balance -= fare
   end

   def minimum_amount?
      fail "You do not have sufficient fund, need a minimum of £#{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
   end

end








