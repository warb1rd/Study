This presentation is available at:
[https://presentations.generalassemb.ly/65ff2fb0cac4d9c21dca#/](https://presentations.generalassemb.ly/65ff2fb0cac4d9c21dca#/1)

---

<img src="https://i.imgur.com/4pK7Q5f.png" width="500">

## Controllers & Views in Rails Part 2

---

## Learning Objectives

- Write a Controller and Action To Returning Static Pages

- Specify a Default (root) Route

---

## Serving Static Pages

---
### Static Pages
- Static pages are basic HTML pages, that are not processed by a view engine like `erb`.

- Even dynamic web applications have a need for static pages.

- **What type of static pages can you think of that might exist in a typical web application?**
  Think like a user!


- So, let's say we want to display a static _welcome_ or _about_ page.

- **So far, what has it taken to render a view in Rails?**


- Does this mean that we need to create a dedicated route and action for every static page we want to view in the app?  

- Heck no, that could get real yucky in a hurry, especially considering an app might have a dozen or more static pages.

- Instead, one way we can deliver any number of static pages with a single controller, and a single action, is by taking advantage of _named parameters_ in routes!

- Let's see how...

---

### Static Pages - Setup
- It's that time again - time to create a new Rails app!

	```sh
	? rails new my_site -T
	...
	...
	? cd my_site
	```
	
- **What does the `-T` option do?**
	
---

### Static Pages - Route
- We need to determine what our route that serves static pages will be:
	
	- **What HTTP Verb will we use?**
	
	- **What URI Path could we use? Remember, we need to be able to pass in the page we want as a paramter.**
	
	- **What Controller and Action will the route map to?**


- Let's go with something like this in our `routes.rb`:

	```ruby
	Rails.application.routes.draw do
  
  	get '/pages/:page', to: 'pages#show'
	
	end
	```

- **Based on this route, take a guess what value would the _href_  &nbsp;attribute in a link be set to if we wanted to view a _home_ page?**


- Yes, we can put `<a>` tags on any page, anywhere we want that look like this:

  ```html
  <a href="/pages/home">Home</a>
  ```

- As you'll see, in our `show` action, we can access the `params` hash to extract the value of "home" that was passed in.

**Perhaps you already know what code would access the value in the path after the pages segment (/pages/_______)?**

---
### Static Pages - Controller
- As before, let's fire up our server with `rails s`, then browse to `localhost:3000/pages/home` to see the error complaining that it can't find the `PagesController`.

- We fixed a similar error in the previous lesson.
  **What did we have to do?**


- So, do this:

	```sh
	? touch app/controllers/pages_controller.rb
	```

- Then, in `pages_controller.rb` write the class:

	```ruby
	class PagesController < ApplicationController
	
	end
	```

- **What's the next error we will see?**

- **How do we fix it?**

---

### Static Pages - Code the `show` Action
- Now that we've stubbed up our `show` action in our `pages` controller, we've got to figure out how we're going to render the page being requested.

- First, let's find out _what_ page has been requested.

  **Again, where do we find this information?**


- Yes, we grab it out of the `params` hash like this:

	```ruby
	def show
   	page = params[:page]
  end
	```
- So, the `params` hash has a key of `:page`, **where did this name come from?**

- Great! We now have the page they want, but where are we going to put these static pages? By convention, Rails is going look in a certain folder - **what is it?**


- Let's create that folder to hold our static pages:

	```sh
	? mkdir app/views/pages
	```

- Now, since we are requesting a `home` page, we better create a `home.html` file:

	```sh
	? touch app/views/pages/home.html
	```
- Note that the `render` method will also find `.html` files if it does not find a `.erb` file.	


- Better put something in there so that we know we got it right. Something short and to the point:

	```html
	<h1>Home</h1>
	```
	


- If we save and refresh, we'll see an error telling us that we're _Missing template pages/show_.

- **Why is it looking for a `show` view?**

- We need to tell it that we want to render a view different from the default convention...


- As a reminder, the convention is that an action will automatically render a view that:
	- Is in a folder named: `app/views/{name of the controller}`.
	- With a filename matching that of the action.
	
-  However, we can use the `render` method to override Rails and render a view different from this default (or render the default in a different way, e.g. skipping the layout template)...


- In our `show` action, we can use the `render` method like this to return the requested page:

	```ruby
	class PagesController < ApplicationController
  	def show
    		page = params[:page]
    		render "pages/#{page}"
  	end
	end
	```
- Refresh - Yay!

- **How could we reduce the show action code to one line?**

---

### Static Pages - Questions
- **Assuming this link on a page:**
  `<a href="/pages/contact">Contact Us</a>`

  **What do we have to do if we want our app to return the `contact.html` page?**

---

## Specifying a Default (Root) Route

- Users of web apps don't expect to have to enter a full URL in the address bar to access certain pages or functionality.

- Instead, they expect to be able to browse to the **root**, e.g. `localhost:3000/`, and be shown the app's landing page. From there, they can use the app's hyperlinks and/or navigation to use the app.


- If we browse to our current app's root, we're going to see the familiar Rails' "Welcome aboard" page.

- Let's see how we can show our _home.html_ page as our app's default...


- We can tell a Rails app which `controller#action` to use as our default by writing a line of code in our `routes.rb` like this:

	```ruby
	Rails.application.routes.draw do
	
		# The action expects a page: parameter...
  	root 'pages#show', page: 'home'
  		
  	get '/pages/:page', to: 'pages#show'
	
	end
	```
	
- Note that in the majority of cases, you will be able to just specify the `controller#action` without parameter(s).

- Refresh!

---
## Final Questions
- **What is a _static_ page?**

- **Assuming this entry in _routes.rb_:**
  **`get '/cars', to: 'cars#index'`**
  **what code would be run if the user browsed to `localhost:3000/cars`?**

- **What route in _routes.rb_ could we define if we wanted the URL of**

  `localhost:3000/`

  **to run the code in**`cars#index`? 

---
## References
- [Rails Guide - Routing from the Outside In](http://guides.rubyonrails.org/v4.2/routing.html)
