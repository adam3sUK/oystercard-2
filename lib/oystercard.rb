class OysterCard
   attr_reader :balance, :entry_station, :journies 
   
   MAXIMUM_BALANCE = 90
   MINIMUM_BALANCE = 1
   MINIMUM_CHARGE = 1
   
   def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journies = []
   end
   
   def top_up(money)
    fail "your balance is already #{MAXIMUM_BALANCE}" if money + @balance > MAXIMUM_BALANCE
    @balance += money
   end 


   def touch_in(station)
      fail "Already in a journey" if in_journey?
      fail "You do not have sufficient #{MINIMUM_BALANCE}" if minimum_amount?
      @entry_station = station
   end

   def touch_out(station)
      fail "Not currently in a journey" unless in_journey?
      deduct(MINIMUM_CHARGE)
      @exit_station = station
      log_journey
   end

   private

   def log_journey
      journies << {entry: @entry_station, exit: @exit_station}
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








