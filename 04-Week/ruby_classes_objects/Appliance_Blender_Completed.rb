class Appliance
  attr_reader :model, :manufacturer
  attr_accessor :condition

  @@appliance_count = 0

  def initialize model, manufacturer, condition="new", powered=true
    @model = model
    @manufacturer = manufacturer
    @condition = condition
    @powered = powered

    @@appliance_count += 1
  end

  def self.count
    @@appliance_count
  end
end

class Blender < Appliance

  def initialize model, manufacturer, condition="new"
    super(model, manufacturer, condition)
  end

  def blend ingredients
    ingredients.join.split('').shuffle.join
  end
end

christmas_gift_for_mom = Blender.new("Nutribullet 5000", "David Avocado Wolf")

groceries = ["pineapples", "carrots", "mangos"]
p christmas_gift_for_mom.blend(groceries)
