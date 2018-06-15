# Rails Amusement Park

## Objectives

Get comfortable with using form helpers, having models interact with each other, and building out a simple sessions system.

You're going to be building an amusement park. There will be users, attractions, and users can take rides on attractions.

## Instructions
* Check out [The Demo](https://flatiron-amusement-park.herokuapp.com/) to see where this lab is headed.
* This is a test driven lab, check out the model tests and get those to pass before moving onto the feature specs.
* Remember, if you use scaffolds or generators do ***not*** overwrite the model specs that are included in this lab. Always use the `--no-test-framework` flag and enter `n` or `no` when prompted to overwrite the model specs for this lab.

**A hint about requiring a password**: ActiveRecord comes with a handy `has_secure_password` attribute that you can set on a model. It requires that you enable the `bcrypt` gem and that you add a `password_digest` column to your model. You can read more about [`has_secure_password` here](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html).

## Resources
* [Rails Generators](http://guides.rubyonrails.org/generators.html)
* [Form Helpers](http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html)
* [Form Helpers Guide](http://guides.rubyonrails.org/form_helpers.html)
* [Collection Select](http://stackoverflow.com/questions/8907867/can-someone-explain-collection-select-to-me-in-clear-simple-terms)
* [Sessions in Rails](http://guides.rubyonrails.org/security.html#sessions)
* [`has_secure_password`](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-amusement-park' title='Rails Amusement Park'>Rails Amusement Park</a> on Learn.co and start learning to code for free.</p>
