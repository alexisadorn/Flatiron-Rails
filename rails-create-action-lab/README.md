# Create Action Lab

1. Build a working `create` action
2. Use a `form_tag` to create a new form that submits to the `index` action
3. Correctly name form fields so that they end up at the top level of the `params` hash
4. Assign data from `params` to a `Student` object in the `create` action
5. Save that `Student` object in the `create` action
6. Create a `redirect_to` from the `create` action to the `show` action


## Instructions

Many of the spec tests are already passing for this lab, but there are some additional ones –– including our first use of controller tests –– located here:

* **Controller Specs** - `specs/controllers/students_controller_spec.rb`

* **Capybara Specs** - `specs/features/student_spec.rb:37`

When this lab is complete, your application should have the following behavior:

1. User fills out the form on `students/new`

2. When the form is submitted, a new record is created in the database

3. After the user submits the form, they are redirected to the `show` page that renders the `Student` record that they created


Make sure to use a route helper method to redirect to the `show` page at the end of the `create` method. You can find the correct syntax for this route by running `rake routes` in the terminal.


## Resources

* [Reading](https://github.com/learn-co-curriculum/rails-create-action-readme)

* [Documentation](http://api.rubyonrails.org/classes/ActiveRecord/Persistence/ClassMethods.html)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-create-action-lab' title='Create Action Lab'>Create Action Lab</a> on Learn.co and start learning to code for free.</p>
