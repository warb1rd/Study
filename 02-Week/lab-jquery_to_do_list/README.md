# To Do List

You come home from work to a sink full of dishes... again. It's your roommate's significant other's kid's chore, but somehow they can never remember to do it. (How they even use that many dishes in a day, we can't figure out.)

![](http://universe.byu.edu/wp-content/uploads/2015/02/dirty-dishes-1.jpg)

But this won't be you tonight.

![](https://media.giphy.com/media/atADH5jFQTIru/giphy.gif)

Your roommate's significant other's kid's says that they'd be on top of their chores if only they had a **to do list** but all the ones on their phone aren't quite right, blah blah blah. 

They've actually taken a first step and had a web designer create a static HTML/CSS template for you to work off of ([starter code can be found here!](./starter-code)) 

But you're a developer now! You can make a custom to do list just for them! And that's way more fun than doing that sink full of dishes!

## The Objective: Make it work!
- When roommate's significant other's kid (henceforth referred to as RSK) types a new to do into the form input and hits submit:
	1. A new to do item needs to be **prepended** to the list
	2. The input field needs to be cleared to allow him to enter another to do
- When RSK clicks on the to do item in the list: 
	1. If the to do item is being marked complete, format the text in the to do item with a line through it ([hint](https://www.w3schools.com/cssref/pr_text_text-decoration.asp))
	2. If the to do item is being marked incomplete, show the text without a line through it
	3. **Bonus** Use a checkbox to add and remove the linethrough
- RSK wants to be able to 'favorite' some of his to do items:
	1. Clicking on a 'star' icon in each item should toggle the star yellow and black
	2. Hint: the web designer created a CSS class to make the stars yellow, you just need to write the JavaScript to make it work!
- Click on the 'X' button in a to do item:
	1. This should remove the to do item from the list
	2. **Bonus** Animate the to do item fading out or sliding up before removing it from the DOM

### Tips:
- Use jQuery [event delegation](https://learn.jquery.com/events/event-delegation/) to create event listeners for things that may or *may not* exist on the page yet!
- Submitting an HTML form will trigger a page load unless you use jQuery to [prevent the default form behavior](https://api.jquery.com/submit/)!
