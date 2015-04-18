class Player < Entity
  include AffectedByGravity

  JumpMax = 200

  def initialize(level, x, y)
    super(level, x, y, 54, 92)

    @images = Gosu::Image.load_tiles($window, "res/robbie.png", 64, 92, false)
  end

  def update
    move
    apply_gravity unless @jump
    check_entity_collisions

    if @jump
      @y -= jumping_speed
      @jump += jumping_speed

      if @jump >= JumpMax
        @jump = nil
      end
    end
  end

  def draw
    @images[sprite_index].draw x, y, Z::Player
  end

  def move
    @moving = nil

    if $window.button_down?(Gosu::KbD)
      @facing = :right
      @moving = :right
      @x += speed if fits_right?
    end
    
    if $window.button_down?(Gosu::KbA)
      @facing = :left
      @moving = :left
      @x -= speed if fits_left?
      @moving = true
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

  def check_entity_collisions
    damage! if @level.enemies.any? do |enemy|
      enemy.intersects? self
    end
  end

  def damage!
    puts "ouch"
  end

  def sprite_index
    timing_offset = Gosu.milliseconds % 1000

    if @facing == :left
      !@moving && !@jumping && timing_offset > 250 && timing_offset < 500 ? 5 : 4
    elsif @facing == :right
      !@moving && !@jumping && timing_offset > 250 && timing_offset < 500 ? 3 : 2
    else
      0
    end
  end

  def speed
    @jump ? 3 : 4
  end

  def jumping_speed
    8
  end
end
