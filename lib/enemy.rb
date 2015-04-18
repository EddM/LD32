class Enemy < Entity
  include AffectedByGravity

  def update
    apply_gravity
  end
end
