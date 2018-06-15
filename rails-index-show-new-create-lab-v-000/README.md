# Index, Show, New, Create Lab

## Objectives

1. Build a RESTful `index` action
2. Build a RESTful `show` action
3. Build a RESTful `new` action
4. Build a RESTful `create` action
5. Link pages using route helpers
6. Use route helpers in a `redirect_to`
7. Build a new form with a `form_tag`


## Instructions

This will be a pretty extensive lab that will combine a number of the concepts that we have reviewed, including:

* Drawing multiple route types

* Integrating route helper methods

* Building out a form and wiring it up to the `create` action

* Linking pages together


In this lab, the application you will be starting out with will be completely blank. There are no models, views, controllers, et cetera. It has a number of RSpec and Capybara tests that will all need to pass to complete the lab. The tests can be found in the `spec` directory, in the `models`, `features`, and `controllers` sub-directories. Feel free to walk through the specs to see what behavior the application should have when you're done.

Like many production applications, we've included the `config/secrets.yml` file in the `.gitignore`. This means that you are going to have to create your own `config/secrets.yml` file for the application to run. Don't worry- we've given you a template. Just rename `config/secrets-template.yml` to `config/secrets.yml`, and you should be able to get the application to run.

The application you will be building is a Coupon app. Below is a high-level overview of the features you'll be building out:

* You will need to create a `coupons` table with `coupon_code` and `store` columns, which should both be of the `string` data type.

* Your `index` page should show all of the coupons in the database.

* The coupon codes on the `index` page should link to their corresponding coupon `show` page. You should use the `link_to` method and route helper methods instead of hard-coding an HTML `<a>` tag.

* Your `show` page should render the specific coupon passed to the route. E.g., `coupons/4` should show the coupon with an ID of 4.

* The `new.html.erb` view template should render a form that uses the `form_tag` method.

* The form should be wired up to the `create` action in the controller and, when submitted, should create a new record in the `coupons` table with the parameters passed through the form.

* The controller should use the `redirect_to` helper method to redirect the user to the `show` page template for the newly-created coupon.


## Resources

* [Reading on Create Action](https://github.com/learn-co-curriculum/rails-create-action-readme)

* [Reading on Form Integration](https://github.com/learn-co-curriculum/rails-form_tag-readme)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-index-show-new-create-lab' title='Index, Show, New, Create Lab'>Index, Show, New, Create Lab</a> on Learn.co and start learning to code for free.</p>
