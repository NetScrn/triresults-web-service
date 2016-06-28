class Event
  include Mongoid::Document
  field :o, type: Integer, as: :order
  field :n, type: String, as: :name
  field :d, type: Float, as: :distance
  field :u, type: String, as: :units

  embedded_in :parent, polymorphic: true, touch: true

  validates_presence_of :order, :name

  def meters
    case units
    when "miles"
      distance / 0.000621371
    when "kilometers"
      distance / 0.001
    when "yards"
      distance * 0.9144
    when "meters"
      distance
    end
  end

  def miles
    case units
    when "meters"
      distance * 0.000621371
    when "kilometers"
      distance * 0.621371
    when "yards"
      distance * 0.000568182
    when "miles"
      distance
    end
  end
end
