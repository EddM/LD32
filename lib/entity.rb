class Entity
  attr_reader :width, :height, :x, :y

  def initialize(x, y, width, height)
    @x, @y, @width, @height = x, y, width, height
  end

  def update
    raise "#{self}#update not implemented"
  end

  def draw
    raise "#{self}#draw not implemented"
  end
end
