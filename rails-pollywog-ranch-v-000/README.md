# Rails Pollywog Ranch Lab

![tadpoles and frogs](https://raw.githubusercontent.com/learn-co-curriculum/rails-pollywog-ranch/master/app/assets/images/intro-image.jpeg)

## Goal

Help Frog Rancher Darryl categorize and track all the ponds, frogs, and tadpoles on his ranch. To do this you will create migrations and models complete with ActiveRecord associations.

## Background

After speaking with Darryl, he has informed us that he has several ponds on his ranch. Each pond has different frogs that live there. Some of those frogs have tadpole babies. The frogs all have the ability to have tadpoles at any given time, and the tadpoles have the ability to metamorphose into frogs at any time.

## Example

Here's a [demo](http://the-pollywog-ranch.herokuapp.com) of what we're aiming for.

## Instructions

#### Getting Started
* Run `bundle install` then `rspec` to see what course to take. Keep in mind that, for the association of `tadpoles` belonging to a `pond` through a `frog`, you'll have to [delegate](http://stackoverflow.com/a/11457714).
* Take a look at the tests in `spec/models` before writing your migrations.
* Once your migrations are done, start on the associations in your models.
* Once the associations are passing, you'll be modifying three files:

  1. `app/controllers/tadpoles_controller.rb`
    * You'll add an action, `#metamorphose`, to this controller
  2. `config/routes.rb`
    * Here you'll allow a form to post to `/tadpoles/:id/metamorphose`
    * This should route the request to the `TadpolesController`'s `#metamorphose` action
  3. `views/tadpoles/show.html.erb`
    * You'll add a form that will post to `/tadpoles/:id/metamorphose` with a submit button that reads "Become a frog"

* If you get stuck refer to the [Rails Active Record documentation](http://guides.rubyonrails.org/active_record_basics.html).
* You can refer to [this link](http://www.tutorialspoint.com/ruby-on-rails/rails-directory-structure.htm) as a quick reference for the Rails 4 folder structure.

#### Running the App Locally
* When you're finished and all the specs are passing, go ahead and run the following commands from your terminal:
  * rake db:migrate
  * rake db:seed
  * rails s
* Then hit up the app [here](http://localhost:3000/).

#### Critical Thinking

* Think about how you would get a tadpole to metamorphose. Click on any tadpole, and make it metamorphose. Did the app go about metamorphosing tadpoles in the same way you would have?
* Think about how you would get a frog to have tadpole babies. Click on any frog, and make it have a baby. Did the app go about making baby tadpoles in the same way you would have? For more details about metamorphosing into a frog, see `config/routes.rb` and `views/frogs/show.html.erb`. You can learn more about nested resources below.

## Resources
* [Stack Overflow — Delegation](http://stackoverflow.com/a/11457714)
* [Pivotal Labs — Delegation](https://content.pivotal.io/blog/rails-delegates-are-even-more-useful-than-i-knew)
* [Tutorials Point: Ruby on Rails](http://www.tutorialspoint.com/ruby-on-rails/) — [Ruby on Rails Directory Structure](http://www.tutorialspoint.com/ruby-on-rails/rails-directory-structure.htm)
* [Rails Guides on Routing](http://guides.rubyonrails.org/routing.html) — [Nested Resources](http://guides.rubyonrails.org/routing.html#nested-resources)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-pollywog-ranch' title='Rails Pollywog Ranch Lab'>Rails Pollywog Ranch Lab</a> on Learn.co and start learning to code for free.</p>
