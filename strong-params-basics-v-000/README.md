# Strong Params Basics

## What are Strong Params?

To understand the goal of strong params, let's pretend that you run a pharmacy. What would happen if you let all prescription orders come through without checking for: valid prescriptions, driver licenses, etc.? (Spoiler alert: you'd probably end up in jail). It would be criminal to run a pharmacy without verifying that orders were legitimate. In the same way Rails application (starting in Rails 4+) wanted to shore up some security vulnerabilities and now require that you whitelist the parameters that are permitted when you're sending form data to the database.


## Setup

To prevent confusion, in previous lessons I manually turned off the strong parameter requirement. Let's discover first why strong params were created and then work with them.

## Why Strong Params

In the Rails app in this lesson there is our blog application with Strong Params *disabled*. Create a new Post by going to `/posts/new`. Once you have created that post, go ahead and edit it at `/posts/1/edit`. You'll notice there is no Description field! In this case, I don't want the user to be able to modify the description of a post once it's been created. This happens in all kinds of different cases. You wouldn't want a bank user to be able to edit their account number or balance, would you? But! `balance` is still a field on the account class. In this case, `description` is still an attribute for the post class. Let's see if a user could "hack" our form to be able to modify the `description`.

1. Right click and inspect the page
2. Find the input for title. it should look like this: `<input type="text" value="asdferwer" name="post[title]" id="post_title">`
3. Right click on choose "Edit as HTML"
4. Add in the following new Description field:

```
<br>
<label>Description:</label>
<br>
<input type="text" value="malicious description" name="post[description]" id="post_description">
```

5. Click somewhere else and look! a wild description field appears.
6. Now type in some message into the new field.
7. Click submit and you'll notice that the description has been updated. What a nefarious hack!

That is the problem that strong params was created to fix. We want to make sure that when users submit a form we only let the field we want get by.

## Code Implementation


Let's enable Strong Params. To do this, open up `config/application.rb` and delete the line that says: `config.action_controller.permit_all_parameters = true`. Now restart your rails server and navigate to `localhost:3000/posts/new`, once there fill out the form and click `submit`. You'll see we get the following `ForbiddenAttributesError`:

![ForbiddenAttributesError](https://s3.amazonaws.com/flatiron-bucket/readme-lessons/ForbiddenAttributesError.png)

What this means is that Rails needs to be told what parameters are allowed to be submitted through the form to the database. The default is to let *nothing* through.

The same error would occur if you were trying to update a record. So how do we fix this? Let's update the `create` and `update` methods to look like the code below:

```ruby
# app/controllers/posts_controller.rb

def create
  @post = Post.new(params.require(:post).permit(:title, :description))
  @post.save
  redirect_to post_path(@post)
end

def update
  @post = Post.find(params[:id])
  @post.update(params.require(:post).permit(:title))
  redirect_to post_path(@post)
end
```

If you go back to the web browser and click refresh you'll see everything is working for both the `create` and `update` actions. Running the Rspec tests reveals that our specs are now passing again as well. You'll notice that our `update` only has a `:title` in the `permit` method. This is because, given our forms, we only want the `title` to be submitable! If you go and do your nefarious hack again, it won't work. Thwarted!!

### Permit vs. Require

What is the deal with the `#permit` vs `#require`? The `#require` method is the most restrictive. It means that the `params` that gets passed in **must** contain a key called "post". If it's not included then it fails and the user gets an error. The `#permit` method is a bit looser. It means that the `params` hash **may** have whatever keys are in it. So in the `create` case, it may have the `:title` and `:description` keys. If it doesn't have one of those keys it's no problem, the hash just won't accept any other keys.


## DRYing up Strong Params

The code we wrote above is great if you only have a `create` method in your controller. However, if you have a standard CRUD setup you will also need to implement the same code in your `update` action. In our example we had different code for `create` and `update`, but generally you have the same items. It's a standard Rails practice to remove code repetition, so let's abstract the strong parameter call into its own method in the controller:

Now, both our `create` and `update` methods in the `posts` controller can simply call `post_params`.

```ruby
# app/controllers/posts_controller.rb

def create
  @post = Post.new(post_params)
  @post.save
  redirect_to post_path(@post)
end

def update
  @post = Post.find(params[:id])
  @post.update(post_params)
  redirect_to post_path(@post)
end

private

def post_params
  params.require(:post).permit(:title, :description)
end
```

This is a very helpful method since if you duplicated the strong parameter call in both the `create` and `update` methods you would need to change both method arguments every time you change the database schema for the `posts` table... and that sounds like a bad way to live. However by creating this `post_params` method we can simply make one change and both methods will automatically be able to have the proper attributes whitelisted.

Hm, but didn't we say above that we only wanted to permit updates to `:title` in
the `update` action? We can make sure that we meet that requirement with a
slightly fancy splat:

```ruby
# app/controllers/posts_controller.rb

def create
  @post = Post.new(post_params(:title, :description))
  @post.save
  redirect_to post_path(@post)
end

def update
  @post = Post.find(params[:id])
  @post.update(post_params(:title))
  redirect_to post_path(@post)
end

private


# We pass the permitted fields in as *args;
# this keeps `post_params` pretty dry while
# still allowing slightly different behavior
# depending on the controller action
def post_params(*args)
  params.require(:post).permit(*args)
end
```

Test this out in the browser and you can see that you can now create and updated posts without any errors. And you will also notice that all of the Rspec tests are still passing.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/strong-params-basics'>Strong Params Basics</a> on Learn.co and start learning to code for free.</p>
