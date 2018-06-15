require 'rails_helper'

describe 'navigate' do
  before do
    @author = Author.create(name: "John Grisham", hometown: "Charlottesville, VA")

    @post = Post.create(title: "A Time To Kill", description: "A Time to Kill is a 1989 legal suspense thriller by John Grisham. It was Grisham's first novel. The novel was rejected by many publishers before Wynwood Press (located in New York) eventually gave it a modest 5,000-copy printing. After The Firm, The Pelican Brief, and The Client became bestsellers, interest in A Time to Kill grew; the book was republished by Doubleday in hardcover and, later, by Dell Publishing in paperback, and itself became a bestseller. This made Grisham extremely popular among readers.", author_id: 1)
  end

  it 'shows the title on the show page in a h1 tag' do
    visit "/posts/#{@post.id}"
    expect(page).to have_css("h1", text: "A Time To Kill")
  end

  it 'to post pages' do
    visit "/posts/#{@post.id}"
    expect(page.status_code).to eq(200)
  end

  it 'shows the description on the show page in a p tag' do
    visit "/posts/#{@post.id}"
    expect(page).to have_css("p", text: "A Time to Kill is a 1989 legal suspense thriller by John Grisham. It was Grisham's first novel. The novel was rejected by many publishers before Wynwood Press (located in New York) eventually gave it a modest 5,000-copy printing. After The Firm, The Pelican Brief, and The Client became bestsellers, interest in A Time to Kill grew; the book was republished by Doubleday in hardcover and, later, by Dell Publishing in paperback, and itself became a bestseller. This made Grisham extremely popular among readers.")
  end
end

describe 'form' do
  before do 
    @author = Author.create(name: "John Grisham", hometown: "Charlottesville, VA")
    @post = Post.create(title: "My Post", description: "My post desc", author_id: @author.id)

  end
  it 'shows a new form that submits content and redirects and prints out params' do
    visit new_post_path

    fill_in 'title', with: "My post title"
    fill_in 'description', with: "My post description"

    click_on "Submit Post"

    expect(page).to have_content("My post title")
  end

  it 'shows a new form that submits content and redirects and prints out params' do

    visit edit_post_path(@post)

    fill_in 'title', with: "My edit"
    fill_in 'description', with: "My post description"

    click_on "Submit Post"

    expect(page).to have_content("My edit")
  end
end