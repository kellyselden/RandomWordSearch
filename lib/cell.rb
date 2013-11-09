class Cell
	def initialize capacity
		@capacity = capacity
		@chr = nil
		@words = Array.new
	end

	def full?
		@words.length == @capacity
	end

	def to_s
		@chr || "_"
	end

	attr_accessor :chr, :words
end
