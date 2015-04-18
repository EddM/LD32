class Player < Entity
  include AffectedByGravity

  JumpMax = 100

  def initialize(level, x, y)
    super(level, x, y, 64, 92)
  end

  def update
    move
    apply_gravity

    if @jump
      @y -= jumping_speed
      @jump += jumping_speed

      if @jump >= JumpMax
        @jump = nil
      end
    end
  end

  def draw
    $window.draw_quad x, y, Gosu::Color::AQUA, x + width, y, Gosu::Color::AQUA, x, y + height, Gosu::Color::AQUA, x + width, y + height, Gosu::Color::AQUA
  end

  def move
    if $window.button_down?(Gosu::KbD)
      @facing = :right
      @x += speed
    end
    
    if $window.button_down?(Gosu::KbA)
      @facing = :left
      @x -= speed
    end
    
    jump! if $window.button_down?(Gosu::KbW)

    # if $window.button_down?(Gosu::KbS)
    #   @facing = :down
    #   @y += speed
    # end
  end

  def jump!
    if !@jump && tile_below?
      @jump = 0
    end
  end

  private

  def speed
    3
  end

  def jumping_speed
    6
  end
end
