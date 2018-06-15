describe Review do
  describe 'associations' do
    it 'has a description' do
      expect(@review1.description).to eq("This place was great!") 
    end

    it 'has a rating' do
      expect(@review1.rating).to eq(5) 
    end

    it 'belongs to a guest' do
      expect(@review1.guest).to eq(@logan) 
    end

    it 'belongs to a reservation' do
      expect(@review1.reservation).to eq(@reservation1) 
    end
  end

  describe 'review validations' do
    before(:each) do 
      @invalidrating = Review.new(:description => "hi", :rating => nil)
      @invaliddescription = Review.new(:description => nil, :rating => 5)
    end

    it 'is valid with a rating and description' do
      expect(@review1).to be_valid 
    end

    it 'is invalid without a rating' do 
      expect(@invalidrating).to_not be_valid
    end

    it 'is invalid without a description' do
      expect(@invaliddescription).to_not be_valid 
    end

    it 'is invalid without an associated reservation, has been accepted, and checkout has happened' do 
      no_res = Review.create(description: "Meh", rating: 2, guest_id: User.find_by(id: 6).id)
      res = Reservation.create(checkin: '2014-04-05', checkout: '2014-04-29', listing_id: 1, guest_id: 5, :status => "pending")
      new_res = Reservation.create(checkin: '2014-08-01', checkout: Date.today + 1, listing_id: 1, guest_id: 5, :status => "accepted")
      res_not_accepted = Review.create(description: "Hi!", rating: 3, guest_id: User.find_by(id: 5).id, reservation_id: res.id)
      res_not_passed = Review.create(description: "Hi!", rating: 3, guest_id: User.find_by(id: 5).id, reservation_id: new_res.id)
      expect(no_res).to_not be_valid
      expect(res_not_accepted).to_not be_valid
      expect(res_not_passed).to_not be_valid
    end
  end
end
