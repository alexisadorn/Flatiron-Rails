RSpec.describe "posts/edit", type: :feature do
  let(:valid_content) { "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dapibus, nulla vel condimentum ornare, arcu lorem hendrerit purus, ac sagittis ipsum nisl nec erat. Morbi porta sollicitudin leo, eu cursus libero posuere ac. Sed ac ultricies ante. Donec nec nulla ipsum. Nunc eleifend, ligula ut volutpat." }
  let(:article) do
    Post.create!(title: "Something", category: "Fiction", content: valid_content)
  end

  before(:each) { visit edit_post_path(article) }

  describe "a blank form" do
    it "does not render an error list" do
      expect(page).not_to have_selector("#error_explanation")
    end

    it "does not render error fields" do
      expect(page).not_to have_selector(".field_with_errors")
    end
  end

  context "invalid submissions" do
    let(:invalid_attributes) do
      { title: nil, category: "Speculative Fiction", content: "too short" }
    end

    before(:each) do
      fill_in "Title", with: invalid_attributes[:title]
      fill_in "Category", with: invalid_attributes[:category]
      fill_in "Content", with: invalid_attributes[:content]
      click_button "Update"
    end

    it "renders an error list" do
      expect(all("#error_explanation li").size).to eq(3)
    end

    it "prefills fields" do
      expect(find("input[name=title]").value).to be_empty
      expect(find("input[name=category]").value).to eq(invalid_attributes[:category])
      expect(find("textarea[name=content]").value).to eq(invalid_attributes[:content])
    end

    it "has error class on bad fields" do
      expect(page).to have_css(".field_with_errors input[name=title]")
      expect(page).to have_css(".field_with_errors input[name=category]")
      expect(page).to have_css(".field_with_errors textarea[name=content]")
    end
  end
end

