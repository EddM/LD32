require "gosu"

class GameWindow < Gosu::Window
  attr_reader :state_manager
  def initialize(width, height, fullscreen)
    super
    $window = self
    self.caption = "Hi"

    @state_manager = GameStateManager.new
    @state_manager << GameplayState.new
  end

  def update
  end

  def draw
  end
end
