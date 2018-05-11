require 'search'

describe Search do

  it "The first file returned should be ironbars.txt" do
    test_search = Search.new(2, 'test_data', 'my first string', 'my second string')
    filepaths = test_search.get_filepaths_from_dir
    expect(filepaths[0]).to eq "test_data/ironbars.txt"
  end

end
