=begin
    
To start:
1. Open up terminal
2. Navigate to/create a folder for W04 D01
3. Create a folder called arrays_and_hashes
4. Create a file called arrays-and-hashes-lab.rb
5. Open with Visual Studio Code
6. Complete the exercises below


Notes: 
To execute the code in your VS Code file, navigate to the directory 
that holds the file and enter the following command: 

$ ruby arrays-and-hashes-lab.rb

    
=end

# Exercise 0. ------------------------------------------------------------------
    pets = [
        {
            name: "Steve",
            type: "dog",
            age: 5
        },
        {
            name: "Calvin",
            type: "snake", 
            age: 2
        }
    ]

    puts "My #{pets[1][:type]}'s name is #{pets[1][:name]}"
    puts "My " + pets[1][:type] + "'s name is " + pets[1][:name]

    pets.each do |pet|
    puts pet[:age] = pet[:age] + 1
    end

    puts pets

# Exercise 1. ------------------------------------------------------------------
    fruits = ["apple", "banana", "orange", "strawberry", "mango"]

    puts "2....."

    fruits.each do |fruit|
        puts fruit
    end

    puts "3....."

    fruits.each do |fruit|
        if fruit != "banana"
            puts fruit
        end
    end

# Exercise 2. ------------------------------------------------------------------
    array = [1, 2, 3, 4, 5, 7]

    puts array[array.length - 1]
    puts array.last
    puts array[-1]

    puts array[-2]

# Exercise 3. ------------------------------------------------------------------
    friends = ["Rachel", "Monica", "Phoebe", "Joey", "Chandler", "Ross"]
    
    puts friends.length

    puts friends.count {|friend| friend[0] == "R"}

    puts friends.sort!

    friends.push "Janice"
    print friends

    friends.delete "Janice"
    print friends
            
# Exercise 4. ------------------------------------------------------------------  
    me = {
        name: "Katie", 
        age: 30,
        hobbies: ["writing", "watching Netflix", "crafts"],
        likes_pizza?: true
    }
    puts me

    me[:birthday] = "April 29"
    puts me

    me[:hobbies].delete me[:hobbies].last
    puts me

    me.delete :age
    puts me

    me[:name] = "Pie"
    puts me

# Exercise 5. ------------------------------------------------------------------
    hash = {a: 100, b: 200, c: 300, d: 400}

    hash.each do |key, value|
        puts "The value of #{key} is #{value}"
    end

    hash.each do |key, value| 
        value = value + 50
        puts "The value of #{key} is #{value}"
    end


