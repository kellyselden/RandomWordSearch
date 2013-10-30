class Game
	def initialize height, width, seed
		@random = Random.new seed
		puts seed
		puts
		words = getWords
		printWords words
		puts
		@height = height
		@width = width
		setUp
		words.each {|word| placeWord word}
		#fillRemainingGrid
		printGrid
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

	def setUp
		@grid = Array.new @height
		for i in 0..@height-1
			@grid[i] = Array.new @width
		end
		@locations = Array(0..@height*@width-1).shuffle(random: @random)
	end

	def fillRemainingGrid
		for i in 0..@grid.length-1
			for j in 0..@grid[i].length-1
				if @grid[i][j] == nil then
					@grid[i][j] = (@random.rand(26) + 65).chr
				end
			end
		end
	end

	def placeWord word, letterIndex = 0, lastX = nil, lastY = nil
		if letterIndex == word.length then
			return true
		end
		if letterIndex == 0 then
			if @locations.empty? then
				return false
			end
			for location in @locations
				nextX = location % @width
				nextY = location / @height
				@grid[nextY][nextX] = word[letterIndex]
				next if !placeWord(word, letterIndex + 1, nextX, nextY)
				@locations.delete(nextY * @width + nextX)
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
				next if nextX == -1 || nextY == -1 || nextX == @width || nextY == @height || @grid[nextY][nextX] != nil
				@grid[nextY][nextX] = word[letterIndex]
				next if !placeWord(word, letterIndex + 1, nextX, nextY)
				@locations.delete(nextY * @width + nextX)
				return true
			end
			@grid[lastY][lastX] = nil
			return false
		end
	end

	def printWords words
		words.each {|word| puts word}
	end

	def printGrid
		for i in 0..@grid.length-1
			for j in 0..@grid[i].length-1
				print @grid[i][j] || "_"
			end
			puts
		end
	end
end

Game.new 10, 10, ARGV.empty? ? Random.new_seed : ARGV[0].to_i