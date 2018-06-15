# Omniauth Lab

## Objectives

1. Use Omniauth to provide OAuth authentication in a Rails server.

## Introduction

Let's implement all the knowledge we've just gained about OAuth and Omniauth. In this lab we'll be allowing users to log in via Facebook. Because we have no control over Facebook, the tests can't ensure that Facebook responds correctly, so you might have issues on the Facebook side if you haven't set up everything exactly as explained in the README. We'll be testing that everything on our server's side is configured correctly and that, assuming that Facebook gives us the correct response, we can log the user in.

## Instructions

Our app will have one page with a "Login with Facebook" link on it. When the user clicks the link, they'll be asked to authorize our app's access to certain details from their Facebook account. Upon acceptance, our app will use the retrieved data to either locate an existing user account or create a new one, and the user will then be logged in to our app.

There is already a view that outputs all the authentication data and displays the user's photo if one is provided.

## Resources
  * [Omniauth](https://github.com/intridea/omniauth)
  * [Facebook Developer Portal](https://developers.facebook.com)
  * [Facebook API User Info Fields](https://developers.facebook.com/docs/graph-api/reference/user/)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/omniauth_lab' title='Omniauth Lab'>Omniauth Lab</a> on Learn.co and start learning to code for free.</p>
