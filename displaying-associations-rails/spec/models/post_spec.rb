require 'rails_helper'

RSpec.describe Post, type: :model do
  it "has a title" do
    expect(@post.title).to eq("My Post")
  end

  it "has a description" do
    expect(@post.description).to eq("My post desc")
  end

  it "has a category" do
    expect(@post.category.name).to eq("My Category")
  end

  it 'has a post_status field' do
    @post.post_status = true
    expect(@post.post_status).to be_truthy
  end
end
