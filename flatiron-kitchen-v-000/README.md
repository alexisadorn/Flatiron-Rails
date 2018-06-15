# Flatiron Kitchen

## Deliverables

Fork this repository. Deliver your solution in master.

## Instructions

Flatiron Kitchen started off as a bubble tea bar in the corner of Flatiron School and is now a five-star restaurant known for its blueberry pancakes.

Things used to be simpler when there were only a few chefs at Flatiron Kitchen, but now that it's expanding an application is needed to keep track of all of the world-class recipes.

We need to be able to track which ingredients the restaurant has available and which ingredients are used in each recipe.

Your application should use a join table called "recipe_ingredients" to keep track of the ingredients for each recipe.

Build your site so that it passes the tests in spec/features. There aren't tests for index pages or things like page headers or links, but feel free to add these (otherwise your app will be difficult to navigate).

**NOTE:** when you generate models, controllers, etc., be sure to include the `--no-test-framework` option so that Rails doesn't create tests (which are already included in the lab).

**NOTE:** Each test has a helpful comment above it!

**HINT:** If you give a checkbox `<input>` a name attribute like `ninja_turtle_colors[]`, each ninja turtle color will be passed to the `params` hash in an array: `{ ninja_turtle_colors: ["red", "blue", "orange", "purple"] }`.

## Bonuses!

Keep track of the quantity of ingredients currently on hand. Display on each recipe page how many dishes can be made given the existing ingredients.

Write RSpec unit tests to verify your ingredients-to-dishes calculator.

## Resources
* [Rails Guides](http://guides.rubyonrails.org/) - [Active Record Basics](http://guides.rubyonrails.org/association_basics.html)
* [Rails Guides](http://guides.rubyonrails.org/) - [Action Controller Overview](http://guides.rubyonrails.org/action_controller_overview.html)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/flatiron-kitchen' title='Flatiron Kitchen'>Flatiron Kitchen</a> on Learn.co and start learning to code for free.</p>
