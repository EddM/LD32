module AffectedByGravity
  GravityFallSpeed = 3

  def apply_gravity
    unless tile_below?
      @y += GravityFallSpeed
    end
  end
end
