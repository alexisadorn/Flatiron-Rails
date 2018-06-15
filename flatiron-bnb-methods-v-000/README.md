# Flatiron-bnb: Methods

In the previous iteration, we built out our model associations and migrated our database. Now we're going to work on building useful methods (class and instance) for rendering data and our own validations. We're doing this to follow the principle that our controllers should be skinny, our models fat, so therefore our views have very little logic in them.

***NOTE***: As with much of our Rails curriculum, remember to always use the `--no-test-framework` flag when you generate models, controllers, etc. That way, the Rails generators will not create additional tests on top of the test suite that already comes with the lesson. E.g., `rails g model User username:string email:string --no-test-framework`.

## Instructions

There are many methods here. Check out the specs and **remember to run your code in `rails c`** — that will help, I promise!

### City

  * The `#city_openings` method should return all of the `Listing` objects that are available for the **entire span** that is inputted. (**NOTE**: This isn't easy. Check the resources below and try out a few things in console until you're satisfied with your solution. Don't be afraid to google!)
  * The `.highest_ratio_res_to_listings` method should return the `City` that is "most full". What that means is it has the highest amount of reservations per listing.
  * The `.most_res` method should return the `City` with the most total number of reservations, no matter if they are all on one listing or otherwise.

### Listing

#### Validations

  * You'll need to write a few validations here, they are all pretty straight forward, just take a look at the tests!

#### Callbacks

  * Whenever a listing is created, the user attached to that listing should be converted into a "host". This means that the user's `host` field is set to `true`
  * Whenever a listing is destroyed (new callback! _Google it!_) the user attached to that listing should be converted back to a regular user. That means setting the `host` field to false.

### Neighborhood

The same class/instance methods as your `City` object. Maybe there is a way they can share code?!?!?

### Reservation

#### Validations

  * Should have a `checkin` and a `checkout` method.
  * Make sure the guest and host aren't the same user.
  * Make sure any reservation that is made, doesn't conflict with others.
  * Make sure the checkout time is after the check in time.

**Note:** Remember, if you're having trouble setting up your models' relationships, Google is your friend. There might be ways of designing associations that you haven't encountered yet but that will vastly simplify your code.

#### Methods

  * `#duration` gives the duration in days
  * `#total_price` returns the price using the duration and the price per day of the listing

### Review

#### Validations

  * Should have a description, rating and reservation
  * Reviews should only be created on reservations that exist and have already happened.

## Resources

* [About Private Methods](http://stackoverflow.com/a/4293330/2890716)
* [AR Validations](http://guides.rubyonrails.org/active_record_validations.html)
* [Rails Callbacks](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)
* [Date range overlaps](http://stackoverflow.com/questions/325933/determine-whether-two-date-ranges-overlap)

<a href='https://learn.co/lessons/flatiron-bnb-methods' data-visibility='hidden'>View this lesson on Learn.co</a>

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/flatiron-bnb-methods'>Flatiron BnB Methods Lab</a> on Learn.co and start learning to code for free.</p>
