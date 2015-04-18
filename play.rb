require "gosu"

Dir["lib/**/*.rb"].each { |file| require "./#{file}" }

include Gosu

window = GameWindow.new(1280, 720, false)
window.show
