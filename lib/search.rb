class Search
	attr_reader :distance, :directory_path, :string1_array, :string2_array

	def initialize(locality, directory_path, string1, string2)
		@locality = locality
		@directory_path = directory_path
		@string1_array = clean_array(string1.split)
		@string2_array = clean_array(string2.split)
		@array_of_filepaths_with_positive_results = []
	end

	def get_filepaths_from_dir
		array_of_filepaths = Dir.glob("#{@directory_path}/*.txt")
		return array_of_filepaths
  end

	def clean_array(array)
		array.map! do |string|
			string.downcase.gsub(/[^a-z0-9\s]/i, '')
		end
		return array
	end

	def get_array_of_words_from_file(file_path)
		text_array = File.open( file_path ) do |file|
			file.read.split
		end
		return clean_array(text_array)
	end

	def get_index_of_string1_in_text_array(array_to_search)
		length_of_string1_array = @string1_array.length
		index = 0

		array_to_search.each do |word|
			if @string1_array[0] == word
				sliced_array = array_to_search.slice(index, length_of_string1_array)
				if sliced_array == @string1_array
					return index
				else
					index = index + 1
				end
			else
				index = index + 1
			end
		end
		return -1
	end

	def get_index_array_of_all_occurances_of_string1_in_text_array(array_to_search)
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

	def get_index_range_to_search_for_string2(array_to_search, string1_occurances_index)
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


	def is_string2_located_within_n_words_of_string1?(array_to_search, index_array)
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

	def perform_locality_search
		array_of_filepaths = get_filepaths_from_dir
		array_of_filepaths.each do |filepath|
			text_array = get_array_of_words_from_file(filepath)
			string1_occurances_index = get_index_array_of_all_occurances_of_string1_in_text_array(text_array)
	    index_range_array = get_index_range_to_search_for_string2(text_array, string1_occurances_index)
	    locality_search = is_string2_located_within_n_words_of_string1?(text_array, index_range_array)
			if locality_search == true
				@array_of_filepaths_with_positive_results << filepath
			end
		end
		return @array_of_filepaths_with_positive_results
	end
end
