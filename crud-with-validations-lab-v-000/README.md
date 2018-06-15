# CRUD With Validations Lab

Your goal in this lab is to create a thorough CRUD interface for one model, the
`Song`.

# Songs

Songs have the following attributes and limitations:

- `title`, a `string`
  - Must not be blank
  - Cannot be repeated by the same artist in the same year
- `released`, a `boolean` describing whether the song was ever officially
  released.
  - Must be `true` or `false`
- `release_year`, an `integer`
  - Optional if `released` is `false`
  - Must not be blank if `released` is `true`
  - Must be less than or equal to the current year
- `artist_name`, a `string`
  - Must not be blank
- `genre`, a `string`

# Requirements

Use the `resource` generator, **not** the `scaffold` generator.

1. Define a model with validations for `Song`.
1. Define all RESTful routes for songs.
1. Build views that connect to each other using route helpers.
1. Use `form_for` to build forms with pre-fill and error list features. (*Hint:
   Try using a partial to cut down on copypasting!*)
1. Allow deleting songs with a link, using `link_to`. (HINT: You might need to [add some functionality](https://github.com/rails/jquery-ujs) so that you can properly delete a song using just a link. Be sure to [include your new assets](http://apidock.com/rails/v4.2.1/ActionView/Helpers/AssetTagHelper/javascript_include_tag) in `application.html.erb`.)
1. Use strong parameters in your POST/PATCH controller actions.
1. Set the root route to the song index.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/crud-with-validations-lab' title='CRUD With Validations Lab'>CRUD With Validations Lab</a> on Learn.co and start learning to code for free.</p>
