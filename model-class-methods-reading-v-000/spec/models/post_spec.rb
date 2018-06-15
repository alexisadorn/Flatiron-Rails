require 'rails_helper'

RSpec.describe Post, type: :model do
describe "class methods" do
  before do
    Author.destroy_all
    Post.destroy_all

    @author = Author.create(name: "Stephen King")
    @post_king = Post.create(title: "Scary Test", description: "More Tests", author: @author)
    @author2 = Author.create(name: "Tom Jerry")
    @post_tom = Post.create(title: "Chasing Mice", description: "Doesn't Work", author: @author2)
    @post_tom.update_attribute(:created_at, Time.zone.today.advance(days: -1))
  end

  it "queries for posts by author" do
    posts = Post.by_author(@author.id)
    expect(posts.count).to eq 1
    expect(posts.first.title).to eq("Scary Test")
  end

  it "queries for posts today" do
    expect(Post.from_today.count).to eq 1
  end

  it "queries for old posts" do
    expect(Post.old_news.count).to eq 1
  end
end

end
