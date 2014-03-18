#! /usr/bin/ruby
#encoding: UTF-8

# The program takes no argument from the command line.
# Instead, the program assumes the working folder as
# the current working folder, scans through all the
# files inside the working folder, processes those
# whose name is made of digits only, finds some
# statistics and reports into their corresponding
# report files by creating a new report file if
# necessary.
#
# Author::    Cong Liu (mailto:congliu0704@gmail.com) 
# Copyright:: Copyright (c) 2014 Cong Liu
# License::   Distributes under the same terms as Ruby

system "clear"

puts ""
puts "Starts working..."
puts ""
puts "Working folder is " + Dir.pwd
puts ""

filePathInString = "./"

#
# Make a collection of all files in the working folder,
# excluding possible subfolder(s)
#
filesOfAllPages = Dir.entries(filePathInString).select {|f| !File.directory? f}

filesOfAllPages.each do |fileNameOfSomePageInString|
  puts "  Retrieving a file, #{fileNameOfSomePageInString}, from current working folder..."
  
  if fileNameOfSomePageInString[/^\d+$/]
    puts "  This file seems to be a valid index page file..."
    puts "  Trying to process file " + fileNameOfSomePageInString + "..."

    reportFileNameOfCurrentPageInString = "#{fileNameOfSomePageInString}_report"
    if File.exist?("#{filePathInString}#{reportFileNameOfCurrentPageInString}");
      # Print notice that the report file does already exist
      puts "  Found report file for this page file..."
      puts "  Going to overwrite the existing report file..."
    else
      # Create a corresponding report file for current page data file
      puts "  Creating a report file for this page file..."
      system "sudo touch \"#{filePathInString}#{reportFileNameOfCurrentPageInString}\""
      puts "  Report file gets created..."
    end 

    system "sudo chmod ug+w \"#{filePathInString}#{reportFileNameOfCurrentPageInString}\""
    
    puts "    Statistics to report:"
    # Count the number of lines in the data file
    numberOfWords = File.foreach("#{filePathInString}#{fileNameOfSomePageInString}").count
    puts "    (1) The number of words on current index page = #{numberOfWords}"
    
    # Count the number of checked words in the data file
    fileDataInString = IO.read("#{filePathInString}#{fileNameOfSomePageInString}")
    numberOfCheckedWords = fileDataInString.scan(/\ c\n/m).size
    puts "    (2) The number of words checked = #{numberOfCheckedWords}"
    
    # Get the time and date of today
    timeInstance = Time.now
    dateString = timeInstance.strftime("%Y%m%d%a") 
    puts "    (3) The date of checking = " + dateString 
    
    # Output to report file
    File.open("#{filePathInString}#{reportFileNameOfCurrentPageInString}", 'w') { |file| file.write("#{numberOfCheckedWords}/#{numberOfWords}@#{dateString}") }
    
    system "sudo chmod ug-w \"#{filePathInString}#{reportFileNameOfCurrentPageInString}\""
    
  else
    puts "  This file seems not to be a page file..."
    puts "  Ignoring this file..."
  end
  
  puts ""
  puts "  Going to retrieve another file in current working folder..."
  puts ""
end

puts "  No other files found..."
puts ""
puts "Done reporting current index page."
puts "Quits the program."
puts ""
