[Click here to view as a presentation](https://presentations.generalassemb.ly/e4a2445216746d1fde4c6f5e93782bec#/1)

---

<img src="https://i.imgur.com/VpVcZeQ.png">

# Control Flow in JavaScript

---
## Learning Objectives
- Know what is "truthy" and "falsey" in JavaScript

- Use the `if...else` statement to perform branching

- Use the `for` statement to perform looping

- Use the `while` statement to perform looping

---
## Roadmap                             

- What is Control Flow? (5 mins)

- Conditional Expressions - (15 mins)

- Branching Statements (15 mins)

- Looping Statements (15 mins)

- Closing Questions (5 mins)

- Practice Exercises (20 mins)

- Bonus Material

---
## Lesson Setup
- We will use  [repl.it](https://repl.it/) to work with the concepts and complete the exercises in this lesson. Be sure to choose JavaScript as the language.

---
## What is Control Flow?
>#### "The execution sequence of instructions in a program determined at run time with the use of control structures"

---

### Basic Types of Control Flow

- **Sequence**:
	- Statements execute one at a time in sequence.

- **Branching**:
	- Different code paths are executed based upon a conditional expression.

- **Looping**:
	- Code is repeatedly executed while a condition is truthy.

---

## Conditional Expressions
- In JavaScript, what is considered to be True/Truthy & False/Falsey?

- Comparison Expressions

---
### What is True/Truthy & What is False/Falsey?

- To test what is truthy and what is falsey, let's type the following code into JS Bin:

	```js
	if (true) {
	  console.log('truthy!');
	} else {
	  console.log('falsey!');
	}
	```

- **?: Clicking the `Run` button at this point will always print what to the console?**

- Now we can easily test expressions by typing it in the place of `true`. 


- Why this _truthy_ and _falsey_ business? Why not just use _true_ and _false_?

- Answer: _Truthy_ and _falsey_ are JavaScript's attempt to treat non-boolean expressions as booleans (`true` or `false`) at runtime.

- For example, the number `3`, is considered to be _truthy_ - test it out.


- Most things in JS are _truthy_, so it's easier to remember what's _falsey_...

- There are two datatypes that are always falsey:<br>`null` and `undefined`

- There are four values that are falsey:<br>`false`, `0` (zero), `NaN` (special value of number), and an _empty string_ (FYI, a string with a value of a space is not empty).

- Everything else is truthy!

- **Take a couple of minutes to test a few of the above.**

---
### The Not Operator

- The _not operator_ (`!`), also known as the "bang" operator, "flips" a true or truthy expression to the boolean value of `false`, and vice-versa.  For example, test the following expressions:

	```js
	!false === true // true
	!null === true // true
	!3 === false // true
	!'' === true // true
	```

- A double `!` operator is a great way to force an expression into its actual boolean value of `true` or `false`:

	```js
	console.log(!!3); // outputs true
	```

---

### Boolean Logic: Comparison Operators

- Let's review these Comparison Operators that you saw in the pre-work:
	- **`===`** (strict equality - best practice)
	- **`==`** (performs type conversion (called coercion) if necessary)
	- **`!=`**
	- **`<`**
	- **`>`**
	- **`<=`**
	- **`>=`**

- Now let's review these Logical Combinators:
	- **`||`**
	- **`&&`**

---
### Conditional Expressions
- The `if`, `for` and `while` statements all require a _conditional expression_. For example:

	```js
	var x = 1;
	while (x <= 10) {
	  var msg = 'Item ' + x;
	  console.log(msg);
	  x++;
	}
	```
	Where, `x <= 10` is the conditional expression.
	
- **?: If `x <= 10` was replaced with just `x`, would it still be considered a valid conditional expression?**

---
## Review Questions
- **Name the two datatypes that are considered to be falsey in JavaScript.**

- **Name the four values that are considered to be falsey in JavaScript.**

- **Is an "empty" object (an object with no properties) truthy or falsey?**

- **What value does `!!0` equal?**

---
## The `if..else` Branching Statement
- As you saw in the pre-work, the `if` and the optional `else` clause allows us to conditionally execute code.

---
### The `if` Branching Statement: Single Path

- Single path `if`:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	```js
	if (val === 1) {
	  console.log('This code will run only if val equals 1');
	}
	```

- Conditional expression must be surrounded by parens.

- If you have only a single statement that needs to execute, you can write that statement without using curly braces (used to define a block statement):

	```js
	if (val === 1) console.log('This code will run only if val equals 1');
	```
	This code is the same as the example above.

---
### The `if..else`(dual path)
- Dual paths `if` with `else`:

	```js
	if (val === 1) {
	  console.log('val is one');
	} else {
	  console.log('val is not one');
	}
	```

---
### The `if..else` (three or more paths)

- If you have three or more code paths use `if` with as many `else if` statements as necessary and optionally a final `else`:

	```js
	if (val === 1) {
	  console.log('val is one');
	} else if (val === 2) {
	  console.log('val is two');
	} else if (val === 3) {
	  console.log('val is three');
	} else {
	  console.log('not one, two, or three');
	}
	```

- Any questions regarding branching with `if...else`?

---
### Exercise - Branching Statements
- Write the `if...else` statement that console.logs the following based upon the value of a variable named `color`:
	- If the value is `green`, log `Go`
	- If the value is `yellow`, log `Slow`
	- If the value is `red`, log `Stop`
	- If the value is anything else, log `Whatever`

---

## Looping Statements 
- Looping statements provide us with the ability to execute a block of code multiple times while a conditional expression is truthy.

- We'll take a look at these statements:

	- **`while`**

	- **`do while`**

	- **`for`**

---
### Looping Statements: `while`

- The first looping statement we'll look at is `while`:

	```js
	var word = '';
	var words = [];
	while (word !== 'end') {
	  word = prompt('Enter a word ("end" to quit)');
	  if (word !== 'end') words.push(word);
	  console.log("You've entered: " + words.join(', '));
	}
	```

- Use `while` when you want to continue to execute a block of code _while_ a condition is true.

- Beware of infinite loops!

---
### Looping Statements: `do…while`

- You may choose to use the `do...while` statement instead of `while` to force the code block to always execute at least once.

	```js
	var step = 1;
	do {
	  console.log('Step ' + step);
	  step++;
	} while (step < 6);
	```

- Again, beware of infinite loops!

---
### Looping Statements `for`

- The next looping statement we'll look at is the `for` statement:

	```js
	var colors = ['red', 'white', 'blue'];
	for (var idx = 0; idx < colors.length; idx++) {
	  console.log(colors[idx]);
	}
	```

- Notice the `for` loop has three parts after the _for_ keyword:
	- The _initializer_ which runs only once before looping begins. It is usually used to declare and initialize a looping variable, but can be any statement.
	- The _condition_ which will be evaluated before each loop. If truthy, the code block will execute.
	- The last part will execute after each loop and is typically used to increment or decrement the looping variable.

---
### Looping Statements `break`

- Use the `break` statement within any `while` or `for` loop to immediately exit the code block and execute code following it.

	```js
	var word = '';
	var words = [];
	while (word !== 'end') {
	  word = prompt('Enter a word ("end" to quit)');
	  if (word !== 'end') {
	  	words.push(word);
	  } else {
	  	break;
	  }
	  console.log("You've entered: " + words.join(', '));
	}
	```
	
---

### Question - Looping Statements
- **When using a `while` or `do...while` loop, we must be careful not put the program's execution into an __________ loop.**

- **How can we avoid the above scenario?**

---

## Closing Questions

I'll give you a couple of minutes to review the following questions, meanwhile, I'll warm up the picker :)

- **In your own words, how would you describe _Control Flow_?**
- **The three primary types of _control flow_ are:**
  1. ?
  2. ?
  3. ?
- **What looping statement ensures that its code block is executed at least once?**

---

## Practice Exercises
#### Exercise 1 - Branching

- The following JavaScript code will accept string input from the user and store the string in a variable named `choice`:

	```js
	var choice = prompt('Enter a, b or c');
	```

	 **Write an `if` statement that 	`console.logs` the following messages**:
	- _a_ entered - "a is for apple"
	- _b_ entered - "b is for banana"
	- _c_ entered - "c is for cantaloupe"
	- anything else - "you're a rebel"

---

### Practice Exercises
#### Exercise 2 - Looping
- **Use one of the looping statements to continue to execute the code you wrote in the previous exercise until the phrase _no more fruit_ is entered by the user.**

---
## Bonus Material

---
### Ternary Operator

- The _ternary_ operator is ideal when you need to return one of two values depending upon a condition:

	```js
	var message = score > 100 ? "You rock!" : "Keep trying!";
	```
	
	The above one line of code replaces this code:
	
	```js
	var message;
	if (score > 100) {
	  message = "You rock!";
	} else {
	  message = "Keep trying!";
	}
	```

- It can also be used to evaluate one of two expressions, so you can actually run a method if you'd like:

	```js
	score > 100 ? gameWinner() : gameLoop();
	```

---
### `switch` Statement
- Look into using the `switch` statement instead of `if...else` if you have more than three code paths and your conditionals always check the same variable.

- Here's the documentation for the [switch statement](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/switch)
