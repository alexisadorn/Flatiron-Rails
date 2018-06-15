require 'rails_helper'

RSpec.describe "settings routing", type: :routing do

  it "routes through admin" do
    expect(get: "/admin/preferences").to be_routable
  end
end
