# Authentication + Sessions in Rails

#### Objectives:

- Understand what password hashing is.
- Use the bcrypt ruby gem to hash + encrypt user passwords.
- Authenticate user passwords in the console.
- Understand Rails sessions, and use password authentication to create / destroy user sessions.

## 1. Create our example rails application

- Navigate to your workspace in your terminal and create the application, specifying PostreSQL as our database:

  ```sh
  rails new authentication_sessions_practice -d postgresql
  ```

- Then navigate into the newly created `authentication_sessions_practice` directory, build the database,  and open the directory in Visual Studio Code:

  ```sh
  cd authentication_sessions_practice
  rails db:create
  code .
  ```

## 2. Install Bcrypt

Bcrypt is an industry-standard password hashing function. We use Bcrypt to protect our users' passwords by encrypting them before storing them in our databases. 

#### What is a hash function?

> A **hash function** is any function that can be used to map data of arbitrary size to data of fixed size. The values returned by a hash function are called **hash values**, **hash codes**, **hash sums**, or simply **hashes**.

The bcrypt ruby gem is used to take in user passwords, and encrypt them. We **NEVER** store raw plaintext passwords in our database.

While this sounds like it could be a lot of work to set up, you'll be pleased to know that there's a convenient ruby gem for bcrypt, and that it has already been included in all of our rails apps' Gemfiles. All we need to do is:

#### Install bcrypt gem by uncommenting it from the Gemfile, and then running:

``` bash
bundle install
```

## 3. Start up the server

Run `rails server` in the terminal, then navigate to `localhost:3000` in your browser. After a brief moment, you should see the default Rails welcome page.

## 4. Create the User model

Let's create the user model, with the following fields:

- name (String)
- email (String)
- password_digest (String)

``` sh
rails g model User name email password_digest
```

#### Important:

- We have to make sure we name the password column `password_digest`. This is the column bcrypt looks for in order to store encrypted (or, digested) password.
- ***REMEMBER***: we never store plain unencrypted passwords... EVER

**Note**: If you accidentally mistype the name of a table of have any kind of typo in the creation of a model, have no fear! Just head over to the documentation on [ActiveRecord Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html#creating-a-standalone-migration) for reference on how to change tables and columns in your database.

Now migrate these changes to the database:

``` bash
rails db:migrate
```

## 5. Add Bcrypt password validation to User model

In the User model (`app/models/user.rb`):

``` ruby
class User < ActiveRecord::Base
	# invoke bcrypt to require AND hash passwords when adding new users:
	has_secure_password
end
```

The addition of `has_secure_password` to our User model does a few really powerful things:

1. It makes sure that a new user **MUST** provide a password when creating their account. This is a form of validation.
2. It makes sure that the provided password will be "digested" (aka encrypted), with Bcrypt, **BEFORE** being stored in our database.
3. It adds methods to instances of the User model class that allow us to validate if a user is entering the correct password when they're attempting to log in.

## 6. Test our User model with Bcrypt

In your terminal, open up the rails console:

```sh
rails console
```

##### First, we'll try creating a user **WITHOUT** a password, to make sure it fails:

``` sh
irb(main):002:0> User.create(name: "T.J.", email: "juckson@gmail.com")
   (0.3ms)  BEGIN
   (0.2ms)  ROLLBACK
=> #<User id: nil, name: "T.J.", email: "juckson@gmail.com", created_at: nil, updated_at: nil, password_digest: nil>
```

------

When we see `ROLLBACK` in the terminal it usually means that the app attempted an ActiveRecord command, but the SQL query was blocked because it failed some kind of validation. In our case, we expected this because our User MUST contain a password in order to be stored. Thanks Bcrypt! 

##### Next we'll try creating a user *with* a password. 

```sh
irb(main):001:0> User.create(name: "T.J.", email: "juckson@gmail.com", password: "eastWestB0wl")
   (0.2ms)  BEGIN
   SQL (1.4ms)  INSERT INTO "users" ...
   (0.5ms)  COMMIT
=> #<User id: 1, name: "T.J.", email: "juckson@gmail.com", created_at: "2018-04-26 17:45:32", updated_at: "2018-04-26 17:45:32", password_digest: "$2a$10$bmJ/KsaY2U3O4BY4.H0uVOOQBqdqUmx73wcwfbYkO9q...">
```

Notice we referred to the user's `password` when creating it, not its `password_digest`. We won't ever set the user's `password_digest` values ourselves. That's up to bcrypt. All we need to provide is a `password` and bcrypt will take care of storing it safely.

Look at the saved user that got returned after we ran the `User.create` command. The value of the user's `password_digest` property is an encrypted hash. It should look something like:

`password_digest: "$2a$10$bmJ/KsaY2U3O4BY4.H0uVOOQBqdqUmx73wcwfbYkO9q…"`

This is what bcrypt generated for us, and somewhere in that jumbled mess of characters lies the user's password. It's important to mention here that this is a **one-way encryption**. That means that `password_digest` isn't meant to be ever be translated back into the original password. However, if a user was trying to log in, we could use bcrypt to test the submitted password against this hash, and bcrypt can at least tell us if they entered the right one or not. Let's test that:

### Testing Authentication

While we're still in the `rails console`, lets find our last user we just created and store it in a variable:

```sh
@user = User.last
```

This user has a fancy method, `.authenticate()`, thanks to the `has_secure_password` we added to our `User` model. Try running it with an *incorrect* password first:

```sh
@user.authenticate('someincorrectpassword')
# => false
```

Providing an incorrect password as an argument to the `.authenticate()` method returns the falsey value of `false`. Now try entering the correct password:

```sh
@user.authenticate('correctpasswordhere')
# => #<User id: 1, name: "T.J.", email: "juckson@gmail.com", created_at: "2018-04-26 17:45:32", updated_at: "2018-04-26 17:45:32", password_digest: "$2a$10$bmJ/KsaY2U3O4BY4.H0uVOOQBqdqUmx73wcwfbYkO9q...">
```

You'll see that this time, the user (a truthy object) gets returned. We'll see this come into play further below. Try and guess where and why we'd use this very important method...

## 7. User's controller

Now that we can create Users from the console, let's add a users controller that will let someone create an account with a form:

``` bash
rails g controller users index show new create edit update destroy
```

Open up your router (`config/routes.rb`), and remove the 7 routes that were automatically added. Instead of using those we'll use:

``` ruby
root 'users#index'
resources :users
```

Your router should now look like:

```ruby
Rails.application.routes.draw do
  root 'users#index'
  resources :users
end
```

###### Refreshing the browser should bring up the Users#index default template that came with our users controller.

When we created our controller, we included all the restful controller actions, but for creating user accounts, we're really only concerned with `new` and `create`:

``` ruby
class UsersController < ApplicationController

  # ... index and show actions here

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    end
  end
    
  # ... edit, update and destroy actions here

  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
```

- the `new` action instantiates a User object to help us render a form.
- the `create` action takes all the submitted form info and uses it to create a user account, then redirects to a not-yet-defined `new_session_path`.
- the `private` `user_params` method declared at the bottom of our users controller makes sure only a name, email, password, and password_confirmation can be submitted in the form for security.
- `password_confirmation` is a useful property that Bcrypt can utilize to (as you might guess) confirm the user's password before creating the account. We'll use that field to make sure that the user that's signing up entered their password the way they intended.

## 8. Signup Form

Before we set up our user account creation form, let's get Bootstrap to make our layouts a little easier on the eyes.

###### Note: For using Bootstrap in Rails, it's recommended to follow the [bootstrap-rubygem documentation](https://github.com/twbs/bootstrap-rubygem) to get setup. For this example, however, we'll source in the Bootstrap CSS as a `<link>` tag.

In `app/views/layouts/application.html.erb`, add the following `<link>` inside the `<head>`:

``` erb
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
```

Then, within the `<body>`, let's wrap the `<%= yield %>` tag in a Bootstrap container:

```erb
<body>
    <div class="container">
        <%= yield %>        
    </div>
</body>
```

###### Refreshing the browser, you should see the same content but with the nicer Bootstrap fonts, and the "container" `div` should be giving us some nicer padding off the left and right edges. That's how we know the Bootstrap CSS has been successfully loaded.

Then, in `/app/views/users/new.html.erb`, replace the default html with:

```erb
<div class="row">
  <div class="col-md-6 offset-md-3">
    <h1>Sign Up</h1>
    <%= form_for @user do |f| %>  
      <div class="form-group">
        <%= f.label :name, 'Name*' %>
        <%= f.text_field :name, class: 'form-control' %>
      </div>

      <div class="form-group">
        <%= f.label :email, 'Email*' %>
        <%= f.text_field :email, class: 'form-control' %>
      </div>

      <div class="form-group">
        <%= f.label :password, 'Password*' %>
        <%= f.password_field :password, class: 'form-control' %>
      </div>
      
      <div class="form-group">
        <%= f.label :password_confirmation, 'Confirm Password*', class: 'col-md-4 control-label' %>
        <%= f.password_field :password_confirmation, class: 'form-control' %>
      </div>

      <%= f.submit 'Create Account', class: 'btn btn-primary' %>
    <% end %>
  </div>
</div>
```

To see this form, navigate your browser to `localhost:3000/users/new`. Try filling out the form and submitting it. 

###### Oh no! What's that error?

You might see the following: 
"undefined local variable or method `new_session_path' for #<UsersController:0x007ff6bbba0d38>"

Looks like everything is broken, but it's not! Our users controller `create` action is set to redirect to the `new_session_path` after creating a user. We haven't defined a `new_session_path` which explains this error. But, if you are seeing that error, it at least means the user was in fact saved into the database.

Let's confirm the user did in fact get saved in our database. Open up the `rails console` again and run:

```sh
User.last
```

You should a user with the information that was entered in the form. Yay!

```sh
#<User id: 2, name: "Jake", email: "jake@gmail.com", created_at: "2018-04-26 19:22:40", updated_at: "2018-04-26 19:22:40", password_digest: "$2a$10$UC1C09zXfA9VTZYfhDMk8.YdmJB0mjFnGmTBe3YxlMC...">
```

In the next section, we'll create the sessions controller, add the necessary session-related routes, and that error should go away.

## 9. Sessions controller

Since sessions are not stored in a database, we don't need to create a model to represent them. Rather, we can simply create a controller for the sessions, and have this controller's logic handle the users' ability to login / logout.

Create the sessions controller, with only three actions (`new`, `create`, and `destroy`):

``` sh
rails g controller sessions new create destroy
```

The `new` action will represent the presentation of the login form, the `create` action will represent the actual session creation, and the `destroy` action will represent logging out.

Before we go into adding the logic to handle sessions, let's make an adjustment to our routes.rb file so that we can take advantage of Rails' automatic path alias assignment:

In `config/routes.rb`, add:

``` ruby
resources :sessions, only: [:new, :create]
delete '/logout' => 'sessions#destroy', as: :logout
```

Now, in our sessions controller, let's write in our session logic:

``` ruby
class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
```

### Break it down. What are these three actions doing?

1. `new`: Doesn't need any logic. It will simply render the login form
2. `create`: Once a user submits a login form to this action, it will:
   - look for a user with the provided email.
   - If there's a user with that email **AND** the password they provided is correct...
   - add that user's ID to the session (the client will be given an updated cookie).
   - redirect to the user's profile (show) page.
   - otherwise, redirect back to the login form page to try again. 
3. `destroy`:
   - clear the user's ID out of the cookie
   - redirect to the home page (you can change this to whichever page you like)

## 10. Application-level helper methods

Now we'll create a couple methods that will help us throughout our application with regard to the currently logged-in user. You can imagine we'll want to access those methods throughout any of our controllers and views, so we'll declare them in the `application controller`, aka the parent of all controllers so that they'll be available everywhere. We call these helpful methods… ahem… helper methods.

The methods we'll create are:

- `current_user`: will return the current user (the user that's making a request at any given moment).
- `logged_in?`: will return a simple boolean (are they logged in? true or false).
- `authorize`: will be used to redirect the client to a different page if they try to access specific routes without being logged in.

In `app/controllers/application_controller.rb`:

``` ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # make the below methods available in our view templates:  
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
    
  def authorize
    redirect_to new_session_path unless logged_in?
  end
end
```

### `current_user`

The syntax here is strange.

- It returns the value of an instance variable called `@current_user`
- If `@current_user` has no value, it assigns it one by finding a user by the ID stored in the session (the cookie provided in the request)
- But it only does this if the request's cookie contains a user's ID to begin with. Otherwise will return `nil`

### `logged_in?`

Simply takes the value we get from `current_user` and converts it into a boolean. Are they logged in? Yes or no? True or false?

### `authorize`

This method will be used a bit later, but imagine there are controller actions we only want logged-in users to access. For example, creating posts, updating a profile, seeing details about other users. Depending on the app being built, the actions you want to protect (aka authorize) will be different. We'll see this method in use further down.

## 11. Login Form (`new_session_path`)

Let's add our login form. Remember we didn't add anything to our sessions controller's `new` action

```ruby
def new
end
```

This means we won't be able to make use of Rails' `form_for` method to construct our form. So, as an alternative, we'll use the more generic `form_tag`, with `label_tag`, `text_field_tag`, `password_field_tag`, and `submit_tag` helpers that come with Rails.

In `app/views/sessions/new.html.erb`

``` erb
<div class="row">
  <div class="col-md-6 offset-md-3">
    <h1>Sign In</h1>
    <%= form_tag sessions_path do %>  
      <div class="form-group">
        <%= label_tag :email, 'Email' %>
        <%= text_field_tag :email, nil, class: 'form-control' %>
      </div>
      <div class="form-group">
        <%= label_tag :password, 'Password' %>
        <%= password_field_tag :password, nil, class: 'form-control' %>
      </div>
      <%= submit_tag 'Log In', class: 'btn btn-primary' %>
    <% end %>
  </div>
</div>
```

Submitting this form will send a POST request to `/sessions`, which will trigger the sessions controller create action. Refer to that action to see what it does. We use `nil` as the second argument for `text_field_tag` and `password_field_tag` so that those form fields don't get rendered with an initial value.

#### Try submitting the form

Navigate to `localhost:3000/sessions/new` to see the login form:

- What should happen if we enter an incorrect email / password combo? Try it!
- What should happen in we enter a correct email / password combo? Try it!

When you enter a correct email / password, we're logged in! Although, we wouldn't know it, because nothing tells us we're logged in. Let's fix that in the next step.

## 12. Dynamic Navigation Bar

On step 10, we added global helper methods that we can use in our view templates (`current_user` and `logged_in?`). We'll use these to construct a navigation bar that will dynamically display links depending on the user's current logged in status. We'll start by creating a dedicated navbar partial template file.

- Create a directory called `partials` inside `app/views`
- In `app/views/partials`, create a file called `_navbar.html.erb`

In `app/views/partials/_navbar.html.erb` start by adding the following:

``` erb
<ul class="nav">
  <li class="nav-item">
    <%= link_to 'Home', root_path, class: 'nav-link' %>
  </li>
  <li class="nav-item">
    <a class="nav-link disabled">Logged In As: </a>
  </li>
  <li class="nav-item">
    <%= link_to 'Log Out', logout_path, method: 'delete', class: 'nav-link' %>
  </li>
  <li class="nav-item">
    <%= link_to 'Sign Up', new_user_path, class: 'nav-link' %>
  </li>
  <li class="nav-item">
    <%= link_to 'Sign In', new_session_path, class: 'nav-link' %>
  </li>
</ul>
```

And render it in `app/views/layouts/application.html.erb` just before the `<%= yield %>` tag:

```erb
<div class="container">
  <%= render 'partials/navbar' %>
  <%= yield %>        
</div>
```

Examining the navbar's html markup, we can see we're using `link_to` with path aliases to generate the links, and giving them bootstrap `nav-link` classes. 

- The disabled `<a>` that says "Logged In As" will be a place where we can render the name of the currently logged-in user.
- The Log Out link might stand out to you too. Specifying `method: 'delete'` on a `link_to` will tell Rails to magically send a `delete` request to the provided path instead of the typical get request.

We need to make this navbar dynamic now. In other words, we want to:

- **ONLY** show the **Sign Up / Sign In** links when **nobody** is logged in
- conversely **ONLY** show **Logged In As and the Logout** link when **someone IS** logged in

To make use of our application-level `helper` methods, let's change our navbar to:

```erb
<ul class="nav">
  <li class="nav-item">
    <%= link_to 'Home', root_path, class: 'nav-link' %>
  </li>
  <% if logged_in? %>
    <li class="nav-item">
      <a class="nav-link disabled">Logged In As: <%= current_user.name %> </a>
    </li>
    <li class="nav-item">
      <%= link_to 'Log Out', logout_path, method: 'delete', class: 'nav-link' %>
    </li>
  <% else %>
    <li class="nav-item">
      <%= link_to 'Sign Up', new_user_path, class: 'nav-link' %>
    </li>
    <li class="nav-item">
      <%= link_to 'Sign In', new_session_path, class: 'nav-link' %>
    </li>
  <% end %>
</ul>
```

#### Notice we're using `logged_in?` as the basis of an if statement. We're also easily able to print out the `current_user`'s name.

Now we should be seeing ONLY the links that pertain to the current user's logged in status. Try it out by refreshing your browser.

## 13. Authorizing routes

The last method we added to our Application Controller was the `authorize` method, but we haven't had a chance to use it until now. Since we declared it in Application Controller, it's automatically inherited by all other controllers. This makes it easy to protected specific routes from unauthorized access, while keeping our code dry.

### When to authorize?

Any action in any controller where we want to require the user to be logged in in order to access, should be authorized. In this example, let's make it a requirement that a user be logged in in order to access the `show`, `edit`, `update`, and `destroy` actions.

In the user's controller (`app/controllers/users_controller.rb`), change the class so that it includes the authorization line:

``` ruby
class UsersController < ApplicationController
  # authorization middleware:
  before_action :authorize, only: [:show, :edit, :update, :destroy]
  
  # ...
  # ...
```

`before_action` is a built-in rails method that allows us to run a specific function before processing a set of requested actions. This is typically called `middleware` in software development.

With `before_action`, we can use `authorize` to redirect the client to the Log In page **BEFORE** allowing them to use the requested **ACTIONS** ***if they're not logged in***.

Now try 'logging out' and visiting /users/1, you should get redirected to the login page. When you log in and try to access /users/1, you should be allowed in now.

# Key takeaways

1. Although there's a lot going on here to make authentication and sessions work, we didn't actually have to write a whole lot of code to get up and running.
2. Bcrypt is a fantastic, easy-to-use authentication and password encryption utility that should be used in EVERY Rails app you build that has some kind of User sign up.
3. **NEVER** store passwords in a database unless they are encrypted. **NEVER EVER**. We may not be security experts, but taking the time to do this will prevent a ton of headache in the future. Ahem, Sony… 
4. Authentication is different from Authorization. How so?

------

## 14. BONUS: Flash Messages

Flash messages are a great user interface element that give the user feedback on an action that just took place. For example, if you enter a password incorrectly while trying to log in and are redirected back to the login form, it'd be nice to know why, since there's no way to actually see the password that was entered.

A flash message is a message that only shows for the duration of one request. That is to say, as soon as the next request is sent and responded to, the message goes away.

Just like the `session` object in rails, we have access to an object called `flash` that we can manipulate and give temporary values to on certain conditions. To demonstrate this, we'll add flash messages for both successful and unsuccessful login attempts in the sessions controller.

In `app/controllers/sessions_controller.rb`, within the `create` action, add the `flash` code to the if / else:

```ruby
# ........

def create
  @user = User.find_by_email(params[:email])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    
    ###########################################
    flash[:success] = "Welcome, #{@user.name}!"
    ###########################################
    
    redirect_to user_path(@user)
  else
    
    ###########################################
    flash[:danger] = 'Incorrect email or password. Please try again.'
    ###########################################
    
    redirect_to new_session_path
  end
end

# ........

```

The above additions to our sessions controller `create` action are responsible for generating custom messages, with custom keys. You can create any flash message you want with any custom key. The format for flash messages is:

#### `flash[:key_name_here] = "message value here"`

Now we can render any available flash messages in `app/views/layouts/application.html.erb`. We'll add them between our `<%= render 'partials/navbar' %>` and the `<%= yield %>`:

```erb
  <body>
    <div class="container">
      <%= render 'partials/navbar' %>
      
      <% flash.each do |key, value| %>
        <div class="alert alert-<%= key %>">
          <%= value %>
        </div>
      <% end %>
      
      <%= yield %>        
    </div>
  </body>
```

With the above code, we are looping through the flash object like we would an array or a hash, and for each message contained within, we create a `<div>` with the associated class, and the corresponding message.

Notice we used `success` and `danger` as the names of the associated messages. This is because we can use those names in the <div> class names to generate bootstrap's alert color coding. In general, you can call the message anything you want, but this is a typical usage.

Try logging in now with the wrong credentials and you should see a red alert div (since it uses the `alert-danger` class), then log in successfully and you'll see a green one (with `alert-success` class). On the next click to another page, the message will go away. Nice!

For more info on flash messages with rails visit:

http://api.rubyonrails.org/classes/ActionDispatch/Flash.html

## Where to go from here?

1. Try continuing with the full-crud implementation of the User model, controller, and views.
2. When you get to the destroy action (deleting a user's account), you may run into a nasty error. Try and figure out what is causing this, and how to fix it. 
   Tip: If you can't get out of that error, try clearing your cookies in your browser… HINT HINT HINT.
3. Try changing the sign up system so that when a user creates their account, they are automatically logged in as well, without having to re-enter their information.