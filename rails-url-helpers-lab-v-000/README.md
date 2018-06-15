# Rails URL Helpers Lab

## Objectives

1. Generate URLs using route helpers

2. Draw routes with implicit and explicit names using `:as`

3. Draw routes with variables

4. Generate URLs using route helpers that require variables


## Instructions

In this lab you will be building out the Student management dashboard for the Flatiron School by starting to integrate the ability to link between pages. Four tests are currently passing, and the rest need implementation code to start passing. In order to complete this lab, you will need to complete the following tasks:

* A user should be able to navigate to `/students` to view all of the students.

* A user should be able to click the student's name on the `index` page and be taken to that specific student's `show` page.

* Create a new boolean attribute called `active` in the students table. (HINT: You might have to search around for the best way to set a (*ahem*) __default value__.)

* A user should be able to go to `/students/:id/activate` to toggle their `active` attribute between `true` and `false`.

* Read the failing tests and modify the code until they pass. 


## Keep in mind

* Make sure the show path is `/students/:id`, where `:id` is a route variable.

* Call the Student class instance method `to_s` on each of the students on the index page so that each student element contains their first and last name.

* On the student index page, test out all three different `link_to` argument options, e.g.: `link_to "post", "/post/#{post.id}"`, `link_to("post", post_path(post.id))`, `link_to("post", post_path(post))`.


## Resources

* [Reading](https://github.com/learn-co-curriculum/rails-url-helpers-readme)

* [URL Helper Documentation](http://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-url-helpers-lab' title='Rails URL Helpers Lab'>Rails URL Helpers Lab</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/rails-url-helpers-lab'>Rails URL Helpers Lab</a> on Learn.co and start learning to code for free.</p>
