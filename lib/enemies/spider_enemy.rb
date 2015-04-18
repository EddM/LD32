class SpiderEnemy < Enemy
  MoveRange = 64

  def initialize(level, x, y)
    super(level, x, y - 144, 78, 144)
    @images = Gosu::Image.load_tiles($window, "res/spider.png", 78, 144, false)
    @base_x = x
    @last_fired_projectile_at = 0
  end

  def update
    super

    fire! if (Gosu.milliseconds - @last_fired_projectile_at) > 1000 && rand > 0.90

    if !@moving
      @moving = [:left, :right].sample
    else
      move
    end
  end

  def draw
    @images[sprite_index].draw x, y, Z::Enemy
    super
  end

  def fire!
    @last_fired_projectile_at = Gosu.milliseconds

    if @facing == :left
      projectiles << Fireball.new(self, x, y + 70, :left)
    else
      projectiles << Fireball.new(self, right, y + 70, :right)
    end
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
