require 'rails_helper'

describe Frog do

  it 'has a name and a color' do
    expect { Frog.create(:name => "Kermit", :color => "green") }.to_not raise_error
    trevor = Frog.create(:name => "Trevor", :color => "brown")
    expect(trevor.name).to eq('Trevor')
    expect(trevor.color).to eq('brown')
  end

  it 'belongs to a pond' do 
    walden = Pond.create(:name => "Walden", :water_type => "alkaline")
    kermit = Frog.create(:name => "Kermit", :color => "green", :pond_id => walden.id)

    updated_walden = Pond.find_by(:name => "Walden")
    updated_kermit = Frog.find_by(:name => "Kermit")

    expect(updated_walden.frogs).to include(updated_kermit)
    expect(updated_kermit.pond).to eq(updated_walden)
  end

  it 'has many tadpoles' do 
    kermit = Frog.create(:name => "Kermit", :color => "green")
    tad = Tadpole.create(:name => "Tad", :color => "green", :frog_id => kermit.id)
    polly = Tadpole.create(:name => "Polly", :color => "green", :frog_id => kermit.id)

    updated_kermit = Frog.find_by(:name => "Kermit")

    expect(updated_kermit.tadpoles).to include(tad)
    expect(updated_kermit.tadpoles).to include(polly)
  end

end