# Programmer Partials Lab

## Objectives
1. Practice using partials.
2. Use all the different techniques you've learned in this unit.
3. DRY up your views with locals.

## Overview

We have a Rails app that showcases some of our favorite programmers. The landing page is an index of all of the programmers, and users can click on each programmer to see his or her profile page. There's just one problem: the views are loaded with repetition and clunky iteration and could use some serious refactoring. Your job is to clean up `programmers/index.html.erb` and `programmers/show.html.erb` by using partials.

## Instructions

Fork and clone the lab. Run `bundle install` and `rake db:migrate`, then `rake db:migrate RAILS_ENV=test`. Next, seed the database with some programmers - run `rake db:seed` - and start the server to see the app in the browser.

Run `rspec` and make the tests pass one at a time! The app will continue to have the same functionality (keep checking it in the browser), but you'll be making the following partials to clean up the views:

1. A partial to render the navbar.
2. A partial to render all of the programmers on the index page.

## Bonus

This part is a little more complex than the previous two steps and will require you to get a little more creative.

When you look at `app/views/programmers/show.html.erb`, you will probably notice a pattern in how several of the attributes are rendered (specifically `home_country`, `quote`, and `claim_to_fame`). They each seem to be in a `<p>` tag with a bolded, capitalized label followed by the value for the given attribute. You'll want to render each of these with a single partial, `app/views/programmers/_attribute.html.erb`, into which you'll pass local variables. For some hints to set you on the right track, check out the resources below.

## Resources
- [Rails Guides — Using Partials](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials)
- [Action View Partials](http://api.rubyonrails.org/classes/ActionView/PartialRenderer.html)
- [Metaprogramming in Ruby](http://ruby-metaprogramming.rubylearning.com/html/ruby_metaprogramming_2.html) (see section 1.3.2 to learn about `send`)
- [Stack Overflow — Passing Variables to a Partial](http://stackoverflow.com/questions/16242121/rails-4-passing-variable-to-partial) (see the first answer for a concise example)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-programmer-profile-partials' title='Programmer Partials Lab'>Programmer Partials Lab</a> on Learn.co and start learning to code for free.</p>