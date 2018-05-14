 # Intro to Ruby

------

Lesson Objectives:

- A brief history of Ruby
- EVERYTHING's an object
- IRB / PRY as a testing ground

------

## A Brief History Of Ruby:

> Ruby is a dynamic, reflective, object-oriented, general-purpose programming language. It was designed and developed in the mid-1990s by Yukihiro "Matz" Matsumoto in Japan.
>
> According to its creator, Ruby was influenced by [Perl](https://en.wikipedia.org/wiki/Perl), [Smalltalk](https://en.wikipedia.org/wiki/Smalltalk), [Eiffel](https://en.wikipedia.org/wiki/Eiffel_(programming_language)), [Ada](https://en.wikipedia.org/wiki/Ada_(programming_language)), and [Lisp](https://en.wikipedia.org/wiki/Lisp_(programming_language)). It supports multiple [programming paradigms](https://en.wikipedia.org/wiki/Programming_paradigm), including [functional](https://en.wikipedia.org/wiki/Functional_programming), [object-oriented](https://en.wikipedia.org/wiki/Object-oriented_programming), and [imperative](https://en.wikipedia.org/wiki/Imperative_programming). It also has a [dynamic type](https://en.wikipedia.org/wiki/Dynamic_type) system and automatic [memory management](https://en.wikipedia.org/wiki/Memory_management).
>
> Matsumoto has said that Ruby is designed for programmer productivity and fun, following the principles of good user interface design. At a Google Tech Talk in 2008 Matsumoto further stated, "I hope to see Ruby help every programmer in the world to be productive, and to enjoy programming, and to be happy. That is the primary purpose of Ruby language." He stresses that systems design needs to emphasize human, rather than computer, needs:
>
> > Often people, especially computer engineers, focus on the machines. They think, "By doing this, the machine will run fast. By doing this, the machine will run more effectively. By doing this, the machine will something something something." They are focusing on machines. But in fact we need to focus on humans, on how humans care about doing programming or operating the application of the machines. We are the masters. They are the slaves.

------

## IRB / PRY As A Testing Ground:

From now on, when we refer to the console, we will need to differentiate between the Browser Console (the one we use to test and debug our front-end code), and the terminal console, which we'll use to test our dynamic back-end code.

You'll see a lot of similarities (and some differences) between the terminal console and the browser console, but as an intro, this will feel very familiar:

Open up a terminal window, and run `irb`:

```bash
irb(main):001:0>
```

You should see something like the above, which indicates that we are in the 'Interactive Ruby' console. You can run any kind of ruby code from right here, just like the browser's JavaScript console.

```bash
irb(main):001:0> 5 + 5
=> 10
irb(main):002:0> 100 / 10
=> 10
irb(main):003:0> "Hello!".length
=> 6
```

------

## Everything is an Object in Ruby:

An often tough topic to grasp when learning Ruby, is that in Ruby, everything is an object.

EVERYTHING. Which means a few things to consider… There are no functions. Weird right? Since everything in Ruby is an object, including the 'global scope', any function you write is by definition a METHOD of its enclosing object. including the Ruby global scope itself. It's like you're writing code in a little universe, and that universe is ALSO an object.

------

## Variables:

In JS, we covered variable assignment and scope, which allowed us to store data, easily refer to it, and block access to it depending on where and how the variable is created. All programming languages have some sort of variable assignment, but they each behave slightly different. The first difference we'll notice in ruby is that there are different TYPES of variables:

```ruby
# local variables:
variable_name = value

# instance variables:
@something = value

# class variables:
@@some_other = value

# global variables:
$variable_name = value
```

We'll cover the differences, but let's for now focus on instance variables and local variables, because they are the most common types we'll start using and together, they can accomplish the same scoping we achieved with JavaScript. Some examples of these below:

------

## Methods:

Remember, everything is an object in Ruby, so whenever you write a 'function', you're actually writing a method of an object. Here's what a Ruby method looks like:

```ruby
def my_first_method
  puts "Hello World!"
end
```

This method simply prints "Hello World!" to the console. To invoke it, simply refer to it:

```ruby
my_first_method
=> "Hello World"
```

This will ALWAYS invoke the method. Unlike JavaScript where adding parentheses invokes the function/method, ruby works a bit different. 

Also, if no `return` statement is used in a method, the last line will always implicitly be used as a return statement. Here's an example:

```ruby
def my_second_method
  "Yo! How goes it?"
  "Not bad, you?"
end

puts my_second_method
=> "Not bad, you?"
```

------

## Data Types:

### Booleans

```ruby
true
false
```

Just like in JavaScript! `true` and `false`, which are used to drive the control flow of our applications.

### Numbers

```ruby
567
123
1
0
```

### Strings

```ruby
"Hello World!"
"Goodnight Moon!"
" "
""
```

Any set of characters that exist within quotes!

### Arrays

```ruby
[true, "Hello", 20]
```

### Hashes

In short, think of hashes in Ruby the way we think of object literals in JavaScript, they are associative arrays (groups of key/value pairs):

```ruby
main_guy = {name: "John Snow", age: 24}
```

One big difference though, is the way in which we access properties of hashes. We don't use the same javascript 'dot' notation (`main_guy.name`). To get properties of a hash, we use the following syntax:

```ruby
main_guy[:name]
=> "John Snow"

main_guy[:age]
=> 24
```

But! We can use that syntax to SET new values for properties as well, just like JS:

```ruby
main_guy[:is_king] = true
```



## Writing Ruby:

Create a Ruby file (the file extension for Ruby files is `.rb`):

```bash
touch first_ruby.rb
```

Open the file in your text editor, and write the following:

```ruby
def hello_to name
  "Good afternoon, " + name
end

puts hello_to "Jimmy"
```

Now let's run this file from the terminal:

```bash
ruby first_ruby.rb
=> "Good afternoon, Jimmy"
```

### What do you notice? Compare this to javascript by writing the equivalent function in JS, and calling it to produce the same results...
