class Player < Entity
  include AffectedByGravity

  InvincibilityTime = 2500
  JumpMax = 100

  def initialize(level, x, y)
    super(level, x, y, 54, 92)
    @facing = :left
    @images = Gosu::Image.load_tiles($window, "res/robbie.png", 64, 92, false)
  end

  def update
    move
    apply_gravity unless @jump
    check_entity_collisions

    if @jump
      @y -= jumping_speed
      @jump += jumping_speed

      if @jump >= JumpMax || !fits_top?
        @jump = nil
      end
    end
  end

  def draw
    @images[sprite_index].draw x, y, Z::Player, 1, 1, Gosu::Color.argb(invincible? ? 100 : 255, 255, 255, 255)
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
  end

  def jump!
    if !@jump && tile_below?
      @jump = 0
    end
  end

  private

  def check_entity_collisions
    damage! if @level.enemies.any? do |enemy|
      enemy.intersects?(self) ||
      enemy.projectiles.any? { |projectile| projectile.intersects?(self) }
    end
  end

  def damage!
    unless invincible?
      SoundBank.current.play! :hurt
      @invincible_until = Gosu.milliseconds + InvincibilityTime
    end
  end

  def sprite_index
    timing_offset = Gosu.milliseconds % AudioClock::BeatLength

    if @facing == :left
      !@moving && !@jumping && timing_offset > 50 && timing_offset < 200 ? 5 : 4
    elsif @facing == :right
      !@moving && !@jumping && timing_offset > 50 && timing_offset < 200 ? 3 : 2
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

  def invincible?
    @invincible_until && @invincible_until > Gosu.milliseconds
  end
end
