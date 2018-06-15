# Nested Resource Routing Lab

## Objectives

1. Write nested routes
2. Filter data sets based on nesting
3. Handle errors in nested routes

## Overview

In this lab, we're going to extend our song library using nested
resources to build new routes for our artists and songs. Then, we'll use
the URL helpers in our views to expose these new routes.

We'll also be handling errors when nested resources aren't found so
that we can provide a more professional experience to our users.

## Instructions

The base models, controllers, views, and other files have been provided. There are tests for the lab in the `spec` directory. You can run tests with the `rspec` command.

Remember to `rake db:seed` to set up a starter song library!

1. Create nested resource routes to show all songs for an artist (`/artists/1/songs`) and individual songs for that artist (`/artists/1/songs/1`). Restrict the nested songs routes to `index` and `show` actions only.
2. Update the artists `index` view to use the new nested resource route URL helper to link to the index of all songs by that artist.
3. Update the artists `show` view to list each song for that artist, and use the new nested resource route helper to link each song to its corresponding `show` page.
4. Update the `songs_controller` to allow the `songs#index` and `songs#show` actions to handle a valid song for the artist.
5. In the `songs#index` action, if the artist can't be found, redirect to the `index` of artists, and set a `flash[:alert]` of "Artist not found."
6. In the `songs#show` action, if the song can't be found for a given artist, redirect to the `index` of the artist's songs and set a
`flash[:alert]` of "Song not found."
7. Make sure all tests pass; then, party down!

![Party Down](http://i.giphy.com/l41lNRz0uXPQLm0RG.gif)

**Hints**

1. For a refresher on the use of `flash`, see the [ActionController RailsGuide](http://guides.rubyonrails.org/action_controller_overview.html#the-flash).
2. Remember when filtering nested resources to query for the children through the parent, e.g., `@artist.songs.find_by(id: ...)`
3. There's more than one way to ride the Rails. You could handle not being able to find a record by using `rescue ActiveRecord::RecordNotFound`, or you could try using `find_by(id: id)` instead of `find()` and checking to see whether the result is `nil`.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/routing-nested-resources-lab' title='Nested Resource Routing Lab'>Nested Resource Routing Lab</a> on Learn.co and start learning to code for free.</p>
