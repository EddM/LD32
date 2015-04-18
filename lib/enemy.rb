class Enemy < Entity
  include AffectedByGravity

  def draw
    projectiles.each(&:draw)
  end

  def update
    apply_gravity
    projectiles.each(&:update)
  end
end
