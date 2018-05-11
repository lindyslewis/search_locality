class Search
	def initialize(distance, directory_path, string1, string2)
		@distance = distance
		@directory_path = directory_path
		@string1 = string1
		@string2 = string2
	end

	def get_filepaths_from_dir
		Dir.glob("#{@directory_path}/*.txt")	
  end

	def search_for_strings
		array_of_files = get_filepaths_from_dir
		array_of_files.each do |file|
			puts file
		end
	end

end
