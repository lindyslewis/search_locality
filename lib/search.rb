class Search
	attr_reader :distance, :directory_path, :string1_array, :string2_array

	def initialize(distance, directory_path, string1, string2)
		@distance = distance
		@directory_path = directory_path
		@string1_array = clean_array(string1.split)
		@string2_array = clean_array(string2.split)
		@results = []
	end

	def get_filepaths_from_dir
		array_of_filepaths = Dir.glob("#{@directory_path}/*.txt")
		if array_of_filepaths.empty?
			#puts "Did not find any files in #{@directory_path}."
		else
			#puts "Searching these files: #{array_of_filepaths}"
		end
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

	def string1_within_text_array?(array_to_search)
		length_of_string1_array = @string1_array.length
		index = 0

		array_to_search.each do |word|
			if @string1_array[0] == word
				sliced_array = array_to_search.slice(index, length_of_string1_array)
				puts " "
				puts "index: #{index}"
				puts "sliced_array: #{sliced_array}"
				puts "@string1_array: #{@string1_array}"
				puts " "
				if sliced_array == @string1_array
					puts "breaking..."
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





=begin
		def get_index_of_string1_location(array_to_search)
			index = 0
			array_to_search.each do |word|
				if @string1_array[0] == word
					return index
				end
				index = index + 1
			end
			return index
		end
	=end

=begin
	def get_array_of_index_ranges(array_to_search, index, locality)
		index - locality < 0 ? first_index = 0 : first_index = index - locality
		index + locality > array_to_search.length - 1 ? last_index = array_to_search.length : last_index = index + locality
		return (first_index..last_index).to_a
	end

	def search_array_by_index_ranges(array_to_search, array_to_find, index_array)
		is_found = false
		length = array_to_find.length

		index_array.each do |index|
			new_array = array_to_search.slice(index, length)
			if new_array == array_to_find
				is_found = true
			end
		end
		return is_found
	end

	def perform_locality_search

		array_of_filepaths = get_filepaths_from_dir
		array_to_find = @string1_array

		puts " "
		puts " "
		puts " "
		puts " "
		#puts " "
		#puts "@distance: #{@distance}"
		#puts "@directory_path: #{@directory_path}"
		#puts "@string1: #{@string1}"
		#puts "@string2: #{@string2}"
		#puts "array_of_filepaths: #{array_of_filepaths}"
		#puts "array_to_find: #{array_to_find}"

		array_of_filepaths.each do |filepath|

			array_to_search = get_array_of_words_from_file(filepath)
			puts " "
			puts "searching #{filepath}......"

			contains_string1 = string1_within_text_array?(array_to_search, @string1_array)
			puts "String 1 is found in #{filepath}:  #{contains_string1}"

			if contains_string1
				index_of_first_match = get_index_of_first_word_in_string1(array_to_search, array_to_find)
				array_of_index_ranges = get_array_of_index_ranges(array_to_search, index_of_first_match, @distance)
				contains_string2 = search_array_by_index_ranges(array_to_search, @string2_array, array_of_index_ranges)
				if (contains_string2 == true)
					puts "inside results if statement: #{filepath}"
					@results << filepath
				end
			end
		end

		puts "Match found for #{@string1} and #{@string2} in the following file: #{@results}"
		return true
	end
=end
end
