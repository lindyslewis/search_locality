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

	def initialize(distance, directory_path, string1, string2)
		@distance = distance
		@directory_path = directory_path
		@string1 = string1
		@string2 = string2
	end

	def run_search
		locality_search = Search.new(@distance, @directory_path, @string1, @string2)
		locality_search.search_for_strings 
  end

end

def run_cli
	
	def usage
		puts "usage: init.rb distance 'directory path' 'string 1' string2";
		exit 1
	end 

  if ARGV.length != 4
		usage
	end

  distance = ARGV[0].to_i
  directory_path = ARGV[1].to_s
  string1 = ARGV[2].to_s 
	string2 = ARGV[3].to_s

	if distance.is_a? Integer
		locality_search_initialize = Init.new(distance, directory_path, string1, string2)
		locality_search_initialize.run_search
	else
		usage
	end

end

run_cli
