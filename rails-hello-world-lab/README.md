# Rails Hello World Lab

In this lab you will integrate a static route so that the application will render a "Hello World" page.

## Objectives
1. Draw a route
2. Map a route to a controller/action
3. Render (implicitly or explicitly) a static template
4. Create a static template

## Instructions

Below are the tasks that you will need to complete in order to finish the lab:
* Integrate a route for `localhost:3000/hello_world`.
* Create a static controller that inherits from the application controller and contains the `hello_world` action. You can have the call to the view file occur using either the implicit or explicit processes.
* Create a file in the `views` directory that will be called by the static controller's `hello_world` action, and add the heading `<h1>Hello World</h1>` to the file. The test is case sensitive, so make sure you enter it _exactly_ as shown.

The RSpec/Capybara test suite is currently not passing. Run the tests to see what you need to fix. It might be helpful to fire up the Rails server (via the `rails s` command) in order to manually test the functionality of your route, action, and view. For students in the IDE, here's a [Help Center article](http://help.learn.co/the-learn-ide/common-ide-questions/accessing-localhost-in-the-learn-ide) if you run into trouble with `rails s`.

***Note***: From this point forward, labs will not always be provided as a blank slate, with the responsibility for creating migrations, models, controllers, etc. falling on you. Instead, many labs will contain broken or incomplete code, and you will be required to add to or fix the existing code in order for the specs to pass. In some cases, code that you wrote in a previous lab will be provided. This way, you can focus on applying new concepts instead of getting bogged down in repetitive work, such as setting up a basic Rails app for every new lab. In other cases, you will be gaining the practical experience of learning how to work within an existing code base, which is what you will likely experience at your first job. Rare is the junior developer who gets to create from whole cloth: it’s far more likely that you’ll be onboarded to a project with unfamiliar code created by other developers. Always use the specs to guide you through what additions and/or modifications are needed, and remember: you do **not** have to run the specs in the order provided in the lab. Work on your troubleshooting chops!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-hello-world-lab' title='Rails Hello World Lab'>Rails Hello World Lab</a> on Learn.co and start learning to code for free.</p>
