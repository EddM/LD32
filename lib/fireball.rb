class Fireball
  include Geometry

  Width = 22
  Height = 12

  def initialize(parent, x, y, direction = :left)
    @parent, @x, @y, @direction = parent, x, y, direction
    @width, @height = Width, Height
    @lifespan = [300, 350, 400].sample
    @images = Gosu::Image.load_tiles($window, "res/fireball.png", Width, Height, false)
  end

  def draw
    @images[sprite_index].draw x, y, Z::Object, @direction == :left ? -1 : 1
  end

  def update
    @lifespan -= speed

    if @lifespan <= 0
      die!
      return
    end

    if @direction == :left
      @x -= speed
    else
      @x += speed
    end
  end

  def die!
    @parent.projectiles.delete(self)
  end

  private

  def sprite_index
    Gosu.milliseconds % 2
  end

  def speed
    6
  end
end
