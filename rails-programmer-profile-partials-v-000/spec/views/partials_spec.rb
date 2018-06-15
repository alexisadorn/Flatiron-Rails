require 'rails_helper'
require 'spec_helper'

describe "the navbar partial" do
  it "renders the navbar correctly" do
    render "layouts/navbar"

    expect(response).to include('Programmers We L<span class="glyphicon glyphicon-heart"></span>ve')
  end
end

describe "the programmer partial" do
  let(:programmer) { FactoryGirl.create(:programmer) }

  before do
    render "programmers/programmer", :programmer => programmer
  end

  it "renders the programmer's name" do
    expect(response).to include(programmer.name)
  end

  it "renders the programmer's image" do
    expect(response).to include(programmer.image)
  end

end

describe "the programmers index page" do
  programmers_index = File.open("app/views/programmers/index.html.erb", "r").read

  it "does not use iteration to render the programmers" do
    expect(programmers_index).to_not include(".each")
  end

  it "uses shorthand syntax for rendering the collection of programmers" do
    expect(programmers_index).to include("<%= render @programmers %>")
  end
end

# BONUS: Create a partial that renders a single attribute of a programmer
describe "the attribute partial" do
  let(:programmer) { FactoryGirl.create(:programmer) }

  it "renders any attribute of the programmer" do
      view.lookup_context.prefixes = %w[programmers]
      assign(:programmer, programmer)
      render :template => "programmers/show.html.erb"
      expect(response).not_to include("programmer.send(attribute)")
      expect(response).not_to include("programmer.home_country")

  end

end
