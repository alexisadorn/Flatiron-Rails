require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:content) { "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dapibus, nulla vel condimentum ornare, arcu lorem hendrerit purus, ac sagittis ipsum nisl nec erat. Morbi porta sollicitudin leo, eu cursus libero posuere ac. Sed ac ultricies ante. Donec nec nulla ipsum. Nunc eleifend, ligula ut volutpat." }

  let(:valid_attrs) do
    {
      title: "You Won't Believe These True Facts",
      content: content,
      summary: "Abstract.",
      category: "Fiction"
    }
  end

  let(:valid_post) { Post.new(valid_attrs) }
  let(:missing_title) { Post.new(valid_attrs.except(:title)) }
  let(:short_content) { Post.new(valid_attrs.merge(content: "too short")) }
  let(:long_summary) { Post.new(valid_attrs.merge(summary: content)) }
  let(:invalid_cat) { Post.new(valid_attrs.merge(category: "Bowling Ball")) }
  let(:non_clickbait) { Post.new(valid_attrs.merge(title: "True Facts")) }

  it "is valid" do
    expect(valid_post).to be_valid
  end

  it "is invalid without a title" do
    expect(missing_title).to be_invalid
  end

  it "is invalid with too short content" do
    expect(short_content).to be_invalid
  end

  it "is invalid with a long summary" do
    expect(long_summary).to be_invalid
  end

  it "is invalid with a category outside the choices" do
    expect(invalid_cat).to be_invalid
  end

  it "is invalid if not clickbait" do
    expect(non_clickbait).to be_invalid
  end
end
