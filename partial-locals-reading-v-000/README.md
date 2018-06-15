# Partials with Locals 

## Objectives
1. Use the locals keyword
2. Understand why using instance variables in partials is bad
3. Use a partial while rendering a collection
4. Use a partial from another controller with a local

## Introduction

Partials help us break our code up into reusable chunks.  They also often have implicit dependencies that can lead to bugs.  To make the implicit explicit, use locals whenever your partials depend on data to work.
In the following example, we'll unpack exactly what locals are and how they're used.

## Lesson

Take a look at the included repo.  You should notice the same piece of view code in a few places.

```erb
<ul>
  <li> <%= @author.name %></li>
  <li> <%= @author.hometown %></li>
</ul>
```
You'll find that code (or very similar code) in the following pages: `app/views/authors/show.html.erb`, `app/views/authors/index.html.erb`, `app/views/posts/show.html.erb`.

Looks like we've got some work to do.  Let's start with the author show page.  
Let's remove the code from our `app/views/authors/show.html.erb` page.  Now our file should be empty:
`app/views/authors/show.html.erb`
```

```
We can move the removed code into a partial, `app/views/authors/_author.html.erb`, that now has the following code.
`app/views/authors/_author.html.erb`
```erb
<ul>
  <li> <%= @author.name %></li>
  <li> <%= @author.hometown %></li>
</ul>
```

To keep our code in the show page rendering out the same content, we call the partial from the `app/views/authors/show.html.erb` file.  Doing this, the `app/views/authors/show.html.erb` file now looks like the following:
```erb
<%= render 'author' %>
```
Great! Now let's take a look at the `app/views/posts/show.html.erb` file.  It currently looks like the following:

`app/views/posts/show.html.erb`
```erb
Information About the Post
<ul>
  <li> <%= @author.name %></li>
  <li> <%= @author.hometown %></li>
</ul>
<%= @post.title %>
<%= @post.content %>
```

You can see that the first two lines are exactly the same as the code in our authors/author partial.  Let's remove the repetition in our codebase by using that partial instead.  By using the partial, our code will look like the following:

`app/views/posts/show.html.erb`
```erb
Information About the Post
<%= render 'authors/author' %>
<%= @post.title %>
<%= @post.content %>
```

Note that, because we are calling a partial from outside the current `app/views/posts` folder, we must specify the folder that our author partial is coming from by calling `render 'authors/author'`.

This code may look OK at first, but it poses some problems.  When we render the partial authors/author, we are not being explicit about that partial's dependencies.
A dependency is data that the code requires in order to work (like passing a variable into a method).  In this case, the dependency of the author partial is the instance variable @author.  Without that instance variable, the code won't work.  Unfortunately, that dependency is defined far away in the controller.
This is not so hot.  Imagine that our team's designer tells us we no longer want to display author information with each post –– we only want the post itself.
We can just delete the line `<%= render 'authors/author' %>`, right? Unfortunately, we forgot to remove the @author instance variable in the controller as well because the dependency was not explicit.  This mistake likely would have been avoided if, whenever we called the partial, we also specified the data that the code relied on by passing through local variables.

Let's see how local variables make our code more explicit.
This is what the entire show view looks like:
`app/views/posts/show.html.erb`
```erb
Information About the Post
<%= render partial: "authors/author", locals: {post_author: @author} %>
<%= @post.title %>
<%= @post.content %>
```

When rendering the authors/author partial without passing through local variables, the second line of code looked like this: `<%= render 'authors/author' %>`.  Now, with passing through locals: `<%= render partial: "authors/author", locals: {post_author: @author} %>`.

Notice a few things.  First, we are no longer passing the render method a string; we're passing a hash with two key-value pairs.

The first key-value pair tells Rails the name of the partial to render.  The second key-value pair contains a key of `locals` pointing to a hash of variables to pass into the partial.  Within that nested hash, the key is the name of the variable and its value is the value you'd like it to have in the partial.  For the values of your locals, you can use instance variables set in the controller.

When we use locals, we need to make sure that the variables we refer to in our partial have the same names as the keys in our locals hash.

In our example partial, `app/views/author/_author.html.erb`, we need to change our code from:
```erb
<ul>
  <li> <%= @author.name %></li>
  <li> <%= @author.hometown %></li>
</ul>
```

to
`app/views/author/_author.html.erb`
```erb
<ul>
  <li> <%= post_author.name %></li>
  <li> <%= post_author.hometown %></li>
</ul>
```

In other words, the way we use locals with a partial is similar to how we pass arguments into a method.  In the locals hash, the `post_author:` key is the argument name, and the value of that argument, `@author`, is the corresponding value stored as `post_author` and passed into the method.  We can name the keys whatever we want (and would probably name this one `author` in a real application), but here the intent was demonstrating that name of the key has no special powers.

Now notice that, if we choose to delete the line `<%= render {partial: "authors/author", locals: {post_author: @author}} %>` from the posts/show view, calling the partial requires us to pass in data about the author. The `@author = @post.author` line in our `PostsController` may no longer be needed.

In fact, with locals, we can completely eliminate the `@author = @post.author` line in the `posts#show` controller action, instead only accessing that data where we need it, in the partial.

Let's remove that line of code in our controller and in the view pass through the author information by changing our code to the following:

`app/controllers/posts_controller`
```ruby
  ...
  def show
    @post = Post.find(params[:id])
  end

```

`app/views/posts/show.html.erb`
```erb
Information About the Post
<%= render partial: "authors/author", locals: {post_author: @post.author} %>
<%= @post.title %>
<%= @post.content %>
```

This code is much better.  We are being more explicit about our dependencies, reducing lines of code in our codebase, and reducing the scope of the author variable.
Don't worry if you find the syntax for rendering a partial hard to remember –– it is.  You can always reference this guide or the Rails Guides.

## Resources
* [RailsGuide: Partials](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/partial-locals-reading' title='Partials with Locals'>Partials with Locals</a> on Learn.co and start learning to code for free.</p>
