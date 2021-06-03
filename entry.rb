#! /usr/bin/ruby

require 'time'
require 'fileutils'

class NewEntry
  def initialize
    @path = "#{Dir.home}/Documents/entries"
    FileUtils.mkdir_p @path
    @filename = "#{@path}/#{Time.now.to_s.gsub(" ", "_")}.md"
    @f = File.new(filename, "w")

    if ARGV[0].nil?
      print "> "
      input = gets.chomp
    else
      input = File.open(ARGV[0]).readlines
    end

    f.puts(input)
    f.close
  end
end
