class Cell
	def initialize x, y, capacity
	  @x = x
	  @y = y
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
