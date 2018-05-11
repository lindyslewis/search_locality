class Search 
	def initialize(distance, directory_path, string1, string2)
		@distance = distance
		@directory_path = directory_path
		@string1 = string1
		@string2 = string2
	end

	def search_for_strings
		puts "Returning the file paths of documents located in #{@directory_path} that contain the strings '#{@string1}' and '#{@string2}' that appear within #{@distance} words of one another."
	end

end
