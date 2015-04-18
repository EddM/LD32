require "gosu"

require "./lib/game_window.rb"
require "./lib/game_state_manager.rb"
require "./lib/game_state.rb"
Dir["./lib/game_states/*.rb"].each { |file| require file }

require "./lib/z.rb"
require "./lib/geometry.rb"

require "./lib/level.rb"

Dir["./lib/traits/*.rb"].each { |file| require file }

require "./lib/entity.rb"
require "./lib/enemy.rb"
Dir["./lib/enemies/*.rb"].each { |file| require file }
require "./lib/player.rb"

require "./lib/fireball.rb"

require "./lib/tileset.rb"
require "./lib/tile.rb"
Dir["./lib/tiles/*.rb"].each { |file| require file }

include Gosu

window = GameWindow.new(1280, 720, false)
window.show
