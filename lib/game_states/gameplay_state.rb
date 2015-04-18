class GameplayState < GameState
  def initialize
    @level = Level.new(:factory)
  end

  def draw
    @level.draw
  end

  def update
    @level.update
  end
end
