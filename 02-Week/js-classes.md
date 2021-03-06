[Click here to view as a presentation](https://presentations.generalassemb.ly/5d66a759b3842b4a06659d1d73da25b6#/1)

---

<img src="https://i.imgur.com/oY0P1r0.png" width="400">

# JS Classes

---
## Learning Objectives
Students will be able to:

- Describe the use case for _classes_
- Describe _encapsulation_ in OOP
- Define a _class_
- Instantiate a _class_
- Include and use a _constructor method_ in a class
- Define _prototype (instance)_ methods in a class
- Recognize _constructor functions_ (predecessor to classes)
- Define _static (class)_ methods
- Use _extends_ to create a _subclass_
- Use _super_ within a subclass

---
## The Use Case of Classes
---
### What Are Classes?
- In **_object oriented programming_**, we use objects to model our application's purpose.

- **Classes** (as well as their predecessor, **constructor functions**) are used to create objects.

- Think of them as little factories responsible for stamping out objects.

---
### Why Use Classes?
- We've already been creating objects using object ___________s, so why do we need classes and/or constructors?
- Because the number of a certain type of object needed by an application often varies; and classes/constructors provide a convenient way to dynamically create objects as needed.
- **Can you think of any applications where the number of objects would vary?**

---
## Encapsulation in OOP

- One of the key principles of Object Oriented Programming is **encapsulation**.

- Encapsulation is the concept of bundling data (properties) and related behavior (methods) within an object. For example:

```js
var cohort = {
  id: 'WDI',
  students: ['Mary', 'Toni', 'Fred'],
  instructors: ['Susan', 'Phil'],
  addStudent: function(name) {
    name = name[0].toUpperCase() + name.substr(1).toLowerCase();
    this.students.push(name);
  },
  pickRandomStudent: function() {
    var rndIdx = Math.floor(Math.random() * this.students.length);
    return this.students[rndIdx];
  }
};
```
---
### Review Questions
- **What does the acronym OOP stand for?**

- **In your own words, describe why Classes exist in OOP.**

- **In your own words, describe the OOP principle known as _encapsulation_.**

---
### Defining Classes in JS
- Here's a minimal class definition that does nothing but create empty objects:

  ```js
  class Vehicle {
    // Code to define the class's properties and methods
    // return is not needed - the new object is returned by default
  }
  ```

- Looks similar to defining a function because classes are in fact, _special_ functions, except...

- **What's different compared to a function?**

- **What's different about the naming convention?**

---
### Instantiating a Class
- Here's a bit more OOP vocab for you:

	- **instance**: An object created by a class

	- **instantiate**: To create an object using a class

	- **instantiation**: The process of creating an object

- In JS, we **instantiate** (create) objects using the `new` keyword when invoking the class:

	```js
	var v1 = new Vehicle();
	```
	Let's use _repl.it_ to take try out the minimal `Vehicle` class

---
### The _constructor_ Method
- When a class is being instantiated, the special `constructor` method in the class will automatically be called:

	```js
	class Vehicle {
	  constructor(vin, make) {
	    this.vin = vin;
	    this.make = make;
	  }
	}
	
	var plane = new Vehicle('X123Y', 'Boeing');
	```

- **The purpose** of the `constructor` method is to initialize the data properties of the new object being created (represented by `this`).


- Defining a `constructor` method is optional, if it is not defined, a hidden **default** `constructor` method is automatically called.

- In derived classes, the default `constructor` method is:

	```js
	constructor(...args) {
	  super(...args);
	}
	```

---
### Practice - Add a Property
- **Modify the `Vehicle` class by adding an additional property named  `model`.**

- Test it out by instantiating another object like this:

  ```js
  var car = new Vehicle('A1234', 'Toyota', 'Camry');
  ```


- When we invoke the class prefaced with `new`:
	- Behind the scenes, JS creates a shiny new object (empty) and assigns it to the `this` keyword.
	- The `constructor` method is called with the arguments we provided when invoking the class. Remember, `constructor` method is where we create/initialize properties on the new object (`this`).
	- After the `constructor` is finished executing, the class automatically returns the shiny new object.

- Although the `constructor` method is _special_ because it's called automatically, there's nothing special about how it's defined, other methods are defined the same way...

---
### Defining Methods in a Class
- There are two types of methods that can be added to a class:
  - **Prototype (instance) methods**, and
  - **Static (class) methods**

- **Prototype methods** are the most common and are available to be called by any instance of the class. 
  **What's an instance?**

- **Static methods** are methods that are called on the class itself and cannot be called by instances.


- Let's add a `start` method to our `Vehicle` class:

	```js
	class Vehicle {
	  // the constructor will always be called
	  constructor(vin, make, model) {
	    this.vin = vin;
	    this.make = make;
	    this.model = model;
	    this.running = false;  // default to false
	  }
	  start() {
	    this.running = true;
	    console.log('running...');
	  }
	}
	```

- Note that unlike within object literals, methods are not separated by a comma.

---
### Practice - Defining Methods
- **Define a `stop` method that sets the `running` property to `false` and console.logs the message "stopped..."**

---
### Overriding Methods
- Thanks to another OOP principle called _inheritance_, we inherit methods from parent classes.

- JS is different from class-based languages like Ruby or Java in that it's inheritance implementation is _prototype-based_.  We won't go into prototypes during this lesson, but if you want to learn more, [here's a good place to start](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Inheritance_and_the_prototype_chain).

- In JS, virtually every object inherits from the `Object` class and thus inherits it's methods, such as `toString`:

	```js
	car.toString() // outputs something like '[object Object]'
	```

---
### Overriding Methods
- If we define a method that already exists, we "override" it. For example, we can override the Object's `toString` method by adding it to our class:

	```js
	  // existing methods above
	  
	  toString() {
	    return 'Vehicle (' + this.vin + ') is a ' +
	      this.make + ' model ' + this.model;
	  }
	```
	and test it out.

---
### Review Questions
You've just learned how to define a class and add prototype methods to it.  This represents about 80% there is to know about classes - congrats!

A few questions before moving on:
- **What is the keyword used to define a class?**
- **What is the name of the method that is automatically called when we call the class prefaced the `new` keyword?**
- **What is the main purpose of this method?**
- **What character(s) separate the methods in a class definition?**

---
### Constructor Functions - B.C. (before classes 😀)
- Before classes brought to us by ES2015 we used _constructor functions_ to do the exact same thing as classes.

- Because of the newness of ES2015, most of the code out there is written using constructor functions, however, most new code today is likely to be written as classes.

- You need to be able to recognize _constructor functions_, so let's look at how the `Vehicle` class can be written as a constructor function...

---
### Constructor Functions

```js
function Vehicle(vin, make, model) {
  this.vin = vin;
  this.make = make;
  this.model = model;
  this.running = false;  // default to false
}
Vehicle.prototype.start = function() {
  this.running = true;
  console.log('running...');
};
// other 'prototype' (instance) methods defined like above
	
var car = new Vehicle('A1234', 'Toyota', 'Camry');
```

- Note that the constructor function is pretty much the same as a constructor method and that methods are defined on the function's prototype object.

- Also, invoking a class and a constructor function is identical.

---
### Static Methods
- Again, _static methods_ are methods that are callable on the class itself - not on its instances.

- Think of them as methods that would not pertain to a particular instance.  For example, we could design the `Vehicle` class so that it tracks every vehicle it creates.  We could then write static methods that return how many vehicles have been created, search for vehicles by their make, etc.


- Here's how to define a basic static method:

	```js
	  static about() {
	    alert("I'm a Vehicle class!");
	  }
	```
	Yup, the only difference is the `static` keyword

- As discussed, you invoke static methods on the class:

	```js
	// invoke static methods on the class
	Vehicle.about();
	
	// this will not work
	car.about();
	```

---
### Review Quesitons

- **Is there anything a class can implement that can't be done using constructor functions?**

- **When using constructor functions, where are the methods defined?**

- **What's wrong with the following code?**

	```js
	class Shape {
	  constructor(x, y) {
	    this.x = x;
	    this.y = y;
	  }
	  static about() {
	    console.log('Position is: ' + this.x + ', ' + this.y);
	  }
	}
	```

---
### Inheritance
- Earlier we spoke briefly about _inheritance_.

- In OOP, inheritance is when a "specialized" class is derived from another (parent) class, and thus inherits it's properties and methods.

- For example, a `Payment` _base_ class could have `CreditCard` & `Cash` subclasses derived from it.

---
### Inheritance

- We use the `extends` keyword to define a subclass:

	```js
	class Plane extends Vehicle {
	  constructor(vin, make, model, airline) {
	    super(vin, make, model);
	    this.airline = airline;
	  }
	  engageAutoPilot() {
	    console.log('Look Mom, no hands!');
	  }
	}
	
	var spyPlane = new Plane('secret', 'Lockhead', 'SR-71', 'USA');
	```

- The `super` method represents the parent class and is being called above to initialize the base properties using the parent's `constructor` method.


- In complex systems, it's not uncommon to have several layers of inheritance - often referred to as an object hierarchy.

<img src="https://i.imgur.com/t9eUguh.png" width="700">

---
### Practice - Inheritance
- **Define another subclass of the `Vehicle` class named `Automobile` with an additional property of `numDoors` and a `honk` method.**

- Test it out by instantiating it like this:

	```js
	var fastCar = new Automobile('TS123Z', 'Tesla', 'P100D', 4);
	```

- Hint: It's okay to copy and paste your own code :)

---
### Final Notes on Classes
- Classes can also be defined as _class expressions_.

- Unlike function declarations, class declarations are not _hoisted_ - they must be declared before using them to create objects.

- It's possible to subclass JS's built-in "classes"! For example:

	```js
	class Stack extends Array {
	  get top() {
	    return this[this.length - 1];
	  }
	}
	```

---
## References

- [Classes on MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes)

- [Prototypal Inheritance example](https://gist.github.com/jim-clark/e3fc426d73153fac6dc1)