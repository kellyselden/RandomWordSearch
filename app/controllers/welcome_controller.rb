class WelcomeController < ApplicationController
	def index
		game = Game.new(20, 20, 20, Random.new_seed)
		@grid = game.grid
		@words = game.words
	end
end
