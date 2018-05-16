require 'search'

# Given a directory containing one or more text files
# When I execute the program
#  and supply the directory path
#  and provide the search distance
#  and provide the two strings
# Then the program should return the set of documents where
#    the strings are located within the specified distance of one another

describe Search do

  it "Lists all text files in a directory when the given directory contains files" do
    test_search = Search.new(2, 'test_data', 'Cattleya and Logan', 'best kitties')
    filepaths = test_search.get_filepaths_from_dir
    expect(filepaths.length).to eq 4
  end

  it "Displays a message when the directory does not exist" do
    test_search = Search.new(2, 'fake_directory', 'Cattleya and Logan', 'best kitties')
    filepaths = test_search.get_filepaths_from_dir
    expect(filepaths).to eq []
  end

  it "Creates an array containing the words from a file" do
    test_search = Search.new(2, 'test_data', 'Cattleya and Logan', 'best kitties')
    array_of_words = test_search.get_array_of_words_from_file('test_data/kitties.txt')
    expect(array_of_words[12]). to eq 'logan'
  end

  it "Cleans an array of special characters" do
    test_search = Search.new(2, 'test_data', 'Cattleya and Logan', 'best kitties')
    text_array = test_search.get_array_of_words_from_file('test_data/kitties.txt')
    expect(text_array[12]). to eq 'logan'
  end

  it "Returns location of string1 in test_array or -1 if not found" do
    test_search = Search.new(2, 'test_data', 'Cattleya and Logan', 'best kitties')
    text_array = test_search.get_array_of_words_from_file('test_data/kitties.txt')
    is_string_found = test_search.get_index_of_string1_in_text_array(text_array)
    expect(is_string_found). to eq 10
  end

  it "Returns location of string1 in test_array or -1 if not found" do
    test_search = Search.new(2, 'test_data', 'Cattleya and Tim', 'best kitties')
    text_array = test_search.get_array_of_words_from_file('test_data/kitties.txt')
    is_string_found = test_search.get_index_of_string1_in_text_array(text_array)
    expect(is_string_found). to eq -1
  end

  it "Gets an array of index ranges to search for string2" do
    test_search = Search.new(3, 'test_data', 'Cattleya and Logan', 'best kitties')
    text_array = test_search.get_array_of_words_from_file('test_data/kitties.txt')
    index_range_array = test_search.get_index_range_to_search_for_string2(text_array)
    expect(index_range_array). to eq [7, 8, 9, 10, 11, 12]
  end


#  it "Should return true if array_to_find is found within array_to_search" do
#    test_search = Search.new(2, 'test_data', 'in Neverland', 'French')
#    array_to_search = ["Once", "upon", "a", "time", "in", "Neverland"]
#    array_to_find = ["in", "Neverland"]
#    is_match = test_search.string1_within_text_array?(array_to_search)
#    expect(is_match). to eq true
#  end
#
#  it "Should return false if array_to_find is not found within array_to_search" do
#    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
#    array_to_search = ["Once", "upon", "a", "time", "in", "Neverland"]
#    array_to_find = ["in", "time"]
#    is_match = test_search.string1_within_text_array?(array_to_search)
#    expect(is_match). to eq false
#  end
#
#
#
#  it "Searches an array based on index range" do
#    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
#    array_to_find = ["in", "Neverland"]
#    index_array = [0, 1, 2, 3, 4, 5]
#    is_found = test_search.search_array_by_index_ranges(array_to_search, array_to_find, index_array)
#    expect(is_found). to eq true
#  end

#  it "Searches an array based on index range" do
#    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
#    array_to_search = ["Once", "upon", "a", "time", "in", "Neverland"]
#    array_to_find = ["in", "Lindy"]
#    index_array = [0, 1, 2, 3, 4, 5]
#    is_found = test_search.search_array_by_index_ranges(array_to_search, array_to_find, index_array)
#    expect(is_found). to eq false
#  end

#  it "Display an array when search terms are found" do
#    test_search = Search.new(6, 'test_data', 'When Dot', 'Penny')
#    expect(test_search.perform_locality_search). to eq true
#  end

#  it "Display an empty array if no match is found." do
#    test_search = Search.new(6, 'test_data', 'Tim', 'Lindy')
#    expect(test_search.perform_locality_search). to eq true
#  end

#  it "Display an empty array if only one match is found" do
#    test_search = Search.new(6, 'test_data', 'chemistry', 'lab partner')
#    expect(test_search.perform_locality_search). to eq true
#  end

end
