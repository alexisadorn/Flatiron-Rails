# Partials with Locals

Now that we learned about locals, let's refactor our old codebase and add a couple new features using this new tool.

## Objectives

1. Use the `locals` keyword
2. Understand why using instance variables in partials is bad
3. Use a partial to iterate over a collection, passing in a local
4. Use a partial from another controller with a local

# Overview
So your team's lead engineer looked over the codebase and asked you to not refer to instance variables in your partials but rather to pass through local variables.  That way, your code will be more explicit about its dependencies when it calls the partial.

Also, the lead engineer asked for a couple new features.

The first is that we display _all_ students on the classroom show page instead of singling out the oldest student with a special note.  The engineer thinks this isn't very polite.

Second, they also want to add some search functionality so that a user can search for a student by name. It's okay if other students with similar names are returned in the search results.

## Instructions

1. Refactor the `_form.html.erb` partial to accept the argument to the `form_for` helper as a local.  You'll also need to change the `new.html.erb` and `edit.html.erb` views as well.

2. Refactor the `_student.html.erb` partial to pass through each rendered student as a local.

3. On the classroom show page, iterate through each classroom's students and display each of them using our `_student.html.erb` partial with locals.

4. Create a `_classroom.html.erb` partial to display classroom information on the classroom show page.

5. Add in search functionality such that users can search for a student by name and see all matching results on the students index page. The results should be displayed by rendering a `students/_student.html.erb` partial.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/partial-locals-lab'>Partial with Locals Lab</a> on Learn.co and start learning to code for free.</p>
