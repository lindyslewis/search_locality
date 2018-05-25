class Search

	attr_reader :distance, :directory_path, :string1_array, :string2_array


	# Constructor for class.  Sets the locality factor, the directory
	#   to search, and an array for each of the two cleaned and downcased
	#   strings to search for.  Also initializes an empty array of filepaths
	#   with positive results that will be set when an array is found that
	#   meets the locality search criteria.
	def initialize(locality, directory_path, string1, string2)
		@locality = locality
		@directory_path = directory_path
		@string1_array = clean_array(string1.split)
		@string2_array = clean_array(string2.split)
		@results = []
	end


	# Returns an array of all .txt files located within a
	#   given directory.
	def get_filepaths_from_dir
		array_of_filepaths = Dir.glob("#{@directory_path}/*.txt")
		return array_of_filepaths
	end


	# For every string in an array, removes all non alphanum
	#   characters and converts string to all lowercase.
	def clean_array(array)
		array.map! do |string|
			string.downcase.gsub(/[^a-z0-9\s]/i, '')
		end
		return array
	end


	# Opens a text file and returns an array containing
	#   all of the strings within that file.
	def get_array_of_words_from_file(file_path)
		text_array = File.open( file_path ) do |file|
			file.read.split
		end
		return clean_array(text_array)
	end


	# Searches through an array of strings and builds and array containing
	#  the index of each occurance of @string1
	def get_string1_index_array(array_to_search)
		length_of_string1_array = @string1_array.length
		index = 0
		string1_occurances_index = []
		array_to_search.each do |word|
			if @string1_array[0] == word
				sliced_array = array_to_search.slice(index, length_of_string1_array)
				if sliced_array == @string1_array
					string1_occurances_index << index
				end
			end
			index = index + 1
		end
		return string1_occurances_index
	end


	# Builds an array of index points to search for string2.
	#    For every string 1 occurance, creates a new array of surrounding
	#    index positions to search based on the locality factor and
	#    places these values into a two dimensional array.
	#    Then this function takes all values and stores them in a one
	#    dimensional array and removes all duplicates. This resulting array will
	#    contain all index positions to begin searching for string2.
	def get_string2_index_range(array_to_search, string1_occurances_index)
		two_d_index_range_to_search_for_string2 = []
		string1_occurances_index.each do |index|
			if index - @locality < 0
				first_index = 0
			else
				first_index = index - @locality
			end
			if index + @locality + @string1_array.length > array_to_search.length - 1
				last_index = array_to_search.length - 1
			else
				last_index = index + @locality + @string1_array.length
			end
			two_d_index_range_to_search_for_string2 << (first_index..last_index).to_a
		end
		flat_array = []
		iterator = 0
		two_d_index_range_to_search_for_string2.each do |i|
			two_d_index_range_to_search_for_string2[iterator].each do |j|
		  	flat_array << j
			end
			iterator = iterator + 1
		end
		return flat_array.uniq
	end

	# Searches the array at matching index positions for string2.
	#   Returns true if found.
	def string2_search(array_to_search, index_array)
		length_of_string2_array = @string2_array.length
		is_found = false
		index_array.each do |index|
			sliced_array = array_to_search.slice(index, length_of_string2_array)
			if sliced_array == @string2_array
				is_found = true
			end
		end
		return is_found
	end

	# Driver function that performs the search.
	#  * Creates an array of filepaths located in the directory
	#  * For each file:
	#     * Creates an index of occurances of string1
	#     * Creates an array of appropriate locations to search for string2
	#     * Searches for string 2
	#     * Returns an array of filepaths where string2 is found
	def perform_locality_search
		array_of_filepaths = get_filepaths_from_dir
		array_of_filepaths.each do |filepath|
			text_array = get_array_of_words_from_file(filepath)
			string1_occurances_index = get_string1_index_array(text_array)
	    index_range_array = get_string2_index_range(text_array, string1_occurances_index)
	    locality_search = string2_search(text_array, index_range_array)
			if locality_search == true
				@results << filepath
			end
		end
		return @results
	end

end
