class Grid
	def initialize height, width
		@grid = Array.new height
		for i in 0..height-1
			@grid[i] = Array.new width
		end
	end

	def get x, y
		return @grid[y][x]
	end

	def set x, y, val
		@grid[y][x] = val
	end

	def height
		return @grid.length
	end

	def width
		return @grid[0].length
	end

	def each
		for y in 0..height-1
			for x in 0..width-1
				yield x, y
			end
		end
	end

	def print
		for y in 0..@grid.length-1
			for x in 0..@grid[y].length-1
				get(x, y).print
			end
			puts
		end
	end
end