describe Reservation do
  describe 'associations' do 
    it 'has a checkin time' do 
      expect(@reservation1.checkin).to eq(Date.parse('2014-04-25'))
    end

    it 'has a checkout time' do
      expect(@reservation1.checkout).to eq(Date.parse('2014-04-30')) 
    end

    it 'has a status, default is pending' do 
      expect(@reservation3.status).to eq("accepted")
    end

    it 'belongs to a guest' do 
      expect(@reservation1.guest).to eq(@logan)
    end

    it 'belongs to a listing' do
    expect(@reservation1.listing).to eq(@listing1)
    end

    it 'has a review' do 
      expect(@reservation1.review).to eq(@review1)
    end
  end

  describe 'reservation validations' do
    before(:each) do 
      @invalidcheckin = Reservation.new(checkout: '2014-01-30', guest_id: User.find_by(id: 4).id, listing_id: Listing.first.id)
      @invalidcheckout = Reservation.new(checkin:  '2014-01-30', guest_id: User.find_by(id: 5).id, listing_id: Listing.find_by(id: 2).id)
      @invalid_same_ids = Reservation.new(checkin: '2014-04-25', checkout: '2014-04-30', listing_id: 1, guest_id: 1)
      @invalid_checkin = Reservation.new(checkin: '2014-04-26', checkout: '2014-05-28', guest_id: User.find_by(id: 4).id, listing_id: Listing.first.id)
      @invalid_checkout = Reservation.new(checkin: '2014-04-20', checkout: '2014-04-26', guest_id: User.find_by(id: 4).id, listing_id: Listing.first.id)
      @invalid_checkin_checkout = Reservation.new(checkin:  '2014-04-26', checkout: '2014-04-28', guest_id: User.find_by(id: 4).id, listing_id: Listing.first.id)
      @invalid_checkout_before_checkin = Reservation.new(checkin:  '2014-05-23', checkout: '2014-05-20', guest_id: User.find_by(id: 4).id, listing_id: Listing.first.id)
      @invalid_same_checkout_checkin = Reservation.new(checkin:  '2014-05-23', checkout: '2014-05-23', guest_id: User.find_by(id: 4).id, listing_id: Listing.first.id)
    end

    it 'is valid with a checkin and checkout' do 
      expect(@reservation1).to be_valid
    end

    it 'is invalid without a checkin' do
      expect(@invalidcheckin).to_not be_valid 
    end

    it 'is invalid without a checkout' do
      expect(@invalidcheckout).to_not be_valid 
    end

    it 'validates that you cannot make a reservation on your own listing' do 
      expect(@invalid_same_ids).to_not be_valid
    end

    it 'validates that a listing is available at checkin before making reservation' do 
      expect(@invalid_checkin).to_not be_valid
    end

    it 'validates that a listing is available at checkout before making reservation' do 
      expect(@invalid_checkout).to_not be_valid
    end

    it 'validates that a listing is available at for both checkin and checkout before making reservation' do 
      expect(@invalid_checkin_checkout).to_not be_valid
    end

    it 'validates that checkin is before checkout' do 
      expect(@invalid_checkout_before_checkin).to_not be_valid
    end

    it 'validates that checkin and checkout dates are not the same' do 
      expect(@invalid_same_checkout_checkin).to_not be_valid
    end
  end

  describe 'instance methods' do
    describe "#duration" do
      it 'knows about its duration based on checkin and checkout dates' do
        expect(@reservation1.duration).to eq(5) 
      end
    end
    describe "#total_price" do
      it 'knows about its total price' do
        expect(@reservation1.total_price).to eq(250.00) 
      end
    end
  end
end