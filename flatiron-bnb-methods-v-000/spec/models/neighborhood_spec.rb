describe Neighborhood do
  describe 'associations' do
    it 'has a name' do
      expect(@nabe3.name).to eq('Brighton Beach')
    end

    it 'belongs to a city' do 
      expect(@nabe3.city.name).to eq('NYC')
    end

    it 'has many listings' do 
      expect(@nabe3.listings).to include(@listing3)
    end
  end

  describe 'instance methods' do
    it 'knows about all the available listings given a date range' do
      expect(@nabe1.neighborhood_openings('2014-05-01', '2014-05-05')).to include(@listing2)
      expect(@nabe1.neighborhood_openings('2014-05-01', '2014-05-05')).to_not include(@listing1)
    end 
  end

  describe 'class methods' do
    describe ".highest_ratio_res_to_listings" do
      it 'knows the neighborhood with the highest ratio of reservations to listings' do 
        expect(Neighborhood.highest_ratio_res_to_listings).to eq(@nabe1)
      end
      it "doesn't hardcode the neighborhood with the highest ratio" do 
        make_denver
        expect(Neighborhood.highest_ratio_res_to_listings).to eq(Neighborhood.find_by(:name => "Lakewood"))
      end
    end

    describe ".most_res" do
      it 'knows the neighborhood with the most reservations' do 
        expect(Neighborhood.most_res).to eq(@nabe1)
      end
      it "doesn't hardcode the neighborhood with the most reservations" do 
        make_denver
        expect(Neighborhood.most_res).to eq(Neighborhood.find_by(:name => "Lakewood"))
      end
    end 
  end
end
