require './Words'
require './Grid'
require './Cell'

class Game
	def initialize height, width, numOfWords, seed
		@capacity = 2
		@canCrissCross = true
		@random = Random.new seed
		puts seed
		puts
		words = Words.get(@random.rand(numOfWords) + 1, @random)
		Words.print words
		puts
		setUp height, width
		words.each do |word|
			@locations = @locations.shuffle(random: @random)
			placeWord word
		end
		#fillRemainingGrid
		@grid.print
	end

private

	def setUp height, width
		@grid = Grid.new(height, width)
		@grid.each {|x, y| @grid.set(x, y, Cell.new(@capacity))}
		@locations = Array(0..height*width-1)
	end

	def placeWord word, letterIndex = 0, lastX = nil, lastY = nil
		if letterIndex == word.length then
			return true
		end
		letter = word[letterIndex]
		if letterIndex == 0 then
			for location in @locations
				nextX = location % @grid.width
				nextY = location / @grid.height
				cell = @grid.get(nextX, nextY)
				next if (cell.chr != letter && !cell.words.empty?) || (cell.chr == letter && cell.words.include?(word)) || cell.full?
				cell.chr = letter
				cell.words.push word
				next if !placeWord(word, letterIndex + 1, nextX, nextY)
				return true
			end
		else
			for direction in Array(0..7).shuffle(random: @random)
				nextX = lastX
				nextY = lastY
				case direction
					when 0
						nextX -= 1
						nextY -= 1
					when 1
						nextY -= 1
					when 2
						nextX += 1
						nextY -= 1
					when 3
						nextX += 1
					when 4
						nextX += 1
						nextY += 1
					when 5
						nextY += 1
					when 6
						nextX -= 1
						nextY += 1
					when 7
						nextX -= 1
				end
				next if nextX == -1 || nextY == -1 || nextX == @grid.width || nextY == @grid.height
				next if @canCrissCross && isCrissCross(lastX, lastY, nextX, nextY, direction, word)
				cell = @grid.get(nextX, nextY)
				next if (cell.chr != letter && !cell.words.empty?) || (cell.chr == letter && cell.words.include?(word)) || cell.full?
				cell.chr = letter
				cell.words.push word
				next if !placeWord(word, letterIndex + 1, nextX, nextY)
				return true
			end
			cell = @grid.get(lastX, lastY)
			if cell.words.length == 1 then
				cell.chr = nil
			end
			cell.words.delete word
			return false
		end
	end

	def isCrissCross lastX, lastY, nextX, nextY, direction, word
		return isDirectionDiagonal(direction) && @grid.get(lastX, nextY).words.include?(word) && @grid.get(nextX, lastY).words.include?(word)
	end

	def isDirectionDiagonal direction
		return direction % 2 == 0
	end

	def fillRemainingGrid
		@grid.each do |x, y|
			cell = @grid.get(x, y)
			if cell.words.empty? then
				cell.chr = (@random.rand(26) + 65).chr
			end
		end
	end
end

Game.new 20, 20, 20, ARGV.empty? ? Random.new_seed : ARGV[0].to_i