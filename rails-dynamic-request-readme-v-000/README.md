# Rails Dynamic Request

## Review

You already know how to create a static request, which is where you create a page that doesn't take any parameters and simply renders a view. For example: `localhost:3000/about`. For Rails to process this request, the `routes.rb` file contains a route such as:

```ruby
get 'about', to: "static#about"
```

This is mapped to the `static` controller and its `about` action, which renders the `about.html.erb` view template.

## Dynamic Requests

If you are comfortable with static requests, you will pick up on dynamic requests quickly. According to REST, if we want to retrieve the post with an id of `42`, we should navigate to `/posts/42`. It's technically possible to create a new line in your routes file for each post... but that would quickly get ridiculous. You would have to modify your web server every time someone posts! Enter: dynamic routes. A breakdown of the dynamic route process flow is below:

1. The `routes.rb` file takes in the request and processes it like normal, except this time it also parses the `42` as a parameter and passes it to the posts controller.

2. From that point, the controller action that you write will parse the `42` parameter and run a query on the Post model, storing the result in an instance variable.

3. Finally, the controller passes the instance variable to the associated view, which renders details of that specific post record for the client.

In review, what's the difference between static and dynamic routes?

* Static routes render pages that have a hard coded path connected to them. For example, the `/welcome` path will always show the `welcome` page.

* Dynamic routes will render different data based on the parameters passed to the route. For example, when `42` is passed in as the parameter to the `/posts/:id` route, the app should render the data for the `post` with an ID of `42`. When `222` is passed in, the app should render the data for the `post` with an ID of `222`.


## Code Implementation

In order to setup a dynamic request feature, we will start by writing a test to verify that the page exists:

```ruby
# spec/features/post_spec.rb

require 'rails_helper'

describe 'navigate' do
  before do
    @post = Post.create(title: "My Post", description: "My post desc")
  end

  it 'loads the show page' do
    visit "/posts/#{@post.id}"
    expect(page.status_code).to eq(200)
  end
end
```

Running `rspec` gives us an expected error of: `ActionController::RoutingError: No route matches [GET] "/posts/1"`. To correct this error, let's draw a route that maps to a show action in the PostsController:

```ruby
get 'posts/:id', to: 'posts#show'
```

Here you will notice something that's different from the static route. The `/:id` tells the routing system that this route can receive a parameter and that the parameter will be passed to the controller's show action. With this route in place, let's run our tests again.

You should see a new failure this time: `ActionController::RoutingError: uninitialized constant PostsController`. Once we stub out a `PostsController` class in `app/controllers/posts_controller.rb`, running the tests again will give us yet another new failure: `AbstractController::ActionNotFound: The action 'show' could not be found for PostsController`. This means that we need to create a corresponding `show` action in the PostsController. Let's get this failure fixed with the code below:

```ruby
# app/controllers/posts_controller.rb

class PostsController < ApplicationController
  def show
  end
end
```

Run the tests again. Now we see a failure saying that we are missing the `posts/show` view template. Let's fix that by creating a `posts` folder in the `views` directory and creating a `show.html.erb` file in the new `views/posts` directory.

Running the tests now shows that we're all green, which means that the request will be properly routed through the controller and view and returns an HTTP status code of `200`.

If you start the Rails server and navigate to `/posts/1` or any other `post` record, the router will know what you're talking about. However, the controller still needs to be told what to do with the `id`.

Now that we have the routing configured, let's build a test to see if the post content is rendered on the show page with the title in an `h1` tag and the description in a `p` tag. We'll start by creating a test for the title:

```ruby
# spec/features/post_spec.rb

require 'rails_helper'

describe 'navigate' do
  before do
    @post = Post.create(title: "My Post", description: "My post desc")
  end

  it 'loads the show page' do
    visit "/posts/#{@post.id}"
    expect(page.status_code).to eq(200)
  end

  it 'shows the title on the show page in an h1 tag' do
    visit "/posts/#{@post.id}"
    expect(page).to have_css("h1", text: "My Post")
  end
end
```

This gives us a failure that says: `expected to find css "h1" with text "My Post" but there were no matches`. We first need to get the ID sent by the user through the dynamic URL. This variable is passed into the controller in a hash called `params`. Since we named the route `:id`, the ID will be the value of the `:id` key, stored in `params[:id]`. Let's set that up here:

```ruby
# app/controllers/posts_controller.rb

def show
  @post = Post.find(params[:id])
end
```

In this line, our show action is running a database query on the Post model that will return a post with an ID that matches the route parameters. It will store this record in the `@post` instance variable and make it available to the `show.html.erb` file. Let's get our spec passing by placing the post's title on the show view template:

```erb
<% # app/views/posts/show.html.erb %>
<h1><%= @post.title %></h1>
```

We're back to green! Now let's implement the description spec:

```ruby
it 'shows the description on the show page in a p tag' do
  visit "/posts/#{@post.id}"
  expect(page).to have_css("p", text: "My post desc")
end
```
This will give us a failure since there are no matches on the template yet. To implement this fix, update the view:

```erb
<% # app/views/posts/show.html.erb %>
<h1><%= @post.title %></h1>
<p><%= @post.description %></p>
```

Now we're passing again, and you now know how to create dynamic routes in Rails! However, we would be remiss if we didn't follow the full "Red, Green, Refactor" TDD workflow. There are a few elements of the application that can be refactored. Instead of the long, drawn out `get` route we placed in our `routes.rb` file, we can use Ruby's RESTful defaults and the `resources` method. Problem is, we only have one of the seven RESTful routes. Thankfully, we can pass in an `only` option, selecting which of the seven RESTful routes we care about. In this case, we only care about the `show` action.

Remove:

```ruby
get 'posts/:id', to: 'posts#show'
```

Replace with:

```ruby
resources :posts, only: :show
```

We will go into detail on what the `resources` method does in a future lesson. For right now, just know that it deals with the seven key RESTful routes. In this case, we limited it to only make the `show` action available.

Run the tests for a final time, and they should still be passing! Nice work!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-dynamic-request-readme'>Rails Dynamic Request</a> on Learn.co and start learning to code for free.</p>
