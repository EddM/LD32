class SpiderEnemy < Enemy
  MoveRange = 64

  def initialize(level, x, y)
    super(level, x, y - 144, 78, 144)
    @images = Gosu::Image.load_tiles($window, "res/spider.png", 78, 144, false)
    @base_x = x
  end

  def update
    super

    if !@moving
      @moving = [:left, :right].sample if rand > 0.95
    else
      move
    end
  end

  def draw
    @images[sprite_index].draw x, y, Z::Enemy
  end

  private

  def move
    if @moving == :left
      @facing = :left
      if @x <= (@base_x - MoveRange)
        @moving = nil
        return
      else
        @x -= speed
      end
    else
      @facing = :right

      if @x >= (@base_x + MoveRange)
        @moving = nil
        return
      else
        @x += speed
      end
    end
  end

  def sprite_index
    if @facing == :left
      if @moving
        Gosu.milliseconds % 2 == 0 ? 0 : 1
      else
        0
      end
    else
      if @moving
        Gosu.milliseconds % 2 == 0 ? 2 : 3
      else
        2
      end
    end
  end

  def speed
    3
  end
end
