class Placing
  attr_accessor :name, :place
  def initialize(placing)
    if Hash === placing
      @name = placing[:name]
      @place = placing[:place]
    end
  end

  def mongoize
    {name: @name, place: @place}
  end

  class << self
    def mongoize(placing)
      case placing
      when Placing
        {name: placing.name, place: placing.place}
      when Hash
        placing
      when NilClass
        nil
      end
    end

    def evolve(placing)
      case placing
      when Placing
        {name: placing.name, place: placing.place}
      when Hash
        placing
      when NilClass
        nil
      end
    end

    def demongoize(placing)
      case placing
      when Placing
        placing
      when NilClass
        nil
      when Hash
        Placing.new(placing)
      end
    end
  end
end
