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

	def get_array_of_words_from_file(file_path)
		array_of_words = File.open( file_path ) do |file|
			file.read.split
		end
	end

	def get_array_of_words_from_string(string)
		return string.split
	end

	def get_index_of_first_match(array_to_search, array_to_find)
		index = 0
		array_to_search.each do |word|
			if array_to_find[0] == word
				return index
			end
			index = index + 1
		end
	end

	def search_for_array_within_array(array_to_search, array_to_find)
		index = get_index_of_first_match(array_to_search, array_to_find)
		length = array_to_find.length
		new_array = array_to_search.slice(index, length)
		if new_array == array_to_find
			return true
		else
			return false
		end
	end


end
