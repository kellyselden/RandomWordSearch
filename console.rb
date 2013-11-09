require './lib/game'
require './lib/words'
require './lib/grid'
require './lib/cell'

Game.new 20, 20, 20, ARGV.empty? ? Random.new_seed : ARGV[0].to_i