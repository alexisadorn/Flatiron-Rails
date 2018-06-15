# Rails Layouts And Templates Lab

## Objectives

Your task is to build an online store! Okay, maybe not a whole online store, but at least some layouts and controllers for an online store. Not only will you learn how to create a layout and how to get an action to use that layout but also how to override defaults and specify layouts on the action level.

## The Default Layout

1. Make a new controller called `StaticController`.
2. Create a home view with an `h2` that says "Welcome to Flatiron Widgets" and a new action in `StaticController` called `home`.
3. Create a default application layout at the correct location, and add an `h1` to it that says "Flatiron Widgets Store". This is for the main site's welcome bar.

## Custom Layouts for a Controller

1. Create a new controller called `StoreAdminController`.
2. We want this controller to use a new layout called `admin`. This layout should have an `h1` that says "Flatiron Widgets: Admin".
3. Create a home view in `StoreAdminController` with an `h2` that says "Welcome Flatiron Admin".
4. Get your newly created action to use the `admin` template.

## Custom Layouts for an Action

1. Create a new view in `StoreAdminController` called `orders` with an `h2` that says "Welcome to Flatiron Open Orders". Also add an `ol` with a few `li` elements containing fake orders.
2. Now you should create a new layout called `order_administration` and add an `h1` that says "Flatiron Widgets: Open Orders".
3. At this point, the `store_admin#orders` action will use the `admin` layout you defined earlier, but we need it to use the new `order_administration` layout. The trick is we want only the `store_admin#orders` action to use the `order_administration` layout, and we want to keep the `admin` layout as the default for the other actions in `StoreAdminController`.

## Ignore Layouts for an Action

1. Create a new action in `StoreAdminController` called `invoice`, and insert an `h1` that says "Your Invoice".
2. This action is assigned the default layout for the controller, `admin`, but we don't want it to use any layout at all (while also not affecting the layouts assigned to other actions in the controller).

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-layouts-and-templates-lab' title='Rails Layouts And Templates Lab'>Rails Layouts And Templates Lab</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/rails-layouts-and-templates-lab'>Layouts And Templates in Rails Lab</a> on Learn.co and start learning to code for free.</p>
