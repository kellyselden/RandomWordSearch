require './lib/game'
require './lib/words'
require './lib/word'
require './lib/grid'
require './lib/cell'

seed = ARGV.empty? ? Random.new_seed : ARGV[0].to_i
puts seed
puts
game = Game.new 10, 10, 10, seed
game.words.each {|word| puts word}
puts
puts game.grid
