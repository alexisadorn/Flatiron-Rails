# Rails form_tag Lab

## Objectives

1. Build a functional Rails form using a `form_tag`

2. Pass a route helper as the argument to a `form_tag`

3. Pass an options hash with a method to a `form_tag`

4. Use a `text_field_tag` and other form controls to create inputs

5. Build a `new` action that renders a form that submits to the `create` action


## Instructions

The two specs for this lab that are currently failing are located within the `form page` feature in `specs/features/student_spec.rb`.

At a high level, you need to build a form to create a new student, have the form redirect back to the `new` view template, and print out the form params to the screen. Below are a few items to keep in mind:

* Draw a `new` and `create` route for the `students` resource

* Print out the student value to the view template page


## Keys to remember

* Look at the tests to see which field values you should be using

* Make sure to use the `form_tag` helpers


## Resources

* [Reading](https://github.com/learn-co-curriculum/rails-form_tag-readme)
* [Form Helper Documentation](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-form_tag-lab' title='Rails form_tag Lab'>Rails form_tag Lab</a> on Learn.co and start learning to code for free.</p>
