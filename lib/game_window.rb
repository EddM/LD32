require "gosu"

class GameWindow < Gosu::Window
  attr_reader :state_manager

  Width = 1280
  Height = 720

  def initialize(width = Width, height = Height, fullscreen = false)
    super
    $window = self
    self.caption = "Hi"

    @state_manager = GameStateManager.new
    @state_manager << GameplayState.new
  end

  def update
    @state_manager.current.update
  end

  def draw
    @state_manager.current.draw
  end
end
