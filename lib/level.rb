require "json"

class Level
  attr_reader :tiles, :enemies

  def initialize(name)
    @player = Player.new(self, 0, 650)
    @camera = [0, 0]
    filename = "res/levels/#{name}.json"
    @json_data = JSON.parse File.open(filename).read
    layout_filename = "res/levels/#{@json_data["layout"]}"
    @layout = File.open(layout_filename).read.split("\n").map { |row| row.split("") }
    build_layout
    @background = Gosu::Image.new($window, "res/backgrounds/#{@json_data["background"]}", false)
  end

  def height_in_tiles
    @layout.size
  end

  def width_in_tiles
    @layout.max_by(&:size).size
  end

  def width
    @width ||= width_in_tiles * Tile::Size
  end

  def height
    @height ||= height_in_tiles * Tile::Size
  end

  def update
    @player.update
    @enemies.each(&:update)

    @camera = [
      [[@player.x - (GameWindow::Width / 2), 0].max, width - GameWindow::Width].min,
      [[@player.y - (GameWindow::Height / 2), 0].max, (height - GameWindow::Height)].min]
  end

  def draw
    $window.translate(-@camera[0], -@camera[1]) do
      @tiles.each(&:draw)
      @enemies.each(&:draw)
      @player.draw
    end

    @background.draw parallax_offset(@background.width, GameWindow::Width, width, @camera[0]),
                     parallax_offset(@background.height, GameWindow::Height, height, @camera[1]),
                     Z::Background
  end

  private

  def parallax_offset(max, size, width_or_height, camera_dimension)
    0 - (max - size).to_f / (100.0 / (100.0 / (width_or_height / camera_dimension.to_f)))
  end

  def build_layout
    @tiles = []
    @enemies = []

    @layout.each_with_index do |row, i|
      build_row(row, i)
    end

    @tiles = @tiles.flatten.compact
  end

  def build_row(row, y)
    @tiles << row.each_with_index.map do |tile_sym, x|
      if klass = Tile::Classes[tile_sym]
        tile = Object.const_get(klass).new(x * Tile::Size, y * Tile::Size)
        tile.randomize_variant! if tile.variants && tile.variants > 0
        tile
      end
    end

    row.each_with_index do |tile_sym, x|
      if tile_sym == "1"
        @enemies << SpiderEnemy.new(self, x * Tile::Size, y * Tile::Size)
      end
    end
  end
end
