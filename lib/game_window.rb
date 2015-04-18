require "gosu"

class GameWindow < Gosu::Window
  attr_reader :state_manager

  Width = 1280
  Height = 720

  def initialize(width = Width, height = Height, fullscreen = false)
    super
    $window = self
    self.caption = "Hi"

    SoundBank.setup

    @state_manager = GameStateManager.new
    @state_manager << GameplayState.new

    @debug_font = Gosu::Font.new(self, Gosu.default_font_name, 10)
    @debug = true
  end

  def update
    @state_manager.current.update
  end

  def draw
    draw_debug if @debug
    @state_manager.current.draw
  end

  private

  def draw_debug
    draw_quad 8, 8, Gosu::Color::BLACK,
              70, 8, Gosu::Color::BLACK,
              8, 42, Gosu::Color::BLACK,
              70, 42, Gosu::Color::BLACK,
              Z::Debug
    
    @debug_font.draw "#{Gosu.fps} FPS", 12, 10, Z::Debug
    @debug_font.draw "#{Gosu.milliseconds}", 12, 20, Z::Debug
  end
end
