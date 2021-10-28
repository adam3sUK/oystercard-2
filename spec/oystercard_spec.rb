require 'oystercard'

describe OysterCard do
  let(:station) { double:station}
  let(:journey) { double("A journey", :penalty => 5, :minimum => 1)}
  it "initializes with a zero balance" do 
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    oystercard = OysterCard.new

    it 'can top up balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "balance cannot exceed £90" do 
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1}.to raise_error "your balance is already #{maximum_balance}"
    end 
  end

  describe "#touch_in" do
    it "raises error on touch in if card has less than minimum fare" do
      expect { subject.touch_in(station) }.to raise_error "You do not have sufficient fund, need a minimum of £#{OysterCard::MINIMUM_BALANCE}"
    end

    it "charges a penalty if performed twice in a row" do
      subject.top_up(50)
      subject.touch_in(station)
      expect { subject.touch_in(station) }.to change{ subject.balance }.by -journey.penalty
    end
  end

    describe "#touch_out" do

      it "completes journey" do
        subject.top_up(50)
        subject.touch_in(station)
        expect{ subject.touch_out(station) }.to change{subject.journeys.count}.by (1)
      end

      it "deducted amount from the journey" do
        subject.top_up(50)
        subject.touch_in(station)
        expect{ subject.touch_out(station) }.to change{subject.balance}.by -journey.minimum
      end

      it "incurs penalty if a user attempts to touch out without touching in" do
        new_card = OysterCard.new
        new_card.top_up(20)
        expect{ new_card.touch_out(station) }.to change{new_card.balance}.by -journey.penalty
      end
    end


end
