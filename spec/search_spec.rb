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

  it "Returns the filepath of a locality search in the same document" do
    test_search = Search.new(2, 'test_data', 'I kinda', 'French')
    context_files = test_search.search_for_strings
    expect(context_files).to eq 'test_data/citychickens.txt'
  end




end
