class Tile < Entity
  attr_reader :x, :y, :variants

  Classes = {
    "_" => :SolidGroundTile,
    "#" => :SolidTile,
    "=" => :SolidFloatingTile
  }

  Size = 64

  def initialize(x, y, tileset = Tileset.default)
    @x, @y, @tileset = x, y, tileset
    @width, @height = Size, Size
  end

  def randomize_variant!
    raise "#{self}#randomize_variant! not defined"
  end

  def image
    raise "#{self}#image not defined"
  end

  def draw
    image.draw x, y, Z::Object
  end
end
