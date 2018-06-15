# Create Action

Let's take a deeper look at how the Rails forms we've been creating actually function. In this lesson, we'll code a `create` action — '**C**' in the '**CRUD**' life cycle — that saves a new `Post` object and then redirects to the newly-created post's `show` page. Before implementing this functionality, let's first open up a Rails console session and create a record manually:

```ruby
post = Post.new
post.title = "Title Goes Here"
post.description = "Desc goes here..."
post.save
```

This syntax will let you manually create a new `Post` record with `title` and `description` attributes. After running the `save` method in the console, you will see output similar to the following:

```shell
 (0.1ms)  begin transaction
SQL (0.3ms)  INSERT INTO "posts" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "Title Goes Here"], ["description", "Desc goes here..."], ["created_at", "2015-11-23 22:26:43.799742"], ["updated_at", "2015-11-23 22:26:43.799742"]]
 (1.2ms)  commit transaction
=> true
```

As you can see, the `save` method generates a SQL script that inserts a new record into the database. Each of the `Post` object's attributes is passed into the SQL statement, and the method returns `true` upon a successful save. At a high level, this is what the `create` method in our `PostsController` will be doing.

Open up the `posts_controller.rb` file. Let's do a few things to replicate the behavior we had in the console:

1. Create a new `Post` instance

2. Pass in the parameters from the form

3. Save the record

To build this behavior initially, let's copy and paste the code that we ran in the console. The only key difference is that now we want to pull in the form data and have that populate the `title` and `description` attributes. You can access each of the form elements by using the hash syntax to grab the elements from the `params` hash that is submitted with the form. The new code in the `create` method should look something like this:

```ruby
def create
  post = Post.new
  post.title = params[:title]
  post.description = params[:description]
  post.save
end
```

If you go to `/posts/new`, fill out the form, and submit it, you'll get the error shown below. That's OK! Rails is simply complaining that it can't find a `create` view template since, by default, it's trying to render a template called `create.html.erb` (which doesn't exist). Remember, Rails tries to map each controller action directly to a template. However, with actions like `create`, we don't want a view template –– all we want is for the action to communicate with the database and then redirect to a different page.

![Missing Create Template Error](https://s3.amazonaws.com/flatiron-bucket/readme-lessons/template_error_create.png)

If you open up the console, you'll see that the record was successfully created in the database even though we ran into an error page. Our form and `create` action are working properly. How do we know the record was successfully created? There are a couple of ways to check:

1. Type `Post.last` into the Rails console, and it will display the most recently created record. We can look at the record's `created_at` attribute to ensure the timestamp is current.
2. We can also simply scroll up through the Rails server logs. All SQL statements are printed out in the log, so it's just a matter of locating the correct `INSERT` statement (example below):

```shell
 (0.1ms)  begin transaction
SQL (0.7ms)  INSERT INTO "posts" ("title", "description", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "My Post"], ["description", "My desc"], ["created_at", "2015-12-26 18:00:31.393419"], ["updated_at", "2015-12-26 18:00:31.393419"]]
 (2.2ms)  commit transaction
```

To fix the 'missing template' error, we simply need to redirect the user after they've filled out the form. Let's do two refactors:

* Update the code with a redirect that leverages a route helper method

* Refactor the `post` variable into an instance variable

The revised `create` method should look something like this:

```ruby
def create
  @post = Post.new
  @post.title = params[:title]
  @post.description = params[:description]
  @post.save
  redirect_to post_path(@post)
end
```

In this refactored `create` action, we're following the convention of redirecting to the new resource's `show` page. It stands to reason that a user who submits a new post would then like to view the successfully-created post. With that being said, the page flow is not set in stone, and we could've redirected the `create` action to the `index` action just as easily.

All our tests should be passing now, and the site is working in the browser. Users are able to create records in the database using the HTML form, and, upon submitting a new post, they're automatically redirected to the `show` page for the post they just created. In future lessons, we'll refactor this further to incorporate awesome Rails components like `strong parameters` and `error handling`, but don't worry about those yet. Great job!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-create-action-readme'>Create Action</a> on Learn.co and start learning to code for free.</p>
