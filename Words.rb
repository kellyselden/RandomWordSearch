class Words
	def self.get numOfWords, random
		filename = "2of12inf.txt"

		numOfLines = 0
		File.foreach(filename) do |line|
			numOfLines += 1
		end

		lineNumbers = Array.new
		for i in 0..numOfWords-1
			begin
				r = random.rand(numOfLines)
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

	def self.print words
		words.each {|word| puts word}
	end
end