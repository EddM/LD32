class Tileset
  attr_reader :name, :size, :tiles

  def initialize(name)
    @name = name
    @tiles = Gosu::Image.load_tiles($window, "res/tilesets/#{name}.png", Tile::Size, Tile::Size, true)
    @size = tiles.size
  end

  def self.default
    Tileset.new(:default)
  end
end
