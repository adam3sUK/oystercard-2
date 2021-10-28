require 'oystercard'

describe OysterCard do
    let(:station) { double:station }

    it "initializes with a zero balance" do 
     expect(subject.balance).to eq(0)
    end

    describe "#top_up" do
      oystercard = OysterCard.new
      it "allows user to increase balance" do
        expect(oystercard).to respond_to(:top_up).with(1).argument
      end
      it 'can top up balance' do
        expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
      end 
      it "balance cannot exceed £90" do 
        maximum_balance = OysterCard::MAXIMUM_BALANCE
        subject.top_up(maximum_balance)
        expect { subject.top_up 1}.to raise_error "your balance is already #{maximum_balance}"
      end 
    
    describe "#in_journey" do

      it "raises error on touch in if card has less than minimum fare" do
        expect { subject.touch_in(station) }.to raise_error "You do not have sufficient #{OysterCard::MINIMUM_BALANCE}"
      end

      it "records the current station" do
        subject.top_up(20)
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end

      it "fails touching out if we haven't touched in" do
        expect { subject.touch_out(station) }.to raise_error "Not currently in a journey"
      end

      it " returns false if touch_out" do
        subject.top_up(50)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.entry_station).to eq nil
      end

      it "includes journey" do
        subject.top_up(50)
        subject.touch_in(station)
        expect{ subject.touch_out(station) }.to change{subject.journeys.count}.by (1)
      end

      it "deducted amount from the journey" do
        subject.top_up(50)
        subject.touch_in(station)
        expect{ subject.touch_out(station) }.to change{subject.balance}.by (-OysterCard::MINIMUM_CHARGE)
      end

  end
end
end
