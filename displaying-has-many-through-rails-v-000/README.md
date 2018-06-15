
# Displaying Has Many Through Rails

## Objectives

1. Construct a bi-directional has many through.
2. Query for associations via the belongs_to, has_many, and has_many through associations.
3. Iterate over associations in a view and display associated data for a primary instance.
4. Identify the join model in a has many through.

## Overview

We've seen how we can use simple associations to display data to our users in Rails, but what about more complex relationships? Lucky for us, the interface for displaying this type of data is just as easy thanks to Active Record and `has_many, through`.

## Lesson

### has_many, through

Let's say you're making a blog and want to give users the ability to sign up and comment on your posts. What's the relationship between a post and a comment?  If you said, "A comment belongs to a post, and a post has many comments," give yourself a pat on the back!

What about the relationship between a user and a comment? Again, a user has many comments, and a comment belongs to the user. So far, this is pretty straightforward.

Things get slightly more complicated when we talk about the relationship between a user and the posts that the user has commented on. How would you describe that relationship? Well, a user obviously can comment on many posts, and a post has comments from many users. Yep, this is a many to many relationship. We can set up a many-to-many relationship using a join table. In this case, `comments` will act as our join table. Any table that contains two foreign keys can be thought of as a join table.  A row in our `comments` table will look something like this:

<table>
  <tr>
    <td> id </td>
    <td> content </td>
    <td> post_id </td>
    <td> user_id </td>
  </tr>
  
  <tr>
    <td> 1 </td>
    <td> "I loved this post!" </td>
    <td> 5 </td>
    <td> 3 </td>
  </tr>
</table>

For this instance, we know that the `Comment` with an ID of `1` was created by the `User` with an ID of `3` for the `Post` with an ID of `5`. We have all of the information we need to determine all of the posts that a particular user has commented on as well as all of the users who commented on any post. When we're done, we'll be able to simply call `@user.posts` to get a collection of all of those posts.

Let's set this up. First, we'll need migrations for `comments`, `posts`, and `users` tables. We've included migrations and models in this repo, so you can follow along.

```ruby
# db/migrate/xxx_create_posts

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.timestamps null: false
    end
  end
end
```

```ruby
# db/migrate/xxx_create_users

class CreateUsers < ActiveRecord::Migration
   def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.timestamps null: false
    end
  end
end
```

```ruby
# db/migrate/xxx_create_comments

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.belongs_to :user
      t.belongs_to :post
      t.timestamps null: false
    end
  end
end
end
```

In our models, we have the following:

```ruby
# app/models/post.rb

class Post < ActiveRecord::Base
  has_many :comments
  has_many :users, through: :comments
end
```

```ruby
# app/models/user.rb

class User < ActiveRecord::Base
  has_many :comments
  has_many :posts, through: :comments
end
```

```ruby
# app/models/comment.rb

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end
```

Notice that we can't just declare that our `User` `has_many :posts` because our `posts` table doesn't have a foreign key called `user_id`. Instead, we tell Active Record to look through the `comments` table to figure out this association by declaring that our `User` `has_many :posts, through: :comments`. Now, instances of our `User` model respond to a method called `posts`. This will return a collection of posts that share a comment with the user.

### Displaying Comments on Our Posts

Now that our association is set up, let's display some data. First, let's set up our `Post#show` page to display all of the comments on a particular post. We'll include the username of the user who created the comment as well as a link to their show page.

In `app/controllers/posts_controller.rb`, define a `show` action that finds a particular post to make it available for display.

```ruby
# app/controllers/posts_controller.rb

class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end
end
```

In our `Post#show` page, we'll display the title and content information for the post as well as the information for each comment associated with the post.

```erb
# app/views/posts/show.html.erb

<h2><%= @post.title %></h2>
<p>
  Content: <%= @post.content %>
</p>
Comments:
  <% @post.comments.each do |comment| %>
    <%= link_to comment.user.username, user_path(comment.user) %> said
    <%= comment.content %>
  <% end %>
```

This is the same as we've done before –– we're simply looking at data associated with posts and comments. Calling `comment.user` returns for use the `User` object associated with that comment. We can then call any method that our user responds to, such as `username`.

## Adding Posts to Our Users

Let's say that on our `User#show` page we want our users to see a list of all of the posts that they've commented on. What would that look like?

Because we've set up a join model, the interface will look almost identical. We can simply call the `posts` method on our user and iterate through.

```erb
# app/views/users/show.html.erb

<h2><%= @user.username %> </h2> has commented on the following posts:

<% @user.posts.each do |post| %>
  <%= link_to post.title, post_path(post) %>
<% end %>
```

## Conclusion

Displaying data via a `has_many, through` relationship looks identical to displaying data through a normal relationship. That's the beauty of abstraction –– all of the details about how our models are associated with each other get abstracted away, and we can focus simply on the presentation.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/displaying-has-many-through-rails' title='Displaying Has Many Through Rails'>Displaying Has Many Through Rails</a> on Learn.co and start learning to code for free.</p>
