class Point
  attr_accessor :longitude, :latitude
  def initialize(point)
    case point
    when Point
      point
    when NilClass
      nil
    when Hash
      @longitude, @latitude = point[:coordinates]
    end
  end

  def mongoize
    {type: "Point", coordinates: [@longitude, @latitude ]}
  end

  class << self
    def mongoize(point)
      case point
      when Point
        {type: "Point", coordinates: [point.longitude, point.latitude ]}
      when NilClass
        nil
      when Hash
        point
      end
    end

    def evolve(point)
      case point
      when Point
        {type: "Point", coordinates: [point.longitude, point.latitude ]}
      when NilClass
        nil
      when Hash
        point
      end
    end

    def demongoize(point)
      case point
      when Point
        point
      when NilClass
        nil
      when Hash
        Point.new(point)
      end
    end
  end
end
