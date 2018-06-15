require 'rails_helper'

describe Tadpole do

  it 'has a name and a color' do
    expect { Tadpole.create(:name => "Polly", :color => "green") }.to_not raise_error
    tad = Tadpole.create(:name => "Tad", :color => "maroon5")
    expect(tad.name).to eq('Tad')
    expect(tad.color).to eq('maroon5')
  end

  it 'belongs to a frog' do 
    kermit = Frog.create(:name => "Kermit", :color => "green")
    tad = Tadpole.create(:name => "Tad", :color => "maroon5", :frog_id => kermit.id)

    updated_kermit = Frog.find_by(:name => "Kermit")

    expect(tad.frog).to eq(kermit)
    expect(updated_kermit.tadpoles).to include(tad)
  end

  it 'belongs to a pond through a frog' do 
    walden = Pond.create(:name => "Walden", :water_type => "alkaline")
    kermit = Frog.create(:name => "Kermit", :color => "green", :pond_id => walden.id)
    tad = Tadpole.create(:name => "Tad", :color => "maroon5", :frog_id => kermit.id)

    updated_walden = Pond.find_by(:name => "Walden")

    expect(tad.pond).to eq(updated_walden)
    expect(updated_walden.tadpoles).to include(tad)
  end

end