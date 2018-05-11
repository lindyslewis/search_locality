#!/usr/bin/ruby
require 'rspec'
require_relative 'lib/search'

def usage
  puts "usage: init.rb distance 'directory path' 'string 1' string2";
  exit 1
end

def check_argument_length
  if ARGV.length != 4
    usage
  end
end

def set_variables_from_arguments
  @distance = ARGV[0].to_i
  @directory_path = ARGV[1].to_s
  @string1 = ARGV[2].to_s
  @string2 = ARGV[3].to_s

  if !@distance.is_a? Integer
		usage
	end
end

def run_search
  locality_search = Search.new(@distance, @directory_path, @string1, @string2)
  locality_search.search_for_strings
end

def run_cli
  check_argument_length
  set_variables_from_arguments
  run_search
end

run_cli
