require 'rails_helper'

RSpec.describe Category, type: :model do
  it "has a name" do
    expect(@category.name).to eq("My Category")
  end

  it "has some posts" do
    expect(@category.posts).to include(@post)
  end
end
