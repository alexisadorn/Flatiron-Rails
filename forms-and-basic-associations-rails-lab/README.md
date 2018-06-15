# Forms And Basic Associations Rails Lab

## Objectives

1. Populate select options based on association options.
2. Assign a foreign key based on a select box value directly through mass assignment (`post[category_id]`).
3. Define a `belongs_to` association writer.
4. Build a form field that will delegate to a belongs\_to association writer (`post#category_name=`) through controller mass assignment.
5. Define a `has_many` association writer.
6. Build a form field that will delegate to a has\_many association writer (`owner#pet_names=`) through controller mass assignment.

## A song library

In this lab, we're going to make a song library. Our data model looks like this:

* `Artist`
  * has a `name` (string)
  * has many `songs`
* `Song`
  * has a `title` (string)
  * belongs to an `Artist`
  * belongs to a `Genre`
* `Genre`
  * has a `name` (string)
  * has many `songs`
* `Note`
  * has `content` (string)
  * belongs to a `Song`

## Instructions

The base models, controllers, and seed data have been provided for you. The associations have not been wired up.

* Write `app/views/songs/new.html.erb`. This form should have:
  * A text input box that sets the song's title.
  * A text input box for the artist.
  * A selection box for genre. Users should be able to pick amongst existing genres only.
  * Several text input boxes to add notes to the song. These should have the IDs `song_notes_1`, `song_notes_2`, and so on for the specs to pass. (You might need to search around for how to pass an array using `strong_params`!)

There are feature tests!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/forms-and-basic-associations-rails-lab' title='Forms And Basic Associations Rails Lab'>Forms And Basic Associations Rails Lab</a> on Learn.co and start learning to code for free.</p>
