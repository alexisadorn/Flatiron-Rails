# Cookies and Sessions Lab

## Objective

We're going to make a very simple shopping cart, stored entirely in the session.

## Introduction

The Rails `session` method gives us access to the Rails session. The session is a datastore implemented with cookies. You can store simple data structures in the session. ActiveRecord models, no. Arrays of strings or numbers, yes. Basically, stick to data literals—numbers, strings, hashes, and arrays.

We're going to use this to implement a shopping site. Here's how the site will work:

  1. The root page of the app has an input box on it (within a form of course).
  2. The user types in the item they want and clicks `add to cart`.
  3. The item is added to their cart. The page shows everything in the user's cart.

## Instructions

1. Create the cart method in `ApplicationController#cart`, this method should return an array of the items stored in the cart (utilizing the Rails `session` method).
2. Create a Products controller with two actions, index and add.
3. Create the routes for the application, we only need two routes, one to display the `Products#index` (the root route) and one to post the products to add them to the cart.
4. Create views using the feature tests as your guide. The page should have, at a minimum: a text box where the user can enter the name of a product, a submit button that adds it to their cart, and a display of what's in the cart.

For this lab, there is no need to create tables and models and store the products in the database. We'll be using cookies via the Rails `session` method, along with our `cart` helper method to persist the products to the cart and to display them in the view.

<p class='util--hide'>View <a href='https://learn.co/lessons/cookies_and_sessions_lab'>Cookies And Sessions Lab</a> on Learn.co and start learning to code for free.</p>
