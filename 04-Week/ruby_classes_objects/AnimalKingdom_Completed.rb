# The parent class
#####################################################

class Animal
  # class variables are used by the Class that
  # which creates objects, not the objects themselves...
  @@animal_count = 0

  # we can see and change name, alive, and age:
  attr_accessor :name, :alive, :age

  # we can see that animals eat, but we can't change that:
  attr_reader :eats

  # the initialize method runs whenever an animal is created:
  def initialize name=nil, age=0
    @name = name
    @age = age
    @alive = true
    @eats = true

    # every time an animal is created, the animal count goes up by one:
    @@animal_count += 1
  end

  # this method can be accessed with Animal.count
  # not to be confused with creating an animal
  # and having the animal object call a method
  # In other words, if nemo = Animal.new, nemo.count doesn't work:
  def self.count
    @@animal_count
  end

  # every animal can make a generic noise:
  def make_noise
    puts "Making a generic animal noise... Meep."
  end

  # every animal can also die, a sad sad truth:
  def die
    # set the animal's alive property to false,
    # and decrease the Animal class' count by 1 :(
    @alive = false
    @@animal_count -= 1
  end
end

# This class inherits all of the properties of the parent Animal class:
#####################################################

class Fish < Animal
  # every Fish object has a species that can be seen, but not changed:
  attr_reader :species

  # when creating a fish, we neclare its species and optionally give it a name.
  # If we don't give it a name, its name defaults to nil;
  def initialize species, name=nil

    # go into parent and treat name how it would be treated if this were an Animal:
    super(name)

    @species = species
  end
end

# Dog also inherits properties from Animal:
#####################################################

class Dog < Animal
  # These magical dogs can change size at any time:
  attr_accessor :size
  # We can see that dogs bark, have 4 legs, and have a breed that can't change:
  attr_reader :barks, :legs, :breed

  def initialize size, breed, name=nil
    # go into parent and treat name how it would be treated if this were an Animal:
    super(name)
    
    @size = size
    @breed = breed
    @barks = true
    @legs = 4
  end
end

#####################################################

nemo = Fish.new("Clownfish", "Nemo Del Mar")
p nemo
nemo.make_noise

ole_yeller = Dog.new(150, "Great Dane", "Ole Yeller")
p ole_yeller

p "There are #{Animal.count} animals in the world..."

ole_yeller.die
p "There are #{Animal.count} animals in the world..."
