# OmniAuth

## Objectives
1. Describe the problem of authentication and how OmniAuth solves it.
2. Explain an OmniAuth strategy.
3. Use OmniAuth to handle authentication in a Rails server.

There are no tests for this lesson, but code along as we learn about OmniAuth and build out a login strategy together!

***NOTE***: If you run into trouble with Facebook, use the usual avenues for assistance (Google, StackOverflow, AAQ, Slack, and so on), but don't bash your head against the wall too much. Facebook is the choice for this lesson because it is ubiquitous as an OAuth provider, but feel free to pick a different provider (GitHub, for instance). A bit of struggle in the setup process is healthy — that's a learning opportunity. However, the ultimate point of this lesson is to learn how to use OmniAuth; not to waste six hours fighting with the Facebook developer interface.

## Overview
Passwords are terrible.

For one thing, you have to remember them. Or you have to use a password manager, which comes with its own problems. Unsurprisingly, some percentage of users will just leave and never come back the moment you ask them to create an account.

And then on the server, you have to manage all these passwords. You have to store them securely. Rails secures your passwords when they are stored in your database, but it does not secure your servers, which see the password in plain text. If I can get into your servers, I can edit your Rails code and have it send all your users' passwords to me as they submit them. You'll also have to handle password changes, email verification, and password recovery. Inevitably, your users accounts will get broken into. This may or may not be your fault, but, when they write to you, it will be your problem.

What if it could be someone else's problem?

Like Google, for example. They are dealing with all these problems somehow (having a huge amount of money helps). For example, when you log into Google, they are looking at vastly more than your username and password. Google considers where you are in the world (they can guess based on [your IP address][ip_geolocation]), the operating system you're running (their servers can tell because they [listen very carefully to your computer's accent when it talks to them][ip_fingerprinting]), and numerous other factors. If the login looks suspicious — for instance, you usually log in on a Mac in New York, but today you're logging in on a Windows XP machine in Thailand — they may reject it or ask you to solve a [CAPTCHA][CAPTCHA].

Wouldn't it be nice if your users could use their Google — or Twitter, Facebook, GitHub, etc. — login for your site?

Of course, you know this is possible. It's becoming increasingly rare to find a modern website that _doesn't_ allow users to login via a third-party account. Today, we're going to talk about how to add this feature to your Rails applications.

## OmniAuth
[OmniAuth][omniauth] is a gem for Rails that lets you use multiple authentication providers alongside the more traditional username/password setup. 'Provider' is the most common term for an authentication partner, but within the OmniAuth universe we refer to providers (e.g., using a Facebook account to log in) as _strategies_. The OmniAuth wiki keeps [an up-to-date list of strategies][list_of_strategies], both official (provided directly by the service, such as GitHub, Heroku, and SoundCloud) and unofficial (maintained by an unaffiliated developer, such as Facebook, Google, and Twitter).

Here's how OmniAuth works from the user's standpoint:
  1. User tries to access a page on `yoursite.com` that requires them to be logged in. They are redirected to the login screen.
  2. The login screen offers the options of creating an account or logging in with Google or Twitter.
  3. The user clicks `Log in with Google`. This momentarily sends the user to `yoursite.com/auth/google`, which quickly redirects to the Google sign-in page.
  4. If the user is not already signed in to Google, they sign in normally. More likely, they are already signed in, so Google simply asks if it's okay to let `yoursite.com` access the user's information. The user agrees.
  5. They are (hopefully quickly) redirected to `yoursite.com/auth/google/callback` and, from there, to the page they initially tried to access.

Let's see how this works in practice.

## OmniAuth with Facebook
The OmniAuth gem allows us to use the OAuth protocol with a number of different providers. All we need to do is add the OmniAuth gem *and* the provider-specific OmniAuth gem (e.g., `omniauth-google`) to our Gemfile. In some cases, adding only the provider-specific gem will suffice because it will install the OmniAuth gem as a dependency, but it's safer to add both — the shortcut is far from universal.

In this case, let's add `omniauth` and `omniauth-facebook` to the Gemfile and then run a `bundle install` command. If we were so inclined, we could add additional OmniAuth gems to our heart's content, offering login via multiple providers in our app.

Next, we'll need to tell OmniAuth about our app's OAuth credentials. Create a file named `config/initializers/omniauth.rb`. It will contain the following lines:
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end
```
The code is unfamiliar, but we can guess what's going on from the characteristically clear Rails syntax. We're telling our Rails app to use a piece of middleware created by OmniAuth for the Facebook authentication strategy.

### `ENV`
The `ENV` constant refers to a global hash for your entire computer environment. You can store any key-value pairs in this hash, so it's a very useful place to keep credentials that we don't want to be managed by Git or displayed on GitHub (especially if your GitHub repo is public). The most common error students run into is that when `ENV["PROVIDER_KEY"]` is evaluated in the OmniAuth initializer it returns `nil`. Later attempts to authenticate with the provider will cause some kind of `4xx` error because the provider doesn't recognize the app's credentials (because they're evaluating to `nil`).

As you can gather from the initializer code, we're going to need two pieces of information from Facebook in order to get authentication working: the application key and secret that will identify our app to Facebook.

Log in to [the Facebook developer site](https://developers.facebook.com/). In the `My Apps` dropdown menu at the top-right of the page, select `Add a New App`, and a modal should appear. Fill out the requested information and click `Create App ID`. You should now be on the `Product Setup` page — if you are not, look in the sidebar for `+ Add Product` under the `Products` heading. On the `Product Setup` page, click `Get Started` next to `Facebook Login`:

![Facebook Login](https://user-images.githubusercontent.com/17556281/27402847-25d8c782-5696-11e7-8fa0-2aaa6602de06.png)

Choose the `Web` option, and enter `http://localhost:3000/` when it prompts you for your `Site URL`. Click `Save`, and then click on `Settings` under the `Facebook Login` heading in the sidebar:

![Facebook Login Settings](https://user-images.githubusercontent.com/17556281/27403332-0cf83f84-5698-11e7-9e59-acb8ec82a5d2.png)

In the `Valid OAuth redirect URIs` field, enter `localhost:3000/auth/facebook/callback`, which is the default callback endpoint for the `omniauth-facebook` strategy:

![Valid OAuth redirect URIs](https://user-images.githubusercontent.com/17556281/27404131-f5aea626-569a-11e7-9f76-df563870d81a.png)

Click `Save Changes`, and then click on `Dashboard` in the sidebar. Keep the page handy because we'll need those `App ID` and `App Secret` values in a minute, but first...

### `dotenv-rails`
Instead of setting environment variables directly in our local `ENV` hash, we're going to let an awesome gem handle the hard work for us. `dotenv-rails` is one of the best ways to ensure that environment variables are correctly loaded into the `ENV` hash in a secure manner. Using it requires four steps:
  1. Add `dotenv-rails` to your Gemfile and `bundle install`.
  2. Create a file named `.env` at the root of your application (in this case, inside the `omniauth_readme/` directory).
  3. Add your Facebook app credentials to the newly created `.env` file
  4. Add `.env` to your `.gitignore` file to ensure that you don't accidentally commit your precious credentials.

For step three, take the `App ID` and `App Secret` values from the Facebook app dashboard...
![Facebook App Dashboard](https://user-images.githubusercontent.com/17556281/27404133-f7220c00-569a-11e7-9494-bc3c805b31d0.png)

...and paste them into the `.env` file as follows:
```
FACEBOOK_KEY=247632982388118
FACEBOOK_SECRET=01ab234567890c123d456ef78babc901
```

### Routing OAuth flow in your application
We now need to create a link that will initiate the Facebook OAuth process. The standard OmniAuth path is `/auth/:provider`, so, in this case, we'll need a link to `/auth/facebook`. Let's add one to `app/views/welcome/home.html.erb`:
```erb
<%= link_to('Log in with Facebook!', '/auth/facebook') %>
```

Next, we're going to need a `User` model and a `SessionsController` to track users who log in via Facebook. The `User` model should have four attributes, all strings: `name`, `email`, `image`, and `uid` (the user's ID on Facebook).

To handle user sessions, we need to create a single route, `sessions#create`, which is where Facebook will redirect users in the callback phase of the login process. Add the following to `config/routes.rb`:
```ruby
get '/auth/facebook/callback' => 'sessions#create'
```

Our `SessionsController` will be pretty simplistic, with a lone action (and a helper method to DRY up our code a bit):
```ruby
class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
    end

    session[:user_id] = @user.id

    render 'welcome/home'
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
```

And, finally, since we're re-rendering the `welcome#home` view upon logging in via Facebook, let's add a control flow to display user data if the user is logged in and the login link otherwise:
```erb
<% if session[:user_id] %>
  <h1><%= @user.name %></h1>
  <h2>Email: <%= @user.email %></h2>
  <h2>Facebook UID: <%= @user.uid %></h2>
  <img src="<%= @user.image %>">
<% else %>
  <%= link_to('Log in with Facebook!', '/auth/facebook') %>
<% end %>
```

Now it's time to test it out! It's best to log out of Facebook prior to clicking the login link — that way, you'll see the full login flow.

#### A man, a plan, a param, Panama
Upon clicking the link, your browser sends a `GET` request to the `/auth/facebook` route, which OmniAuth intercepts and redirects to a Facebook login screen with a ridiculously long URI: `https://www.facebook.com/login.php?skip_api_login=1&api_key=247632982388118&signed_next=1&next=https%3A%2F%2Fwww.facebook.com%2Fv2.9%2Fdialog%2Foauth%3Fredirect_uri%3Dhttp%253A%252F%252Flocalhost%253A3000%252Fauth%252Ffacebook%252Fcallback%26state%3Df4033bf06e2c3d74f1e65367e9c1651e2bde5487d5a7ca8d%26scope%3Demail%26response_type%3Dcode%26client_id%3D247632982388118%26ret%3Dlogin%26logger_id%3Dd31c6728-d017-cee3-503d-5fe1bb6d8ad3&cancel_url=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Ffacebook%2Fcallback%3Ferror%3Daccess_denied%26error_code%3D200%26error_description%3DPermissions%2Berror%26error_reason%3Duser_denied%26state%3Df4033bf06e2c3d74f1e65367e9c1651e2bde5487d5a7ca8d%23_%3D_&display=page&locale=en_US&logger_id=d31c6728-d017-cee3-503d-5fe1bb6d8ad3`. The URI has a ton of [encoded](http://ascii.cl/url-encoding.htm) parameters, but we can parse through them to get an idea of what's actually being communicated.

Right away, we see our Facebook application key, `api_key=247632982388118`, and the Facebook API endpoint that the login flow will send us to next: `next=https://www.facebook.com/v2.9/dialog/oauth`. At that point, there are divergent paths, one for successful login:
  + `redirect_uri=http://localhost:3000/auth/facebook/callback` — If login succeeds, we'll be redirected to our server's OmniAuth callback route.
  + `scope=email` — This tells Facebook that we want to receive the user's registered email address in the login response. We didn't have to configure anything (`scope=email` is the default), but if you want to request other specific pieces of user data check out [the `omniauth-facebook` documentation](https://github.com/mkdynamic/omniauth-facebook#configuring).
  + `client_id=247632982388118` — There's our application key again, this time provided to the success callback.
And one for failure:
  + `cancel_url=http://localhost:3000/auth/facebook/callback` — If login fails, we'll also be redirected to our server's OmniAuth callback route. However, this time there are some nested encoded parameters that provide information about the failure:
    * `error=access_denied`
    * `error_code=200`
    * `error_description=Permissions error`
    * `error_reason=user_denied`

#### Inspecting the returned authentication data
If you want to inspect the exact information that Facebook returns to our application about a logged-in user, throw a `binding.pry` in the `SessionsController#create` method and call `auth` inside the Pry session:
```bash
     2: def create
     3:   @user = User.find_or_create_by(uid: auth['uid']) do |u|
     4:     u.name = auth['info']['name']
     5:     u.email = auth['info']['email']
     6:     u.image = auth['info']['image']
     7:   end
     8:
 =>  9:   binding.pry
    10:
    11:   session[:user_id] = @user.id
    12:
    13:   render 'welcome/home'
    14: end

[1] pry(#<SessionsController>)> auth
=> {"provider"=>"facebook",
 "uid"=>"123456789012345",
 "info"=>
  {"email"=>"mary@poppins.com",
   "name"=>"Mary Poppins",
   "image"=>"http://graph.facebook.com/v2.6/123456789012345/picture"},
 "credentials"=>
  {"token"=>
    "ABCDaEFbcGHIJKLMNdlOPeQRfSTUVWgXf1hYiZAjBkClDEmFG234n5oH6p7IJqKr0stLMNuOPQRv86S47TUVWX1YZwABCDxyz2EabcdFGeH4IfgJK9hLi0jM1kNOPQlRmn1oSTUp5qr7VWstuXvYZwxAByza807CbD9c3defEFGghijkHIJK",
   "expires_at"=>1503263133,
   "expires"=>true},
 "extra"=>
  {"raw_info"=>
    {"name"=>"Mary Poppins",
     "email"=>"mary@poppins.com",
     "id"=>"123456789012345"}}}
```

When you make a server-side API call (as we did), Facebook will provide an access token that's good for about two months, so you don't have to bug your users very often. That's good!

## Conclusion
Implementing the OAuth protocol yourself is extremely complicated. Using the OmniAuth gem along with any `omniauth-provider` gem(s) streamlines the process, allowing users to log in to your site easily. However, it still trips a lot of people up! Make sure you understand each piece of the flow, what you expect to happen, and any deviation from the expected result. The end result should be gaining access to the user's data from the provider in your `SessionsController`, where you can then decide what to do with it. Typically, if a matching `User` exists in your database, the client will be logged in to your application. If no match is found, a new `User` will be created using the data received from the provider.

## Resources
* [Managing Environment Variables](https://launchschool.com/blog/managing-environment-configuration-variables-in-rails)

[ip_geolocation]: https://en.wikipedia.org/wiki/Geolocation
[ip_fingerprinting]: https://en.wikipedia.org/wiki/TCP/IP_stack_fingerprinting
[CAPTCHA]: https://en.wikipedia.org/wiki/CAPTCHA
[yak]: https://en.wiktionary.org/wiki/yak_shaving
[omniauth]: https://github.com/intridea/omniauth
[list_of_strategies]: https://github.com/omniauth/omniauth/wiki/List-of-Strategies

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/omniauth_readme' title='OmniAuth'>OmniAuth</a> on Learn.co and start learning to code for free.</p>
