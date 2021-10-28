require_relative './journey.rb'

class OysterCard
   attr_reader :balance, :entry_station, :journeys
   
   MAXIMUM_BALANCE = 90
   MINIMUM_BALANCE = 1
   
   def initialize
    @balance = 0
    @journeys = []
   end
   
   def top_up(money)
    fail "your balance is already #{MAXIMUM_BALANCE}" if money + @balance > MAXIMUM_BALANCE
    @balance += money
   end 


   def touch_in(station)
      fail "You do not have sufficient #{MINIMUM_BALANCE}" if minimum_amount?
      if @current_journey == nil 
         @current_journey = Journey.new
         @current_journey.start_journey(station)
      else
         complete_journey
         charge_for_journey
      end


      #fail "Already in a journey" if in_journey?
   end

   def touch_out(station)
      @current_journey.end_journey(station)
      complete_journey
      charge_for_journey
      #fail "Not currently in a journey" unless in_journey?
      #deduct(MINIMUM_CHARGE)
   end

   private

   def complete_journey
      log_journey
   end

   def charge_for_journey
     @balance -= @current_journey.fare
     @current_journey = nil
   end

   def log_journey
      journeys << @current_journey.journey
   end

   #def finish_journey
   #   @entry_station = nil
   #   @exit_station = nil
   #end

   def in_journey?
      @entry_station
   end

   def deduct(fare)
      @balance -= fare
   end

   def minimum_amount?
      @balance < MINIMUM_BALANCE
   end

end








