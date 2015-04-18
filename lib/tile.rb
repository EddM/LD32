class Tile
  attr_reader :x, :y, :variants

  Classes = {
    "_" => :SolidGroundTile
  }

  Size = 64

  def initialize(x, y, tileset = Tileset.default)
    @x, @y, @tileset = x, y, tileset
  end

  def randomize_variant!
    raise "#{self}#randomize_variant! not defined"
  end

  def image
    raise "#{self}#image not defined"
  end

  def draw
    puts x
    puts y
    puts "*"
    image.draw x, y, Z::Objects
  end
end
