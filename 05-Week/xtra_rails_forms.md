## Forms, `form_for`, and `link_to`

### Lesson Objectives

1. Understand the `action` and `method` attributes on an HTML5 form
2. Be able to use Rails form helpers to build out forms

## Prelude: Forms in HTML5 

A form is typically used in a web application to collect user data, then subsequently send this data *somewhere*. For Ruby on Rails applications the "somewhere" is a server. A `<form>` in HTML5 looks like this: 

```html
<form action="/beans" method="POST">
</form>
``` 

Two important attributes on a `<form>` tag are:
* The `action` attribute's value is a URL which corresponds to the URL we are sending the form data to
* The `method` attributes value is the HTTP verb we using to send data to the server. The two possible values for this attribute are `GET` and `POST`

### Forms in Rails

In, Rails the most rudimentary usage of a `form_tag` generates an HTML `<form>`:

```erb
<%= form_tag do %>
  Hello World
<% end %>
```

Creates the following HTML form: 

```html
<form action="/" accept-charset="UTF-8" method="post">
<input name="utf8" type="hidden" value="✓">
<input type="hidden" name="authenticity_token" value="vG5HbekGB4qe8oV5Y2U2vZlbEjz9l0dMafkrKYNUvZYVfumSAbam4N4UeBAyvCY8BGQpNOJgpeETiJOQpFmoJQ==">
	Hello World!
</form>
```

When the `form_tag` helper is called without arguments (like above) it creates a HTML5 `<form>` tag which, when submitted, will POST to the **current page**

For instance, assuming the current page is `/home/index`, the generated HTML will look like this (some line breaks added for readability):

```html
<form accept-charset="UTF-8" action="/home/index" method="post">
  <input name="utf8" type="hidden" value="&#x2713;" />
  <input name="authenticity_token" type="hidden" value="J7CBxfHalt49OSHp27hblqK20c9PgwJ108nDHX/8Cts=" />
  Form contents
</form>
```

Things to note about the form above:

* You'll notice that the HTML contains an `<input>` element with `type=hidden`. This input is important, because the form cannot be successfully submitted without it.
* The hidden input element with the `name=utf8` enforces browsers to properly respect your form's character encoding and is generated for all forms whether their action is "GET" or "POST".
* The second input element with the name `authenticity_token` this is a security feature of Rails called Cross-Site Request Forgery protection, and form helpers generate it for every non-GET form (provided that this security feature is enabled)


### Dynamic Forms

* A **dynamic form** is one that is generated from Rails helpers
* Below we have a form generated dynamically using form helpers:

```erb
<%= form_tag("/search", method: "get") do %>
  <%= label_tag(:q, "Search for:") %>
  <%= text_field_tag(:q) %>
  <%= submit_tag("Search") %>
<% end %>
```


The above example will generate html that looks like the following

```html
<form accept-charset="UTF-8" action="/search" method="get">
  <input name="utf8" type="hidden" value="&#x2713;" />
  <label for="q">Search for:</label>
  <input id="q" name="q" type="text" />
  <input name="commit" type="submit" value="Search" />
</form>
```

* For every form input, an `id` attribute is generated from its name ("q" in above example).
* These `id`'s can be very useful for CSS styling or manipulation of form controls with JavaScript
* Besides `text_field_tag` and `submit_tag` there is a similar helper for every form control in HTML.


### `form_tag`

* The form_tag helper accepts 2 arguments: 
1. the path for the action 
2. an **options hash**; this hash specifies the method of form submission and HTML options such as the form element's class.

```erb
<%= form_tag("/cars", { method: "post", class: "nifty_form" }) %>
```

In the example above: 
* `/cars` is the path value for the action 
* `{ method: "post", class: "nifty_form" }` is the options hash


### Helpers for Generating Form Elements

* Rails provides a series of helpers for generating form elements such as checkboxes, text fields, and radio buttons.
* These basic helpers, with names ending in `_tag` (such as `text_field_tag` and `check_box_tag`), generate just a single `<input>` element.

### form helper examples and helpers

For most forms, you're probably going to use inputs and text areas. But for every form element you can think of, Rails has a way for you to write some ruby to generate your html. This is a list of them:

```erb
<%= check_box_tag(:pet_dog) %>
<%= radio_button_tag(:age, "child") %>
<%= text_area_tag(:message, "Hi, nice site", size: "24x6") %>
<%= password_field_tag(:password) %>
<%= hidden_field_tag(:parent_id, "5") %>
<%= search_field(:user, :name) %>
<%= telephone_field(:user, :phone) %>
<%= date_field(:user, :born_on) %>
<%= datetime_local_field(:user, :graduation_day) %>
<%= month_field(:user, :birthday_month) %>
<%= week_field(:user, :birthday_week) %>
<%= url_field(:user, :homepage) %>
<%= email_field(:user, :address) %>
<%= color_field(:user, :favorite_color) %>
<%= time_field(:task, :started_at) %>
<%= number_field(:product, :price, in: 1.0..20.0, step: 0.5) %>
<%= range_field(:product, :discount, in: 1..100) %>
```

The above outputs the following in `HTML`:

```html
<input id="pet_dog" name="pet_dog" type="checkbox" value="1" />
<input id="age_child" name="age" type="radio" value="child" />
<textarea id="message" name="message" cols="24" rows="6">Hi, nice site</textarea>
<input id="password" name="password" type="password" />
<input id="parent_id" name="parent_id" type="hidden" value="5" />
<input id="user_name" name="user[name]" type="search" />
<input id="user_phone" name="user[phone]" type="tel" />
<input id="user_born_on" name="user[born_on]" type="date" />
<input id="user_graduation_day" name="user[graduation_day]" type="datetime-local" />
<input id="user_birthday_month" name="user[birthday_month]" type="month" />
<input id="user_birthday_week" name="user[birthday_week]" type="week" />
<input id="user_homepage" name="user[homepage]" type="url" />
<input id="user_address" name="user[address]" type="email" />
<input id="user_favorite_color" name="user[favorite_color]" type="color" value="#000000" />
<input id="task_started_at" name="task[started_at]" type="time" />
<input id="product_price" max="20.0" min="1.0" name="product[price]" step="0.5" type="number" />
<input id="product_discount" max="100" min="1" name="product[discount]" type="range" />
```


#### Model Object Helpers

**A particularly common task for a form is editing or creating a model object**

* For example, providing a form in `new.html.erb` we provide our form helper with an instance of a model object.
* While the `*_tag` helpers can certainly be used for this task they are somewhat verbose as for each tag you would have to ensure the correct parameter name is used and set the default value of the input appropriately.
* Rails provides helpers tailored to this task. These helpers lack the `_tag` suffix, for example `text_field_tag` becomes `text_field`.


### Binding forms to objects

As you have already seen, using `form_for` allows us to bind a form to a specific object and allows us to write complex forms more easily than using the `form_tag` options.


#### A MVC form example

This would be a typical example of what a form would like look attached to a model:

```ruby
def new
  @question = Question.new
end
```

```erb
<%= form_for @article, url: {action: "create"}, html: {class: "nifty_form"} do |f| %>
  <%= f.text_field :title %>
  <%= f.text_area :body, size: "60x12" %>
  <%= f.submit "Create" %>
<% end %>
```

* a few things to note about this form:
  - `@article` is the actual object being edited (our model).
  - There is a single hash of options. Routing options are passed in the `:url` hash, HTML options are passed in the `:html` hash.
  - The `form_for` method yields a form builder object (the f variable).
  - Methods to create form controls are called on the form builder object f.

* The resulting `html` looks like this:

```html
<form accept-charset="UTF-8" action="/articles" method="post" class="nifty_form">
  <input id="article_title" name="article[title]" type="text" />
  <textarea id="article_body" name="article[body]" cols="60" rows="12"></textarea>
  <input name="commit" type="submit" value="Create" />
</form>
```

* The name passed to `form_for` controls the key used in `params` to access the form's values.
* Here the name is article and so all the inputs have names of the form article[attribute_name].
* Accordingly, in the create action `params[:article]` will be a hash with keys `:title` and `:body`


### Forms with Resources

* When dealing with RESTful resources, calls to `form_for` can get significantly easier if you rely on record identification.
* For example, let's say you have an `Article` model, and `resources :articles` in your `routes.rb` file
* In short, you can just pass the model instance and have Rails figure out model name and the rest:


```erb
<%= form_for @question do |field| %>
    <%= field.label(:first_name) %>
    <%= field.text_field(:first_name, { class: "form-control", placeholder: "First Name" }) %>
<% end %>
```

### Forms using Nested Resources

* **nested resources** are `resources` that are children of other `resources`.
* for example, a `magazine` resource may have a nested `ad` resource like this

```ruby

class Magazine < ActiveRecord::Base
  has_many :ads
end

class Ad < ActiveRecord::Base
  belongs_to :magazine
end
```

* Nested routes allow you to capture this relationship in your routing. In this case, you could include this route declaration:

```ruby
resources :magazines do
  resources :ads
end
```


* In the example above, if you wanted to have a form for your `ad` resource based on your `magazine` resource, you would do the following

`form_for [:magazine, @ad]`


### How do forms with PATCH, PUT, or DELETE methods work?

* The Rails framework encourages RESTful design of your applications, which means you'll be making a lot of "PATCH" and "DELETE" requests (besides "GET" and "POST").
* However, most browsers don't support methods other than "GET" and "POST" when it comes to submitting forms
* Rails works around this issue by emulating other methods over POST with a hidden input named `_method`, which is set to reflect the desired method

So something like this,

```erb
form_tag(search_path, method: "patch")
```
produces this,

```html
<form accept-charset="UTF-8" action="/search" method="post">
  <input name="_method" type="hidden" value="patch" />
  <input name="utf8" type="hidden" value="&#x2713;" />
  <input name="authenticity_token" type="hidden" value="f755bb0ed134b76c432144748a6d4b7a7ddf2b71" />
</form>
```

- When parsing POSTed data, Rails will take into account the special `_method` parameter and act as if the HTTP method was the one specified inside it ("PATCH" in this example)


## `Link_to`


- `link_to` creates an anchor element of the given name using a URL created by the set of options.
- `link_to` can be written in the following ways

```ruby
link_to(body, url, html_options = {})
  # url is a String; you can use URL helpers like
  # posts_path

link_to(body, url_options = {}, html_options = {})
  # url_options, except :method, is passed to url_for

link_to(options = {}, html_options = {}) do
  # name
end

link_to(url, html_options = {}) do
  # name
end
```


### Link to examples

```ruby
link_to "Profile", profile_path(@profile)
```
produces
```html
<a href="/profiles/1">Profile</a>
```

* Another way to write this, but specifiing the action and the id manually
```ruby
link_to "Profile", controller: "profiles", action: "show", id: @profile
```
produces
```html
<a href="/profiles/show/1">Profile</a>
```


* link_to also allows you to write it as a block if your link target is hard to fit into the name parameter

```ruby
<%= link_to(@profile) do %>
  <strong><%= @profile.name %></strong> -- <span>Check it out!</span>
<% end %>
```
produces
```html
<a href="/profiles/1">
  <strong>David</strong> -- <span>Check it out!</span>
</a>
```


- when using link_to, rails makes it super easy to add custom css attributes to allow you to write your css in an effort to style your application how you see fit

```ruby
link_to "Articles", articles_path, id: "news", class: "article"
```
produces
```html
<a href="/articles" class="article" id="news">Articles</a>
```


- rails also gives you a way to add `anchor links` and `query strings` inside your links
- this is convenient if you want to link to a certain part of a page (`anchor links`) or link to a certain search term (`query strings`)

```ruby
link_to "Comment wall", profile_path(@profile, anchor: "wall")
# anchor link
```
produces
```html
<a href="/profiles/1#wall">Comment wall</a>
```



```ruby
link_to "Ruby on Rails search", controller: "searches", query: "ruby on rails"
# query string
```
produces
```html
<a href="/searches?query=ruby+on+rails">Ruby on Rails search</a>
```



```ruby
link_to "Nonsense search", searches_path(foo: "bar", baz: "quux")
# multiple queries
```
produces
```html
<a href="/searches?foo=bar&amp;baz=quux">Nonsense search</a>
```


- adding `method` to our links allow us to tell rails what `HTTP` method we want to use. this is especially useful for deleting things
```ruby
link_to("Destroy", "http://www.example.com", method: :delete)
```
produces
```html
<a href='http://www.example.com' rel="nofollow" data-method="delete">Destroy</a>
```


- you can also use `data` attributes, which can allow things like a pop up (javascript `alert`) to give the user more information
```ruby
link_to "Visit Other Site", "http://www.rubyonrails.org/", data: { confirm: "Are you sure?" }
```
produces
```html
<a href="http://www.rubyonrails.org/" data-confirm="Are you sure?">Visit Other Site</a>
```


- and finally, rails allows you to set any link attributes such as `target`, `rel`, `type`:
```ruby
link_to "External link", "http://www.rubyonrails.org/", target: "_blank", rel: "nofollow"
```
produces
```html
<a href="http://www.rubyonrails.org/" target="_blank" rel="nofollow">External link</a>
```


### Conclusion

* `form_tag` are forms generally used for things that are not attached to models
* when using a form that we want to bind to a model, we use `form_for`
* when using `link_to` we have a way to do everything from writing dynamically generated links, to custom query strings, and to even tell rails what `HTTP` method we would like to use

- some exteneral resources for the curious
  - [forms](http://guides.rubyonrails.org/form_helpers.html)
  - [link to](http://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-link_to)