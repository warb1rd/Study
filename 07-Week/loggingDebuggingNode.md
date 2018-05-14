# Logging & Debugging in NodeJS

## Lesson Objectives:

1. Understand error handling in the Node console
2. Use the console to log events
3. Set up a basic web server to learn about debugging​

------

# Why Do We Log To The Console?

##### Building off of the experience we gained in project 2, what were some of the issues that were faced in trying to get our apps to work?

1. Variables were showing as 'undefined' in our views
2. Syntax errors all over the place
3. Database connection issues (Postgres wasn't running)

The errors we got from Rails, as ominous and frighteningly red as they were, were the only way we could learn what was expected from us for our code to work. Without them, we'd be shooting in the dark.

When building software applications, the errors we see in the console and the screen are the only way for us to debug. There's no faster way of understanding how our apps are working in development, and there's no better way to isolate the data we want to use in the control flow of our apps, than by learning how to log and debug in our console.

##### So why should we use the console?

1. See the format of our database records, and what fields they contain
2. Make sure variables are being scoped properly
3. Understand what's happening in our control flow, in the order that we expect

Node, unlike Rails, can operate asynchronously. It's event-driven, which means when we present data to a user, we want to make sure that data is retrieved, processed and presented in a certain order before we serve it to them. Likewise, we want to make sure when a user sends our app some data, we can receive it, process it, and react to it in a certain order.

##### The console allows us to make sure this is happening how we expect it.

## Let's demonstrate this in a new Node application

First let's create a basic blank Node application in our workspace:

``` bash
mkdir node-logging-debugging
cd node-logging-debugging
touch main.js
npm init
code .
```

In `main.js`, let's look at how logging works:

``` javascript
// main.js
console.log('Hello World!')
```

The syntax is really no different than writing a log method for a front-end application. The only difference is that instead of seeing "Hello World!" in our browser's console, we'll be looking at it in the terminal window. Let's demonstrate that:

``` bash
node main.js
# Hello World!
```



------

Harking to when we created full CRUD-enabled Rails applications, let's recap some of the things we used to display data: 

ActiveRecord allowed us to retrieve database records (such as user information) and store single users as ruby objects, or multiple users as arrays of objects. In order to make sure we could access that data and display them on a view the way we wanted to, we would run Rails Console and look at the data straightaway. No different in Node! 

##### Why don't we test that:

In `main.js`, build an array of objects and log it!

``` javascript
myArray = [
	{name: "Jeff", email: "jeff@gmail.com", age: 29},
	{name: "Jill", email: "jill@gmail.com", age: 32},
	{name: "Boris", email: "boris@gmail.com", age: 19}
]

console.log(myArray)
```

Then run `node main.js` again, and you should see the array in the terminal.

The same thing goes for logging bits of information out of an array, or an object:

``` javascript
console.log(myArray[0].name)
```

will give you `Jeff`.

And finally, the value that a function returns can also be logged to the node console, unsurprisingly:

``` javascript
function myFunction() {
	return "The returned value of my function!";
}

console.log(myFunction());
```

## Take 5 Minutes:

Write your own function, and log its returned value to the node console.

------

# Errors! Oh No!

Errors in Node may not seem as straightforward and helpful as the ones provided by Rails, but with enough practice you'll be able catch on to how they work, and they'll be much easier to handle.

Here, I've intentionally created a syntax error, to show how it logs in Node's console:

``` javascript
consle.lg(myFunction();
```

The error output looks like this (pay particular attention to the first few lines of the error, as they are typically the most descriptive:

``` bash
/Users/ENDIGO/workspace/node-practice/installing-stuff/index.js:5
console.lg(myFunction();
                      ^

SyntaxError: missing ) after argument list
```

In reality, this is VERY helpful. It gave me the filename, the line number and the type of error.

- on the first line of the error: `/Users/ENDIGO/workspace/node-practice/installing-stuff/index.js:5`
  `index.js:5` means the error occurred on line 5 of index.js

- the next two lines:

  ```bash
  console.lg(myFunction();
                        ^
  ```

  literally point to where the error was found

- Finally, a description of the error: `SyntaxError: missing ) after argument list`

------

Now that we've established that logging / debugging can be just as straightforward in node as it is in the browser, let's use a built-in Node package called `http` to create a simple Node server, making sure (and learning HOW) it works using the console.

Since it's a built-in Node Module, we don't need to install it from the terminal. We simply need to import, or `require()` it in our app code:

``` javascript
var http = require('http')
// console.log the http module to see what it is:
console.log(http)
```

You should see a **HUGE** object with tons of properties, including a bunch of methods. Don't worry, you won't need to learn all of these. We'll just be using *some* of the methods this `http` module gives us to create our own web server in Node:

``` javascript
var http = require('http');
var server = http.createServer(function(request, response){
	response.writeHead(200, {'Content-Type': 'text/html'})
	response.end('<h1>Welcome to my Node App!</h1>');
});
server.listen(3000);
```

#### Run the code

This time, when you run `node main.js`:

You may notice that the terminal window doesn't exit from the process it's running!

What's happening here? We're using `http`'s `.createServer()` and `.listen()` methods to construct basic server, with a generalized event handler for anyone that visits localhost:3000. We respond to those requests with a message that's formatted as HTML.

BUT, all we see in the console is that our command prompt is gone. Like it's waiting for something to happen. We'd like to know when our server spins up. Luckily, the `.listen()` method can also be used with a callback that fires when the server runs, so we can modify the code a bit:

``` javascript
// main.js
// ...
server.listen(3000, function(){
  console.log('Our server is running on port 3000! Hazawww!')
});
```

Given the event-based functional programming style we use in Node, we can safely apply the same logic to let us know whenever a request is being made to our app:

``` javascript
// main.js, add a console.log() to our server callback:
// ...
var server = http.createServer(function(request,response){
	response.writeHead(200, {'Content-Type': 'text/html'})
	response.end('<h1>Welcome to my Node App!</h1>');

  	// log each request
	console.log('A request was made...');
});
// ...
```

After making the above changes to your code, you'll need to make sure you restart the Node process to have it re-run the new code. 

Exit out of the Node process with `ctrl + c`, then restart it with `node main.js`

You'll see the console print out `Our server is running on port 3000! Hazawww!`, and when you refresh `localhost:3000` in your browser...

Are you seeing 2 messages in the console saying 'A request was made?' that's because your browser is secretly sending a second request for a 'favicon' image. Totally normal, but we might not have never known that was happening if not for the console.

##### NOTE: If you run a Node application with `node <filename>`, you'll always need to restart the process manually when you make changes to your code. Pretty soon, we'll learn about a way to not have to do this.

### Request and Response objects

The request and response parameters we're using in our callback are objects, (just like the example we used earlier, but much larger), which can also be logged in the console. Let's try it out by changing our code, restarting our server, and refreshing the page:

``` javascript
// main.js
// ...
var server = http.createServer(function(request,response){
	response.writeHead(200, {'Content-Type': 'text/html'})
	response.end('<h1>Welcome to my Node App!</h1>');
	
	//log each request
	console.log(request);
});
// ...
```

It's huge! And although we can ignore a lot of the information contained here, we can make great use of some of it to see the nature of every request. For instance, we can log the path being used with `request.url` or the http method, with `request.method`

We can build a simple but descriptive log with these request object properties to get an accurate reading of what and where from a user is requesting:

``` javascript
console.log(request.method, request.url);
```

Finally, we can see when the request was made by creating a readable-formatted timestamp for our log:

``` javascript
var timestamp = new Date().toLocaleString();
console.log(request.method, request.url, timestamp);
```

### Takeaway:

The majority of what we will want to log to our console will be centered around the things our users are trying to create / read / update / destroy, and the data we want to send back to them.

### Before we wrap, basic routing with raw JS:

You'll notice that when we fire up our server, we're ready to send an html or text message back to the user, but it's the same message no matter what url they are visiting. We can use the `request.url` property to conditionally show different things depending on the url they GET to. This is a basic, albeit messy way to route a node application. Consider our current `.createServer()` callback:

``` javascript
var server = http.createServer(function(request,response){
	response.writeHead(200, {'Content-Type': 'text/html'});
	response.end('<h1>Welcome to my Node App!</h1>');
	
	//log each request
	var timestamp = new Date().toLocaleString();
	console.log(request.method, request.url, timestamp);
});
```

**How would you modify this to display different content to a user depending on the route they choose? Take 5 minutes and write down some ideas**

With some simple `if` statements, or even `switch` statements, we can make this possible. An example of a primitively routed node `http` server might look like this:

``` javascript
var server = http.createServer(function(request,response){

	// route our requests
	if(request.url === '/') {
		response.writeHead(200, {'Content-Type': 'text/html'});
		response.end('<h1>Welcome to my Node App!</h1>');	
	} else if(request.url === '/about'){
		response.writeHead(200, {'Content-Type': 'text/html'});
		response.end('<h1>This is the about page!</h1>');
	} else {
		response.writeHead(404, {'Content-Type': 'text/html'});
		response.end('<h1>Sorry, page not found!</h1>');
	}
	
	//log each request
	var timestamp = new Date().toLocaleString();
	console.log(request.method, request.url, timestamp);
});
```

Soon, you'll get a clearer picture of how we can work with built-in + third-party node packages to make our code better, more functional, and efficient. Routing with the Express package will make routing WAY easier and cleaner than the above code.

"As always you need to first see how these things work manually, before getting into the tools that do heavy lifting for you. Otherwise, it won't make sense and you'll be dependent on those tools"