class AudioClock
  attr_reader :start_time

  BeatLength = 800 # ms per beat

  def initialize(start_time = 0, listener = nil, callback_method = :tick)
    @start_time = start_time
    @listeners = []
    @count, @last_fired_at = 0, 0
    @next_fire_at = start_time + BeatLength

    add_listener listener, callback_method if listener
  end

  def add_listener(listener, callback_method)
    @listeners << [listener, callback_method]
  end

  def start(start_time)
    @start_time = start_time
  end

  def update
    time = Gosu.milliseconds

    if time >= @next_fire_at
      fire!
      @next_fire_at = BeatLength * @count
    end
  end

  def fire!
    @listeners.each do |listener, callback_method|
      listener.send(callback_method, @count)
    end

    @count += 1
  end
end
