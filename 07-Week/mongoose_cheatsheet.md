# Using `mongoose` to query MongoDB

Make sure the mongoose npm package is installed in your app:

```bash
npm install mongoose
```

### Connect to MongoDB:

```javascript
const mongoose = require('mongoose')
const mongoDBConnectionString = 'mongodb://localhost/jurassicpark'

mongoose.connect(mongoDBConnectionString, (err) => {
  console.log(err || "Connected to MongoDB.")
})
```

### Build a Mongoose model with a schema

In this example we'll use `Dinosaur` as the model. By first defining a schema, we can guarantee that only the keys / values we want will get saved to the collection:

```javascript
// define the schema:
const dinosaurSchema = new mongoose.Schema({
  name: String,
  species: String,
  weight: Number
})

// create the model, with a string name, and the schema that the model should follow:
const Dinosaur = mongoose.model('Dinosaur', dinosaurSchema)

// the Dinosaur model can now be used to query MongoDB:
// Dinosaur.find({}, (err, dinosaurs) => {
//  if(err) return console.log(err)
//  console.log(dinosaurs)
// })
```

### Optional: Add validators to the schema

In addition to ensuring a set structure for each document, we can also add requirements on each individual property in the schema. For example, we can make sure that:

1. each document's `name` property is `unique`
2. `species` is `required` (the document won't get saved unless a species is provided)

We modify the schema to add these requirements:

```javascript
const dinosaurSchema = new mongoose.Schema({å
  name: {type: String, unique: true},
  species: {type: String, required: true}
})

const Dinosaur = mongoose.model('Dinosaur', dinosaurSchema)
```

For more information on the types of validations you can apply to a schema, see:
http://mongoosejs.com/docs/validation.html

With a schema and a working mongoose model in place, you can begin performing CRUD actions on the database.

# Querying MongoDB with Mongoose

For documentation on all of the query + document methods built into mongoose, see:
http://mongoosejs.com/docs/guide.html

##### In the meantime, some common Mongoose Model methods include:

------

### `ModelName.find(criteria, callback)` 

Retrieve an Array of documents:

```javascript
// An empty criteria object will query all documents in a collection:
User.find({}, (err, results) => {
  if(err) return console.log(err)
  console.log(results)
})

// retrieve all users with the name 'Jimmy':
User.find({name: 'Jimmy'}, (err, results) => {
  if(err) return console.log(err)
  console.log(results)
})
```

------

### `ModelName.findOne(criteria, callback)`

Retrieve ONE document, using a criteria object like in `find()` above. It's important to remember this method will only retrieve the FIRST matching result, even if several exist in the collection:

```javascript
Tweet.findOne({authorName: 'jimbog'}, (err, tweet) => {
  if(err) return console.log(err)
  console.log(tweet)
})
```

------

### `ModelName.findById(id, callback)`

Retrieve ONE document, by its Mongo ID:

```javascript
// If you know the ID of the document:
Robot.findById("5962ed02bf9fd44b02f6436f", (err, robot) => {
  if(err) return console.log(err)
  console.log(robot)
})

// from an Express app route:
app.get('/robots/:id', (req, res) => {
  Robot.findById(req.params.id, (err, robot) => {
    if(err) return console.log(err)
    res.json(robot)
  })
})
```

------

### `ModelName.create(dataObject, callback)`

Insert a new document in a collection. Mongo will automatically assign an `_id` property to the new document:

```javascript
User.create({name: "Janice", email: "janice@gmail.com"}, (err, savedUser) => {
  if(err) return console.log(err)
  console.log(savedUser)
})

// from an Express app route, where req.body is the incoming body of data, from a form usually:
app.post('/users', (req, res) => {
  User.create(req.body, (err, savedUser) => {
    if(err) return console.log(err)
    res.json({message: "User saved!", user: savedUser})
  })
})
```

------

### `ModelName.findByIdAndUpdate(id, dataObject, options, callback)`

Update ONE document, to get the updated document (with new attributes) in the callback function, use the option `{new: true}`. Without that option set, the callback function will only expose what the document had BEFORE the update occurred:

```javascript
// in an Express app route:
app.patch('/bank-accounts/:id', (req, res) => {
  Account.findByIdAndUpdate(req.params.id, {balance: 33.42}, {new: true}, (err, updatedAccount) => {
    if(err) return console.log(err)
    res.json({message: "Account updated.", account: updatedAccount})
  })
})
```

------

### `ModelName.findByIdAndRemove(id, callback)`

Delete ONE document. The callback function exposes the deleted document:

```javascript
// in an Express app route:
app.delete('/comments/:id', (req, res) => {
  Comment.findByIdAndRemove(req.params.id, (err, deletedComment) => {
    if(err) return console.log(err)
    res.json({message: "Comment removed.", comment: deletedComment})
  })
})
```

