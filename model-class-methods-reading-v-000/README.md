# Model Class Methods

## Objectives

1. Know when to use a model class method
2. Create model class methods for custom queries

## Lesson

We're gonna keep working on our blog application and adding more
features, so make sure to follow along and try out the code for yourself as
we go! 

Make sure to run `rake db:seed` to get some starter posts and authors.
You might be surprised to see the big names that definitely wrote these
example blog posts!

### Filtering Posts by Author

We have our list of blog posts, which is great, but our readers would
like to be able to filter the list by author. Let's do what every
great blog does and pander to the masses!

We want to start by adding some controls to our view to do the
filtering:

```erb
<!-- app/views/posts/index.html.erb -->

<h1>Believe It Or Not I'm Blogging On Air</h1>

<!-- add this new code above the @posts.each loop -->
<div>
  <h3>Filter posts:</h3>
  <%= form_tag("/posts", method: "get") do %>
    <%= select_tag "author", options_from_collection_for_select(Author.all, "id", "name"), include_blank: true %>
    <%= submit_tag "Filter" %>
  <% end %>
</div>
<!-- end new code -->

<% @posts.each do |post| %>

  ...
  
<% end %>
```

Now if we refresh `/posts`, we should see a select control with our
authors in it and a button. Pick an author and hit "Filter"!

Hm, nothing interesting happened. Rails is magical but not *that*
magical. We have to take that action and write the code to do the
filtering.

Since we're here, we'll just add it right into the view. At the top of
our `index` view, let's add the following:

```erb
<!-- app/views/posts/index.html.erb -->

<!-- new code starts here -->
<% if !params[:author].blank? %>
  <% @posts = Post.where(author: params[:author]) %>
<% end %>
<!-- new code ends here -->

<h1>Believe It Or Not I'm Blogging On Air</h1>

  ...
```

And to ensure that our view has access to the controller's `params`
hash, let's go into `posts_controller` and add this line near the top:

```ruby
# app/controllers/posts_controller.rb

class PostsController < ApplicationController
  helper_method :params

  def index

    ...
```

**Note:** You can use `helper_method` in a controller to expose, or make
available, a controller method in your view, but, as we'll talk about
soon, this isn't always a great idea.

Let's reload our `/posts` page and try that filter again. It
works! Now our readers can filter posts by author.

### Filtering Posts by Date

Job well done. But before we can get even another cup of coffee, we find
out our readers want to be able to filter posts by date so they can see the
freshest hot takes.

Let's get back into our view and add the new filter to our form:

```erb
<!-- app/views/posts/index.html.erb -->

<%= form_tag("/posts", method: "get") do %>
  <%= select_tag "author", options_from_collection_for_select(Author.all, "id", "name"), include_blank: true %>
  
  <!-- new code -->
  <%= select_tag "date", options_for_select(["Today", "Old News"]), include_blank: true %>
  <%= submit_tag "Filter" %>
<% end %>
```

And then let's activate that filter so the new code at the top of our
view looks like this:

```erb
<!-- app/views/posts/index.html.erb -->

<% if !params[:author].blank? %>
  <% @posts = Post.where(author: params[:author]) %>
<% elsif !params[:date].blank? %>
  <% if params[:date] == "Today" %>
    <% @posts = Post.where("created_at >=?", Time.zone.today.beginning_of_day) %>
  <% else %>
    <% @posts = Post.where("created_at <?", Time.zone.today.beginning_of_day) %>
  <% end %>
<% end %>

<h1>Believe It Or Not I'm Blogging On Air</h1>

  ...
```

Reload `/posts` and try it out. If they choose an author, they can
filter by author, or they can filter by date, or they can have it all.
We've pleased everyone!

**Just Between Us:** We haven't pleased everyone because someone will
inevitably want to now filter on the combination of an author and a
date. We could do that, but today, in this lesson, we're going to
stand against the slings and arrows of [scope creep](https://en.wikipedia.org/wiki/Scope_creep)!

### Refactoring out of the View

Okay. We did it! We added our filters. But we understand that in MVC we
separate concerns and put code in the right place. Looking at our current
`posts#index` view cluttered with so much *business logic* got us like:

![Nick Miller NO](http://i.giphy.com/D0psmHNJTFdiE.gif)

So it's time to do some refactoring.

We have some pretty big red flags here:
* View directly querying the database for posts *and* authors!
* View reading `params`, which we had to go out of our way to allow from
  the controller!
* View overriding `@posts`, which the controller is already creating,
  fully *doubling* our database requests!

Okay. Let's get to work. First, let's dive back into the `posts#index` view
and kill that filter logic. Just straight up delete everything that comes
before the `<h1>` so that it looks like this:

```erb
<!-- app/views/posts/index.html.erb -->

<h1>Believe It Or Not I'm Blogging On Air</h1>
<div>
  <h3>Filter posts:</h3>
  <%= form_tag("/posts", method: "get") do %>
    <%= select_tag "author", options_from_collection_for_select(@authors, "id", "name"), include_blank: true %>
    <%= select_tag "date", options_for_select(["Today", "Old News"]), include_blank: true %>
    <%= submit_tag "Filter" %>
  <% end %>
</div>
<% @posts.each do |post| %>
  <div>
    <h2><%= post.title %></h2>
    <h3>by: <%= link_to post.author.name, author_path(post.author) %></h3>
    <p><%= post.description %></p>
  </div>
<% end %>
```

Don't forget to also change the `select_tag` options from `Author.all`
to `@authors` because our view shouldn't be directly querying the
database for that, either. A view's concern is *presentation*. The
controller should give it all the data it needs.

Now let's get into our controller and repurpose our filter code so it
will run there.

First, let's get rid of that `helper_method :params` line. We don't need
it anymore. Reading `params` is a controller concern, so we don't need
to expose it to the views.

Now let's dig into our `index` method and make some changes. First, we
need to add this line to satisfy our author select control: `@authors =
Author.all`. We're using the same code, just moving it to where it
belongs.

Then let's put in our filter code so that `index` looks like this:

```ruby
# app/controllers/posts_controller.rb

def index
  # provide a list of authors to the view for the filter control
  @authors = Author.all

  # filter the @posts list based on user input
  if !params[:author].blank?
    @posts = Post.where(author: params[:author])
  elsif !params[:date].blank?
    if params[:date] == "Today"
      @posts = Post.where("created_at >=?", Time.zone.today.beginning_of_day)
    else
      @posts = Post.where("created_at <?", Time.zone.today.beginning_of_day)
    end
  else
    # if no filters are applied, show all posts
    @posts = Post.all
  end
end
```

Great! Now let's reload the `/posts` page and make sure everything still
works.

### Refactoring Database Logic out of the Controller

This is looking much better. Our view is back to only dealing with
presentation logic, and our controller is providing the right data. But
we're still not there yet.

If we think about separation of concerns, is the controller concerned
with having deep knowledge of the database so that it can make queries
directly? No. All a controller wants to do is ask a model for what it
needs in the simplest way possible.

So having something that looks like this...
```ruby
@posts = Post.where("created_at >=?", Time.zone.today.beginning_of_day)
```
...isn't the best application of MVC and separation of concerns. We want
the model to know things like `"created_at >=?", Time.zone.today.beginning_of_day`
and the controller to just ask for something more like `from_today`.

So we need to move this into the model. Now, the question becomes: is
this a *class method* on the `Post` model itself, or is it an *instance
method* on a specific `post`?

Well, since we are going to be asking for multiple `post` instances from
the database, we won't have an instance to begin with, so we'll need to
use a class method.

Class methods are commonly used on ActiveRecord models to encapsulate
this type of custom query functionality, so let's do that now.

First, we want to add one for the author filter. Let's dive into
`post.rb` and get to work.

```ruby
# app/models/post.rb

def self.by_author(author_id)
  where(author: author_id)
end
```

You'll notice that it's essentially the same code that we had in the
controller, but it's now properly encapsulated in the model. This way, a
controller doesn't have to query the database — it just has to ask for
posts `by_author`.


So let's do that. Get back in the `posts_controller`, and change the code
to use our new class method:

```ruby
# app/controllers/posts_controller.rb

if !params[:author].blank?
  @posts = Post.by_author(params[:author])
elsif !params[:date].blank?

  ...
```

**Top-tip:** There are always more ways to accomplish the same thing. You
may be wondering why we didn't just `find` the author and return
`author.posts`. That also would work. But when we think about
constructing an application in a logical way, using principles like
Separation of Concerns to guide us, we can conclude that the
`posts_controller` is concerned with the `Post` model, so almost
everything that controller does will probably flow through that model.

Now that we have that done, we can reload our `/posts` page and make
sure it's all still working.

Next, let's give the same treatment to our date filter. We want to
move the database code from the controller to the model, so let's add
a couple more class methods to the `Post` model:

```ruby
# app/models/posts.rb

...

def self.from_today
  where("created_at >=?", Time.zone.today.beginning_of_day)
end

def self.old_news
  where("created_at <?", Time.zone.today.beginning_of_day)
end
```

And then let's update our controller to use them. Our final
`index` method should now look like this:

```ruby
# app/controllers/posts_controller.rb

def index
  # provide a list of authors to the view for the filter control
  @authors = Author.all

  # filter the @posts list based on user input
  if !params[:author].blank?
    @posts = Post.by_author(params[:author])
  elsif !params[:date].blank?
    if params[:date] == "Today"
      @posts = Post.from_today
    else
      @posts = Post.old_news
    end
  else
    # if no filters are applied, show all posts
    @posts = Post.all
  end
end
```

Let's test it out and see if it works. And for good measure, let's run
`rspec` on the console and make sure our tests pass. All green? Good.

![Nick Miller Approves](http://i.giphy.com/GlIRhM4n17XgY.gif)

## Summary

We've taken a look at a few different ways to create some features, but
the big takeaway is this: by considering the separation of concerns,
sticking to MVC, and using class methods on our models, we were ultimately
able to implement those features in a clean, well-organized way.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/model-class-methods-reading'>Model Class Methods</a> on Learn.co and start learning to code for free.</p>
