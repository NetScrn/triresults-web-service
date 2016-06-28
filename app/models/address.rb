class Address
  attr_accessor :city, :state, :location
  def initialize(address = nil)
    case address
    when Address
      address
    when NilClass
      nil
    when Hash
      @city = address[:city]
      @state = address[:state]
      @location = Point.new(address[:loc])
    end
  end

  def mongoize
    {city: @city, state: @state, loc: Point.mongoize(@location)}
  end

  class << self
    def mongoize(address)
      case address
      when Address
        {city: address.city, state: address.state, loc: Point.mongoize(address.location)}
      when NilClass
        nil
      when Hash
        address
      end
    end

    def evolve(address)
      case address
      when Address
        {city: address.city, state: address.state, loc: Point.mongoize(address.location)}
      when NilClass
        nil
      when Hash
        address
      end
    end

    def demongoize(address)
      case address
      when Address
        address
      when NilClass
        nil
      when Hash
        Address.new(address)
      end
    end
  end
end
