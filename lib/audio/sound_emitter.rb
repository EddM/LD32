class SoundEmitter
  def initialize(parent, target)
    @parent, @target = parent, target
  end

  def play!(sound_name, max_distance)
    SoundBank.current.play!(sound_name, volume(max_distance), pan)
  end

  def volume(max_distance)
    distance = @parent.distance_to(@target).abs

    if distance > max_distance
      0
    else
      1.0 - (distance / max_distance)
    end
  end

  def pan
    x_distance = [(@parent.x - @target.x).abs, 100].min / 100.0

    if @target.x < @parent.x
      0 - x_distance
    elsif @target.x > @parent.x
      x_distance
    else
      0
    end
  end
end
