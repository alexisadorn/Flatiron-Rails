require 'rails_helper'

describe TadpolesController, :type => :request  do
  before(:each) do
    @pond = Pond.create(:name => "Walden", :water_type => "alkaline")
    @frog = Frog.create(:name => "Kermit", :color => "green",  :pond_id => @pond.id)
    @tadpole = Tadpole.create(:name => "Linda", :color => "tan", :frog_id => @frog.id)
  end

  describe "post tadpoles/:id/metamorphose" do
    it "makes a new frog with the tadpole's name, color, and pond" do
      post "/tadpoles/#{@tadpole.id}/metamorphose"
      found_by_name = Frog.find_by(:name => @tadpole.name)
      found_by_color = Frog.find_by(:color => @tadpole.color)
      expect(found_by_color.name).to eq(@tadpole.name)
      expect(found_by_name.color).to eq(@tadpole.color)
      expect(found_by_name.pond).to eq(@tadpole.pond)
      expect(found_by_name).to eq(found_by_color)
    end

    it "deletes the tadpole from the database" do
      post "/tadpoles/#{@tadpole.id}/metamorphose"
      found_by_name = Tadpole.find_by(:name => @tadpole.name)
      found_by_color = Tadpole.find_by(:color => @tadpole.color)
      expect(found_by_color).to be_nil
      expect(found_by_name).to be_nil
    end

    it "redirects to the newly made frog's show page" do
      new_frog_id = Frog.last.id + 1
      post "/tadpoles/#{@tadpole.id}/metamorphose"
      expect(response).to redirect_to("/frogs/#{new_frog_id}")
    end
  end
end