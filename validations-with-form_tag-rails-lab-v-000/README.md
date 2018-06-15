# Validations with `form_tag`

# Objectives

- Render or redirect based on validation of instance in create/update
- Prefill in form values based on an instance
- Print out full error messages based on an invalid instance
- Introspect on errors for a field
- Apply an error class to a field conditionally based on errors on a field

# Requirements

## Validations

1. Add validations to `Author` such that...
  1. `name` is not blank
  1. `email` is unique
  1. `phone_number` is exactly 10 digits long
1. Add validations to `Post` such that...
  1. `title` is not blank
  1. `content` is at least 100 characters long
  1. `category` is either `"Fiction"` or `"Non-Fiction"`

## Basic Routes & Controllers

1. Create controllers for both models.
1. Create `show`, `new`, `edit`, `create`, and `update` routes for both models.
1. Define controller actions for `show`, `new`, and `edit`.
1. Define the "valid path" for the `create` and `update` controller actions.
1. Define the "invalid path" for the `create` and `update` controller actions.

## Forms

1. Create forms with `form_tag` for both models' `new` and `edit` actions.
1. Prefill already-submitted forms with the invalid data when re-rendering.
1. Display a list of errors at the top of forms when an invalid action is
   attempted. They should be contained in an element with id
   `error_explanation`, and each error should have its own `<li>`.
1. Conditionally wrap each field in a `.field_with_errors` div if it has errors.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/validations-with-form_tag-rails-lab' title='Validations with form_tag'>Validations with form_tag</a> on Learn.co and start learning to code for free.</p>
