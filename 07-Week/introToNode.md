[Click to view this presentation.](https://presentations.generalassemb.ly/2c139ff7a8fd59fcb82d#/1)

---

![](https://i.imgur.com/hA8ZNev.png)

# Intro to Node.js

---

## Learning Objectives
- Explain the Use Case for Node.js

- Use Node.js to Execute JavaScript

- Create and Use Modules

- Use NPM to Install External Packages

---

## Roadmap
- Transitioning to Unit 3
- Facts about Node.js
- Why the Enthusiasm for Node?
- Rails or Node?
- Why is Node so Performant?
- Using Node to Execute JavaScript
- Node.js Modules
- Our First Module
- NPM - Node Package Manager

---

### Transitioning to Unit 3
- In _Unit 2_, you begun your journey of becoming a full-stack developer.

- Although we're heading off the Rails, rest assured that much of what you've learned applies to full-stack development as a whole...

 The following concepts we've covered in class will continue to serve you well:

 - OOP - Design, Encapsulation of Data (attributes) & Behavior (methods) and Inheritance)
 - HTTP and the Browser-Request/Server-Response Cycle
 - MVC (Model/View/Controller) Architectural Pattern
 - RESTfull Routing & Mapping to Data CRUD
 - Relational Data Modeling
 - Data Manipulation using an ORM such as ActiveRecord
 - Server-side View Templating
 - Authentication & Authorization
 - Deployment

---

### So, We're Going Off the Rails
<img src="https://i.imgur.com/fV6QIiT.jpg" style="width:950px">

---

### Unit 3 - Technologies
- In _Unit 3_, we will delve into the world of:
  - **Node.js** - An _operating environment_ that executes our old friend - JavaScript
  - **Express** - The most popular web framework for Node.js
  - **MongoDB** - A _NoSQL_, _document_-based database system

- The three technologies above account for three of the four technologies involved in the **MEAN** and **MERN** [Solution Stacks](https://en.wikipedia.org/wiki/Solution_stack).

---

### Heading for a Train Wreck? - No, but...
- Learning new technologies is always a challenge.

- Secondly, Node/Express, unlike with Rails, does not subscribe to the _Convention over Configuration_ methodology, which translates into:
  - More code to write to accomplish even the most basic of tasks
  - Wildly varying ways to structure applications
  - More complexity - thanks to more flexibility
  - Varying degree of modularization of code

- Basically, Node/Express apps are the...

---

![](http://www.wrlsweb.org/desoto/wp-content/uploads/2015/04/wild-wild-west-sign-banner_213473.jpg)

---

# What is Node.JS?

---

<img src="http://www.nikola-breznjak.com/blog/wp-content/uploads/2014/10/scepticKid.jpg" height="700">

---

### Facts about Node.js
- An open source, cross-platform, **runtime environment** that executes JavaScript, primarily on the server-side.

- Created in 2009 by Ryan Dahl with Joyent, Inc.

- Written primarily in _C++_, not JS!

- Uses Google's _V8 JavaScript Engine_ to compile JS programs into machine code.


- The runtime environment for JS is different in Node than that in the browser, primarily because **there is no DOM.**

- Although Node.js is primarily thought of as a runtime for server-side JavaScript, it is also used extensively for running client-side utility programs.

---

### Node's REPL

- Let's take a look at Node's interactive [Node's REPL](https://nodejs.org/api/repl.html) (Read-Eval-Print-Loop). Think of Node's REPL as Node's version of Ruby's IRB. Typing `node` in terminal launches it:

```sh
$ node
> 10 + 5
15
> function sayHello() {
... console.log('Hello');
... }
undefined
> sayHello()
Hello
undefined
> var http = require('http');
undefined
> http
[ a large JS object representing Node's 'http' module ]
```
Press `control-c` twice to exit REPL.

- Node is an open source project governed by the _Node.js Foundation_ with board representation from companies such as:
  - PayPal
  - Microsoft
  - Google
  - GoDaddy
  - IBM
  - Red Hat
  - Intel
  
- There is also a Technical Steering Committee independent from the Board.


- Extremely lightweight. Only low-level "core" modules for networking, filesystem access, etc. are baked-in.

- Node's functionality is extended via open source libraries called packages. Packages usually contain a _module_ of code that we can _require_ (use) in our own modules, but sometimes a package installs command line interface (CLI) tools.


- Packages are to Node, as Gems are to Ruby. 

- Packages are managed using a package manager called _npm_ which is installed with Node.

- Node's package ecosystem is the largest open source ecosystem in the world.

---

### Why the Enthusiasm for Node?
- First and foremost, **performance** - businesses can handle more traffic with less hardware!

- Secondly, developer **synergy**. Because a developer can use JS on client & server, becoming a full-stack dev is more obtainable and companies can better utilize their developer resources across the front and back-ends.


- The improvements in server performance and developer productivity result in **businesses saving money**.

- Businesses saving money results in **wide adoption**:

![](https://i.imgur.com/5nvUBa3.jpg)

- Wide adoption of Node results in more **demand for Node developers**:

<img src="https://i.imgur.com/etppWiG.png" width="900">

## Rails or Node?

---

### Why Choose Rails?
- Quickest path to building an app with full CRUD.

- Better at working with complex data relationships - ActiveRecord rocks!

- When full page refreshes aren't an issue.

- Easier to program because synchronous programming is more straightforward than async programming.

---

### Why Choose Node?
- JavaScript everywhere!

- When high performance and high capacity matter.

- Designed with modern realtime, mobile and Single Page Applications in mind - easier to avoid full page refreshes.

### Why is Node so Performant?

- First, it's important to understand how time consuming and "expensive" data Input/Output operations are:

<img src="https://i.imgur.com/iXshhYh.jpg" width="900">

- Node's **Asynchronous / Event-driven** design enables **non-blocking** Input/Output:

<img src="https://i.imgur.com/ARbweHg.jpg" width="800">

- This technical jargon basically results in a Node server capable of supporting _tens of thousands_ of concurrent connections!

- For more information, check the references at the end of this presentation.

---

### Synchronous vs. Asynchronous
##### Rails (Synchronous Programming)

- Each line of code must finish before the next line is executed. Sounds logical until you consider if the line of code involves an I/O operation (network, database, or file system call) that your program will spend most of its time waiting until the I/O operation is completed.

##### Node.js (Asynchronous Programming)
- Node is asynchronous and non-blocking, that means that it is designed not wait for those notoriously slow I/O operations to complete before it moves on.

- Your friend, the **callback function**, enables this pattern. When our code calls a method involving I/O, we also provide a callback function to be, well, "called back", when the I/O operation is complete.

### Questions - What is Node.js?
- **True or false - Node itself is written in JavaScript.**

- **Is Node.js a programming language?**

- **What is the primary reason why Node/Express applications are so performant?**

- Is `var elem = document.getElementById('my-list');` a valid JavaScript statement in a Node app?

#### Now that you've learned the use case for Node, let's see how it can run JavaScript programs

## Using Node to Execute JavaScript
Let's see how we can run a JavaScript program in Node:

```sh
$ mkdir first-node
$ cd first-node
$ touch main.js
$ subl .
```

Toss in a little JavaScript into `main.js`

```js
function multiply(x, y) {
  return x * y;
}

var n = multiply(5, 8);

console.log(n);
```

Now use Node to run `main.js`

```sh
$ node main
40
```

Note how you don't need to include the "js" file extension.

---

### Practice (5 mins)

### Use Node to Execute JavaScript

- To practice, and to help get back into the JavaScript "mindset", replace the code in `main.js` with code that:

  - Defines an empty array named `fives`.
  - Uses a `for` loop to loop through the numbers 1 through 100.
  - Within the loop's code block, if the current value of the loop variable is evenly divisible by 5, add it to the `fives` array.
  - After the loop has completed, `console.log` the `fives` array.

- Use Node to execute your program.

#### So far, so good! Now let's learn about `Modules`

---

### Node.js Modules
- Modules in Node allow us to organize and reuse JavaScript code.

- Node itself comes with several **core modules**, such as the `http` and `fs` modules.

- There are thousands of open-source modules available.


- In our own programs, we organize our code into modules.

- Each module will be contained in its own file - there is a one-to-one mapping between a file and a module.

- You can put your app's custom module files in any folder within your project. This allows us to organize our code inside folders named `models`, `routes`, etc.

<img src="https://i.imgur.com/UxiEYUJ.png" width="950">

---

### A Module *exports* Its Functionality

- Inside of our modules, Node automatically provides a special object named `module.exports` and a "shortcut" variable that points to `module.exports` named what else - `exports`.

- We can attach our module's functionality to `module.exports` or `exports`:

	```js
	module.exports.myNumber = 123;
	// same as above
	exports.myNumber = 123;
	
	// add as many properties as you wish
	exports.sayHi = function() { console.log('Hi'); };
	```


- If we want to **assign a single piece of functionality** without using a property, be sure to use `module.exports`:

	```js
	module.exports = function() { console.log('Hi'); };
	// Below will not work due to breaking the object reference
	// exports = function() { console.log('Hi'); };
	```

- Now, a `var` that `require`s this module references the function!

---

### Using the `require()` Method
- Wherever and whenever we need to use our custom module, we just `require` the module file, without the file extension, using a relative path.

- Note that the module is loaded only once, even if it is "required" multiple times.


- `require` basically "turns into" whatever `module.exports` is. This is true whether we "attach" properties the original `module.exports` or `exports` object, or assign to it a function, array or whatever:

	```js
	// my-module attached a myNumber property to module.exports
	var myMod = require('my-module');
	console.log(myMod.myNumber);  // outputs 123
	
	// module.exports was assigned a sayHi function
	var sayHi = require('my-module');
	console.log( sayHi() );  // outputs 'Hi'
	```

---

### Modules - Remember This:
#### `require(…)` equals whatever `module.exports` is set to!!!

---

### Our First Module
- Together, let's create a module that:
  -  Provides an array named `weekdays` containing two-character names of the days of the week.
  -  Provides a function named `getWeekday` that accepts a number from
     0 to 6 and returns the name; where 0 = 'Su'.
  -  If an invalid number is passed in, assume a value of 1.

- Let's put our module inside of a "utilities" folder and name it "days-of-week.js":

  ```sh
  $ mkdir utilities
  $ touch utilities/days-of-week.js
  ```

The code will look like this:

```js
// days-of-week.js

// This is a local variable in scope to this module only
var defaultDay = 1;

// Exporting the weekdays array
module.exports.weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

// You can "attach" properties directly on "exports".
// However, "assigning" directly to exports breaks!
exports.getWeekday = function(dayNo) {
	return exports.weekdays[dayNo < 0 || dayNo > 6 ? defaultDay : dayNo];
}

console.log("days-of-week module has been loaded");
```
**Note that in Node, all variables defined are local to that module - they will not pollute the global scope.**

Use our "days-of-week" module in "main.js":

```js
// main.js
	
var dow = require('./utilities/days-of-week');
	
// Outputs the weekdays array
console.log(dow.weekdays);
	
// Outputs "Fr"
console.log(dow.getWeekday(5));
```

Run "main.js" with Node:

`> node main`

---

### Practice - Modules #1 (10 mins)
Create two separate modules:

A module named "random" that has a function **assigned** to the *module.exports* and returns a random number, as an integer, between two numbers provided, inclusive, as arguments; so that we could use it in our program like this:
```js
var random = require('./utilities/random');
for (var i = 0; i < 10; i++) {
	console.log( random(100, 200) );
}
```

---

### Practice - Modules #2 (10 mins)
A module named "circle" that exports two functions:

- `area`: Computes the area of a circle (radius squared X Pi), with the radius provided as an argument. 
- `circumference`: Computes the circumference of a circle (radius X 2 X Pi), with the radius provided as an argument. 
- Hint: This is JS, so `Math.PI` is available.

```js
var circle = require('./utilities/circle');
console.log( circle.area(50) );  // 7853.98...
console.log( circle.circumference(75) );  // 471.23...
```

---

### Questions - Modules

- **What are modules used for in Node?**

- **How many modules can be defined in a file?**

- **What is the special object we use in our module to attach or assign functionality to?**

- **How many times can we `require` a module in our program?**

- **Does the variable name we use need to match the name of the module?**


- **Will this work?**

	```js
	// in module file named add.js
	exports = function (x, y) { return x + y };
	
	// in other file
	var add = require('add');
	console.log( add(1, 2) );
	```

---

#### Now that you've created and used your own modules, let's see how we can install open-source packages and use the modules they contain

---

### NPM - Node Package Manager
- Node uses a package management system to distribute open-source packages called **N**ode **P**ackage **M**anager (_npm_).

- Usually a package distributes a Node module, however, sometimes the package distributes a CLI instead of a module we would use in our program.


- Working with packages in Node is very similar to working with gems in Ruby:


	| Ruby | Node |
	| ---- | ------- |
	| `gem install ... ` | `npm install ...` |
	| `bundle install` (works with `Gemfile`) | `npm install` (works with `package.json`)|

- Similar to how Rails has a `Gemfile` to track gems that an application depends on, Node apps have a `package.json` file that does the same thing.

- **Why is tracking an application's dependencies in a separate file important?**


- If you start a Node app from scratch, the first thing you should do is create the `package.json` file by entering the following command:

	```sh
	$ npm init
	```

- It's okay to accept all of the default settings.  To accept the defaults without being prompted, you can run the command as follows:

	```sh
	$ npm init -y
	```


- Now, let's use `npm` to install one of Node's packages:

	```sh
	$ npm install request
	```

- Take a look and you will find that a `node_modules` folder has been added to your project and that it contains a folder for the `request` module.

- Note: it's recommended that `node_modules` be added to your `.gitignore` file.


- We can now require the `request` module in our "main.js" and make HTTP requests:

```js
// Don't specify path when module is in node_modules
var request = require('request');
request('http://jsonplaceholder.typicode.com/users', function(err, res, body) {
	console.log(body);
});
```

- **Why do we need to provide a callback?**

- Note the first parameter in the callback is `err`. This "error-first" callback signature is prevalent throughout Node.

- Use Node to execute _main.js_ and check out the result!


- Examining the `packages.json` file reveals that it's structured like this...

```js
{
  "name": "first-node",
  "version": "1.0.0",
  "description": "My first node app",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "You <you@email.com>",
  "license": "MIT",
  "dependencies": {
    "request": "^2.69.0"
  }
}

```

- The `package.json` file works a like a `Gemfile` in that we can install the dependencies from it. This is almost always necessary after cloning a repo or using the starter code for a given lesson. 

- Let's delete our `node_modules` file:

	```sh
	$ rm -rf node_modules
	```


- Now we can install our app's dependencies like this:

	```sh
	$ npm install
	```
	Witness the return of `node_modules`!

---

### Conclusion
- In the next lesson, you will use one of the most popular Node modules, `Express`, that turns Node into a capable web server.

- **Questions?**

- Take a break!

---

### References
[Node.js Homepage](https://nodejs.org/)

[Node Package Manager](https://www.npmjs.com/)

[Why Do Companies Choose Node](https://strongloop.com/strongblog/why-do-companies-choose-node-performance-scalability-and-productivity/)

[Blocking/Non-Blocking, Async/Sync](http://stackoverflow.com/questions/10570246/what-is-non-blocking-or-asynchronous-i-o-in-node-js)

[Node Event Loop](https://www.youtube.com/watch?v=0fM4pRAs3BI)
