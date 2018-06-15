require "rails_helper"

RSpec.describe PostsController do
  let(:attributes) do
    {
      title: "The Dangers of Stairs",
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dapibus, nulla vel condimentum ornare, arcu lorem hendrerit purus, ac sagittis ipsum nisl nec erat. Morbi porta sollicitudin leo, eu cursus libero posuere ac. Sed ac ultricies ante. Donec nec nulla ipsum. Nunc eleifend, ligula ut volutpat.",
      category: "Non-Fiction"
    }
  end
  let(:article_found) { Post.find(@article.id) }

  before do
    @article = Post.create!(attributes)
  end

  describe "showing a post" do
    it "shows a post" do
      get :show, id: @article.id
      expect(article_found).to eq(@article)
    end
  end

  describe "making valid updates" do
    let(:new_attributes) do
      attributes.merge(
        id: @article.id,
        title: "Fifteen Ways to Transcend Corporeal Form",
        category: "Fiction"
      )
    end

    it "updates successfully" do
      @article.update(new_attributes)
      expect(article_found.title).to eq(new_attributes[:title])
    end

    it "redirects to show page" do
      patch :update, new_attributes
      expect(response).to redirect_to(post_path(@article))
    end
  end

  describe "making invalid updates" do
    let(:bad_attributes) do
      {
        id: @article.id,
        title: nil,
        content: "too short",
        category: "Speculative Fiction"
      }
    end

    let(:article_bad) { Post.create(bad_attributes) }

    it "has an error for missing title" do
      expect(article_bad.errors[:title]).to_not be_empty
    end

    it "has an error for too short content" do
      expect(article_bad.errors[:content]).to_not be_empty
    end

    it "has an error for invalid category" do
      expect(article_bad.errors[:category]).to_not be_empty
    end

    describe "controller actions" do
      before { patch :update, bad_attributes }

      it "does not update" do
        expect(article_found.content).to_not eq("too short")
      end

      it "renders the form again" do
        expect(response).to render_template(:edit)
      end
    end
  end

end

