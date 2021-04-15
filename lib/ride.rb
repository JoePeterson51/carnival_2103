class Ride
  attr_reader :name, :cost
  def initialize(attributes_hash)
    @name = attributes_hash[:name]
    @cost = attributes_hash[:cost]
  end
end