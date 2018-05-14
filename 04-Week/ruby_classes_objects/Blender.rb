class Blender
  attr_reader :model, :manufacturer
  attr_accessor :condition

  @@blender_count = 0

  def initialize model, manufacturer, condition="new"
    @model = model
    @manufacturer = manufacturer
    @condition = condition

    @@blender_count += 1
  end

  def blend ingredients
    ingredients.join.split('').shuffle.join
  end

  def self.count
    @@blender_count
  end
end

christmas_gift_for_mom = Blender.new("Nutribullet 5000", "David Avocado Wolf")

groceries = ["pineapples", "carrots", "mangos"]
p christmas_gift_for_mom.blend(groceries)
