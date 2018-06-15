# Edit/Update Action

## Rails Controller Conventions

Now that you know how to implement a create action, the next logical step will be to integrate an edit/update action. As you may have noticed, there is a trend in Rails conventions where the logic for rendering a form is separate from the action that manages the database record alteration. For example:

* The `new` action in the controller simply renders the `new` form

* The `create` action is what actually handles the process of inserting the form data into the database

In like fashion, the `edit` and `update` actions have a similar convention:

* The `edit` action will handle rendering the `edit` form

* The `update` action will be the method that updates the database record itself


## Rendering the `edit` form

To start off, let's draw a `get` route for our edit form. Since the form will need to know which record is being edited, this will need to be a dynamic route that accepts an `:id` as a parameter that the controller can access:

```ruby
get 'posts/:id/edit', to: 'posts#edit', as: :edit_post
```

We still need to draw one additional route to handle the `update` action. This second route will also need to be dynamic, accepting the same `:id` as a parameter so that the action will know which record is being altered. If you're curious about which HTTP verb should be selected, consider the following: we're sending data to the server, so we know it's not `GET`, and since we're not creating a new record it shouldn't be `POST`. That's right- `PUT` should be the HTTP verb!

```ruby
put 'posts/:id', to: 'posts#update'
```

On a side note, as a shortcut you could also simply add the `edit` and `update` actions to the `resources` call in the routes file. That would accomplish the same goal that these two lines do.

If you run `rake routes`, you will see we have two new routes:

```bash
Verb    URI Pattern                  Controller#Action
GET     /posts/:id/edit(.:format)    posts#edit
PUT     /posts/:id(.:format)         posts#update
```

With our routes in place, let's add in the controller actions...

```ruby
def edit
end

def update
end
```

...and then create the edit view template in `app/views/posts/edit.html.erb`. Let's just copy and paste the `new` form:

```erb
<%= form_tag posts_path do %>
  <label>Post title:</label><br>
  <%= text_field_tag :title %><br>

  <label>Post Description</label><br>
  <%= text_area_tag :description %><br>

  <%= submit_tag "Submit Post" %>
<% end %>
```

If you open the browser and go to the `edit` page, it will now display the form, but you may have noticed a pretty big flaw. It doesn't load the record's data into the form! There are a few things that we'll need to do in order to implement this behavior. First, let's have our `edit` action store the `post` record in an instance variable:

```ruby
def edit
  @post = Post.find(params[:id])
end
```

Now that the `edit` view template will have access to the `Post` object (stored in `@post`), we need to refactor the form so that it auto-fills the form fields with the corresponding data from `@post`. This is done below:

```erb
<% # app/views/posts/edit.html.erb %>

<%= form_tag posts_path do %>
  <label>Post title:</label><br>
  <%= text_field_tag :title, @post.title %><br>

  <label>Post Description</label><br>
  <%= text_area_tag :description, @post.description %><br>

  <%= submit_tag "Submit Post" %>
<% end %>
```

This will now populate the form correctly, but if you try submitting the form you may notice something strange. Instead of updating the appropriate `Post` object, submitting the form creates a whole new post! Oops, we forgot to change the target of the `form_tag` method from `posts_path` to `post_path(@post)`. The former is the equivalent of submitting a new post via the `/posts` action in Sinatra; the latter is the equivalent of updating an existing post via the `/posts/:id` action in Sinatra.

But wait –– there's more! Unless we specify otherwise, a `form_tag` will default to sending an HTTP `POST` request. How can we let the app know that we want to send a `PUT` request instead here? We need to add an argument to the `form_tag` so that it knows not only which route the data should be passed through but also which HTTP verb to use. Make the following change to the `form_tag` line:

```erb
<%= form_tag post_path(@post), method: "put" do %>
```

By explicitly stating the route and method, the form will now be routed to the `update` action. Before we try to implement the `update` action, let's first make sure the data is being routed properly. Enter the following code inside of the `update` method:

```ruby
def update
  raise params.inspect
end
```

The `raise` method will cause the application to pause and print out the `params` on an error page. You could also see the `params` if you called `puts params.inspect`; using `puts` would simply require you to track down the data in the Rails server log.

If you open up the browser, navigate to an edit page (such as `localhost:3000/post/6/edit`), change some elements in the form, and submit it, it should take you to an error page that prints out the params from the form, such as in the below image:

![Raised Exception for Update Action](https://s3.amazonaws.com/flatiron-bucket/readme-lessons/update_raised_exception.png)

As you can see, the parameters are being passed to the `update` action. With that in mind, let's implement the functionality needed inside of the `update` action so that it will take the form data and update the specified record. Let's sketch out a basic flow for what the `update` action should do:

* Query the database for the `Post` record that matches the `:id` passed to the route.

* Store the query in an instance variable.

* Update the values passed from the form (the update method here is the `update` method supplied by Active Record, not the `update` method we're creating). **The update method takes a hash of the attributes for the model as its argument, e.g. `Post.find(1).update(title: "I'm Changed", description: "And here too!")**

* Save the changes in the database.

* Redirect the user to the `show` page so they can see the updated record.


We'll take advantage of Active Record's `update` method so that we're not manually assigning each attribute:

```ruby
def update
  @post = Post.find(params[:id])
  @post.update(title: params[:title], description: params[:description])
  redirect_to post_path(@post)
end
```

Now if you go to the `edit` page and make changes to the `title` or `description` form elements, you will see they are changed when the form is submitted. The `edit` and `update` functions are working properly!


## Extra Credit

* When only one form element is updated, such as the `title`, does the `description` also get updated?

* How could we refactor this form code? You may notice that we have a form for the `new` and `edit` actions. Is there a better way of doing this?

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-edit-update-action-readme' title='Edit/Update Action'>Edit/Update Action</a> on Learn.co and start learning to code for free.</p>
