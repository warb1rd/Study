

![](https://i.imgur.com/vUOu9NW.jpg)
# Intro to ExpressJS

---

## Learning Objectives

- Create a Basic App From Scratch With the Express Framework

- Configure an Express Application's Settings


---
## Roadmap
- Intro to Express
- Setup our App
- Express "Hello World"
- Basic Structure of an Express App
- Our First Route
- The Route's Callback Function
- Define a Simple Route (Practice)
- Request Parameters
- Query String Values


- Ways to Respond to a Request

---
### Express Framework - Intro
- Express is the most popular web framework for Node.js.

- It is minimalistic and lightweight, especially when compared to a massive framework such as Rails.

- Express uses Node's built-in HTTP server, but extends its capability by giving us the ability to:
	- Define Routes
	- Add functionality with third-party Middleware
	- Define our own Custom Middleware
	- Use View Engines to Render Views

### Setup our App
- Create a folder and cd into it:

	```sh
	$ mkdir first-express
	$ cd first-express
	```
	
- Create our `package.json`. Accept the defaults, **except** for the **entry point** - set this to be "**server.js**":

	```sh
	$ npm init
	```

- `code .`


---
### Install the Express Module
- Use `npm` to install the Express module in this project:

  ```sh
  $ npm install express
  ```

- Create a `server.js` to put our web app's main code in:

  ```sh
  $ touch server.js
  ```

---
### Express - Hello World!

- To test our setup, let's make our app return "Hello World!" when we browse to `localhost:3000`.  In `server.js`:

	```js
	// Load express
	var express = require('express');
	
	// Create our express app
	var app = express();
	
	// Define a root route directly on app
	// Later, we will use the router object
	app.get('/', function(req, res) {
	  res.send('<h1>Hello World!</h1>');
	});
	
	// Tell the app to listen on port 3000
	app.listen(3000, function() {
	  console.log('Listening on port 3000');
	});
	```


- Run the app:

	```sh
	$ node server
	```
	
- Browsing to `localhost:3000` will hit our app's root route that we defined and return "Hello World!".


---
### Basic Structure of Express App

- Here is a helpful outline of what we need to do in our main Express app file - let's put this guide right in our `server.js`:

	```js
	// Require modules
	var express = require('express');
	
	// Create the Express app
	var app = express();
	
	// Configure the app (app.set)
	
	
	// Mount middleware (app.use)
	
	
	// require and mount (app.use) routes

	
	// Tell the app to listen on port 3000
	app.listen(3000, function() {
	  console.log('Listening on port 3000');
	});
	```

---
### Update Our First Route

- Now let's update our route to return "Hello Express" instead of "Hello World":

	```js
	app.get('/', function(req, res) {
	  res.send('<h1>Hello Express</h1>');
	});
	```

- If you refresh the page, you'll see that it still says "Hello World!" - what's up?  Well, unlike with Rails, Node does not automatically restart the server for us when we make changes to our code.

- Of course there are utilities to perform the restart for us, but until we install one later this week, get used to stopping the server with `control-c` and restarting it.


- Looking at our first route in our editor, note that we are defining a route using the `get` method on the Express `app` object. Later, we will learn a preferred way of defining routes using the Express `Router` object, but you need to be aware of defining routes this way because you will see it quite often.

- Besides the `get` method, there are other methods such as `post`, `put` and `delete`, that map to the other HTTP verbs.


- In the case of our first route, we have specified a HTTP method of `get` and a path of `/`.

- Only HTTP **get** requests matching a path of `/` (root path) will invoke the callback function.

	```js
	app.get('/', function(req, res) {
	  res.send('<h1>Hello Express</h1>');
	});
	```

---
### The Route's Callback
- Again, looking at our first route:

	```js
	app.get('/', function(req, res) {
	  res.send('<h1>Hello Express</h1>');
	});
	```

- The route's callback function will be executed if a matching HTTP request (HTTP Verb + Path) comes along.


- This is just JS, and so instead of an anonymous function for the callback, we could also use a named function if we wished:

	```js
	app.get('/', handleRoot);
	
	function handleRoot(req, res) {
		res.send('<h1>Hello Express</h1>');
	}
	```


- The route's callback function defines two parameters, the first representing the [request](http://expressjs.com/en/api.html#req) object, the second the [response](http://expressjs.com/en/api.html#res) object:

	```js
	app.get('/', function(req, res) {
	  res.send('<h1>Hello Express</h1>');
	});
	```

- These two arguments are automatically provided to the callback by Express.
  - The `request` object has properties and methods pertaining to the HTTP request and we use the `response` object primarily to send back our app's response to the request.


- Because they are just parameter names, you can change them. For example, feel free to use `request` for `req` and `response` for `res`:

	```js
	app.get('/', function(request, response) {
	  response.send('<h1>Hello Express</h1>');
	});
	```

---
### Practice: Define a Simple Route
- Define another route that matches a `get` request to a path of `/goodbye` that sends a text response of "Goodbye World".

- Don't forget to restart the server and test your new route by browsing to `localhost:3000/goodbye`.

---
### Question - Basic Routing
- **Is it okay to define more than one route on the same path? For example:**

	```js
	app.get('/cars', function(req, res) {
  	res.send("Here's a list of my cars...");
	});
	
	app.post('/cars', function(req, res) {
  	res.send('Thanks for the new car!');
	});
	```

---
### Request Parameters
- Remember the `params` hash in Rails? Well, the _request_ object in Express has a `params` object.

- However, it **only** contains the parameters contained in _named routes_:

- Let's add another route:

	```js
	app.get('/goodbye/:name', function(req, res) {
  	res.send('Goodbye ' + req.params.name);
	});
	```


- Restart and check it out in your browser:

	```sh
	localhost:3000/goodbye/PeeWee
	```

- **For what purpose did we commonly use _named parameters_ in routes in Rails?**

- Now, instead of using `params[:id]` like you did in Rails, you'll use `req.params.id` in an Express app.

---
### Query String Values
- Who remembers **what a `query string` is?**

- In Express, we can access them in our route handlers using the `query` object attached to the _request_ object. Let's modify our root route to try this out:

	```js
	app.get('/', function(req, res) {
		var msg = req.query.msg ? req.query.msg : '!';
  		res.send('<h1>Hello Express ' + msg + '</h1>' );
	});	
	```

- **What can we type in the address bar to test this out?**

---
### Body Data in the Request
- Later you'll see that data being sent in the HTTP request's body, for example, the data being posted from a form, will be accessed via `req.body` thanks to the `body-parser` middleware (more on this later). 

- In summary, **how is accessing _named parameters_ in routes, _query string_ key/value pairs, and _data in the body_ different in Express than what we saw in Rails?**

---
### Ways to Respond to a Request

- So far we have responded in our route handler (callback) code by using the `send` method on the _res_ (response) object.

- Here is a list of other methods that can be used to terminate the request/response cycle:
  
  - `res.redirect()` -	Redirect a request
  - `res.render()` - Render a view template
  - `res.json()` - Send a JSON response
  - `res.jsonp()` - Send a JSON response with JSONP support
  - `res.send()` - Send a response of various types
  - `res.sendFile()` - Send a file as an octet stream

- The most commonly used are the first three.

---
### Ways to Respond to a Request (cont.)
- Let's change our `/goodbye` route to return `json` instead of plain text:

  ```js
  app.get('/goodbye', function(req, res) {
  		res.json( {msg: 'Goodbye World'} );
  });
  ```

- Try it out!
