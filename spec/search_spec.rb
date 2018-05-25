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

  it "Returns an empty array when the directory does not exist" do
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

  it "Gets an array of index ranges to search for string2" do
    test_search = Search.new(1, 'test_data', 'Cattleya', 'best kitties')
    text_array = test_search.get_array_of_words_from_file('test_data/kitties.txt')
    string1_occurances_index = test_search.get_string1_index_array(text_array)
    index_range_array = test_search.get_string2_index_range(text_array, string1_occurances_index)
    expect(index_range_array). to eq [2, 3, 4, 5, 9, 10, 11, 12]
  end


  it "Finds string2 if it's within n words of string1" do
    test_search = Search.new(3, 'test_data', 'Cattleya and Logan', 'best kitties')
    text_array = test_search.get_array_of_words_from_file('test_data/kitties.txt')
    string1_occurances_index = test_search.get_string1_index_array(text_array)
    index_range_array = test_search.get_string2_index_range(text_array, string1_occurances_index)
    locality_search = test_search.string2_search(text_array, index_range_array)
    expect(locality_search). to eq true
  end

  it "Return false if string2 if is not within n words of string1" do
    test_search = Search.new(1, 'test_data', 'Logan', 'knows')
    text_array = test_search.get_array_of_words_from_file('test_data/kitties.txt')
    string1_occurances_index = test_search.get_string1_index_array(text_array)
    index_range_array = test_search.get_string2_index_range(text_array, string1_occurances_index)
    locality_search = test_search.string2_search(text_array, index_range_array)
    expect(locality_search). to eq false
  end

  it "Performs locality search" do
    test_search = Search.new(3, 'test_data', 'Cattleya and Logan', 'best kitties')
    test_search_results = test_search.perform_locality_search
    expect(test_search_results[1]). to eq 'test_data/kitties.txt'
  end


  it "Performs locality search" do
    test_search = Search.new(4, 'test_data', 'five foot five', 'height')
    test_search_results = test_search.perform_locality_search
    expect(test_search_results[0]). to eq 'test_data/dreamworld.txt'
  end

  it "Finds the results of a context search in more than one document" do
    test_search = Search.new(3, 'test_data', 'Cattleya and Logan', 'best kitties')
    test_search_results = test_search.perform_locality_search
    expect(test_search_results[1]). to eq 'test_data/kitties.txt'
    expect(test_search_results[0]). to eq 'test_data/citychickens.txt'
  end

  it "Finds the results of a context search in more than one document" do
    test_search = Search.new(3, 'test_data', 'Cattleya', 'Logan')
    test_search_results = test_search.perform_locality_search
    expect(test_search_results[1]). to eq 'test_data/kitties.txt'
    expect(test_search_results[0]). to eq 'test_data/citychickens.txt'
  end

end
