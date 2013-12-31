require 'json'

class WelcomeController < ApplicationController
	def index
		#game = Game.new(20, 20, 20, Random.new_seed)
		game = Game.new(20, 20, 20, 1)
		@grid = game.grid
		@words = game.words
		@json = JSON.pretty_generate(@words)
	end
end
