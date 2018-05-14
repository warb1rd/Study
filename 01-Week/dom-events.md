[Click here to view as a presentation](https://presentations.generalassemb.ly/3e7f8d1f6c73f917d5a041d4da611383#/1)

---

<img src="https://i.imgur.com/VLwvpbl.jpg" width="900">

---

## Learning Objectives
Students will be able to:

- Add event handlers for events such as `click`
- Explore the event object
- Explain event bubbling
- Stop an event from bubbling

---
## Roadmap
- What are DOM events?
- What's an _event handler_?
- Our first _event handler_
- The event object
- Creating a new element
- Event bubbling
- Event delegation
- Removing event listeners

---
### What are DOM Events?
- DOM events are the bedrock of interactivity on web pages.

- DOM events enable us as developers to implement _event-driven programming_. This programming paradigm is such that much of our code, written as _event handlers_, runs in response to events being triggered during run-time.

- Events are being generated when a user moves the mouse, clicks the mouse, presses a key, when the page has loaded, when timer's timeout, etc.

- Take a gander [here](https://developer.mozilla.org/en-US/docs/Web/Events) at the type and sheer number of events.

---
### What's an Event Handler?

- An _event handler_ is a function, often referred to as a _callback function_, that is called when an event is triggered.

- Here is the common pattern for _registering_ an event handler for a given event:

  **element.addEventListener(\<event-name>, \<callback>, \<use-capture>);**

  - **event-name** is the name of the event (string)
  - **callback** is the function we want executed when the event happens. When called, it will be passed an _event object_ as an argument.
  - **use-capture** is a boolean and is optional. It has to do with _event phases_. We won't need to worry about it in WDI but if you want to know more, read the [Event Phases section of this article](https://www.smashingmagazine.com/2013/11/an-introduction-to-dom-events/). 

---
### Our first Event Handler
- We'll use [CodePen](http://codepen.io/) today to experiment with events.

- After opening a new pen, add the following HTML:

	```html
	<h3>Comments</h3>
	<ul>
	  <li>WDI Rocks!</li>
	</ul>
	<input>
	<button>Add Comment</button>
	```


- When we click the _Add Comment_ button, we want to create a new comment with the text entered in the input and then clear the input.

- We can add a **`click`** event listener to pretty much any element - not just buttons.  However, buttons come pre-styled to look and act clickable :)

- We're going to use an anonymous callback function in this first example:

	```js
	var btn = document.querySelector('button');
	btn.addEventListener('click', function(evt) {
	  // testing!
	  console.log(evt);  
	});
	```


- If all goes well, clicking the button should log out the _event object_.

- Congrats, hooking up an event listener is that easy!

---
### Review Questions
- **What is the name of the method that we use to create event handlers to elements?**

- **What is that method's _signature_?**

- **Name three types of events.**

---
### The _event object_
- Examining the _event object_ that was provided as an argument to our event handler reveals lots of useful information.

- Of special interest are:
	- Several _...X_ and _...Y_ properties that provide where the click occurred.
	- The _target_ property which holds a reference to the DOM element that was clicked.  Note that JS's _this_ keyword will also point to this element.

---
### Creating a new `<li>` element

- If we want to add a new comment, we're going to need to create a new `<li>` element.

- Here's how we can do it using the `document.createElement` method:

	```js
	btn.addEventListener('click', function(evt) {
	  var li = document.createElement('li');
	  console.log(li)
	});
	```

---
### Creating a new Comment
- Okay, we have the new `<li>` element created and assigned to a variable named `li`, but it has no no content.

- We want to get whatever text the user types into the `<input>` element. I know you know how to select the `<input>` and `console.dir` it out, but I need you to find the property that holds what the user has typed into it - do it now - yell it out when you find it!  Google if you must!


- So, now we can set the `textContent` of the new `<li>`:

  ```js
  btn.addEventListener('click', function(evt) {
    var li = document.createElement('li');
    var inp = document.querySelector('input');
    li.textContent = inp.value;
  });
  ```

Now our new &lt;li&gt; is ready to be added to the DOM.
Which element do we we need to add it to?

- There are several ways to add DOM elements to the document dynamically.

- A common approach is to add new elements to another element using the `appendChild` method like this:

	```js
	  li.textContent = inp.value;
	  // new code below
	  document.querySelector('ul').appendChild(li);
	});
	```
	Note that the new element is appended as the last child.


- Test it out - nice!

- The new comment has been added, but we have one more task - clear out the `<input>`.

- One line of code is all it takes - you got this!

---
### Event bubbling
- When an event occurs on an element, that event, whether it is listened to on that element or not, _bubbles_ up through the DOM, all the way to the `document` object.

<img src="https://i.imgur.com/B7f5PAZ.png" width="900">

- All event handlers registered for the same event, such as `click`, along the path to the `document` object will be called, unless one of those handlers calls the _event object_'s `stopPropagation` method.

- Why does JS bubble up (propagate) its events?...

---
### Event Delegation

- Imagine a web app, like a game perhaps, with lots of elements that need to respond to a click. It's possible there could be tens, hundreds or more of these elements.

- That would be a lot of listeners, wouldn't it - not very efficient at all.

- Event bubbling allows us to implement what's known as **_event delegation_**.

- **_Event delegation_** allows us to register a single event handler that can respond to events triggered by any of its **descendants**.  Much more efficient!


- Let's register a handler (this time for kicks we'll use a named function) on the `<ul>` that can respond to clicks on any of its `<li>`s:

	```js
	document.querySelector('ul')
	  .addEventListener('click', handleClick);
	
	function handleClick(evt) {
	  console.log(evt);
	}
	```

- Notice that the event object's _target_ property is correctly set to the **actual** element that was clicked.


- Not only is _event delegation_ more efficient, by it's very design, it's dynamic - as descendants are added, they too will be listened to!

- Without _event delegation_, you would have to register a handler every time a new element, such as our comment `<li>` is added. 

**Practice: Write the code to change the color of the text of a clicked comment.**

---
### Removing event listeners
- It's possible to remove an added event listener, however, only if a named function was used as the callback:

  ```js
  btn.removeEventListener('click', clickHandler);
  ```
  This would remove the 'click' event handler (`clickHandler`) that was registered on the `btn` element like this:
  `btn.addEventListener('click', clickHandler);`

---
### Practice

- Add a `<div>` on the page and style it so that has:
	- A width of 300px
	- A height of 200px
	- Its `background-color` set to yellow
	- A border of `border: solid orange 10px;`

- Register an event handler on the `<div>` to listen to the `mousemove` event.

- The callback function should display the x and y coordinates inside of the `<div>` (see next slide for example).

- Try using different location properties such as clientX/Y and offsetX/Y.

---

<img src="https://i.imgur.com/LxsT1iD.png" width="500">

---
## References
- [Event Developer Guide on MDN](https://developer.mozilla.org/en-US/docs/Web/Guide/Events)