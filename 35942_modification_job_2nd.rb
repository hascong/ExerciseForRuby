#! /usr/bin/ruby
#encoding: UTF-8

require 'net/http' # for Net::HTTP.get()

# The file folder where the following input and output files located
folderPath = "/Users/congliu/Desktop/"

# The input file where all the 138 API calls are located
fileInputName = "35942_list_modification_job_2nd_ready"
fileInputPath = "/Users/congliu/Desktop/35942_list_modification_job_2nd_ready"
fileInputObject = File.new(fileInputPath, "r")
# TEST
puts "The input file is #{fileInputPath}"

# The output file where the returned JSON results are located
fileOutputName = "35942_result_modification_job_2nd"
fileOutputPath = "/Users/congliu/Desktop/35942_result_modification_job_2nd"
# TEST
puts "The output file is #{fileOutputPath}"
File.open("#{fileOutputPath}", 'w') { |fileOutput| 

puts "--------------------------------------------------------------------------------"
puts "Starts working..."

# TASK: Set the line counter to 1
counterLine = 1 # Initialize the line counter
maxLine = 138 # 138 lines in input file
maxLinePlusOne = maxLine + 1

# TEST: If counterLine is set to 1
puts "The line counter has been set to #{counterLine}"

while (line = fileInputObject.gets.chomp and counterLine < maxLinePlusOne)
    # TEST: Retrieve current line
    puts "Line #{counterLine}=[#{line}]"

    # TASK: Run the API call in current line
    html_uri_object = URI(line)
    results_json = Net::HTTP.get(html_uri_object)
    fileOutput.puts "#{counterLine} #{results_json}"
    # TEST
    puts "Line #{counterLine}=[#{results_json}]"
    
    # Increment line number counterLine
    counterLine = counterLine + 1
    puts ""
end # end of while

# Close input file
fileInputObject.close

} # Close output file

puts "Work done."
puts "--------------------------------------------------------------------------------"
