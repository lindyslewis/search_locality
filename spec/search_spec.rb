require 'search'

# Given a directory containing one or more text files
# When I execute the program
#  and supply the directory path
#  and provide the search distance
#  and provide the two strings
# Then the program should return the set of documents where
#    the strings are located within the specified distance of one another

describe Search do

  it "Finds all text files in a directory" do
    test_search = Search.new(2, 'test_data', 'my first string', 'my second string')
    filepaths = test_search.get_filepaths_from_dir
    expect(filepaths.length).to eq 3
  end

  it "Creates an array containing the words of a file" do
    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
    array_of_words = test_search.get_array_of_words_from_file('test_data/citychickens.txt')
    expect(array_of_words[4]). to eq 'Hanna'
  end

  it "Gets the index of the first word in the string" do
    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
    array_to_search = ["Once", "upon", "a", "time", "in", "Neverland"]
    array_to_find = ["a", "time"]
    index = test_search.get_index_of_first_match(array_to_search, array_to_find)
    expect(index). to eq 2
  end

  it "Checks the rest of the substring for a match" do
    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
    array_to_search = ["Once", "upon", "a", "time", "in", "Neverland"]
    array_to_find = ["in", "Neverland"]
    is_match = test_search.search_for_array_within_array(array_to_search, array_to_find)
    expect(is_match). to eq true
  end

  it "Checks the rest of the substring for a match" do
    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
    array_to_search = ["Once", "upon", "a", "time", "in", "Neverland"]
    array_to_find = ["in", "time"]
    is_match = test_search.search_for_array_within_array(array_to_search, array_to_find)
    expect(is_match). to eq false
  end


end
