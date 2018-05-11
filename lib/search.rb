class Search 
	def initialize(distance, string1, string2)
		@distance = distance
		@string1 = string1
		@string2 = string2
	end

	def search_for_strings
		puts "Searching for '#{@string1}' and '#{@string2}' to appear within #{@distance} words of one another."
	end

end
