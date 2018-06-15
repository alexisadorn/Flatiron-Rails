# Refactoring Views With Helpers Lab

## Objectives

1. Review creating associated objects
2. Write a helper to conditionally display different links
3. Use the helper in multiple views

## Song Library

In this lab, we're going to augment our song library to show the artists associated with songs, and we'll use helpers to display different links based on whether or not a song is associated with an artist.

When we add songs to our library, we want to be sure to include the artist so that we can keep things organized. Sometimes, however, we might be in a hurry and not know the artist off the top of our head, so we leave it blank.

When we display the song library, we want to include the artist, but if there's no artist associated we want to prompt the user to add one (mostly because we don't want to contribute to the global iTunes library "Unknown Artist" epidemic).

## Instructions

The base models, controllers, views and other files have been provided. There are tests for the lab in the `spec` directory. You can run tests with the `rspec` command.

1. Write the code to get (`artist_name`) and set (`artist_name=`) the `Artist` associated with a given `Song` model.
2. Write a helper method to display the artist for a song, with the following considerations:
  - Put the method in the appropriate helper file following the principle of Separation of Concerns
  - Name the method `display_artist`
  - If the artist name is not `nil`, return a link to the artist's `show` page
  - If the artist name is `nil`, return a link to the song's `edit` page, with a link text of "Add Artist"
3. Use the helper to display the artist on the `songs#show` and `songs#index` pages.
4. Make sure all tests pass. Then, do this:

![Dancing Daft Punk](http://i.giphy.com/ZCKh7knqLpc4M.gif)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/refactoring-views-with-helpers-lab' title='Refactoring Views With Helpers Lab'>Refactoring Views With Helpers Lab</a> on Learn.co and start learning to code for free.</p>
