module AffectedByGravity
  GravityFallSpeed = 1

  def apply_gravity
    unless tile_below?
      @y += GravityFallSpeed
    end
  end
end
