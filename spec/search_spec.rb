require 'search'

# Given a directory containing one or more text files
# When I execute the program
#  and supply the directory path
#  and provide the search distance
#  and provide the two strings
# Then the program should return the set of documents where
#    the strings are located within the specified distance of one another

describe Search do

  it "Finds three text files in the directory" do
    test_search = Search.new(2, 'test_data', 'my first string', 'my second string')
    filepaths = test_search.get_filepaths_from_dir
    expect(filepaths.length).to eq 3
  end

  it "Creates an array containing the words of a file" do
    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
    array_of_words = test_search.get_array_of_words('test_data/citychickens.txt')
    expect(array_of_words[4]). to eq 'Hanna'
  end

  it "Should return true if it finds string 1" do
    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
    array_of_strings = ["My", "Foo", "Bar"]
    test_results = test_search.search_for_strings(array_of_strings, 'Foo', 'Bar')
    expect(test_results).to eq true
  end

  it "Should return false if it finds string 1 but not string 2" do
    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
    array_of_strings = ["My", "Foo", "Bar"]
    test_results = test_search.search_for_strings(array_of_strings, 'Foo', 'Lily')
    expect(test_results).to eq false
  end

end
