#!/usr/bin/ruby
 
# OO Design
# Unit Testing
# 
# 1. Iterate over all the plain text documents in a directory
# 2. Return the set of documents where two search terms 
#          occur whithin N words of each other
# 3. Extra Credit: Allow the user to specify phrases instead of terms
#
# Attach the source files as a zip to the Jira ticket

require 'rspec'
require_relative 'lib/search'

class Init

	def initialize(string1, string2)
		@string1 = string1
		@string2 = string2
	end

	def run_search
		puts "Running search for #{@string1}."
    puts "Running search for #{@string2}."
		locality_search = Search.new(@string1, @string2)
		locality_search.search_for_strings 
  end

end

def run_cli
	
	def usage
		puts "usage: init.rb 'string 1' string2";
		exit 1
	end 

  if ARGV.length != 2
		usage
	end

  string1 = ARGV[0].to_s 
	string2 = ARGV[1].to_s

	locality_search_initialize = Init.new(string1, string2)
	locality_search_initialize.run_search
	
end

run_cli
