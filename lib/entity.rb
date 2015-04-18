class Entity
  attr_reader :width, :height, :x, :y

  GravityFallSpeed = 3

  def initialize(level, x, y, width, height)
    @level, @x, @y, @width, @height = level, x, y, width, height
  end

  def bottom
    y + height
  end

  def right
    x + width
  end

  def update
    raise "#{self}#update not implemented"
  end

  def draw
    raise "#{self}#draw not implemented"
  end

  private

  def apply_gravity
    unless tile_below?
      @y += GravityFallSpeed
    end
  end

  def tile_below?
    @level.tiles.any? do |tile|
      ((tile.x <= x && tile.right >= x) || (tile.x <= right && tile.right >= right)) && tile.y <= (bottom + 1)
    end
  end
end
