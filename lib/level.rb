require "json"

class Level
  def initialize(name)
    @player = Player.new(0, 700)
    @camera = [0, 0]
    filename = "res/levels/#{name}.json"
    @json_data = JSON.parse File.open(filename).read
    layout_filename = "res/levels/#{@json_data["layout"]}"
    @layout = File.open(layout_filename).read.split("\n").map { |row| row.split("") }
    build_layout
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

    @camera = [
      [[@player.x - (GameWindow::Width / 2), 0].max, width - GameWindow::Width].min,
      [[@player.y - (GameWindow::Height / 2), 0].max, (height - GameWindow::Height)].min]
  end

  def draw
    $window.translate(-@camera[0], -@camera[1]) do
      @tiles.each(&:draw)
      @player.draw
    end
  end

  private

  def build_layout
    @tiles = []

    @layout.each_with_index do |row, i|
      draw_row(row, i)
    end

    @tiles = @tiles.flatten.compact
  end

  def draw_row(row, y)
    @tiles << row.each_with_index.map do |tile_sym, x|
      if klass = Tile::Classes[tile_sym]
        tile = Object.const_get(klass).new(x * Tile::Size, y * Tile::Size)
        tile.randomize_variant! if tile.variants.size > 0
        tile
      end
    end
  end
end
