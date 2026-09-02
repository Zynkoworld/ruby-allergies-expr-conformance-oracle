class Allergies
  ALLERGENS = %w(eggs peanuts shellfish strawberries tomatoes chocolate pollen cats)

  def initialize(score)
    @score = score
  end

  def list
    ALLERGENS.select do |item|
      allergic_to?(item)
    end
  end

  # This project uses a concept called bitflagging where each new allergen
  # is a power of 2. If you want to see how this works, try using to_s(2)
  # to turn @score into a binary string. `@score.to_s(2) #=> 100010` when
  # @score == 34. The first 1 is chocolate, the second 1 is peanuts. 32 + 2
  # == 34.
  # This works because even if all the allergens below 'cats' were active,
  # their total value would be 127.
  def allergic_to?(item)
    index = ALLERGENS.index(item)
    # Use a Binary AND to see if this allergen's bit is active or not.
    @score & (2**index) > 0
  end
end

require 'json'
__exprs = JSON.parse("[\"Allergies.new(0).list\", \"Allergies.new(1).list\", \"Allergies.new(2).list\", \"Allergies.new(8).list\", \"Allergies.new(3).list\", \"Allergies.new(5).list\", \"Allergies.new(248).list\", \"Allergies.new(255).list\", \"Allergies.new(509).list\", \"Allergies.new(257).list\"]")
__out = []
__exprs.each do |e|
  begin
    __out << {ok: true, v: eval(e)}
  rescue => ex
    __out << {ok: false, e: ex.class.to_s}
  end
end
puts JSON.generate({out: __out})
