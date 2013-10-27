class Game
	def initialize
		words = getWords
		@@Height = 10
		@@Width = 10
		setUpGrid
		@@Directions = [0,1,2,3,4,5,6,7]
		@@Directions = @@Directions.shuffle
		@@Directions.each do |x| print x end
		return
		placeWord words[0], 0
		#fillRemainingGrid
		printWords words
		puts
		printGrid
	end
	
private

	def getWords
		filename = "2of12inf.txt"

		numOfLines = 0
		File.foreach(filename) do |line|
			numOfLines += 1
		end

		numOfWords = rand(10) + 1
		lineNumbers = Array.new
		for i in 0..numOfWords-1
			begin
				r = rand(numOfLines)
			end while lineNumbers.include? r
			lineNumbers.push r
		end

		lineNumber = 0
		words = Array.new
		File.foreach(filename) do |line|
			for i in 0..numOfWords
				if lineNumber == lineNumbers[i] then
					words.push line.upcase
				end
			end
			lineNumber += 1
		end
		
		return words
	end

	def setUpGrid
		@@grid = Array.new @@Height
		for i in 0..@@Height-1
			@@grid[i] = Array.new @@Width
		end
	end

	def fillRemainingGrid
		for i in 0..@@grid.length-1
			for j in 0..@@grid[i].length-1
				if @@grid[i][j] == nil then
					@@grid[i][j] = (rand(26) + 65).chr
				end
			end
		end
	end

	def placeWord word, letterIndex, lastX = nil, lastY = nil
		if letterIndex == word.length - 1 then
			return
		end
		if letterIndex == 0 then
			nextX = rand @@Width
			nextY = rand @@Height
		else
			@@Direction.shuffle
			begin
				direction = rand(8)
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
			end while nextX == -1 || nextY == -1 || nextX == @@Width || nextY == @@Height || @@grid[nextX][nextY] != nil
		end
		@@grid[nextX][nextY] = word[letterIndex]
		placeWord(word, letterIndex + 1, nextX, nextY)
	end

	def printWords words
		words.each {|word| puts word}
	end
	
	def printGrid
		for i in 0..@@grid.length-1
			for j in 0..@@grid[i].length-1
				print @@grid[i][j] || "_"
			end
			puts
		end
	end
end

Game.new