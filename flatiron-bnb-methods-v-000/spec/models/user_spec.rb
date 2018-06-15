describe User do
  describe 'associations' do
    it 'has a name' do
      expect(@katie.name).to eq("Katie") 
    end

    it 'as a host has many listings' do
      expect(@amanda.listings).to include(@listing1) 
    end

    it 'as a guest has many trips' do
      expect(@tristan.trips).to include(@reservation2)
    end

    it 'as a host has many reservations through their listing' do 
      expect(@amanda.reservations).to include(@reservation1)
    end

    it 'as a guest has written many reviews' do
      expect(@avi.reviews).to include(@review3)
    end
    
    it 'as a host, knows about the guests its had' do 
      expect(@amanda.guests).to include(@logan)
    end

    it 'as a guest, knows about the hosts its had' do 
      expect(@logan.hosts).to include(@amanda)
    end

    it 'as a host, knows about its reviews from guests' do
      expect(@amanda.host_reviews).to include(@review1) 
    end
  end
end
