# Modifying Nested Resources

## Objectives

1. Understand how to handle modifications (create/update) of nested resources.
2. Handle errors and validate data from nested resources.
3. Review the use of view helpers to keep views clean.

## Lesson

Continuing with our blog application, we're going to extend our nested resources to allow for creating and modifying blog posts by author.

### Creating A New Post For An Author

The first thing we want to do is to create a new post that is automatically linked to an `Author`. We could set up a select box on the post page and make the author choose. However, if we're already on the author's page, we know who the author is, so why not do it without forcing the user to choose?

We already used nested resources to view posts by author, so now let's look at nested resources to create posts by author. As usual, we want to start with the route. We want to add `:new` to our nested `:posts` resource:

```ruby
# config/routes.rb

resources :authors, only: [:show, :index] do
  resources :posts, only: [:show, :index, :new]
end
```

This gives us access to `/authors/:id/posts/new`, and a `new_author_post_path` helper.

**Top-tip:** Remember to run `rake routes` if you're unsure of the URL helper name.

We have the route, so now we need to update our `posts_controller#new` action to handle the `:author_id` parameter.

```ruby
# controllers/posts_controller.rb

def new
  @post = Post.new(author_id: params[:author_id])
end
```

Notice that we're passing the `params[:author_id]` into `Post.new()`. We want to make sure that, if we capture an `author_id` through a nested route, we keep track of it and assign the post to that author. We'll actually be carrying this `id` with us for the next few steps, babysitting it through the server request/response cycle.

Now let's get into our author `show` template and add a link to the nested new post page for that author.

```erb
<!-- authors/show.html.erb -->

<h1><%= @author.name %></h1>

<%= link_to "New Post", new_author_post_path(@author) %>

<p>Posts:</p>
<% @author.posts.each do |post| %>
  <div><%= post.title %></div>
<% end %>
```

Let's launch the app (don't forget to `rake db:seed`), browse to `/authors`, click on an author's name, and then click the new post link. Once there, let's make a post.

Something seems off. Where's our author? Looks like we didn't do a great job babysitting that `author_id`. We set it up in the `new` action, but it never made it to the view so that it could get submitted back to the server. Let's fix that. Open up the post form partial and add a hidden field for the `:author_id`.

```erb
<!-- posts/_form.html.erb -->

<%= form_for(@post) do |f| %>
  <label>Post title:</label><br>

  <%= f.hidden_field :author_id %>

  <%= f.text_field :title %><br>
  <label>Post Description</label><br>
  <%= f.text_area :description %><br>
  <%= f.submit %>
<% end %>
```

If we reload the new post page for the author and inspect the source, we should see something like this:

```html
<input type="hidden" value="1" name="post[author_id]" id="post_author_id">
```

Great. That part's working, but we need to carry that `author_id` with us even further.

Remember [Strong Parameters](http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters)? We need to update our `posts_controller` to accept `:author_id` as a parameter for a post. So let's get in there and modify our `post_params` method.

```ruby
# controllers/posts_controller.rb

...

private

def post_params
  params.require(:post).permit(:title, :description, :author_id)
end
```

Now we know the `author_id` will be allowed for mass-assignment in the `create` action.

Let's try it out. Go to an author's new post page, and make a post. We should see the author's name in the byline now!

Why didn't we have to make a nested resource route for `:create` in addition to `:new`? 

The `form_for(@post)` helper in `posts/_form.html.erb` will automatically route to `POST posts_controller#create` for a new `Post`. By carrying the `author_id` as we did and allowing it through strong parameters, the existing `create` route and action can be used without needing to do anything else.

### Editing An Author's Posts

We can use the same technique to allow us to directly edit an author's posts.

First, we allow the `:edit` action in the nested route:

```ruby
# config/routes.rb

resources :authors, only: [:show, :index] do
  resources :posts, only: [:show, :index, :new, :edit]
end
```

We don't have to change any views because `new` and `edit` both use the same `_form` partial that already has the `author_id`.

Now we need to update our post `show` view to give us the new nested link to edit the post for the author.

```erb
<!-- posts/show.html.erb -->

<h1><%= @post.title %></h1>
<p>by <%= link_to @post.author.name, author_path(@post.author) if @post.author %> (<%= link_to "Edit Post", edit_author_post_path(@post.author, @post) if @post.author %>)</p>
<p><%= @post.description %> </p>
```

And if we try it out, everything should work just fine. Reload the page, click the edit link, and edit the post.

Pretty easy, right? We didn't even have to change the controller this time. What's the catch?

### Handling Mischief And Errors In Our URLs

The catch is that we've opened ourselves up to a couple of potential bugs or, worse, opportunities for our more playful users to make a mess of our data. Let's work backward, starting with our recent changes to `edit`.

If you go back to your author post edit page, you'll see a URL similar to `http://localhost:3000/authors/1/posts/1/edit`. This tells us that we are editing the `Post` with `id: 1` by the `Author` with `id: 1`. But what if we change that `author_id` in the URL? Try browsing to `http://localhost:3000/authors/123456/posts/1/edit`, and see what happens.

We end up on the same page! But post `1` belongs to author `1` — not author `123456`. In fact, there *is no* author `123456` in the system. How is this happening?

Remember how we didn't have to change the controller when we added the nested resource route for `:edit`? Well, this is the price we pay for taking shortcuts. What we should do is check to make sure that 1) the `author_id` is valid and 2) the post matches the author. So let's fix that now.

```ruby
# controllers/posts_controller.rb

def edit
  if params[:author_id]
    author = Author.find_by(id: params[:author_id])
    if author.nil?
      redirect_to authors_path, alert: "Author not found."
    else
      @post = author.posts.find_by(id: params[:id])
      redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
    end
  else
    @post = Post.find(params[:id])
  end
end
```

Here we're looking for the existence of `params[:author_id]`, which we know would come from our nested route. If it's there, we want to make sure that we find a valid author. If we can't, we redirect them to the `authors_path` with a `flash[:alert]`.

If we do find the author, we next want to find the post by `params[:id]`, but, instead of directly looking for `Post.find()`, we need to filter the query through our `author.posts` collection to make sure we find it in that author's posts. It may be a valid post `id`, but it might not belong to that author, which makes this an invalid request.

Now if we go back and try our invalid URL (`http://localhost:3000/authors/123456/posts/1/edit`), we should be redirected back to where we belong.

**Top-tip:** One of the downsides of RESTful URL schemes is that curious users can edit the URLs to try to explore the system further. This is how we discovered [all the hidden Netflix genres](http://mashable.com/2016/01/11/netflix-search-codes/#LM6QcfeksZqG). However, this could also lead to security holes in your system, allowing users to potentially mismatch id parameters and wreak havoc in your database, so always guard against that by doing what we've done above.

While we're at it, we should fix up our `new` action to ensure that we're creating a new post for a valid author. Let's make it look like this:

```ruby
# controllers/posts_controller.rb

def new
  if params[:author_id] && !Author.exists?(params[:author_id])
    redirect_to authors_path, alert: "Author not found."
  else
    @post = Post.new(author_id: params[:author_id])
  end
end
```

Here we check for `params[:author_id]` and then for `Author.exists?` to see if the author is real.

Why aren't we doing a `find_by` and getting the author instance? Because we don't need a whole author instance for `Post.new`; we just need the `author_id`. And we don't need to check against the `posts` of the author because we're just creating a new one. So we use `exists?` to quickly check the database in the most efficient way.

But what if `params[:author_id]` is `nil` in the example above? If we just did `Post.new` without the `(author_id: params[:author_id])` argument, the `author_id` attribute of the new `Post` would be initialized as `nil` anyway. So we don't have to do anything special to handle it. It works for us if there is or isn't an `author_id` present.

Which brings us to the last thing we have to do.

### Missing Authors

When someone creates a new post via our nested route, we automatically assign an author, and everything works great. But what about when they create a new post from the regular old `new_post_path`?

We could just eliminate that route and only allow post creation through the nested resource. That might be a valid choice in some applications.

But we've decided we want to be able to select an author at the time of posting if we haven't used the nested route.

Since we're already set up to handle `author_id` on the controller, all we have to do is augment our `posts/_form.html.erb` partial to present a list of authors when none is present.

```erb
<!-- posts/_form.html.erb -->

<%= form_for(@post) do |f| %>
  <label>Post title:</label><br>
  <% if @post.author.nil? %>
    <%= f.select :author_id, options_from_collection_for_select(Author.all, :id, :name) %><br>
  <% end %>
  <%= f.hidden_field :author_id %>

...
```

That gives us a select control if we don't have an author, but we have a problem. We can only have one `:author_id` field. We could put that `hidden_field` in an `else`, which would work, but then we would have a whole bunch of logic cluttering up our view. So let's dump it in our `posts_helper` and clean up that form.

```ruby
# helpers/posts_helper.rb

module PostsHelper
  def author_id_field(post)
    if post.author.nil?
      select_tag "post[author_id]", options_from_collection_for_select(Author.all, :id, :name)
    else
      hidden_field_tag "post[author_id]", post.author_id
    end
  end
end
```

And back in our form partial:

```erb
<!-- posts_form.html.erb -->

<%= form_for(@post) do |f| %>
  <%= author_id_field(@post) %>
  <br>
  <label>Post title:</label><br>
  <%= f.text_field :title %><br>

...
```

Now we should have a selector when we browse to `/posts/new` and a hidden `author_id` field when we browse to `/authors/1/posts/new`.

## Summary

We've seen how to create and edit nested resources, handle for errors or mischievous users in our parameters, and use helpers to extend our views to handle for nested and non-nested versions of the resource.

You're well on your way to becoming a nested resource ninja!

![Ninja Baby](http://i.giphy.com/ErdfMetILIMko.gif)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/modification-nested-routes-reading'>Modifying Nested Resources</a> on Learn.co and start learning to code for free.</p>
