# Where In The World Is Carmen Sandiego?!

## Introduction

> ***Note:*** _This can be a pair programming activity or done independently._

We're going to use what we've learned already about searching with SQL commands, and apply it to chase down and capture an elusive and world-reknowned thief, Carmen Sandiego. Follow the clues, use the interweb - write down both the SQL commands /queries you used and your answers to the clues - and figure out where Carmen's headed, so we can catch her and bring her in.

## Exercise

#### Setup:

1. Copy this directory (including 'world.sql') to your workspace, and navigate to it in terminal.

2. Make sure the PostgreSQL server is running (the elephant in the menu bar at the top).

3. In the terminal, from the directory that contains this world.sql file run `psql` to enter the PostgreSQL shell.

4. Create the database for this exercise (titled 'world'):

   ```sql
   CREATE DATABASE world;
   ```

5. Connect to this new blank database:

   ```bash
   \c world
   ```

6. Import the data from world.sql:

   ```bash
   \i ./world.sql

   # you should see something like the following get returned:

   # BEGIN
   # SET
   # CREATE TABLE
   # CREATE TABLE
   # CREATE TABLE
   # COPY 4079
   # COPY 239
   # COPY 984
   # ALTER TABLE
   # ALTER TABLE
   # ALTER TABLE
   # ALTER TABLE
   # ALTER TABLE
   # COMMIT
   # ANALYZE
   # ANALYZE
   # ANALYZE
   ```

7. Now the 'world' database is populated. We can now use the clues below to solve the mystery. Write the SQL commands you used to follow each clue in './clues.txt'. As a start, use the `\d` command to 'describe' the database. Then, when you are shown each table in the output, you can describe each table with `\d <table_name>`. For example, if you have a table called "city", you can see its structure with `\d city`

***Pro tip: If the output of an SQL query is too long for one line, use `\x` to toggle between horizontal or vertical outputs (they call it expanded display)***

- Then, use the clues below to create the appropriate SQL queries to help you find Carmen and then, tell us where she's heading!!

  - **Clue #1:** We recently got word that someone fitting Carmen Sandiego's description has been traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed, so find the least populated country in Southern Europe, and we'll start looking for her there.

  - **Clue #2:** Now that we're here, we have insight that Carmen was seen attending language classes in this country's officially recognized language. Check our databases and find out what language is spoken in this country, so we can call in a translator to work with you.

  - **Clue #3:** We have new news on the classes Carmen attended: our gumshoes tell us she's moved on to a different country, a country where people speak *only* the language she was learning. Find out which nearby country speaks nothing but that language.

  - **Clue #4:** We're booking the first flight out: maybe we've actually got a chance to catch her this time. There are only two cities she could be flying to in the country. One is named the *same* as the country â€“ that would be too obvious. We're following our gut on this one;Â find out what other city in that country she might be flying to.

  - **Clue #5:** Oh no, she pulled a switch: there are two cities with very similar names, but in totally different parts of the globe! She's headed to South America as we speak; go find a city whose name is *like* the one we were headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!

  - **Clue #6:** We're close! Our South American agent says she just got a taxi at the airport, and is headed towards the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll follow right behind you!

  - **Clue #7:** She knows we're on to her: her taxi dropped her off at the international airport, and she beat us to the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the landing dock. Lucky for us, she's getting cocky. She left us a note, and I'm sure she thinks she's very clever, but if we can crack it, we can finally put her where she belongs – behind bars.

    > As an agent, I'll say, you've been a joy to outrun.
    >
    > And while the food here is great, and the people – so nice!
    >
    > I need a little more sunshine with my slice of life.
    >
    > So I'm off to add one to the population I find
    >
    > In a city of ninety-one thousand and now, eighty five...

  ​

#### Starter code

Again, be sure to grab the .sql file from the [starter-code](starter-code/world.sql) and run it in your PostgreSQL terminal using the commands above.

#### Deliverable

Use the clues.sql file to write in the SQL queries that correspond with each clue and tell us where she's heading at the bottom:



## Additional Resources

- [PostgreSQL tutorial](http://www.tutorialspoint.com/postgresql/)
- [PostgreSQL official documentation](http://www.postgresql.org/docs/)
