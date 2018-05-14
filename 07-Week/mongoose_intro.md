# Mongo-backed Models with Mongoose

### Objectives
*After this lesson, students will be able to:*

- Update & destroy a model
- Initialize & create a new instance of a model
- Perform basic find queries
- Reference other documents in an instance of a model
- Work with embedded and referenced documents with Mongoose

### Preparation
*Before this lesson, students should already be able to:*

- Describe how Mongo documents work
- Describe how an ORM works
- Create a basic NodeJS app

## Using MongoDB with Node - Intro (5 mins)

NodeJS and MongoDB work really well together. To handle HTTP requests and read from or send data to MongoDB, Mongoose is the most common Node.js ORM to manipulate data using MongoDB: CRUD functionality is something that is necessary in almost most every application, as we still have to create, read, update, and delete data.

Since we'll be able to use JSON across our application - with Mongo and Node - using JavaScript in our application is much easier. The MERN stack - Mongo, Express, React, and Node - is becoming increasingly popular because of this.

For today, we will build a simple Node app in a folder and a file app.js.

#### What Is Mongoose?

Mongoose is an object modeling package - think ORM for Node this gives us the MongoDB CRUD commands.

## Setting up Mongoose in your app - Codealong (5 mins)

Create a new Express app and install the relevant npm packages:

1. `mkdir family-tree`
2. `cd family-tree`
3. `touch app.js`
4. `npm init`
5. `npm install express morgan bodyparser`

To use Mongoose in your Node app:

```bash
$ npm install mongoose
```

With the package installed, lets use it - open app.js and add:

```javascript
const
	express = require('express'),
    app = express(),
    logger = require('morgan'),
    mongoose = require('mongoose')

mongoose.connect('mongodb://localhost/family-tree', (err) => {
  console.log(err || "Connected to MongoDB")
})

app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))
```

You can now execute all the mongoDB commands over the database `family-tree`.


## Working with Models - Codealong (20 mins)


#### Defining a Model

We must build a Mongoose Model before we can use any of our new CRUD operations think of the models as constructors we define, documents we can persist to and request from our database. Just like a `schema.rb` file, our Mongoose Schema is what we'll use to define our document attributes. Think about it like this: a document is the equivalent of a record/row in a relational database only here, our attributes - or columns - are flexible.

One large different from Rails/Sinatra: we can define methods in our Mongoose schema!

From within our family-tree app:

```bash
mkdir models
touch models/User.js
```

Now, in `models/User.js` let's add:

```javascript
const mongoose = require('mongoose')
const userSchema = new mongoose.Schema({
  first_name: String,
  last_name: String,
  email: { type: String, required: true, unique: true },
  meta: {
    age: Number,
    website: String,
    address: String,
    country: String,
  }
}, {timestamps: true})
```

MongoDB is schemaless, meaning: all the documents in a collection can have different fields, but for the purpose of a web app, often containing validations, it's better to use a schema that will cast and validate each type.

At the moment we only have the schema, representing the structure of the data we want to use. To save some data, we will need to make this file a Mongoose model and export it:

```javascript
//in user.js
const mongoose = require('mongoose')
const userSchema = new mongoose.Schema({
  first_name: String,
  last_name: String,
  email: { type: String, required: true, unique: true },
  meta: {
    age: Number,
    website: String,
    address: String,
    country: String,
  }
}, {timestamps: true})

const User = mongoose.model('User', userSchema)

// make this available to our other files
module.exports = User
```

Notice that you can use hashes and nested attributes inside a hash.

Here's a look at the datatypes we can use in Mongoose documents:

- String
- Number
- Date
- Boolean
- Array
- Buffer
- Mixed
- ObjectId

Also, notice we create the Mongoose Model with `mongoose.model`. Remember, we can define custom methods here - this would be where we could write a method to encrypt a password.

#### Creating Custom Methods

When defining a schema, you can add custom methods and call these methods on the models.  You can even overwrite the default Mongoose document methods.  Anyway, let's write a `sayHello` function under our schema:

```javascript
const userSchema = new mongoose.Schema({
  first_name: String,
  last_name: String,
  email: { type: String, required: true, unique: true },
  meta: {
    age: Number,
    website: String,
    address: String,
    country: String,
  }
}, {timestamps: true})

userSchema.methods.sayHello = function() {
  console.log(`Hi, my name is ${this.first_name}`)
}

const User = mongoose.model('User', userSchema)

module.exports = User
```

Now we can call it by requiring the User model in app.js:

```javascript
const User = require('./models/User.js')

// create a new user called chris
const gerry = new User({
  first_name: 'Gerry',
  meta:{
    age: 27
  }
})

gerry.sayHello()
```

Now run the app with `node app.js` to see the result!

## Interacting with MongoDB's CRUD - Demo (15 mins)

Let's hope into an interactive shell and test out CRUD functionality.  To do this, from our app directory, we'll have to type in `node` and then require our Models manually.

#### Create

We'll create two users using the User method from before, along with the default save method from Mongoose:

```javascript
const User = require('./models/user')

const newUser = User({
  first_name: 'gerry',
  email: 'gerry@gmail.com',
  password: 'password',
})

// save the user
newUser.save(err => {
  if(err) console.log(err)
  console.log('User created!')
})
```

#### What about Read?

Just like ActiveRecord, we can use the JavaScript equivalent of `.all`, `.find_by_`, and `.find` to get a hold of what we're looking for.

Inside `app.js` let's add:

```javascript
// Find All
User.find({}, (err, users) => {
  if(err) console.log(err)
  console.log(users)
})
```

...and just like `.find_by_` in ActiveRecord, you'll get the first record that matches the attributes defined, but in Mongoose, it's `.find`:

```javascript
//Find One
User.find({ first_name: 'gerry' }, (err, user) => {
  if (err) console.log(err)
  console.log(user)
})
```

The ActiveRecord equivalent of `.find` is `.findById`:

```javascript
// get a user with ID of 28945hskr4298rysdk
User.findById("28945hskr4298rysdk", (err, user) => {
  if (err) console.log(err)
  console.log(user)
})
```

#### Update

For update, you can do it in one of two ways (that are super easy!) - using `.findByIdAndUpdate()` or `.findOneAndUpdate()`:

```javascript
User.findOneAndUpdate({ first_name: 'gerry' }, { meta: { age: 26 } }, (err, user) => {
  if (err) console.log(err)

  console.log(user)
})
```

#### Destroy

Mongoose gives you two easy methods to delete documents - `findByIdAndRemove()`and `.findOneAndRemove()`.

```js
// find the user with id 4
User.findOneAndRemove({ first_name: 'gerry' }, (err) => {
  if (err) console.log(err)
  console.log('User deleted!')
})
```

