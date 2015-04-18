class GameState
  def update
    raise "#{self}#update not implemented"
  end

  def draw
    $window.state_manager.previous.draw unless exclusive?
  end
end
