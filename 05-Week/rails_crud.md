# Rails CRUD (Part 1 - Create & Read)

## Objectives
*After this lessons, SWBAT:*

- Create forms in Rails using form helpers
- Render partial views for forms
- Understand `link_to` and `image_tag`
- Practice Create and Read in Active Record using these controller actions:
  - index
  - new
  - create
  - show

## Intro

We've already talked about how to add Ruby to your HTML using `erb`. In Rails, there are also some special helper tags that render specific HTML tags.

During this lesson, we will talk about `link_to`, `image_tag`, and form helpers. We will open up the dev tools in Chrome to see how each of these tags is translated to HTML!

Form helpers are a great tool in Rails to help us gather data for a create or update action (the C and U of CRUD!).

## Set Up

Go to your workspace and create a new Rails app called `cat_app`, which uses a postgreSQL database and skips the test unit:

`rails new cat_app -d=postgresql -T`

## Create a Cat Model

Rails has handy generators that can make creating models and controllers easier. Once you decide what attributes your cats will have, use the rails generator to create a Cat model:

`rails g model Cat name age:integer gender breed indoor:boolean`

Why is Cat written that way? Models are classes, so we name them like classes: capitalized and singular.

In this model, age is an integer, indoor is a boolean, and name, gender, and breed are strings, since we didn't specify another data type.

Now that we have created the model, we need to run `rake db:create` to create our postgreSQL database, and `rake db:migrate` to push the changes (creating a cats table) to our database. *Note: we only run `rake db:create` once per project, not after creating every model.*

Before we get to controllers, routes, and views, let's use ActiveRecord to add a couple of cats to our database to get us started. Spend a few minutes with a partner adding at least two cats to your database.

Next up...

## Create a Cats Controller

Rails convention is to name each controller the plural version of the corresponding model. So, since we just made a Cat model, let's make a cats controller. There's a generator for that, too!

`rails g controller cats`

This command will create a few things:

- a controller file (in this case, **cats_controller.rb**), which lives in **app/controllers**
- a stylesheet and a coffeescript file
- a new directory for beans in the **app/views** directory.

If we want to, we can do even more with that command. If we ran `rails g controller cats index`, Rails would also generate a method called index in the cats controller and a view called index.html.erb in the app/views/cats directory. It would also create a 'cats/index' route, but that isn't RESTful, so we would have to change it!

You can add as many of these methods/views to your rails g controller command as you want. `rails g controller cats index new show edit` would create methods and views for all of the controller actions which correspond with the HTTP verb GET. Create, update, and destroy don't require views because they are not GETs.

**Let's create all of our views and routes manually for now.** Just run `rails g controller cats`.

## Let's Do Some CR *(that's CRUD without the UD)*

### Read
We will want to read data from our database individually (`show`) and all at once (`index`). Let's start with an `index`.

#### Index
This will be a view where all of the cats are listed.

##### Controller Action
In the controller, we'll assign an instance variable to represent all of the records in the cats table.

```ruby
def index
  @cats = Cat.all
end
```

`@cats` will be an array containing all of the Cat records in the cats table of our database.

##### Route
Let's make our index route (RESTfully, of course!):
```ruby
get '/cats' => 'cats#index'
```

The route starts with the HTTP verb, followed by the URI, then a hash rocket, then the controller and action pair (cats controller, index method).

##### View Template
In our view template, we'll use erb and html, so the file extension should include both.

Navigate to `app/views/cats` and create a new file called `index.html.erb` - This file must be called "index" to correspond with our index controller action and our index route.

Since `@cats` is an array, we need to use `.each` to display each item within that array.

```erb
<h1>Cats</h1>

<ul>
	<% @cats.each do |cat| %>
		<li>
			<%= cat.name %> is a <%= cat.age %> year old <%= cat.breed %>.
			<% if cat.gender == "female" %>
				She
			<% else %>
				He
			<% end %>
			is an
			<% if cat.indoor %>
				indoor
			<% else %>
				outdoor
			<% end %>
			cat.
		</li>
	<% end %>
</ul>
```

Run your rails server and navigate to `localhost:3000/cats` in your browser. You should see a list of the cats you entered into your database.

What if we want to see only one cat?

#### Show
This will be a view where one cat is shown, specified by the id in the url.

##### Controller Action
In the controller, we'll assign an instance variable to represent the cat whose id is in the url.

```ruby
def show
  @cat = Cat.find(params[:id])
end
```

`@cat` will not be an array this time since it will only represent one record from the cats table of our database.

##### Route
Let's make our show route:
```ruby
get '/cats/:id' => 'cats#show'
```

The route starts with the HTTP verb, followed by the URI, then a hash rocket, then the controller and action pair (cats controller, show method).

Run `rake routes` in your terminal. There's no prefix for the show route! We can fix that by adding an alias to our route:

```ruby
get '/cats/:id' => 'cats#show', as: :cat
```

You'll see why this is helpful in a minute.

##### View Template
Navigate to `app/views/cats` and create a new file called `show.html.erb` - This file must be called "show" to correspond with our show controller action and our show route.

```erb
<h1><%= @cat.name %></h1>

Age: <%= @cat.age %> <br>
Breed: <%= @cat.breed %> <br>
Gender: <%= @cat.gender %> <br>
<%= "Indoor" if @cat.indoor %>
<%= "Outdoor" unless @cat.indoor %>
```

Run your rails server and navigate to `localhost:3000/cats/1` in your browser. You should see the first cat that you entered into your database.

What if you don't know the id of the cat you want to view? Let's add a `link_to` tag in our index view to dynamically link to each cat.

Replace `<%= cat.name %>` with `<%= link_to cat.name, cat_path(cat) %>` and check out your index page in your browser.

The `link_to` tag takes two arguments:

- the text to display (in this case, `cat.name`, but we could put a string in there)
- where the link should go (the path - this could also be an external url as a string)

Now that we have the ability to read our data, let's set up our app so we can add cats in the browser instead of only in the console.

### Create
In order to create data, we will need a `create` action **and** a `new` action. Why?! Because new and create are BFF!

![](https://media.giphy.com/media/l4KhXO06gtMQbomIg/giphy.gif)

No, really. Create is a POST, but in order to post data to our database, we need to first gather the data. The best way to do this is in a form in the `new` view.

#### New
This will be a form.

##### Controller Action
In the controller, we'll assign an instance variable to represent a new cat.

```ruby
def new
  @cat = Cat.new
end
```

##### Route
Let's make our new route:
```ruby
get '/cats/new' => 'cats#new', as: :new_cat
```

**It is very important that this route go above the show route!**
The routes file reads from top to bottom, and the `:id` portion of the show route is a variable. If you put the new route below the show route, then you will get an error that says, *Couldn't find Cat with 'id'=new*. Just make sure the new route is first and you'll be good to go!

##### View Template
Navigate to `app/views/cats` and create a new file called `new.html.erb` - This file must be called "new" to correspond with our new controller action and our new route.

```erb
<h1>Add a new cat!</h1>

<%= form_for @cat do |f| %>

	<div>
		<%= f.label :name %>
		<%= f.text_field :name %>
	</div>

	<div>
		<%= f.label :age %>
		<%= f.number_field :age %>
	</div>

	<div>
		<%= f.label :breed %>
		<%= f.text_field :breed %>
	</div>

	<div>
		<%= f.label :gender %>
		<%= f.select :gender, options_for_select([["Select One", ""], "male", "female"]) %>
	</div>

	<div>
		<%= f.label :indoor %>
		<%= f.check_box :indoor %>
	</div>

	<div>
		<%= f.submit %>
	</div>

<% end %>
```

Let's talk about all of these [form helpers](http://guides.rubyonrails.org/form_helpers.html)!

If you go to `cats/new` in your browser and try to submit the form, you will get an error because there's no create method yet. So...

#### Create
This will take the data from our form and post it to the database.

##### Controller Action
In the controller, we'll assign an instance variable to represent a new cat and then we'll need to save the cat in the database.

```ruby
def create
    @cat = Cat.new(cat_params)
    if @cat.save
        redirect_to cat_path(@cat)
    else
        render :new
    end
end
```

Notice the conditional statement: our app will behave differently if there is an error in saving the record.

What are cat_params? Good question!

By default, Rails doesn't let us just add any old thing to our database. We must "whitelist" (allow) what we want to be added. We'll define our whitelist in a private method.

At the bottom of the controller, add this:

```ruby
private
def cat_params
    params.require(:cat).permit(:name, :age, :breed, :gender, :indoor)
end
```

*Notice that `private` does not have a corresponding `end`*

##### Route
Let's make our create route:
```ruby
post '/cats' => 'cats#create'
```

##### View Template
There is none! Since `create` is not a GET, there is no view template.

##Independent Practice

You'll learn the UD of CRUD after lunch with Philippe. For now, let's focus on making our app easier to navigate. Using `link_to`, add some navigational links:

- add a link to the `new` view from the `index` view
- add a link to the `index` view from the `show` view
- add a link to the `index` view from the `new` view

## Conclusion

- Does it matter which order the routes are in? Why or why not?
- Can you (as a developer) create records in your database without a form?
- Why doesn't `create` have a view template?