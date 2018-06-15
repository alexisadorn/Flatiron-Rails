# Modifying Nested Resources Lab

## Objectives

1. Implement nested resources for creation and modification

## Overview

In this lab, we're going to be implementing nested resources for
creating and editing songs through an artist.

## Instructions

1. Using nested resources, set up routes and controller actions to
   create new `song` records through an `artist`. **Hint:** Don't forget
to update the strong parameters.
2. Set up routes and controller actions to support editing a `song` as a
   nested resource of an `artist`.
3. Create a helper to display a drop-down list of artists if someone
   edits a song directly via `/songs/id/edit` and to only display the
artist's name if they are editing through nested routing. Name the
helper method `artist_select`. **Hint:** You'll need to set a variable
in the controller action to pass to the helper method as an argument
along with a `song` instance.
4. Validate that new songs created for an artist via nested routing are
   created for valid artists, and redirect to `/artists` if not.
5. Validate that songs being edited via nested routing have a valid artist. Redirect to `/artists` if not.
6. Validate that songs being edited via nested routing are in the
   artist's `songs` collection. Redirect to `/artists/id/songs` if not.
7. Make sure all tests pass!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/diy-nested-resources-lab' title='Modifying Nested Resources Lab'>Modifying Nested Resources Lab</a> on Learn.co and start learning to code for free.</p>
