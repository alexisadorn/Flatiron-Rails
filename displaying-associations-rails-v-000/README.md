# Displaying Associations Rails

## Objectives

After this lesson, you should be able to...

1. Create a `has_many` and `belongs_to` association.
2. Build associated data through the console and `db/seeds.rb`.
3. Query for associated data using methods provided by association.
4. Embed association data within views.
5. Iterate over associated data within a view displaying individual instances.

# Blog Categories

In this lesson, we'll be setting up a blog admin panel so that `Post` objects can be created, associated with `Category` objects, and listed by `Category`.

# The Models

First, we'll set up associated models, just like in the preceding lesson:

```ruby
# app/models/post.rb

class Post < ActiveRecord::Base
  belongs_to :category
end
```

```ruby
# app/models/category.rb

class Category < ActiveRecord::Base
  has_many :posts
end
```

# Seed Data

Once you start working with more and more complicated data sets, you will realize that there is a lot of *stuff* you have to set up just to be able to play with your methods. The associations are so vast that you need to make many posts with many categories and all of that! How frustrating. What you are doing is called "seeding" the database. Pretty much putting in some test data so that you can play with your app. In Rails we set up our seed data in `db/seeds.rb`. Then we'll be able to just seed (or re-seed) the database with a quick `rake db:seed`.

```ruby
# db/seeds.rb

clickbait = Category.create!(name: "Motivation")
clickbait.posts.create!(title: "10 Ways You Are Already Awesome")
clickbait.posts.create!(title: "This Yoga Stretch Cures Procrastination, Maybe")
clickbait.posts.create!(title: "The Power of Positive Thinking and 100 Gallons of Coffee")

movies = Category.create!(name: "Movies")
movies.posts.create!(title: "Top 20 Summer Blockbusters Featuring a Cute Dog")
```

Woot! The best thing about the `seeds.rb` file is that it's just Ruby! There is no magic. Look, super standard Ruby. To run the seed file in the development environment, you can activate the rake task:

```bash
rake db:seed
```

If you want to play around with the data, of course, it's always possible to take the create statements exactly as written above and type them into `rails console`.

# The Views

## Posts

When viewing a single post, we'll want to have a link to its category available.

```erb
<!-- app/views/posts/show.html.erb -->

<h1><%= @post.title %></h1>

<h3>Category: <%= link_to @post.category.name, category_path(@post.category) if @post.category %></h3>

<p><%= @post.description %></p>
```

`@post.category` is the `Category` model itself, so we can use it anywhere we would use `@category` in a view for that object. Also note that we added the `if @post.category` conditional to ensure that the view doesn't try to call `@post.category.name` if the post has not been associated with a category.

## Categories

In this domain, the primary use of a category is as a bucket for posts, so we'll definitely have to make heavy use of associations when designing the view.

```erb
<!-- app/views/categories/show.html.erb -->

<h1><%= @category.name %></h1>

<h3><%= pluralize(@category.posts.count, 'Post') %></h3>
<ul>
  <% @category.posts.each do |p| %>
    <li><%= link_to p.title, post_path(p) %></li>
  <% end %>
</ul>
```

The object returned by an association method (`posts` in this case) is a [CollectionProxy][collection_proxy], and it responds to most of the methods you can use on an array. Think of it like an array.

If we open up `rails console`, we can confirm that the `count` results are accurate:

```shell
Post.count
 => 4
clickbait = Category.find_by(name: "Motivation")
 => #<Category id: 1, ...>
clickbait.posts.count
 => 3
```

Meanwhile, for listing a category's posts, we wrote a loop very similar to the loops we've been writing in `index` actions, which makes sense since a category is essentially an index of its posts. Let's compare them side-by-side:

```erb
<!-- app/views/categories/show.html.erb -->

...

<% @category.posts.each do |p| %>
  <li><%= link_to p.title, post_path(p) %></li>
<% end %>

...
```

Versus:

```erb
<!-- app/views/posts/index.html.erb -->

...

<% @posts.each do |p| %>
  <li><%= link_to p.title, post_path(p) %></li>
<% end %>

...
```

In fact, the only difference is what we call `each` on.


# Recap

With Active Record's powerful association macros and instance methods, we can treat related models exactly the same as we treat directly-accessed models. As long as the database and classes are set up correctly, Active Record will figure the rest out for us!

[collection_proxy]: http://edgeapi.rubyonrails.org/classes/ActiveRecord/Associations/CollectionProxy.html

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/displaying-associations-rails'>Displaying Associations Data</a> on Learn.co and start learning to code for free.</p>
