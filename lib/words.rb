class Words
	def self.get numOfWords, random
		filePath = File.expand_path("2of12inf.txt", File.dirname(__FILE__))
		numOfLines = 0
		File.foreach(filePath) do |line|
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
		File.foreach(filePath) do |line|
			for i in 0..numOfWords
				if lineNumber == lineNumbers[i] then
					words.push line.chomp.upcase
				end
			end
			lineNumber += 1
		end

		return words
	end
end
