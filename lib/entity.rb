require "./lib/traits/affected_by_gravity"

class Entity
  include Geometry

  attr_reader :speed, :projectiles

  def initialize(level, x, y, width, height)
    @level, @x, @y, @width, @height = level, x, y, width, height
    @projectiles = []
  end

  def update
    raise "#{self}#update not implemented"
  end

  def draw
    raise "#{self}#draw not implemented"
  end

  private

  def on_floor?
    !fits_bottom?
  end
  
  def fits_top?
    y >= 0 && !tile_above?
  end
  
  def fits_right?
    (x < (@level.width - width)) && !tile_right?
  end
  
  def fits_bottom?
    !(y >= (@level.height - height)) && !tile_below?
  end
  
  def fits_left?
    x >= 0 && !tile_left?
  end
  
  def tile_above?
    @level.tiles.any? do |tile|
      ((tile.x <= x && tile.right >= x) || (tile.x <= right && tile.right >= right)) &&
        tile.bottom == (y - 1)
    end
  end
  
  def tile_right?
    @level.tiles.any? do |tile|
      tile.y <= mid_point_y &&
        tile.bottom >= mid_point_y &&
        tile.x >= right &&
        tile.x <= (right + speed)
    end
  end
  
  def tile_left?
    @level.tiles.any? do |tile|
      tile.y <= mid_point_y &&
        tile.bottom >= mid_point_y &&
        tile.right >= (x - speed) &&
        tile.right <= x
    end
  end

  def tile_below?(threshold = 1)
    @level.tiles.any? do |tile|
      ((tile.x <= x && tile.right >= x) || (tile.x <= right && tile.right >= right)) &&
        tile.y >= (bottom + 1) &&
        tile.y <= (bottom + 5)
    end
  end
end
