require './Grid'

class Cell
	def initialize
		@chr = nil
		@num = 0
	end

	def empty?
		@num == 0
	end

	attr_accessor :chr, :num
end

class Game
	def initialize height, width, seed
		@canCrissCross = true
		@random = Random.new seed
		puts seed
		puts
		words = getWords
		printWords words
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

	def getWords
		filename = "2of12inf.txt"

		numOfLines = 0
		File.foreach(filename) do |line|
			numOfLines += 1
		end

		numOfWords = @random.rand(10) + 1
		lineNumbers = Array.new
		for i in 0..numOfWords-1
			begin
				r = @random.rand(numOfLines)
			end while lineNumbers.include? r
			lineNumbers.push r
		end

		lineNumber = 0
		words = Array.new
		File.foreach(filename) do |line|
			for i in 0..numOfWords
				if lineNumber == lineNumbers[i] then
					words.push line.chomp.upcase
				end
			end
			lineNumber += 1
		end

		return words
	end

	def setUp height, width
		@grid = Grid.new(height, width)
		@grid.each {|x, y| @grid.set(x, y, Cell.new)}
		@locations = Array(0..height*width-1)
	end

	def placeWord word, letterIndex = 0, lastX = nil, lastY = nil
		if letterIndex == word.length then
			return true
		end
		letter = word[letterIndex]
		if letterIndex == 0 then
			if @locations.empty? then
				return false
			end
			for location in @locations
				nextX = location % @grid.width
				nextY = location / @grid.height
				cell = @grid.get(nextX, nextY)
				next if cell.chr != letter || cell.num > 1
				cell.chr = letter
				cell.num += 1
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
				next if @canCrissCross && isCrissCross(lastX, lastY, nextX, nextY, direction)
				cell = @grid.get(nextX, nextY)
				next if cell.chr != letter || cell.num > 1
				cell.chr = letter
				cell.num += 1
				next if !placeWord(word, letterIndex + 1, nextX, nextY)
				return true
			end
			cell = @grid.get(lastX, lastY)
			if cell.num == 1 then
				cell.chr = nil
			end
			cell.num -= 1
			return false
		end
	end

	def isCrissCross lastX, lastY, nextX, nextY, direction
		return isDirectionDiagonal(direction) && @grid.get(lastX, nextY).chr && @grid.get(nextX, lastY).chr
	end

	def isDirectionDiagonal direction
		return direction % 2 == 0
	end

	def fillRemainingGrid
		@grid.each do |x, y|
			if @grid.get(x, y) == nil then
				@grid.set(x, y, Cell.new((@random.rand(26) + 65).chr, 0))
			end
		end
	end

	def printWords words
		words.each {|word| puts word}
	end
end

Game.new 10, 10, ARGV.empty? ? Random.new_seed : ARGV[0].to_i