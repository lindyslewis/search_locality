class Search

	def initialize(distance, directory_path, string1, string2)
		@distance = distance
		@directory_path = directory_path
		@string1 = string1
		@string2 = string2
	end

	def get_filepaths_from_dir
		return Dir.glob("#{@directory_path}/*.txt")
  end

	def get_array_of_words(file_path)
		array_of_words = File.open( file_path ) do |file|
			file.read.split
		end
	end

	def search_for_strings(array_of_strings, string1, string2)
		if array_of_strings.include? string1
			if array_of_strings.include? string2
				return true
			else
				return false
			end
		else
			return false
		end
	end

end
