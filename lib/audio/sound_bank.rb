class SoundBank
  def initialize
    @sounds = {}

    Dir["res/sfx/**/*.wav"].each do |sound|
      name = sound.split("/").last.split(".").first
      @sounds[name.to_sym] = Gosu::Sample.new($window, sound)
    end
  end

  def play!(name, volume = 1.0, pan = 0)
    @sounds[name].play(volume)
  end

  class << self
    def current
      @current = SoundBank.new
    end

    alias :setup :current
  end
end
