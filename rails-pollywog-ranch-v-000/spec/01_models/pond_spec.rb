require 'rails_helper'

describe Pond do

  it 'has a name and a water_type' do
    expect { Pond.create(:name => "Walden", :water_type => "alkaline") }.to_not raise_error
    lake = Pond.create(:name => "Hanging Lake", :water_type => "clear")
    expect(lake.name).to eq('Hanging Lake')
    expect(lake.water_type).to eq('clear')
  end

  it 'has many frogs' do
    walden = Pond.create(:name => "Walden", :water_type => "alkaline")
    kermit = Frog.create(:name => "Kermit", :color => "green", :pond_id => walden.id)
    trevor = Frog.create(:name => "Trevor", :color => "brown", :pond_id => walden.id)

    updated_walden = Pond.find_by(:name => "Walden")

    expect(updated_walden.frogs).to include(kermit)
    expect(updated_walden.frogs).to include(trevor)
  end

  it 'has many tadpoles through frogs' do
    walden = Pond.create(:name => "Walden", :water_type => "alkaline")
    kermit = Frog.create(:name => "Kermit", :color => "green", :pond_id => walden.id)
    tad = Tadpole.create(:name => "Tad", :color => "green", :frog_id => kermit.id)
    polly = Tadpole.create(:name => "Polly", :color => "green", :frog_id => kermit.id)

    updated_walden = Pond.find_by(:name => "Walden")

    expect(updated_walden.tadpoles).to include(tad)
    expect(updated_walden.tadpoles).to include(polly)
  end

end
