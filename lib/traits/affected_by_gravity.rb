module AffectedByGravity
  GravityFallSpeed = 5

  def apply_gravity
    unless tile_below?(GravityFallSpeed)
      @y += GravityFallSpeed
    end
  end
end
