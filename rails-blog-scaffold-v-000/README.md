# Rails Blog

## Instructions

This is a simple lab. All you have to do is get the tests passing. There are a bunch of tests, but it should take you less than 5 minutes to finish this lab. Try to figure out the one command you need to run to make the entire suite pass. **Read the Controller and Views specs for help on figuring out this one command.** Try running rspec. You'll most likely get an error. You'll need to also remember to migrate your test database, but rspec will clue you in. Browse the code, read, try to take it all in.

The model name will be `Post` and the attributes will be `title` and `description`. The `title` attribute should be of type `string` and `description` should be of type `text`.

## What are all these files?

All the files that you currently see in your project directory, with the exception of a few `spec` files, were generated via the `rails new` command. Consequently, it built a fully fledged web app ready out of the box. This is an example of why the Rails framework is called an opinionated framework that favors convention over configuration. With Sinatra, we can build an app from scratch by just adding `require  'sinatra'` in a file and calling `rackup`. Rails is much heavier than that. With an app ready out of the box through generators like `rails new` and `rails generate scaffold`, we're able to build larger scale applications very quickly.

## Rails Scaffolding

Scaffolding is a powerful tool that Rails provides. Here's the syntax:

```bash
> rails generate scaffold <capitalized singular model name> <optional first attribute name>:<first attribute type> <optional second attribute name>:<second attribute type> <optional third attribute name>:<third attribute type> <etc.>
```

For the purposes of all Rails labs at Flatiron, you'll be adding the flag `--no-test-framework` to every command that includes "generate" or "g" for short. Therefore, the Flatiron version is:

```bash
> rails generate scaffold <capitalized singular model name> <optional first attribute name>:<first attribute type> <optional second attribute name>:<second attribute type> <optional third attribute name>:<third attribute type> <etc.> --no-test-framework
```

For instance, say you were making an app to help New Yorkers find apartments. Your apartments should have an address (string), a price (float), a description (text), and an image url (string). You want to make the following things:

1. an apartment model
2. an apartments table with four columns (address, price, description, image_url)
3. an apartments controller
4. routes for apartments (show, new, index, update, edit, delete, create)
5. views (show, new, edit, index)

To make all these in one command, you would run:

```bash
> rails generate scaffold Apartment address:string price:float description:text image_url:string
```

The above command would also build out tests for your views, controller, etc. If you were scaffolding Apartments for a Flatiron lab, you would add that `--no-test-framework` flag, so the command would be:

```bash
> rails generate scaffold Apartment address:string price:float description:text image_url:string --no-test-framework
```

This will build everything except for the tests out for you. Not only will it build out the controller, migration, model, and views, it will also create a helper, some JSON builders, a stylesheet, and a [CoffeeScript](http://coffeescript.org/) file. It will also add `resources :apartments` to the `config/routes.rb` file.

```shell
 create    db/migrate/20150117151933_create_apartments.rb
    create    app/models/apartment.rb
    invoke    test_unit
    invoke  resource_route
     route    resources :apartments
    invoke  scaffold_controller
    create    app/controllers/apartments_controller.rb
    invoke    erb
    create      app/views/apartments
    create      app/views/apartments/index.html.erb
    create      app/views/apartments/edit.html.erb
    create      app/views/apartments/show.html.erb
    create      app/views/apartments/new.html.erb
    create      app/views/apartments/_form.html.erb
    invoke    helper
    create      app/helpers/apartments_helper.rb
    invoke    jbuilder
    create      app/views/apartments/index.json.jbuilder
    create      app/views/apartments/show.json.jbuilder
    invoke  assets
    invoke    coffee
    create      app/assets/javascripts/apartments.js.coffee
    invoke    scss
    create      app/assets/stylesheets/apartments.css.scss
    invoke  scss

```

If you forget to add the `--no-test-framework` argument, you will have to comb through your local repo and manually delete all of the newly-created, unnecessary tests. This is not fun! **Please, remember the `--no-test-framework` argument.**

Browse through the Rails Guides below:

## Resources

* [Rails Guides](http://guides.rubyonrails.org/) - [Getting Started with Rails](http://guides.rubyonrails.org/getting_started.html)
* [Rails Guides](http://guides.rubyonrails.org/) - [Layouts and Rendering](http://guides.rubyonrails.org/layouts_and_rendering.html)
* [Rails Guides](http://guides.rubyonrails.org/) - [Action Controller Overview](http://guides.rubyonrails.org/action_controller_overview.html)
* [Rails Guides](http://guides.rubyonrails.org/) - [Rails Routing from the Outside In](http://guides.rubyonrails.org/routing.html)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-blog-scaffold' title='Rails Blog'>Rails Blog</a> on Learn.co and start learning to code for free.</p>
