class SolidGroundTile < Tile
  def initialize(x, y, tileset = Tileset.default)
    super
    @variants = 2
    @variant = 0
  end

  def image
    @tileset.tiles[@variant]
  end

  def randomize_variant!
    @variant += 1 if rand > 0.8
  end
end
