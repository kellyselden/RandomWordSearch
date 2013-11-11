class Word
	def initialize word, cells
		@word = word
		@cells = cells
	end

	def to_s
		@word
	end

	attr_accessor :word
end
