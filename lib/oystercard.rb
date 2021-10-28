class OysterCard
   attr_reader :balance, :entry_station, :journeys 
   
   MAXIMUM_BALANCE = 90
   MINIMUM_BALANCE = 1
   MINIMUM_CHARGE = 1
   
   def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
   end
   
   def top_up(money)
    fail "your balance is already #{MAXIMUM_BALANCE}" if money + @balance > MAXIMUM_BALANCE
    @balance += money
   end 


   def touch_in(station)
      @current_journey = Journey.new
      @current_journey.start_journey(station)

      #fail "Already in a journey" if in_journey?
      #fail "You do not have sufficient #{MINIMUM_BALANCE}" if minimum_amount?
   end

   def touch_out(station)
      @current_journey.end_journey(station)
      
      
      fail "Not currently in a journey" unless in_journey?
      deduct(MINIMUM_CHARGE)
      @exit_station = station
      log_journey
   end

   private

   def log_journey
      journeys << {entry: @entry_station, exit: @exit_station}
      finish_journey
   end

   def finish_journey
      @entry_station = nil
      @exit_station = nil
   end

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








