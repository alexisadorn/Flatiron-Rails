# Has Many Through Forms Rails Labs

## Overview

We've looked at setting up the associations behind posts with comments, categories, and users. Now, let's actually give our users the ability to create new comments, users, and categories! For this lab, your models are already stubbed out, but you may need to update them to make your forms work properly.


## Objectives

1. Construct a bi-directional has many through.
2. Identify the join model in a has many through.
3. Construct a nested params hash with data about the primary object and a has many through association.
4. Use the conventional key names for associated data (association_attributes).
5. Name form inputs correctly to create a nested params hash with has many through association data.
6. Define a conventional association writer for the primary model to properly instantiate associations based on the nested params association data.
7. Define a custom association writer for the primary model to properly instantiate associations with custom logic (like unique by name) on the nested params association data.
8. Use fields_for to generate the association fields.

## Instructions

1. Create a form at `posts#new` to create a new post. The form should include check boxes for us to select categories as well as a text field to create a new category. You should do this with a nested form so that our controller stays thin. Also, typing in a `Category` name that already exists should not create a new category. Instead, if we type in a category that already exists, we should select it from the database and associate the post we've created with the existing category.

2. Create a `posts#show` page to display the following:
  1. The title and content of the post.
  2. All of the comments associated with the post.
  3. A list of all the unique users who have commented on the post. A user's name should only show up once in this section, even if they've commented multiple times.
  4. A form to add a new comment. The form should have a drop-down menu to select a user (we'll change this in future lessons to automatically associate the comment with a logged-in user). We should also be able to create a new user here and automatically associate it with the post.

3. Create a `users#show` page that links to all of the posts a user has commented on.

4. Create a `categories#show` page that links to all of the posts associated with a given category.

## Hints

+ When creating new comments, we should only create a new user if they filled in that input. `accepts_nested_attributes_for` has a `reject_if` option that you can configure to only create new records if all the fields aren't blank.
+ Also, the select box that we use for the users needs to have a blank option –– check out the `include_blank` option for `collection_select`.

## Resources

+ [Accepts Nested Attributes For](http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html)
+ [Collection Select](http://apidock.com/rails/ActionView/Helpers/FormOptionsHelper/collection_select)
+ [Lab Review](https://www.youtube.com/watch?v=k7s2LjVF3YY)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/has-many-through-forms-rails-labs' title='Has Many Through Forms Rails Labs'>Has Many Through Forms Rails Labs</a> on Learn.co and start learning to code for free.</p>
