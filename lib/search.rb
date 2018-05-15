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

		array_of_files.each do |file_in_list|
			#puts "Now searching #{file_in_list}."

      File.open(file_in_list, 'r') do |file|
  			while line = file.gets

					if line.include? @string1
						if line.include? @string2
							#puts "Found inside #{file_in_list}: #{line}"
							return file_in_list.to_s
						end
					end

				end
			end

		end


	end
end
