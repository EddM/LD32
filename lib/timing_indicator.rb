class TimingIndicator
  CursorHeight = 60

  def initialize(level)
    @level = level
    @bar_length = AudioClock::BeatLength * 4
  end

  def update
    time_offset = Gosu.milliseconds % @bar_length
    bar_progress = time_offset.to_f / @bar_length

    if (bar_progress > 0.00 && bar_progress < 0.05) ||
        (bar_progress > 0.25 && bar_progress < 0.30) ||
        (bar_progress > 0.50 && bar_progress < 0.55) ||
        (bar_progress > 0.75 && bar_progress < 0.80)
      @height = CursorHeight * 2
    else
      @height = CursorHeight
    end

    @cursor_x = GameWindow::Width * bar_progress
    @cursor_y = (GameWindow::Height / 2.0) - (@height / 2)
  end

  def draw
    $window.draw_line @cursor_x, @cursor_y, 0xffffffff,
                      @cursor_x, @cursor_y + @height, 0xffffffff, Z::UI
  end
end
